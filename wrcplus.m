function [w, tr_err] = wrcplus(X, y, lambda)
    
    %Normalizes the data
    m_X=mean(X);
    s_X=std(X);

    %mu_mat=repmat(m_X,size(X,1),1);
    s_mat_X=repmat(s_X,size(X,1),1);
    X=(X-m_X)./s_mat_X;
    
    m_y=mean(y);
    s_y=std(y);

    %mu_mat_y=repmat(m_y,size(y,1),1);
    s_mat_y=repmat(s_y,size(y,1),1);
    y=(y-m_y)./s_mat_y;
    

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

    I = eye(d1);
    %initial w (X'*X + lambda*I) * (X'*y)  
    A = X'*X + lambda*I;
    B = X'*y;
    %w = pinv(A) * B; %initializing w, way of doing the inverse
    w = zeros(d1,1); %for error check
    
    
    r = zeros(d1,1);
    conv = 0; %converging limit
    p = 1;
    obj = zeros(1, d1);
    least_sq = zeros(d1,1); 
    loss = [];
    loss2 = [];
    
    while conv < 100 
        
        for i = 1:d1

            a = 0;
            for j = 1:m1
                a = a + 2*(X(j,i).^2);
            end

            c = 0;
            for j = 1:m1
                c = c + 2*(X(j,i)*(y(j) - w'*X(j,:)' + w(i)*X(j,i)));
            end
            
            %soft thresholding
            w(i) = sign(c/a)*(max((abs(c/a)-(lambda/a)),0));
            
            %checking value of objective function
            %{
            if (i == 1 && conv == 0)
                r = lambda * norm(w,p); % r is regularizer
                least_sq = (norm(y-(X*w))).^2; %Least square 
                obj_wo =  (r + least_sq);
            end
            %}
        end
        
        %calculating objective function
        r = lambda * norm(w,p); % r is regularizer
        least_sq = (norm(y-(X*w))).^2; %Least square 
        obj =  (r + least_sq);
        
        %loss for objective function
        loss = [loss;obj];
        conv = conv + 1;
        
        %loss for training error
        tr_err = (1/m1)*sum((y-(X*w)).^2);
        loss2 = [loss2;tr_err];
    end
    

    %[r,~] = size(loss);
    %[r2, ~] = size(loss2);
    %{
    figure(1)
    for i = 1:r
        plot(i,loss(i),'*');
        title("objective lambda = 0.01, w = (X'*X + lambda*I) * (X'*y)")
        hold on;
    end
    hold off;
    
    figure(2)
    for i = 1:r2
        plot(i, loss2(i),'*');
        title("trr err lambda = 0.01, w = (X'*X + lambda*I) * (X'*y)")
        hold on;
    end
    hold off;
    %}
    %tr_err = (1/m1)*sum((X*w - y).^2);
    %disp(obj_wo) %displays objective function
    %disp(sum(y.^2)) % displays the objective function when w = 0

end
