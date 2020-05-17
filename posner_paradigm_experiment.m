%%% 4.4 Project
%% dependencies: allcomb.m from File Exchange
%% set up experiment conditions
% model trials as a tuplet (cue position, valid/invalid, delay1/delay2, reaction time)
num_pos = 16;
num_trials = 20; % trials per set of conditions
cues = 1:num_pos;
valid_cond = [1 0];
delay_cond = [100 300];
unique_trials = allcomb(cues, valid_cond, delay_cond);
trials = repelem(unique_trials, num_trials, 1);
data = [trials zeros(size(trials, 1),1)];

% shuffle trials
data = data(randperm(size(data,1)),:);

%% set up screen
fig = fullfig;
screen_dims = [0 sqrt(num_pos)];
screen_grid = allcomb(0:sqrt(num_pos), 0:sqrt(num_pos));
xlim(screen_dims);
ylim(screen_dims);
% text(0, 0, "H", 'FontSize', 30);
% text(4, 0, "H", 'FontSize', 30);
% text(4, 1, "H", 'FontSize', 30);

for r = 1:size(screen_grid, 1)
    coord = screen_grid(r,:);
    text(coord(1), coord(2), "H", 'FontSize', 30);
end