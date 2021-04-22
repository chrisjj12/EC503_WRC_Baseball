[w, tr_err] = wrcplus(Xtrain_raw,ytrain_raw,10);
Xtest_raw = X21_test_raw;
ytest_raw = y21_test_raw;
m_X=mean(Xtest_raw);
s_X=std(Xtest_raw);

%mu_mat=repmat(m_X,size(X,1),1);
s_mat_X=repmat(s_X,size(Xtest_raw,1),1);
Xtest=(Xtest_raw-m_X)./s_mat_X;
    
m_y=mean(ytest_raw);
s_y=std(ytest_raw);

%mu_mat_y=repmat(m_y,size(y,1),1);
s_mat_y=repmat(s_y,size(ytest_raw,1),1);
ytest1=(ytest_raw-m_y)./s_mat_y;


test_pred = Xtest*w;

test_error = mean((test_pred-ytest1).^2); %0.2224
truetest_pred = test_pred*s_y + m_y;
test_unnorm = mean((truetest_pred-ytest_raw).^2);

figure(1)
plot(ytest_raw, 'b')
hold on
plot(truetest_pred, 'r')
xlabel('Players')
ylabel('wRC+')
legend('True', 'Predicted')
title('2019 & 2021 Seasons')
hold off

%{
figure(2)
plot(ytest1, 'b')
hold on
plot(test_pred, 'r')
legend("True", "Predicted")
ylabel('wRC+')
xlabel('Players')
title('Test Error = 0.2224')
%}