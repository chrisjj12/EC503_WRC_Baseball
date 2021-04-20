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
    A = X'*X + lambda*I;
    B = X'*y;
    w_init = A\eye(size(A))*B; %initializing w
    wrc_w = zeros(m2,d2);
    r = zeros(d1,1);
    exact_s = zeros(1,m1);
    p = 1;
    w = [];
    
    
    for i = 1:d1
        r(i) = lambda * norm(w_init,p); % r is regularizer
        disp(r)
        
        for j = 1:m1
            exact_s(:,j) = (norm(y-X*w_init))^2; %exact_s is exact sparsity
            
            wrc_w(j,:) = r(i) + exact_s(:,j);
  
        end
    end
    
    %squared loss
    for a = 1:m1
        if (y(j) - wrc_w(j,:)).^2/m1 > 1 %subject to change
            wrc_w(j,:) = [];
        end
    end
    w = wrc_w;
end


    
 
    
    
    
    
    
    