function w = wrcplus(X, y, lambda)

    [m1, d1] = size(X);
    [m2, d2] = size(y);
    
    %y must be a m_y by 1 vector
    if (d2 ~= 1 )
        w = [];
        return;
    end
    
    % compare X and y row size
    if (m1 ~= m2 )
        w = [];
        return;
    end
    
    %lambda has to be greater than or equal to 0
    if(lambda < 0 )
        w = [];
        return;
    end
    
    %converg_tol = 1e-4; % convergence tolerance
    I = eye(d1);
    w_init = ((X.'*X + lambda*I)^-1) * (X.'*y); %initializing w
    r = zeros(1,d);
    exact_s = zeros(1,m);
    p = 1;
    iter = 100; % iterations
    
    for i = 1:d1
        r(i) = lambda * norm(w_init,p); % r is regularizer
        
        for j = 1:m1
            exact_s(:,j) = (norm(y-X*w_init))^2; %exact_s is exact sparsity
            
            w_init(:,j) = r(i) + exact_s(:,j);
            if (w_init(:,j) < lambda)
                
        end
    end
end
