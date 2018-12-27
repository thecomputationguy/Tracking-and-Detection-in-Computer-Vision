clc;
clear all;

x = rand(100,1);

y = 10*x + 0.5;

y1 = y + randn(size(y));



y1(10) = 155;
y1(5) = 126;
y1(5) = 157;
y1(60) = 155;
y1(75) = 156;
y1(50) = 154;

points = [x y1];

[robustModel, robustPoints] = ransac_rahul(4,points,20,100);

p = polyfit(x,y1,1);
f = polyval(p,x);
p1 = polyfit(robustPoints(:,1), robustPoints(:,2), 1);
f1 = polyval(p1, robustPoints(:,1));
plot(x, y1, 'o', x, f, '-');
axis([0 1 -10 200]);
legend('data','linear fit')
figure
plot(robustPoints(:,1), robustPoints(:,2), 'x', robustPoints(:,1), f1, '-');
axis([0 1 -10 200]);
legend('robust data','robust fit')
hold on