function [Q_out error]=tank(Q_in,OD,pipe_spec,Volume,tank_height,height)
global Dt m
persistent h
   error = 0;
   O_degree = OD;
   rho = 1000;
   g = 9.82;
   max_out = 72*(pipe_spec(1).d/4)^0.635*pi*(pipe_spec(1).d/2)^2*pipe_spec(1).Ib^0.5;
  % valve limit
  if m == 1
      h(m) = height;
  end
  if height > tank_height
      fprintf('Error, fluid height is larger than tank height')
      Q_out = 0;
      error = 1;
      return
  else
      if OD < 0
          O_degree = 0;
      elseif OD > 1
          O_degree = 1;
      end
      

      Q_out = abs((max_out*O_degree*max_out)*sqrt(rho*g*h(m))/1000);
      h_dot = (1/(Volume/tank_height))*(Q_in - Q_out)*Dt;
      h(m+1) = h(m)+h_dot;
      if h(m+1) < 0
          h(m+1) = 0;
      end
  end
end