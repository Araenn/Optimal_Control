clc; clear; close all

load("Experimental_Data.mat");
t = ToSave(:,1);
u1 = ToSave(:,2);
u2 = ToSave(:,3);
y1 = ToSave(:,4);
y2 = ToSave(:,5);

u1 = u1(75:end);
y1 = y1(75:end);
u2 = u2(75:end);
y2 = y2(75:end);

Y = [y1 y2]';
U = [u1 u2]';
i = 100;
j = length(u2) - i;

Yh1 = zeros(i, i+j-1);
Uh1 = zeros(i, i+j-1);
for k = 1:i-1
    for l = 1: i + j
        if k == 1
            Yh1(k,:) = [y1(k:i+j-k)'];
            Yh1(k + 1,:) = [y2(k:i+j-k)'];
            Uh1(k,:) = [u1(k:i+j-k)'];
            Uh1(k + 1,:) = [u2(k:i+j-k)'];
        else
            Yh1(k,:) = [y1(k:i+j-k)' y1(i+j-k+1:i+j)' y1(1:k-2)'];
            Yh1(k + 1,:) = [y2(k:i+j-k)' y2(i+j-k+1:i+j)' y2(1:k-2)'];
            Uh1(k,:) = [u1(k:i+j-k)' u1(i+j-k+1:i+j)' u1(1:k-2)'];
            Uh1(k + 1,:) = [u2(k:i+j-k)' u2(i+j-k+1:i+j)' u2(1:k-2)'];
        end
    end
end

Yh2 = zeros(i, length(y2)-1);
Uh2 = zeros(i, length(u2)-1);
for k = 1:i-1
    for l = i: length(y2)-1
        if k == 1
            Yh2(k,:) = [y1(k:end-k)'];
            Yh2(k + 1,:) = [y2(k:end-k)'];
            Uh2(k,:) = [u1(k:end-k)'];
            Uh2(k + 1,:) = [u2(k:end-k)'];
        else
            Yh2(k,:) = [y1(k:end-k)' y1(end-k+1:end)' y1(1:k-2)'];
            Yh2(k + 1,:) = [y2(k:end-k)' y2(end-k+1:end)' y2(1:k-2)'];
            Uh2(k,:) = [u1(k:end-k)' u1(end-k+1:end)' u1(1:k-2)'];
            Uh2(k + 1,:) = [u2(k:end-k)' u2(end-k+1:end)' u2(1:k-2)'];
        end
    end
end

Mh1 = [Yh1; Uh1];
Mh2 = [Yh2; Uh2];
Qf = orth(Mh1')';
Qg = orth(Mh2')';
[U, S, V] = svd(Qf'*Qg);
Xh = Qg * V;
n = 200;
X = Xh(n,:);




figure(1)
plot(u1)
hold on
plot(u2)
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