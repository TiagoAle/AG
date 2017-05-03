function mse_calc = myFitness(x)
    global X_treino
    global D_treino
    y = X_treino * x';
    for i = 1:120
        if(y(i)> 0)
           y(i) = 1;
        else
           y(i) = 0;
        end
    end
    mse_calc = sum((y-D_treino).^2)/length(D_treino);
end

