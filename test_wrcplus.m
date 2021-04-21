clear all
close all

load Xtest
load ytest
for z = 1:5
    for lambda=1:10^z:1000
        [w_train]=wrcplus(X_train,y_train,lambda);
        [w_test]=wrcplus(X_test,y_test,lambda);

        [w, train_err, val_err] = wrcplus(Xtrain,ytrain,lambda);
        train_err_array(lambda)=train_err;
        val_err_array(lambda) = val_err;
        test_err_array(lambda)=mean((ytest-Xtest*w).^2);
    end
end

plot(train_err_array,'r')
hold on
plot(val_err_array,'b')
plot(test_err_array,'lambda')
xlabel('lambda')
ylabel('Errors')
legend('Training error', 'Validation err', 'Testing error')