%% visually inspect distribution between valid and invalid cues
histogram(data.('Response Time')(data.('Valid') == 1), 'DisplayName', 'Valid Cue');
hold on;
histogram(data.('Response Time')(data.('Valid') == 0), 'DisplayName', 'Invalid Cue');
title("Valid vs Invalid Cue Response Times");
xlabel("Response Times(s)");
legend();

%% numerically verify difference
A = data.('Response Time')(data.('Valid') == 1);
B = data.('Response Time')(data.('Valid') == 0);
[sig, p] = ttest2(A, B);
if (p <= 0.05)
    fprintf("Significant difference between valid and invalid cues. P-value %d\n", p);
end

%% numerically verify whether valid is less than invalid on average
A = data.('Response Time')(data.('Valid') == 1);
B = data.('Response Time')(data.('Valid') == 0);
[sig, p] = ttest2(A, B, 'Tail', 'left');
if (p <= 0.05)
    fprintf("Valid cue responses significantly less than invalid cues. P-value %d\n", p);
end
