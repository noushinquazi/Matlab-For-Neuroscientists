%% setup figure which will contain visual search objects
% target is green O when present
fig = fullfig; % install fullfig.m from matlab file exchange for this to work
xlim = [0 1];
ylim = [0 1];
fontsize = 20;
tar_symbol = "O";
nontar_symbol = "X";
tar_col = "green";
nontar_col = "red";

% instructions
% plot(xlim, ylim);
axis = gca;
axis.Position(3) = 0.5;
instructions = {['target is {\color{green}',char(tar_symbol), '}'],...
    'Press ''j'' if you see the target'...
    '''k'' otherwise'};
annotation('textbox', [0.65, 0.2, 0.1, 0.1], 'interpreter', 'tex','String', instructions);

%% set up data
% number of objects on screen
% even sizes
start_size = 4;
num_sizes = 4;
end_size = 16;
sizes = linspace(start_size, end_size, num_sizes); %[4, 8, 12, 16]


% data containers
num_trials = 20;
n_vars = 2; % (response time, indicator for target, indicator for correct trial)
RESP_TIME = 1;
TARGET = 2;
data = zeros(2, num_sizes, num_trials, n_vars); % (2 task types, num_sizes sizes per task, num_trials trials per size, variables)

%% iterate over trials for pop-out and conjunction search
for cond=1:2 % cond = 1 is conjunction, cond = 2 is popout
    pop_out = logical(cond - 1); % translate to flag for popout
    for size_idx = 1:num_sizes % iterate over num objects on screen
            num_correct_trials = 0;
            while num_correct_trials < num_trials % wait until num_trials correct trials  
                %% set up screen
                num_objs = sizes(size_idx); % number of objects on screen
                tar_pos = rand(1, 2) * 0.7 + 0.1; % randomly pick target position on screen
                tar_present = logical(rand(1) > 0.5); % coin flip if target is present
                
                %% paint target
                tar_t = text(tar_pos(1), tar_pos(2), tar_symbol, 'Color', nontar_col, 'FontSize', fontsize);

                %% set up distractors
                dis_data = struct;
                dis_data.pos = rand(num_objs - 1, 2) * 0.7 + 0.1; % randomly pick distractor positions
                
                % if conjunctive, ensure exact number of 'X' and 'O'
                dis_x = randsample(num_objs - 1, num_objs / 2);
                dis_o = setdiff(1:num_objs - 1, dis_x);
                dis_data.symbols = [""];
                dis_data.symbols(dis_x) = nontar_symbol;
                dis_data.symbols(dis_o) = tar_symbol;
                                
                % make sure no distractor circles match target
                dis_data.colors(dis_o) = nontar_col;
                dis_data.colors(dis_x) = tar_col;
                
                % if conjunctive search and target present, make sure to even out the number of
                % target and non-target colors by selecting a distractor of
                % the opposite shape to match non-target color
                if (tar_present)
                    set(tar_t, 'Color', tar_col);
                    rand_x = randsample(dis_x, 1);
                    dis_data.colors(rand_x) = nontar_col;
                end
                
                % if popout, then randomly pick feature for popout
                % and make sure no other object matches the target feature
                if (pop_out && tar_present)
                    popout_color = logical(rand(1) > 0.5);
                    if (popout_color)
                        dis_data.colors(1:num_objs - 1) = deal(nontar_col);
                    else
                        dis_data.symbols(1:num_objs - 1) = deal(nontar_symbol);
                    end
                end

                %% paint distractors
                tt = text(dis_data.pos(:,1), dis_data.pos(:,2), dis_data.symbols, 'FontSize', fontsize);
                for i = 1: num_objs - 1
                    tt(i).Color = dis_data.colors(i);
                end
                
                %% time response
                tic;
                pause
                key = get(fig, 'CurrentCharacter');
                t = toc;
                
                %% record response
                if (key == 'j' && tar_present || key == 'k' && ~tar_present) % correct response
                    num_correct_trials = num_correct_trials + 1;
                    data(cond, size_idx, num_correct_trials, :) = [t double(tar_present)];
                    fprintf("correct trial # %d\n", num_correct_trials);
                else
                    fprintf("incorrect\n");
                end
                clf(fig) % clears figure
            end
    end
 end
