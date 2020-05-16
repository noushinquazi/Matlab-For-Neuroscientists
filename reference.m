%% creating variables + arithmetic operations
a = 3;
b = 2;
% exponent
b^2
exp(3) % e^3
nextpow2(a)

% mod
mod(a, b)

% log
log(a)
log10(a)
log1p(a)

% roots
sqrt(a)
nthroot(a,a)

%% assign multiple variables in one line (generic)
[r1, c1, v1] = subsref({zeros(3,1), "a", zeros(2,2)}, substruct('{}',{':'}));

%% creating sequences
% specify increments
start = 1;
inc = 10;
end_ = 50;
seq1 = start:inc:end_

% specify size
seq2 = linspace(start, end_, inc)

%% creating vectors + arithmetic operations
a = 3 * ones(1,10);
b = 2 * ones(1,10);

mu = 10;
std = 2;
c = std * rand(1,10) + mu; % uniform dist
d = std * randn(1,10) + mu; % normal dist

e = [1 0 2; 3 4 5] % hardcode

% basic math
a + b
a .* b % element-wise product
a * b' % inner product
a' * b % outer product 
a .^ b

%% creating matrices + arithmetic operations
a = 3 * ones(10) % specifying one number n usually generates n x n tensor
b = zeros(10)

mu = 10;
std = 2;
c = std * rand(10) + mu; % uniform dist
d = std * randn(10) + mu; % normal dist

% basic math
a - b
a * c
a .* c
a / c
a ./ c

% exponent + natural log
expm(c)
logm(d)

% eigenvalues
[V, D] = eig(d)
V
D

% indexing
c(1,2)
d(3,:)
% c(3,) not valid
c(1:2,:)
c(1:2, 3:5)

% concatenate
[c, d]

% find
% IMPORTANT returned indices are in columnar order
find(e) % index of non-zero elements in flattened array
find(~e) % index of zero elements in flattened array
find(e < 4) % criteria
find(e <4, 2) % top 2 that satisfy criteria
k = find(e < 4, 2, 'last') % bottom 2
e(k) % plug indices into tensor to get original elems

% A + A' (outer addition)
[1, 2] + [1, 2]' 
[2, 3; 3, 4] % result

%% structures
data = rand(10, 3);
a = struct();
a.A = data(:,1)
a.B = data(:,2)
b = struct("A",data(:,1), "B", data(:,2))

% array
c = struct()
c(1).field1 = "val";
c(1).field2 = 3;
c(1).field3 = [1, 2];
c(2).field1 = "val2";
c(2).field2 = 4.5;
c(2).field3 = [3, 4];
c

% indexing
c(1), c(2)
b.A
b.("B")

%% strings + operations
str = "hello world"
pi = string(pi())
str_mat = [str, pi]

% length
strlength(str) % reports num characters
length(str) % since strings are scalars, this returns 1
strlength(str_mat)

% concatenation
str + pi
append(str, pi)
str + pi() % converts numerics to string automatically
str_mat + str_mat % addition applies to string matrices

% indexing (CAN'T DO THIS BC STRINGS ARE SCALARS)

%% character vectors + operations
char1 = 'hello world';
char2 = char(str);

% length
length(char1)
strlength(char1)

% concat
[char1 char2]
append(char1, char2)

% indexing
char1(2:4)

%% plotting
% lines
data = struct()
data.X = randn(1, 100)
data.Y = 3 * data.X + 5
data.Y2 = -4 * data.X + 10

% way 1
figure()
plot(data.X, data.Y)
hold on; % keep what's currently on figure
plot(data.X, data.Y2)
title("Example")
xlabel("Dim 1")
ylabel("Dim 2")
hold off;

% way 2
figure()
plot(data.X, data.Y, data.X, data.Y2)
title("Example")
xlabel("Dim 1")
ylabel("Dim 2")

% histogram
figure()
h = histfit(data.X)
h(1).FaceColor = [0.9, 0.5, 0.2];
h(1).EdgeColor = 'g';
title("My histogram");
xlabel("var");

% bar
fig = figure();
bar_data = [rand(1,3); rand(1,3); rand(1,3)];
bar(bar_data)
title("My bar")
xlabel("vars")

% fplot
figure()
myfunc = @(x)x.^3 % c-style DEFINE
fplot(myfunc, [0 10])

% close all open figures
%close all;
% close specific figure
%close(fig) 


%% save and load variables
% hit "Save workspace" to save all variables
% select subset of variables and hit "Save as"
save("varfile") % save all workspace variables to file
save("varfile2", 'a', 'b') % save specific variables to file
% load("varfile");
% load("varfile2", 'a', 'b');

%% write and read 2D matrix to/from file
mat = [1 2; 3 4];
writematrix(mat, "matrix_file"); % saves matrix in txt
mat2 = readmatrix("matrix_file.txt");
isequal(mat, mat2)