function [est] = secant(fun,a,b,limit)

est = 10;
i = 2;
x(1) = a;
x(2) = b;
while abs(est) > limit
x(i+1) = x(i) - (fun(x(i)))*((x(i) - x(i-1))/(fun(x(i))-fun(x(i-1))));

est = abs(x(i+1)-x(i))
i = i+1;

end

