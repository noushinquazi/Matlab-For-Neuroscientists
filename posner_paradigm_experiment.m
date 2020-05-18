%%% 4.4 Project
%% dependencies: allcomb.m from File Exchange
%% set up experiment conditions
% don't use the same seed across tries
rng(sum(100*clock));

% model trials as a tuplet (cue position, valid/invalid, delay1/delay2, reaction time)
num_pos = 4; % number of cue positions
num_conds = 2; % number of conditions
num_trials = 1; % trials per combo of conditions
cues = 1:num_pos;
valid_cond = [1 0];
delay_cond = [100 300];
cue_disp_time = 0.25; % # secs to display cue
unique_trials = allcomb(cues, valid_cond, delay_cond);
trials = repelem(unique_trials, num_trials, 1);
data = [trials zeros(size(trials, 1),1)];

% randomly choose color for cue so subject continues to track cue w/ same
% level of arousal
cols = 'ymrgbk';

% shuffle trials
data = data(randperm(size(data,1)),:);

%% set up screen
fig = fullfig;
max_dim = sqrt(num_pos) - 1;
screen_dims = [0 max_dim + 1];
screen_grid = allcomb(0:max_dim, 0:max_dim);
xlim(screen_dims);
ylim(screen_dims);

%% wait for user to be ready
intro_t = text(ceil(max_dim / 4), ceil(max_dim / 2), ["Instructions: Focus on colored oval.", "Click enter when 'X' appears", "Click enter to start!"], 'FontSize', 30); 
pause;
key = get(fig, 'CurrentKey');
while ~strcmp(key, 'return')
    pause;
    key = get(fig, 'CurrentKey');
end
delete(intro_t);


%% conduct trials
%% first showing cue and then target
%% and collecting response time
for t_idx = 1:size(data,1)
    cell_data = num2cell(data(t_idx, 1:1+num_conds)); % get cue + conditions
    [cue_pos, valid, delay] = cell_data{:};
    
    % flash cue for delay ms
    coords = screen_grid(cue_pos,:);
    col = randsample(cols, 1);
    rect = rectangle('Position', [coords + 0.25 0.5 0.5], 'Curvature',[1,1], 'FaceColor', col);
    pause(cue_disp_time);
    cla;

    % display target either at cue or random loc
    if (valid == 0)
        new_cue_pos = randsample(cues, 1);
        while (new_cue_pos == cue_pos)
            new_cue_pos = randsample(cues, 1);            
        end
        cue_pos = new_cue_pos;
    end
    coords = screen_grid(cue_pos,:);
    pause(1e-3 * delay);
    text(coords(1) + 0.5, coords(2) + 0.5, "X", 'FontSize', 30);
    
    % time response
    tic;
    pause
    key = get(fig, 'CurrentKey');
    while ~strcmp(key, 'return')
        pause;
        key = get(fig, 'CurrentKey');
    end
    t = toc;
    data(t_idx, 1 + num_conds + 1) = t;
    cla;
end
text(ceil(max_dim / 4), ceil(max_dim / 2), ["You're done!", "Press enter to quit."], 'FontSize', 30); 
pause;
key = get(fig, 'CurrentKey');
while ~strcmp(key, 'return')
    pause;
    key = get(fig, 'CurrentKey');
end
data = array2table(data, 'VariableNames', {'Cue Position', 'Valid', 'Delay', 'Response Time'});
close(fig);
