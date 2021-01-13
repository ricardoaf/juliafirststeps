function copy_multidimensional_arrays (n_rep, N)
if nargin<1 || isempty(n_rep), n_rep = 5; end
if nargin<2 || isempty(N), N = [5000 7000 9000]; end

loop_time = zeros(size(N));
vec_time = zeros(size(N));
for i = 1:length(N), n = N(i);
    
    A_ = rand(n, n, 3);
    
    A = A_; tic;
    for k = 1:n_rep, A = loop_strategy(A, n); end
    loop_time(i) = toc/n_rep;
    
    A = A_; tic;
    for k = 1:n_rep, A = vec_strategy(A, n); end
    vec_time(i) = toc/n_rep;
end
disp('Loop time [s]:'); disp(loop_time)
disp(' Vec time [s]:'); disp(vec_time)


function A = loop_strategy(A, n)
for i = 1:n
    for j = 1:n
        A(i,j,1) = A(i,j,2);
        A(i,j,3) = A(i,j,1);
        A(i,j,2) = A(i,j,3);
    end
end

function A = vec_strategy(A, ~)
A(:,:,[1 3 2]) = A(:,:,[2 1 3]);
