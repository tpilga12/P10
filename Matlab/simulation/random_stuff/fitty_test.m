
d = 1;
Ib = 0.003;


            Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ib^0.5;% Hennings
            h=0:d/10000:d;
            for t = 1:10001
                Q_init(t)=(0.46 - 0.5 *cos(pi*(h(t)/d))+0.04*cos(2*pi*(h(t)/d)))*Qf;
               div_Q(t)= (0.5 *(pi/d)* sin(pi*(h(t)/d))-0.04*(2*pi/d)*sin(2*pi*(h(t)/d)))*Qf;
                
            end
           fitty = fit(Q_init',h','poly9');
           div_fitty = differentiate(fitty,0.5);
           
           
           