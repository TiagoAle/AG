clc;
clear all;
close all;
%Carregando dados da iris embaralhados
global X
global D
B = load('iris.data');
B = B(randperm(size(B,1)),:);

bias = repmat(-1,size(B,1),1);

B = [bias B];

D = B(:,6);
X = B(:,1:5);

geracoes = 50;
W = rand(20, 5);
populacaoInicial = W;

% INITIALIZE THE NEURAL NETWORK PROBLEM %
% inputs for the neural net
inputs = X;
% targets for the neural net
targets = D;
nvars = 5;
% create handle to the MSE_TEST function, that
% calculates MSE

% Setting the Genetic Algorithms tolerance for
% minimum change in fitness function before
% terminating algorithm to 1e-8 and displaying
% each iteration's results.
%% Start with the default options
options = gaoptimset;
%% Modify options setting
options = gaoptimset(options,'CrossoverFcn', {  @crossoverheuristic [] });
options = gaoptimset(options,'Display', 'off');
options = gaoptimset(options,'PlotFcns', { @gaplotbestf });
[x,fval,exitflag,output,population,score] = ...
ga(@myFitness,nvars,[],[],[],[],[],[],[],[],options);

Y_test = X * x';
for i = 1:150
    if(Y_test(i)> 0)
        Y_test(i) = 1;
    else
        Y_test(i) = 0;
    end
end