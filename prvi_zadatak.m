clc, clear, close all

N = 500;
x = linspace(0, 1, N);
h = 3 * sin(2* pi * 20 * x) + 3 * sin(2 * pi * 9 * x);
s = 0.6 * randn(1,N);
y = h + s;

figure, hold all
plot(x, h, 'r');
plot(x, y, 'b');
yline(0);

ulaz = x;
izlaz = y;

%%
ind = randperm(N); 
ind_trening = ind(1 : 0.9*N); 
ind_test = ind(0.9*N+1 : N); 

ulaz_trening = ulaz(ind_trening);
izlaz_trening = izlaz(ind_trening);

ulaz_test = ulaz(ind_test);
izlaz_test = izlaz(ind_test);

%% Kreiranje neuralne mreze
net = fitnet([7, 15]);

net.divideFcn = '';
net.trainFcn = 'trainlm';

net.trainParam.epochs = 1000; 
net.trainParam.goal = 1e-3; 
net.trainParam.min_grad = 1e-4;

%%
net = train(net, ulaz_trening, izlaz_trening);

%%
figure, hold all
plot(ulaz, izlaz)
plot(ulaz, net(ulaz), 'r')