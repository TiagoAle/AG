clc;
clear all;
close all;
%Carregando dados da iris embaralhados
global X_treino
global D_treino
B = load('iris.data');
B = B(randperm(size(B,1)),:);

bias = repmat(-1,size(B,1),1);

B = [bias B];
treinamento = B(1:120,:);
teste = B(121:150,:);

D_treino = treinamento(:,6);
X_treino = treinamento(:,1:5);

Y_teste = teste(:,6);
X_teste = teste(:,1:5);

nvars = 5;
%% Start with the default options
options = gaoptimset;
%% Modify options setting
options = gaoptimset(options,'EliteCount', 4);
options = gaoptimset(options,'CrossoverFcn', {  @crossoverheuristic [] });
options = gaoptimset(options,'Display', 'off');
options = gaoptimset(options,'PlotFcns', { @gaplotbestf });
[x,fval,exitflag,output,population,score] = ...
ga(@myFitness,nvars,[],[],[],[],[],[],[],[],options);

Y_obt = X_teste * x';
for i = 1:30
    if(Y_obt(i)> 0)
        Y_obt(i) = 1;
    else
        Y_obt(i) = 0;
    end
end
mseTest = sum((Y_obt-Y_teste).^2)/length(Y_teste);