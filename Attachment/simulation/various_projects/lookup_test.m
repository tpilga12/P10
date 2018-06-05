clc
clear all

d = 0.9;
Ib = 0.003;
make_data_points = 10000;
            Qf = 72*(d/4)^0.635*pi*(d/2)^2*Ib^0.5;% Hennings
            h=0:d/make_data_points:(d);
            for t = 1:length(h)
                Q(t)= round((0.46 - 0.5 *cos(pi*(h(t)/d))+0.04*cos(2*pi*(h(t)/d)))*Qf,7);
            end
            fitfunc = fit(Q',h','poly9');
            lookup.Q = Q;
            lookup.h = h;
            lookup.limit = Qf;
          in = 0.8;
          tic
          fit_res = fitfunc(in)
          fit_time = toc
           
           tic 
           lut_res = lut(in,lookup)
           lut_time = toc 
            function look_func = lut(input,look)
                [~, indx] = min(abs(input-look.Q))
%                 look_func = look.h(1,nearestpoint(input, look.Q, 'nearest'));
                look_func = look.h(1,indx);
                

                if input > look.limit
                    fprintf('height limit in pipe crossed')
                end
                                     
            end