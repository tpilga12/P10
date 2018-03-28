function [sys,x0,str,ts] = initloss(t,x,u,flag,init,k)

%This function subtracts the initial loss from the rain data at the
%beginning of each rain period 

%init is the initial loss[mm]

%S-function, written according to "Writing S-functions"- handbook

%Cecilia Engvall, June 11 1999



switch flag,
  
  %%%%%%%%%%%%%%%%%%
  % Initialization %
  %%%%%%%%%%%%%%%%%%
  % Initialize the states, sample times, and state ordering strings.
  case 0
    [sys,x0,str,ts]=mdlInitializeSizes;
  
  %%%%%%%%%%
  % Update %
  %%%%%%%%%%
  case 2,                                                
    sys = mdlUpdate(t,x,u,init,k); 

  %%%%%%%%%%%
  % Outputs %
  %%%%%%%%%%%
  % Return the outputs of the S-function block.
  case 3
    sys=mdlOutputs(t,x,u,init,k);

  %%%%%%%%%%%%%%%%%%%
  % Unhandled flags %
  %%%%%%%%%%%%%%%%%%%
  % There are no termination tasks (flag=9) to be handled.
  % Also, there are no continuous  states,
  % so flags 1 and 4 are not used, so return an empty u
  % matrix 
  case { 1,  4, 9 }
    sys=[];

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Unexpected flags (error handling)%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Return an error message for unhandled flag values.
  otherwise
    error(['Unhandled flag = ',num2str(flag)]);

end

% end initloss

%
%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,x0,str,ts] = mdlInitializeSizes

sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 1;
sizes.NumOutputs     = -1;  % dynamically sized
sizes.NumInputs      = -1;  % dynamically sized
sizes.DirFeedthrough = 1;   % has direct feedthrough
sizes.NumSampleTimes = 1;

sys = simsizes(sizes);
str = [];
x0  = 0;
ts  = [1 0];   %  sample time=1
k=0;


% end mdlInitializeSizes

%=======================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=======================================================================
%
function sys = mdlUpdate(t,x,u,init,k)

%x keeps track of the rain status at the previous sample
%x=0 -> it didn't rain
%x=10 -> it rained and more rain than initial loss has fallen
%0<x<init -> x tells how much initial loss has been withdrawn
if u==0
   disp('1')
   sys=u
   k=sys+1
elseif x>=init
   disp('2')
   sys=10
else
   disp('3')
   sys=x+u
end

%end mdlUpdate

%=============================================================================
% mdlOutputs
% Return the output vector for the S-function
%=============================================================================
%
function sys = mdlOutputs(t,x,u,init,k)

%outputs rain after subtraction of initial loss
x
k
%it is not raining
if u==0
   disp('10')
  sys=0
end

%it is raining and initial loss is already subtracted
if x>=init
   disp('11')
  sys=u
end

%it didn't rain before and now it rains a lot
if x==0 & u>=init
   disp('12')
  sys=u-init
end

%it didn't rain before and now it rains a little
if x==0 & u<init
   disp('13')
  sys=0
end

%it rained a little before
if x>0 & x<init
   disp('14')
  sys=max(u-(init-x),0)
end

% end mdlOutputs
