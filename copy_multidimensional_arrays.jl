function copy_multidimensional_arrays(n_rep=5, N=[5000 7000 9000])

    loop_time = zeros(size(N))
    vec_time = zeros(size(N))

    for i = 1:length(N); n = N[i]

        A_ = rand(n, n, 3)

        A = A_;
        loop_time[i] = @elapsed begin
            for k = 1:n_rep; A = loop_strategy(A, n); end
        end
        loop_time[i] /= n_rep;

        A = A_;
        vec_time[i] = @elapsed begin
            for k = 1:n_rep; A = vec_strategy(A); end
        end
        vec_time[i] /= n_rep;
    end
    println("Loop time [s]:"); println(loop_time)
    println(" Vec time [s]:"); println(vec_time)

end

function loop_strategy(A, n)
    for j = 1:n, i = 1:n
        A[i,j,1] = A[i,j,2]
        A[i,j,3] = A[i,j,1]
        A[i,j,2] = A[i,j,3]
    end
    return A
end

function vec_strategy(A)
    A[:,:,[1 3 2]] = A[:,:,[2 1 3]];
    return A
end

copy_multidimensional_arrays()






