use "/Users/chandramaharshivalasa/Dropbox/Historical Agricultural Statistics/updated_all_sources_master.dta", clear


foreach v of varlist _all {
   capture replace `v' = "" if inlist(strtrim(`v'), "…", "···", "—", "- -",  "...",  "n.a.(W)","n.a.", "ma.")
   } 
   
replace Rice_Area_kHA_Rose = "1646" if Rice_Area_kHA_Rose == "i646"

replace Rice_Area_kHA_Rose = "640" if Rice_Area_kHA_Rose == "64o"

replace Rice_Area_kHA_Rose = "610" if Rice_Area_kHA_Rose == "6io"

                                         
*Dropping island nations 
drop if country == "Falkland Islands" ///
    | country == "Faroe Islands" ///
	| country == "Mauritius" ///
	| country == "Barbados" ///
	| country == "São Tomé and Príncipe" ///
	| country == "Singapore" ///
    | country == "Guadeloupe" ///
    | country == "Martinique" ///
    | country == "Réunion" ///
    | country == "Hawaii" ///
    | country == "Hong Kong" ///
    | country == "Newfoundland"
	
                                              
* Standardize spacing first
replace country = trim(country)

* Get all non-ID variables
ds country year _merge, not
local vars `r(varlist)'

* Convert them to numeric if needed
destring `vars', replace

capture program drop harmonize_one
program define harmonize_one
    args old modern vars

    foreach v of local vars {
        bysort year: egen tmp = total(cond(country=="`old'", `v', .))
        bysort year: egen has_old = max(country=="`old'" & !missing(`v'))

        replace `v' = `v' + tmp if country=="`modern'" & has_old==1 & !missing(`v')
        replace `v' = tmp       if country=="`modern'" & has_old==1 & missing(`v')

        drop tmp has_old
    }

    bysort year: egen has_modern = max(country=="`modern'")
    replace country = "`modern'" if country=="`old'" & has_modern==0
    drop if country=="`old'" & has_modern==1
    drop has_modern
end

harmonize_one "Burkhina Faso" "Burkina Faso" "`vars'"
harmonize_one "Upper Volta" "Burkina Faso" "`vars'"
harmonize_one "Malasia" "Malaysia" "`vars'"
harmonize_one "Peurto Rico" "Puerto Rico" "`vars'"
harmonize_one "Czech" "Czech Republic" "`vars'"
harmonize_one "Congo, The Democratic Republic of the" "Democratic Republic of the Congo" "`vars'"
harmonize_one "Democratic Republic of Congo" "Democratic Republic of the Congo" "`vars'"
harmonize_one "Korea, Republic of" "South Korea" "`vars'"
harmonize_one "Zaire" "Democratic Republic of the Congo" "`vars'"
harmonize_one "Tanganyika" "Tanzania" "`vars'"
harmonize_one "Italian Somaliland" "Somalia" "`vars'"
harmonize_one "French Cameroon" "Cameroon" "`vars'"
harmonize_one "Kingdom of Korea" "Korea" "`vars'"
harmonize_one "Isreal/Palestine" "Israel" "`vars'"

* Fix obvious spelling / naming inconsistencies
replace country = "Cape Verde"                      if country == "Cape Verte"
replace country = "Kyrgyzstan"                      if country == "Kyrgistan"
replace country = "Trinidad and Tobago"             if country == "Trinidad & Tobago"
replace country = "United Kingdom"                  if country == "UK: Great Britain"
replace country = "United States"                   if country == "USA"

* --- Historical name changes → modern country names --- *

replace country = "Côte d’Ivoire" if country == "Ivory Coast"
replace country = "Yemen"        if country == "Aden Protectorate"


capture program drop harmonize_many
program define harmonize_many
    args modern old1 old2 old3 old4 old5

    ds country year, not
    local vars `r(varlist)'

    foreach v of local vars {
        bysort year: egen tmp = total(cond(inlist(country,"`old1'","`old2'","`old3'","`old4'","`old5'"), `v', .))
        bysort year: egen has_old = max(inlist(country,"`old1'","`old2'","`old3'","`old4'","`old5'") & !missing(`v'))

        replace `v' = `v' + tmp if country=="`modern'" & has_old==1 & !missing(`v')
        replace `v' = tmp       if country=="`modern'" & has_old==1 & missing(`v')

        drop tmp has_old
    }

    bysort year: egen has_modern = max(country=="`modern'")
    bysort year: gen old_member = inlist(country,"`old1'","`old2'","`old3'","`old4'","`old5'")
    bysort year: gen old_seq = sum(old_member)

    replace country = "`modern'" if has_modern==0 & old_member==1 & old_seq==1
    drop if old_member==1 & country!="`modern'"

    drop has_modern old_member old_seq
end

harmonize_many "Libya" "Cyrenaica" "Tripolitania" "" "" ""
harmonize_many "South Africa" "Cape Province" "Cape of Good Hope" "Natal" "Cape" ""
harmonize_many "Malaysia" "Sabah" "Sarawak" "Malaya" "West Malaysia" "British North Borneo"
harmonize_many "Indonesia" "Java and Madura" "" "" "" ""
harmonize_many "Nigeria" "Nigeria and British Cameroon" "" "" "" ""
harmonize_many "Ireland" "Southern Ireland" "" "" "" ""
harmonize_many "United Kingdom" "Northern Ireland" "" "" "" ""
harmonize_many "China" "Manchuria" "" "" "" ""
harmonize_many "Germany" "East Germany" "West Germany" "" "" ""
harmonize_many "Croatia" "Croatia-Slavonia" "" "" "" ""

save "/Users/chandramaharshivalasa/Dropbox/Historical Agricultural Statistics/updated_all_sources_master_new.dta"


