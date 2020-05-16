%% run visual_search_experiment first
%% verify completeness of dataset
% recall the following form of the dataset
% (2 task types, num_sizes sizes per task, num_trials trials per size, variables)

if ~isempty(find(~data(:,:,:,1),1))
    fprintf("FAILURE: data is incomplete\n")
    return
else 
    fprintf("SUCCESS: data is complete!\n")
end

%% calculate avg response time as a function of set size
%% split by pop-out vs conjunction search
pop_out_resp = mean(data(2, :, :, 1), 3);
conj_resp = mean(data(1, :, :, 1), 3);
figure;
plot(sizes, pop_out_resp, 'r', sizes, conj_resp, 'b');

%% plot line of best fit
hold on;
pop_out_coeffs = polyfit(sizes, pop_out_resp, 1);
conj_coeffs = polyfit(sizes, conj_resp, 1);
pop_out_fit = polyval(pop_out_coeffs, sizes);
conj_fit = polyval(conj_coeffs, sizes);
plot(sizes, pop_out_fit, 'r--', sizes, conj_fit, 'b--');

%% format plot
title("Response times as a function of task difficulty");
xlabel("Set size");
ylabel("Response time (s)");
legend(["pop-out" "conjunction"]);