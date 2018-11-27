% <Driver>
w = -50:50;
t = 0:0.1:8*pi;
Xt = cos(t) + cos(10*t);
result=zeros(1, 100);

% plot(t, Xt);

for i = 1:length(w)
    result(i) = MyFT(Xt, t, w(i));
end

figure, plot(w(31:70), result(31:70))

Wt = result;
Xt = MyiFT(Wt, w, t);
figure, plot(t, Xt);
% </Driver>