%% run visual_search_experiment first
%% verify completeness of dataset
% recall the following form of the dataset
% (2 task types, num_sizes sizes per task, num_trials trials per size, variables)
if isempty(data.("Response Time") == 0)
    fprintf("FAILURE: data is incomplete\n")
    return
else 
    fprintf("SUCCESS: data is complete!\n")
end

%% calculate avg response time as a function of set size
%% split by pop-out vs conjunction search
grp_stats = grpstats(data, {'Set Size', 'Condition'}, "mean", "DataVars", "Response Time");
pop_out_resp = grp_stats.("mean_Response Time")(grp_stats.Condition == POPOUT);
conj_resp = grp_stats.("mean_Response Time")(grp_stats.Condition == CONJ);
figure;

% tile layout for subplots
tiledlayout(2,2);
nexttile([1, 2]);
plot(sizes, pop_out_resp, 'r', sizes, conj_resp, 'b');

% plot line of best fit
hold on;
pop_out_coeffs = polyfit(sizes, pop_out_resp, 1);
conj_coeffs = polyfit(sizes, conj_resp, 1);
pop_out_fit = polyval(pop_out_coeffs, sizes);
conj_fit = polyval(conj_coeffs, sizes);
plot(sizes, pop_out_fit, 'r--', sizes, conj_fit, 'b--');

% format plot
title("Response times as a function of task difficulty");
xlabel("Set size");
ylabel("Response time (s)");
legend(["pop-out" "conjunction"]);

%% plot data for when target is present
grp_stats = grpstats(data, {'Set Size', 'Condition', 'Target Present'}, "mean", "DataVars", "Response Time");
pop_out_resp_tar = grp_stats.("mean_Response Time")(grp_stats.Condition == POPOUT & grp_stats.('Target Present') == 1);
conj_resp_tar = grp_stats.("mean_Response Time")(grp_stats.Condition == CONJ & grp_stats.('Target Present') == 1);

% only include sizes where target is present
popout_tar_sizes = unique(data.('Set Size')(data.('Target Present') == 1 & data.Condition == POPOUT));
conj_tar_sizes = unique(data.('Set Size')(data.('Target Present') == 1 & data.Condition == CONJ));

nexttile;
plot(popout_tar_sizes, pop_out_resp_tar, 'r', conj_tar_sizes, conj_resp_tar, 'b');

% line of best fit
hold on;
pop_out_coeffs_tar = polyfit(popout_tar_sizes, pop_out_resp_tar, 1);
conj_coeffs_tar = polyfit(conj_tar_sizes, conj_resp_tar, 1);
pop_out_fit_tar = polyval(pop_out_coeffs_tar, popout_tar_sizes);
conj_fit_tar = polyval(conj_coeffs_tar, conj_tar_sizes);
plot(popout_tar_sizes, pop_out_fit_tar, 'r--', conj_tar_sizes, conj_fit_tar, 'b--');

% format plot
title(["Response times as a function", " of task difficulty (target present)"]);
xlabel("Set size");
ylabel("Response time (s)");
legend(["pop-out" "conjunction"]);

%% plot data for when target is not present
pop_out_resp_tar = grp_stats.("mean_Response Time")(grp_stats.Condition == POPOUT & grp_stats.('Target Present') == 0);
conj_resp_tar = grp_stats.("mean_Response Time")(grp_stats.Condition == CONJ & grp_stats.('Target Present') == 0);

% only include sizes where target is present
popout_tar_sizes = unique(data.('Set Size')(data.('Target Present') == 0 & data.Condition == POPOUT));
conj_tar_sizes = unique(data.('Set Size')(data.('Target Present') == 0 & data.Condition == CONJ));

nexttile;
plot(popout_tar_sizes, pop_out_resp_tar, 'r', conj_tar_sizes, conj_resp_tar, 'b');

% line of best fit
hold on;
pop_out_coeffs_tar = polyfit(popout_tar_sizes, pop_out_resp_tar, 1);
conj_coeffs_tar = polyfit(conj_tar_sizes, conj_resp_tar, 1);
pop_out_fit_tar = polyval(pop_out_coeffs_tar, popout_tar_sizes);
conj_fit_tar = polyval(conj_coeffs_tar, conj_tar_sizes);
plot(popout_tar_sizes, pop_out_fit_tar, 'r--', conj_tar_sizes, conj_fit_tar, 'b--');

% format plot
title(["Response times as a function", " of task difficulty (target not present)"]);
xlabel("Set size");
ylabel("Response time (s)");
legend(["pop-out" "conjunction"]);
