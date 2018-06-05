
syms h d Qf Q
Q = (0.46 - 0.5 *cos(pi*(h/d))+0.04*cos(2*pi*(h/d)))*Qf;

solve((Q == (0.46 - 0.5 *cos(pi*(h/d))+0.04*cos(2*pi*(h/d)))*Qf),h)