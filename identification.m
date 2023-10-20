clc; clear; close all

load("Experimental_Data.mat");
t = ToSave(:,1);
u1 = ToSave(:,2);
u2 = ToSave(:,3);
y1 = ToSave(:,4);
y2 = ToSave(:,5);

t = t(105:end);
t = t - t(1);
u1 = u1(105:end);
u1 = u1 - 130;
y1 = y1(105:end);
y1 = y1 - y1(1);
u2 = u2(105:end);
u2 = u2 - 130;
y2 = y2(105:end);
y2 = y2 - y2(1);

Y = [y1 y2]';
U = [u1 u2]';
j = 200;

i = floor((length(u2) - j)/2);

Yh1 = zeros(i, j);
Uh1 = zeros(i, j);
Yh2 = zeros(i, j);
Uh2 = zeros(i, j);
for k = 1:i
    Yh1((1:2)+(k-1)*2, :) = Y(:,k:k+j-1);
    Uh1((1:2)+(k-1)*2, :) = U(:,k:k+j-1);

    Yh2((1:2)+(k-1)*2, :) = Y(:,(k:k+j-1)+i);
    Uh2((1:2)+(k-1)*2, :) = U(:,(k:k+j-1)+i);
end

Mh1 = [Yh1; Uh1];
Mh2 = [Yh2; Uh2];
Qf = orth(Mh1')';
Qg = orth(Mh2')';
[Us, S, V] = svd(Qf'*Qg);
Xh = Qg * V;
n = 10;
X = zeros(n, j);
for m = 1:n
    X(m,:) = Xh(m,:);
end

C = Y(:, i:j-1)' \ X(:, i:j-1)';
B = X(:, i+1:j-1)' \ U(:, i:j-2)';
A = X(:, i+1:j-1)' \ X(:, i:j-2)' ;

dt = 20;
figure(1)
plot(t, u1)
hold on
plot(t, u2)
grid("on")
title("Entrée")
legend("u1", "u2")

figure(2)
plot(y1)
hold on
plot(y2)
grid("on")
title("Sortie")
legend("y1", "y2")