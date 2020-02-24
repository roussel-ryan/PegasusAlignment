function [centroids] = gp_explore(limits)
%GP_EXPLORE Search the 2d trim space using GP regression
%   Detailed explanation goes here

    x = linspace(limits(1),limits(2),10);
    
    x_train = [1 2];
    y_train = [1 4];
    sigma = 1;
    sigma_y = 0;
    
    [x, mu, cov] = gp_predict(x,x_train,y_train);
    hold all
    plot(x,mu)
    patch([x fliplr(x)],[mu-cov fliplr(mu+cov)],'b')
    
    function y = RBFKernel(x1,x2)
       y = exp(-norm(x1 - x2)^2 /(2*sigma^2)); 
    end
    
    function [x, mu, cov] = gp_predict(x,x_train,y_train)
        %calculate the function prediction at test points x using
        %training points (x_train,y_train)
        
        %calculate the covarience of the training points
        n_test_pts = length(x);
        n_train_pts = length(x_train);
        K = zeros(n_train_pts,n_train_pts);
        for i = 1:n_train_pts
            for j = 1:n_train_pts
                K(i,j) = RBFKernel(x_train(i),x_train(j));
            end
        end
        
        %add noise if necessary
        K = K + sigma_y^2 * eye(n_train_pts);
        
        %calculate the covarience between the training points and
        %the test points
        K_star = zeros(n_train_pts,n_test_pts);
        for k = 1:n_train_pts
            for l = 1:n_test_pts
                K_star(k,l) = RBFKernel(x(l),x_train(k));
            end
        end
        
        %finally, calculate covarience between test points
        K_star_star = zeros(n_test_pts,n_test_pts);
        for m = 1:n_test_pts
            for n = 1:n_test_pts
                K_star_star(m,n) = RBFKernel(x(m),x(n));
            end
        end
        
        mu = (K_star.' * inv(K) * y_train.').';
        cov = diag(K_star_star - K_star.' * inv(K) * K_star).';
        
    end
    

end

