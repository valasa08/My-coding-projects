%% Run and plot IRF of replication file 

   clear all;
   clc;

% Adjust path to folder where replication file is stored
cd('/Users/chandramaharshivalasa/Desktop/Iacoviello');
% Run replication dynare file
% dynare Iacoviello05_old.mod

dynare Iacoviello05_extension
% pause(2);
% whos;
edit Iacoviello05_extension.mod


%% % For interest rate shock when psi_i =0
rirfmon = oo_.irfs.Rhat_eRhat; % Nominal interest rate IRF
piirfmon = oo_.irfs.pihat_eRhat; % quarterly Inflation IRF
qirfmon = oo_.irfs.qhat_eRhat; % Real House price IRF
yirfmon = oo_.irfs.Yhat_eRhat; % Output IRF

% Go back to original path
cd('..');


% Plot replicated IRFs
t = 0:1:length(qirfmon)-1;
t2 = 1:1:length(qirfmon);
zeroline = ones(length(t),1)*0;

figure1 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Monetary Policy Shock (one standard deviation)');
subplot(2,2,1);
plot(t,rirfmon,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Nom. Int. Rate (R)','FontSize',10);

subplot(2,2,2);
plot(t,piirfmon,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Quarterly Inflation','FontSize',10);

subplot(2,2,3);
plot(t,qirfmon,t,zeroline,'LineWidth',2);
axis([0 20 -1 2]);
xlabel('quarters','FontSize',8);
title('House Price (q)','FontSize',10);

subplot(2,2,4);
plot(t,yirfmon,t,zeroline,'LineWidth',2);
axis([0 20 -1 2]);
xlabel('quarters','FontSize',8);
title('Output (Y)','FontSize',10);
% print -dpdf irf
%% For interest rate shock when psi_i =1.1197
rirfmon1 = oo_.irfs.Rhat_eRhat; % Nominal interest rate IRF
piirfmon1 = oo_.irfs.pihat_eRhat; % quarterly Inflation IRF
qirfmon1 = oo_.irfs.qhat_eRhat; % Real House price IRF
yirfmon1 = oo_.irfs.Yhat_eRhat; % Output IRF

% Go back to original path
cd('..');


% Plot replicated IRFs
t = 0:1:length(qirfmon1)-1;
t2 = 1:1:length(qirfmon1);
zeroline = ones(length(t),1)*0;

figure1 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Monetary Policy Shock (one standard deviation)');
subplot(2,2,1);
plot(t,rirfmon1,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Nom. Int. Rate (R)','FontSize',10);

subplot(2,2,2);
plot(t,piirfmon1,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Quarterly Inflation','FontSize',10);

subplot(2,2,3);
plot(t,qirfmon1,t,zeroline,'LineWidth',2);
axis([0 20 -1 2]);
xlabel('quarters','FontSize',8);
title('House Price (q)','FontSize',10);

subplot(2,2,4);
plot(t,yirfmon1,t,zeroline,'LineWidth',2);
axis([0 20 -1 2]);
xlabel('quarters','FontSize',8);
title('Output (Y)','FontSize',10);
% print -dpdf irf

%% Impulse Responses to a Monetary Policy Shock (Comparison)

% Define time vectors
t = 0:1:length(qirfmon)-1;
zeroline = zeros(length(t),1); % Zero line for reference

% Create a figure
figure1 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Monetary Policy Shock (Comparison)');

% Subplot 1: Nominal Interest Rate (R)
subplot(2,2,1);
plot(t, rirfmon, 'b-', 'LineWidth', 2); hold on; % First set (blue solid line)
plot(t, rirfmon1, 'r--', 'LineWidth', 2); % Second set (red dashed line)
plot(t, zeroline, 'k-', 'LineWidth', 1); % Zero line
hold off;
axis([0 20 -0.2 0.4]);
xlabel('Quarters', 'FontSize', 8);
title('Nom. Int. Rate (R)', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i=1.1'}, 'Location', 'best');

% Subplot 2: Quarterly Inflation
subplot(2,2,2);
plot(t, piirfmon, 'b-', 'LineWidth', 2); hold on;
plot(t, piirfmon1, 'r--', 'LineWidth', 2);
plot(t, zeroline, 'k-', 'LineWidth', 1);
hold off;
axis([0 20 -0.2 0.4]);
xlabel('Quarters', 'FontSize', 8);
title('Quarterly Inflation', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i=1.1'}, 'Location', 'best');

% Subplot 3: House Price (q)
subplot(2,2,3);
plot(t, qirfmon, 'b-', 'LineWidth', 2); hold on;
plot(t, qirfmon1, 'r--', 'LineWidth', 2);
plot(t, zeroline, 'k-', 'LineWidth', 1);
hold off;
axis([0 20 -1 2]);
xlabel('Quarters', 'FontSize', 8);
title('House Price (q)', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i=1.1'}, 'Location', 'best');

% Subplot 4: Output (Y)
subplot(2,2,4);
plot(t, yirfmon, 'b-', 'LineWidth', 2); hold on;
plot(t, yirfmon1, 'r--', 'LineWidth', 2);
plot(t, zeroline, 'k-', 'LineWidth', 1);
hold off;
axis([0 20 -1 2]);
xlabel('Quarters', 'FontSize', 8);
title('Output (Y)', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i=1.1'}, 'Location', 'best');

% Add a super title to the figure
sgtitle('Impulse Responses to a Monetary Policy Shock (Comparison)', 'FontSize', 14, 'FontWeight', 'bold');


%% % IRFs for cost-push shock
rirfcostpush = oo_.irfs.Rhat_euhat;   % Nominal interest rate IRF
piirfcostpush = oo_.irfs.pihat_euhat; % Quarterly inflation IRF
qirfcostpush = oo_.irfs.qhat_euhat;   % Real house price IRF
yirfcostpush = oo_.irfs.Yhat_euhat;   % Output IRF

% Go back to original path
cd('..');

% Plot replicated IRFs
t = 0:1:length(qirfcostpush)-1;
zeroline = zeros(length(t),1);

figure2 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Cost-Push Shock (one standard deviation)');

% Nominal Interest Rate
subplot(2,2,1);
plot(t,rirfcostpush,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Nom. Int. Rate (R)','FontSize',10);

% Quarterly Inflation
subplot(2,2,2);
plot(t,piirfcostpush,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Quarterly Inflation','FontSize',10);

% Real House Price
subplot(2,2,3);
plot(t,qirfcostpush,t,zeroline,'LineWidth',2);
axis([0 20 -1.5 2]);
xlabel('quarters','FontSize',8);
title('House Price (q)','FontSize',10);

% Output
subplot(2,2,4);
plot(t,yirfcostpush,t,zeroline,'LineWidth',2);
axis([0 20 -1.2 2]);
xlabel('quarters','FontSize',8);
title('Output (Y)','FontSize',10);

% Save the figure as a PDF (optional)
%print -dpdf irf_costpush


%% % IRFs for Housing Preference Shock when Psi_i= 0
rirfhousingshock = oo_.irfs.Rhat_ejhat;   % Nominal interest rate IRF (housing price shock)
piirfhousingshock = oo_.irfs.pihat_ejhat; % Quarterly inflation IRF (housing price shock)
qirfhousingshock = oo_.irfs.qhat_ejhat;   % Real house price IRF (housing price shock)
yirfhousingshock = oo_.irfs.Yhat_ejhat;   % Output IRF (housing price shock)
% b2hat = oo_.irfs.b2hat_ejhat;
% bhat = oo_.irfs.bhat_ejhat;
% 
% b_agg = btoY * bhat + b2toY * b2hat; (To see how borrowing is changing when there is a housing price shock)

% Go back to original path
cd('..');

% Plot replicated IRFs
t = 0:1:length(qirfhousingshock)-1;
zeroline = zeros(length(t),1);

figure3 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Housing Price Shock (one standard deviation)');

% Plot for Nominal Interest Rate (R)
subplot(2,2,1);
plot(t,rirfhousingshock,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Nom. Int. Rate (R)','FontSize',10);

% Plot for Quarterly Inflation (pihat)
subplot(2,2,2);
plot(t,piirfhousingshock,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Quarterly Inflation','FontSize',10);

% Plot for Real House Price (qhat)
subplot(2,2,3);
plot(t,qirfhousingshock,t,zeroline,'LineWidth',2);
axis([0 20 -0.5 1.5]);
xlabel('quarters','FontSize',8);
title('House Price (q)','FontSize',10);

 % Plot for Output (Yhat)
subplot(2,2,4);
plot(t,yirfhousingshock,t,zeroline,'LineWidth',2);
axis([0 20 -1.2 2]);
xlabel('quarters','FontSize',8);
title('Output (Y)','FontSize',10);

% Optionally, save the figure as a PDF
% print -dpdf irf_housingshock


%% % IRFs for Housing Preference Shock when Psi_i=1.197
rirfhousingshock1 = oo_.irfs.Rhat_ejhat;   % Nominal interest rate IRF (housing price shock)
piirfhousingshock1 = oo_.irfs.pihat_ejhat; % Quarterly inflation IRF (housing price shock)
qirfhousingshock1 = oo_.irfs.qhat_ejhat;   % Real house price IRF (housing price shock)
yirfhousingshock1 = oo_.irfs.Yhat_ejhat;   % Output IRF (housing price shock)
% b2hat = oo_.irfs.b2hat_ejhat;
% bhat = oo_.irfs.bhat_ejhat;
% 
% b_agg = btoY * bhat + b2toY * b2hat; (To see how borrowing is changing when there is a housing price shock)

% Go back to original path
cd('..');

% Plot replicated IRFs
t = 0:1:length(qirfhousingshock1)-1;
zeroline = zeros(length(t),1);

figure3 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Housing Price Shock (one standard deviation)');

% Plot for Nominal Interest Rate (R)
subplot(2,2,1);
plot(t,rirfhousingshock1,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Nom. Int. Rate (R)','FontSize',10);

% Plot for Quarterly Inflation (pihat)
subplot(2,2,2);
plot(t,piirfhousingshock1,t,zeroline,'LineWidth',2);
axis([0 20 -0.2 0.4]);
xlabel('quarters','FontSize',8);
title('Quarterly Inflation','FontSize',10);

% Plot for Real House Price (qhat)
subplot(2,2,3);
plot(t,qirfhousingshock1,t,zeroline,'LineWidth',2);
axis([0 20 -0.5 1.5]);
xlabel('quarters','FontSize',8);
title('House Price (q)','FontSize',10);

 % Plot for Output (Yhat)
subplot(2,2,4);
plot(t,yirfhousingshock1,t,zeroline,'LineWidth',2);
axis([0 20 -1.2 2]);
xlabel('quarters','FontSize',8);
title('Output (Y)','FontSize',10);

% Optionally, save the figure as a PDF
% print -dpdf irf_housingshock

%% Impulse Responses to a Housing Preference Shock (Comparison)
% Define time vector and zero line
t = 0:1:length(qirfhousingshock)-1;
zeroline = zeros(length(t),1);

% Create a figure
figure2 = figure('PaperSize',[20.98 29.68],...
    'Name','Impulse Responses to a Housing Preference Shock (Comparison)');

% Subplot 1: Nominal Interest Rate (R)
subplot(2,2,1);
plot(t, rirfhousingshock, 'b-', 'LineWidth', 2); hold on; % First set (blue solid line)
plot(t, rirfhousingshock1, 'r--', 'LineWidth', 2); % Second set (red dashed line)
plot(t, zeroline, 'k-', 'LineWidth', 1); % Zero line
hold off;
axis([0 20 -0.2 0.4]);
xlabel('Quarters', 'FontSize', 8);
title('Nom. Int. Rate (R)', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i =1.1'}, 'Location', 'best');

% Subplot 2: Quarterly Inflation (pihat)
subplot(2,2,2);
plot(t, piirfhousingshock, 'b-', 'LineWidth', 2); hold on;
plot(t, piirfhousingshock1, 'r--', 'LineWidth', 2);
plot(t, zeroline, 'k-', 'LineWidth', 1);
hold off;
axis([0 20 -0.2 0.4]);
xlabel('Quarters', 'FontSize', 8);
title('Quarterly Inflation', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i =1.1'}, 'Location', 'best');

% Subplot 3: Real House Price (qhat)
subplot(2,2,3);
plot(t, qirfhousingshock, 'b-', 'LineWidth', 2); hold on;
plot(t, qirfhousingshock1, 'r--', 'LineWidth', 2);
plot(t, zeroline, 'k-', 'LineWidth', 1);
hold off;
axis([0 20 -0.5 1.5]);
xlabel('Quarters', 'FontSize', 8);
title('House Price (q)', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i =1.1'}, 'Location', 'best');

% Subplot 4: Output (Yhat)
subplot(2,2,4);
plot(t, yirfhousingshock, 'b-', 'LineWidth', 2); hold on;
plot(t, yirfhousingshock1, 'r--', 'LineWidth', 2);
plot(t, zeroline, 'k-', 'LineWidth', 1);
hold off;
axis([0 20 -1.2 2]);
xlabel('Quarters', 'FontSize', 8);
title('Output (Y)', 'FontSize', 10);
legend({'\psi_i=0', '\psi_i =1.1'}, 'Location', 'best');

% Add a super title to the figure
sgtitle('Impulse Responses to a Housing Preference Shock (Comparison)', 'FontSize', 14, 'FontWeight', 'bold');

%% % IRFs for Output Shock
rirfoutputshock = oo_.irfs.Rhat_eAhat;   % Nominal interest rate IRF (output shock)
piirfoutputshock = oo_.irfs.pihat_eAhat; % Quarterly inflation IRF (output shock)
qirfoutputshock = oo_.irfs.qhat_eAhat;   % Real house price IRF (output shock)
yirfoutputshock = oo_.irfs.Yhat_eAhat;   % Output IRF (output shock)

% Time vector for plotting
t = 0:1:length(qirfoutputshock)-1;  % Time in quarters
zeroline = zeros(length(t), 1);     % Zero baseline for comparison

% Plot replicated IRFs
figure4 = figure('PaperSize', [20.98 29.68], ...
    'Name', 'Impulse Responses to an Output Shock (Technology Shock, one standard deviation)');

% Plot for Nominal Interest Rate (Rhat)
subplot(2, 2, 1);
plot(t, rirfoutputshock, t, zeroline, 'LineWidth', 2);
axis([0 20 -0.2 0.4]);  % Adjust axis limits if necessary
xlabel('quarters', 'FontSize', 8);
title('Nom. Int. Rate (R)', 'FontSize', 10);

% Plot for Quarterly Inflation (pihat)
subplot(2, 2, 2);
plot(t, piirfoutputshock, t, zeroline, 'LineWidth', 2);
axis([0 20 -0.2 0.4]);  % Adjust axis limits if necessary
xlabel('quarters', 'FontSize', 8);
title('Quarterly Inflation', 'FontSize', 10);

% Plot for Real House Price (qhat)
subplot(2, 2, 3);
plot(t, qirfoutputshock, t, zeroline, 'LineWidth', 2);
axis([0 20 -1.5 2]);  % Adjust axis limits if necessary
xlabel('quarters', 'FontSize', 8);
title('House Price (q)', 'FontSize', 10);

% Plot for Output (Yhat)
subplot(2, 2, 4);
plot(t, yirfoutputshock, t, zeroline, 'LineWidth', 2);
axis([0 20 -1.2 2]);  % Adjust axis limits if necessary
xlabel('quarters', 'FontSize', 8);
title('Output (Y)', 'FontSize', 10);

% Optionally save the figure as a PDF
% print -dpdf irf_outputshock

%% Aggregate consumption for different values of psi_i

 % Parameter Set 1: m = 0.55, psi = 0
chat_psi0 = oo_.irfs.chat_ejhat;    % Aggregate consumption for psi = 0
c1hat_psi0 = oo_.irfs.c1hat_ejhat;  % Patient households' consumption for psi = 0
c2hat_psi0 = oo_.irfs.c2hat_ejhat;  % Impatient households' consumption for psi = 0
c_agg_psi0 = ctoY * chat_psi0 + c1toY * c1hat_psi0 + c2toY * c2hat_psi0;
 
% Save results for Parameter Set 1
c_agg_1 = c_agg_psi0;

% Now change the parameters and rerun Dynare to get the second set of IRFs
% Parameter Set 2: m = 0.55, psi = 1.1
chat_psi1 = oo_.irfs.chat_ejhat;    % Aggregate consumption for psi = 1.1
c1hat_psi1 = oo_.irfs.c1hat_ejhat;  % Patient households' consumption for psi = 1.1
c2hat_psi1 = oo_.irfs.c2hat_ejhat;  % Impatient households' consumption for psi = 1.1
c_agg_psi1 = ctoY * chat_psi1 + c1toY * c1hat_psi1 + c2toY * c2hat_psi1;

% Save results for Parameter Set 2
c_agg_2 = c_agg_psi1;


%% Plotting aggregate consumption for different values of psi_i and m

% Time period and zero line
t = 1:length(c_agg_1);  % Time period (assumes both simulations have the same length)
zeroline = zeros(size(t));  % Line at zero for reference

% Journal-style color choices
color_psi0 = [0, 0.27, 0.55];  % Navy Blue for m = 0.55, psi_i = 0
color_psi1 = [0.55, 0, 0];     % Maroon for m = 0.55, psi_i = 1.1

% Plotting both curves on the same graph
figure;
plot(t, c_agg_1, 'Color', color_psi0, 'LineStyle', '-', 'LineWidth', 1.5); hold on; % Curve for m = 0.55, psi_i = 0
plot(t, c_agg_2, 'Color', color_psi1, 'LineStyle', '--', 'LineWidth', 1.5);        % Curve for m = 0.55, psi_i = 1.1
plot(t, zeroline, 'k-', 'LineWidth', 1);        % Thinner zero line for subtlety
hold off;

% Customize the graph
xticks(1:1:20);  % Set x-ticks to start from 1
xticklabels(1:20);  % Adjust labels to show "1" as the starting point
xlim([1 20]);  % Ensure the x-axis starts from 1
ylim([-0.5 0.5]);  % Keep the y-axis limits unchanged

% Customize the graph
axis([0 20 -0.5 0.5]);
xlabel('Quarters', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('Aggregate Consumption', 'FontSize', 10, 'FontWeight', 'bold');
title('Comparison of Aggregate Consumption', 'FontSize', 12, 'FontWeight', 'bold');

% Improved legend with descriptive parameter sets
legend({'m = 0.55, \psi_i = 0', 'm = 0.55, \psi_i = 1.1'}, ...
    'FontSize', 9, 'FontWeight', 'normal', 'Location', 'Best');

% Add grid for clarity
grid on;

% Additional aesthetic adjustments
set(gca, 'FontSize', 10, 'FontName', 'Times New Roman');  % Journal-style font
set(gcf, 'Color', 'w');  % White background for clean appearance






%%
%% Combined IRFs in a 4x4 format with professional colors
% Define time vector
t = 0:1:length(oo_.irfs.qhat_eRhat)-1;  % Adjust based on the length of responses
zeroline = zeros(length(t), 1);  % Zero baseline for all plots

% Define professional color palette
colors = [0, 0.27, 0.55;    % Deep navy blue
          0, 0.55, 0.27;    % Muted green
          0.55, 0, 0.27;    % Maroon
          0.27, 0, 0.55];   % Purple

% Create figure
figure('Name', 'Impulse Responses (4x4 Format)', 'Color', 'w', 'PaperSize', [20.98, 29.68]);

% Row 1: Monetary Policy Shock
subplot(4, 4, 1);
plot(t, oo_.irfs.Rhat_eRhat, 'Color', colors(1, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
title('Nom. Int. Rate (R)', 'FontSize', 12);
ylabel('Shock to R', 'FontSize', 12, 'FontWeight', 'bold');
ylim([-0.2, 0.4]);

subplot(4, 4, 2);
plot(t, oo_.irfs.pihat_eRhat, 'Color', colors(2, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
title('Quarterly Inflation', 'FontSize', 12);
ylim([-0.2, 0.4]);

subplot(4, 4, 3);
plot(t, oo_.irfs.qhat_eRhat, 'Color', colors(3, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
title('House Price (q)', 'FontSize', 12);
ylim([-1, 2]);

subplot(4, 4, 4);
plot(t, oo_.irfs.Yhat_eRhat, 'Color', colors(4, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
title('Output (Y)', 'FontSize', 12);
ylim([-1, 2]);

% Row 2: Cost-Push Shock
subplot(4, 4, 5);
plot(t, oo_.irfs.Rhat_euhat, 'Color', colors(1, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylabel('Shock to \pi', 'FontSize', 12, 'FontWeight', 'bold');
ylim([-0.2, 0.4]);

subplot(4, 4, 6);
plot(t, oo_.irfs.pihat_euhat, 'Color', colors(2, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylim([-0.2, 0.4]);

subplot(4, 4, 7);
plot(t, oo_.irfs.qhat_euhat, 'Color', colors(3, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylim([-1.5, 2]);

subplot(4, 4, 8);
plot(t, oo_.irfs.Yhat_euhat, 'Color', colors(4, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylim([-1.2, 2]);

% Row 3: Housing Preference Shock
subplot(4, 4, 9);
plot(t, oo_.irfs.Rhat_ejhat, 'Color', colors(1, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylabel('Shock to q', 'FontSize', 12, 'FontWeight', 'bold');
ylim([-0.2, 0.4]);

subplot(4, 4, 10);
plot(t, oo_.irfs.pihat_ejhat, 'Color', colors(2, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylim([-0.2, 0.4]);

subplot(4, 4, 11);
plot(t, oo_.irfs.qhat_ejhat, 'Color', colors(3, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylim([-0.5, 1.5]);

subplot(4, 4, 12);
plot(t, oo_.irfs.Yhat_ejhat, 'Color', colors(4, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylim([-1.2, 2]);

% Row 4: Output Shock
subplot(4, 4, 13);
plot(t, oo_.irfs.Rhat_eAhat, 'Color', colors(1, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
ylabel('Shock to Y', 'FontSize', 12, 'FontWeight', 'bold');
xlabel('Quarters', 'FontSize', 12);
ylim([-0.2, 0.4]);

subplot(4, 4, 14);
plot(t, oo_.irfs.pihat_eAhat, 'Color', colors(2, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
xlabel('Quarters', 'FontSize', 12);
ylim([-0.2, 0.4]);

subplot(4, 4, 15);
plot(t, oo_.irfs.qhat_eAhat, 'Color', colors(3, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
xlabel('Quarters', 'FontSize', 12);
ylim([-1.5, 2]);

subplot(4, 4, 16);
plot(t, oo_.irfs.Yhat_eAhat, 'Color', colors(4, :), 'LineWidth', 2); hold on;
plot(t, zeroline, 'Color', [0.7 0.7 0.7], 'LineWidth', 1); hold off;
xlabel('Quarters', 'FontSize', 12);
ylim([-1.2, 2]);

% Adjust subplot spacing for readability
sgtitle('Impulse Responses to Various Shocks', 'FontSize', 14, 'FontWeight', 'bold');  % Overall title
