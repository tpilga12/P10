function [out]=tank(in_flow,OD,dia_out,Area,tank_height)
   
    

    Q_out(n) = abs((b0+b1*OD)*sqrt(rho*g*h(n-1)))
    %Q_out = 0.1+n/100;
    h_dot = (1/A)*(Q_in - Q_out(n))*Dt;
    
end