function mse_calc = myFitness(x)
    global X
    global D
    y = X * x';
    for i = 1:150
        if(y(i)> 0)
           y(i) = 1;
        else
           y(i) = 0;
        end
    end
    mse_calc = sum((y-D).^2)/length(D);
end

