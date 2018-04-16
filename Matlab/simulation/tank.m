function [Q_out error]=tank(Q_in,OD,max_out,Volume,tank_height,height,m)
global Dt
   error = 0;
   O_degree = OD;
   rho = 1000;
   g = 9.82;
  % valve limit
  if height > tank_height
      fprintf('Error, fluid height is larger than tank height')
      Q_out = 0;
      error = 1;
      return
  elseif tank_height
  else
      if OD < 0
          O_degree = 0;
      elseif OD > 1
          O_degree = 1;
      end
      
      if m == 1
          h(m) = height
          Q_out(m) = abs((max_out*O_degree)*sqrt(rho*g*h(m)))
          h_dot = (1/(Volume/tank_height))*(Q_in - Q_out(m))*Dt;
          h(m+1) = h(m)+h_dot;
      else
          Q_out(m) = abs((max_out*O_degree)*sqrt(rho*g*h(m)))
          h_dot = (1/(Volume/tank_height))*(Q_in - Q_out(m))*Dt;
          h(m+1) = h(m)+h_dot;
      end
  end
end