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
    %initial w (X'*X + lambda*I) * (X'*y)  
    A = X'*X + lambda*I;
    B = X'*y;
    w = pinv(A) * B; %initializing w, way of doing the inverse
    %wrc_w = zeros(m2,d2);
    r = zeros(d1,1);
    least_sq = zeros(1,m1);
    conv = 0; %converging limit
    a = zeros(1,m1);
    c = zeros(1,m1);
    p = 1;
    w = [];
    
    while conv < 100  
        for i = 1:d1
            r(i) = lambda * norm(w,p); % r is regularizer
            least_sq(:,i) = (norm(y-X*w))^2; %Least square 
            obj(i,:) = r(i) + least_sq(:,i);
            
               
            a(i) = 2*sum(X(i,:)'.^2);
               
            c(i) = 2*sum(X(i,:)*(y(i) - w'*X(i,:) + w(i,:)*X(i,:)));
            
            %soft thresholding
            w(i,:) = sign(c(i),a(i)) * max((abs(c(i)/a(i)) - (lambda/a(i))),0);
        end
        conv = conv + 1;
    end
    
end


    
 
    
    
    
    
    
    