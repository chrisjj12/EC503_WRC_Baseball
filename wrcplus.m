function w = wrcplus(X, y, lambda)
    X = X(:, 1:11);
    %X = normalize(X,'scale');
    %y = normalize(y,'scale');
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
    %X = [ones(m1,1),X];
    %converg_tol = 1e-4; % convergence tolerance
    I = eye(d1);
    %initial w (X'*X + lambda*I) * (X'*y)  
    A = X'*X + lambda*I;
    B = X'*y;
    w = pinv(A) * B; %initializing w, way of doing the inverse
 
    
    
    %wrc_w = zeros(m2,d2);
    r = zeros(d1,1);
    %least_sq = zeros(1,m1);
    conv = 0; %converging limit
    %a = zeros(1,m1);
    %c = zeros(1,m1);
    p = 1;
    %w = [];
    obj = zeros(1, d1);
    least_sq = zeros(d1,1); 
    loss = [];
    loss2 = [];
    while conv < 50 
        
        for i = 1:d1
            %r = lambda * norm(w,p); % r is regularizer
            checkr = size(r)
            wsize = size(w)
            xsize = size(X)
            %least_sq(i) = (norm(y-(X*w))).^2; %Least square 
            %least_sq = mean((y-X*w).^2)
            checklstsqr = size(least_sq)
            %obj(i) = r(i) + least_sq(:,i);
            %obj(i) = (1/m1)*(r(i) + (least_sq(i)));
            
            %a = 2*sum(X(i,:)'.^2);
            a = 0;
            for j = 1:m1
                a = a + 2*(X(j,i).^2);
            end
            
               
            %c = 2*sum(X(i,:)*(y(i) - w*X(i,:) + w(i,:)*X(i,:)));
            c = 0;
            for j = 1:m1
                c = c + 2*(X(j,i)*(y(j) - w'*X(j,:)' + w(i)*X(j,i)));
            end
            checka = size(a)
            checkc = size(c)
            
            %soft thresholding
            %w(i,:) = sign(c(i),a(i)) * max((abs(c(i)/a(i)) - (lambda/a(i))),0);
            w(i) = sign(c/a)*(max((abs(c/a)-(lambda/a)),0));
        end
        r = lambda * norm(w,p); % r is regularizer
        least_sq = (norm(y-(X*w))).^2; %Least square 
        obj =  (1/m1) * (r + least_sq);
        
        
        %objcheck = obj
        tr_err = least_sq;
        loss2 = [loss2;tr_err];
        %tr_err = mean(r) + mean(least_sq);
        
        %loss2 = [loss2;tr_err];
        loss = [loss;obj];
        conv = conv + 1;
        
        
    end
    %tr_err = mean((X*w-y).^2);
    y_predict = X*w;
    [r,~] = size(loss);
    [r2, ~] = size(loss2);
    checkloss = size(loss)
    figure(1)
    for i = 1:r
        plot(i,loss(i),'*');
        title("objective lambda = 100")
        hold on;
    end
    hold off;
    figure(2)
    for i = 1:r2
        plot(i, loss2(i),'*');
        title("trr err lambda = 100")
        hold on;
    end
    hold off;


end
