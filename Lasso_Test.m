[w, tr_err] = wrcplus(Xtrain,ytrain,10);
Xtest = X21_test_rapid;
ytest = y21_test_rapid;
m_X=mean(Xtest);
s_X=std(Xtest);

%mu_mat=repmat(m_X,size(X,1),1);
s_mat_X=repmat(s_X,size(Xtest,1),1);
Xtest=(Xtest-m_X)./s_mat_X;
    
m_y=mean(ytest);
s_y=std(ytest);

%mu_mat_y=repmat(m_y,size(y,1),1);
s_mat_y=repmat(s_y,size(ytest,1),1);
ytest1=(ytest-m_y)./s_mat_y;


test_pred = Xtest*w;

test_error = mean((test_pred-ytest1).^2); %0.2224
truetest_pred = test_pred*s_y + m_y;
test_errunnorm = mean((truetest_pred-ytest).^2);

figure(1)
plot(ytest, 'b')
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