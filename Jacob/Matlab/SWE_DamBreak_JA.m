% ========================================================================
% Matlab program to solve the 1D SWE using the Lax-Friedrichs,
% Lax-Wendroff, MacCormack or Adams Average scheme.
% Simulates water being released with Dam Break conditions. 
% The user is allowed to select one of the schemes to run.
% Uses an initial rectangular Dam profile with bed slope omitted.
% Initial Dam profile can be changed by editing parameters in depth
% function.
% A Heuristic time step is used with a safety factor.
% Zero gradient boundary conditions are set, however reflective can be
% activated if necessary.
% Simulation will halt if the time step becomes too small (i.e. the scheme 
% becomes unstable). 
% Plots a time step graph after simulation has finished. 

% Additional info
% The Adams Average scheme was Devised by myself (James Adams) in 2014. 
% Recommended parameters are,
% A = 4, B = 4, C = 1 (Feel free to change these however scheme may not
% perform as well). 
%=========================================================================

function SWE_DamBreak_JA
clear
clc
clf
%========== Sets constants (same for all schemes)==========================
N = 501;   % Defines the no. of grid points
p = 0;   % Sets the lower domain boundary
q = 100; % Sets the upper domain boundary
dx = (q - p)/(N - 1); % Calculates the grid spacing between points
g = 9.81; % Defines gravity constant
s = 0.8; % Safety Factor for timestep calculation
runningtime = 100;  % Set time simulation runs for
t = 0  % Definines initial time
iterations = 0; % Sets initial iterations to 0
pausetime = 0.1;  % Set time inverval between simulation
leftboundary = 0;    % Initiates left solid boundary condition if set to 1
rightboundary = 0;   % Initiates right solid boundary condition if set to 1
x = p : dx : q ;  % Calculates initial values of x using grid spacing
%==========================================================================

for i = 1 : N
    h(i) = Hinitial(x(i));        % Sets initial flow depth
end

v = Vinitial(x,N);        % Sets initial flow velocity

Choice = input('Lax-Friedrichs - 1  MacCormack - 2  Lax-Wendroff - 3  Adams Average - 4\n\n');  % Select a scheme to run

% ================= Defines array sizes =================================
if Choice == 2
    h = [0 h 0];         % Defines array size of future boundary values
    v = [0 v 0];
elseif Choice == 3
    h = [0 h 0];         % Defines array size of future boundary values
    v = [0 v 0];
end

U1(1:N+2) = zeros;   % Defines array size of future grid points
U2(1:N+2) = zeros;

if Choice == 3
    U1predplus(1:N+2) = zeros;  % Defines Lax-Wendroff arrays if scheme
    U1predminus(1:N+2) = zeros;  % is chosen
    U2predplus(1:N+2) = zeros;
    U2predminus(1:N+2) = zeros;
end


[h, v] = boundary(h,v, leftboundary, rightboundary,N,Choice);  % Sets boundary values for height and velocity
[un1, un2, F1, F2] = dependent(h,v,g);        % Sets initial dependent variables

if Choice == 1   
    A = 1;
    B = 1;      % DO NOT CHANGE THESE VALUES
    C = 0;
% ==================== Parameters for Adams Average scheme ================
elseif Choice == 4
    A = 4;
    B = 4;    % Values can be changed
    C = 1;
end

%=======================  Runs Scheme  ====================================

while t < runningtime  % Halts the program when condition is violated
    dt = timestepinequality(dx,s,v,g,h);       % Calculates timestep dt
    t = t + dt                                 % Calculates time program runs for
    iterations = iterations + 1;               % Adds 1 to the iteration no.
    c = dt/dx;    % Calculates this here to save computation 
    
    if Choice ==  1 | Choice == 4   % Applies Lax-Friedrichs or Adams Average scheme (depending on choice)
        for j = 2 : N + 1
            U1(j) = (A*un1(j - 1) + B*un1(j + 1) + C*un1(j))/(A+B+C) - 0.5 * c * (F1(j+1) - F1(j-1));  
            U2(j) = (A*un2(j - 1) + B*un2(j + 1) +  C*un2(j))/(A+B+C) - 0.5 * c *(F2(j+1) - F2(j-1));
        end
    elseif Choice == 2 % Applies MacCormack scheme
        for j = 2 : N + 1
            U1(j) = un1(j) - c * (F1(j+1) - F1(j));  % Applies MacCormack predictor scheme
            U2(j) = un2(j) - c * (F2(j+1) - F2(j));
        end
        un1pred = un1;    
        un2pred = un2;      % Stores values for corrector formula
                            % (this way they wont be overwritten).
        U1pred = U1;    
        U2pred = U2;      
        
        [h,v] = redependent(U1,U2,N, leftboundary, rightboundary,Choice);   % Calculates new h and v values for corrector scheme
        [~, ~, F1,F2] = dependent(h,v,g);     % Calculates new flux values for corrector scheme
        
        for j = 2 : N + 1
            U1(j) = 0.5 * (un1pred(j) + U1pred(j) - c * (F1(j) - F1(j-1)));  % Applies MacCormack corrector scheme
            U2(j) = 0.5 * (un2pred(j) + U2pred(j) - c * (F2(j) - F2(j-1)));  % for rest of values (Replaces predictor values).
        end
    elseif Choice == 3  % Applies Lax-Wendroff scheme
        for j = 2 : N + 1
            U1predplus(j) = 0.5 *(un1(j+1) + un1(j)) - 0.5 * c * (F1(j+1) - F1(j));  % Applies first steps of Lax-Wendroff scheme
            U2predplus(j) = 0.5 *(un2(j+1) + un2(j)) - 0.5 * c * (F2(j+1) - F2(j));
            
            U1predminus(j) = 0.5 *(un1(j) + un1(j-1)) - 0.5 * c * (F1(j) - F1(j-1));
            U2predminus(j) = 0.5 *(un2(j) + un2(j-1)) - 0.5 * c * (F2(j) - F2(j-1));
        end
        
        un1pred = un1;   % Stores current gridpoints for second step.
        un2pred = un2;   % (prevents overwritting)
        
        U1 = U1predplus;   % Changes variables for redependent function.
        U2 = U2predplus;
        
        [h,v] = redependent(U1,U2,N, leftboundary, rightboundary,Choice);   % recalculates dependent
        [~, ~, F1, F2] = dependent(h,v,g);                                  % variables.
        
        F1predplus = F1;    % Stores values for second step calculation.
        F2predplus = F2;    % (prevents overwritting)
        
        U1 = U1predminus;   % Changes variables for redependent function.
        U2 = U2predminus;
        
        [h,v] = redependent(U1,U2,N, leftboundary, rightboundary,Choice); % recalculates
        [~, ~, F1, F2] = dependent(h,v,g);                         % dependent variables
        
        F1predminus = F1;  % Stores values for second step calculation
        F2predminus = F2;  % (prevents overwritting)
        
        for k = 2 : N + 1
            U1(k) = un1pred(k) - c * (F1predplus(k) - F1predminus(k));  % Applies Step two of
            U2(k) = un2pred(k) - c * (F2predplus(k) - F2predminus(k));  % Lax-Wendroff scheme.
        end
    end
    
    if dt < 10^-5  % Terminates loop is scheme becomes unstable
        t = runningtime;
        fprintf('\n\nScheme has become unstable. Simulation terminated.')
    end
    
    [h,v] = redependent(U1,U2,N, leftboundary, rightboundary,Choice);     % Recalculates dependent variables
    
    subplot(2,1,1)
    plot(x, h(2:N+1),'b')  % Plots water height aproximations for each timestep.
    axis([p q min(h) 1.1*max(h)])
    
    %=============== Sets titles and labels depending on choice ===========
    if Choice == 1
        title('Water height for Lax-Friedrichs Scheme','Fontsize',12)
    elseif Choice == 2
        title('Water height for MacCormack Scheme','Fontsize',12)
    elseif Choice == 3
        title('Water height for Lax-Wendroff Scheme','Fontsize',12)
    elseif Choice == 4
        title(['Water height for Adams Average Scheme   A = ' num2str(A) '  B = ' num2str(B) '  C = ' num2str(C)],'Fontsize',12)
    end
    xlabel('x [m]','Fontsize', 12)
    ylabel('h [m]', 'Fontsize', 12)
 
    subplot(2,1,2)
    plot(x, v(2:N+1),'b')   % Plots water velocity aproximations for each timestep.
    axis([p q min(v) 1.1*max(v)])   
    
    %=============== Sets titles and labels depending on choice ===========
    if Choice == 1
        title('Water velocity for Lax-Friedrichs Scheme','Fontsize',12)
    elseif Choice == 2
        title('Water velocity for MacCormack Scheme','Fontsize',12)
    elseif Choice == 3
        title('Water velocity for Lax-Wendroff Scheme','Fontsize',12)
    elseif Choice == 4
        title('Water velocity for Adams Average Scheme','Fontsize',12)
    end
    xlabel('x [m]','Fontsize', 12)
    ylabel('v [m/s]', 'Fontsize', 12)
    
    timestore(iterations) = t; % Stores time at each iteration
    timestep(iterations) = dt; % Stores time step at each iteration
    
    pause(pausetime)   % Shows results for each timestep.
    
    [un1, un2, F1, F2] = dependent(h,v,g);   % Recalculates flux vectors and
                                             % and matrix of dependent variables
end
%=========================== Terminates Scheme ============================
pause(5)  % Pauses for 5 seconds before time step graph appears
clf
plot(timestore,timestep,'r')  % Plots time step results

%=============== Sets titles and labels depending on choice ===========
if Choice == 1
    title('Values for dt obtained from heuristic calculation - Lax-Friedrichs','fontsize',14)
elseif Choice == 2
    title('Values for dt obtained from heuristic calculation - MacCormack','fontsize',14)
elseif Choice == 3
    title('Values for dt obtained from heuristic calculation - Lax-Wendroff','fontsize',14)
end
xlabel('Time [seconds]','fontsize',18)
ylabel('dt [seconds]','fontsize',18)
axis([0 t 0 max(timestep)])
end

%====================  Functions of initial conditions ====================
function depth = Hinitial(x) 
depth = 0.2;   % <<<<<<<< This is the depth of the Dam (can be changed)
damwall = 30;  % <<< Defines the location of the breached Dam wall
               % (do not select a number less than p or larger than q)
if x >= damwall 
    depth = 0.1;   % Defines the initial depth of the floor water (do not   
end                % use zero). 
end

function velocity = Vinitial(x,N)  % Defines initial velocity
for j = 1 : N
    velocity (j) = 0; % <<<< Sets initial velocity to zero (can be changed).
end
end

%======== Function of initial independent and dependent variables =========
function[un1, un2, F1, F2] = dependent(h,v,g)
un1 = h;                 % Function to calculate initial
un2 = h.*v;              % dependent variables.

F1 = h.*v;
F2 = h.*v.^2 + (g.*h.^2)/2;
end

%=========== Functions to recalculate height and velocities================
function[h,v] = redependent(U1,U2,N, leftboundary, rightboundary,Choice)
if Choice == 1
    h = U1(2:N+1);             % Calculates new h and v values for Lax-F
    v = U2(2:N+1)./U1(2:N+1);  % (Old ghost values are deleted)
elseif Choice == 4
    h = U1(2:N+1);             % Calculates new h and v values for Adams Average
    v = U2(2:N+1)./U1(2:N+1); 
elseif Choice == 2
    h = U1;             % < Calculates new h and v values for MacCormack
    v = U2./U1;         
elseif Choice == 3
    h = U1;             % < Calculates new h and v values for lax-Wendroff
    v = U2./U1;         
end
[h, v] = boundary(h,v, leftboundary, rightboundary,N,Choice);  % Recalculates boundary values
end

%=========== Function to calculate timestep ==============================
function [dt, max1, max2, maxoverall] = timestepinequality(dx,s,v,g,h)
max1 = max(abs(v + sqrt(g*h)));
max2 = max(abs(v - sqrt(g*h)));
maxoverall = max(max1,max2);      % Calculates maximum wave speed

dt = s * dx / maxoverall;   % Calculates timestep
end

%============= Function to calculate Boundary conditions ==================
function [h v] = boundary(h,v, leftboundary, rightboundary,N,Choice)  
% Sets boundary conditions (either zero gradient or reflective)
if Choice == 1 % Lax-Friedrichs 
    if leftboundary == 0 && rightboundary == 0
        h = [h(1) h h(N)];
        v = [v(1) v v(N)];
    elseif leftboundary ==1 && rightboundary == 0
        h = [h(1) h h(N)];
        v = [-v(3) v v(N)];
    elseif leftboundary == 0 && rightboundary == 1
        h = [h(1) h h(N)];
        v = [v(1) v -v(N-2)];
    elseif leftboundary == 1 && rightboundary == 1
        h = [h(1) h h(N)];
        v = [-v(3) v -v(N-2)];
    end
elseif Choice == 4 % Adams Average
    if leftboundary == 0 && rightboundary == 0
        h = [h(1) h h(N)];
        v = [v(1) v v(N)];
    elseif leftboundary ==1 && rightboundary == 0
        h = [h(1) h h(N)];
        v = [-v(3) v v(N)];
    elseif leftboundary == 0 && rightboundary == 1
        h = [h(1) h h(N)];
        v = [v(1) v -v(N-2)];
    elseif leftboundary == 1 && rightboundary == 1
        h = [h(1) h h(N)];
        v = [-v(3) v -v(N-2)];
    end
elseif Choice == 2 % MacCormack
    if leftboundary == 0 && rightboundary == 0
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = v(2);
        v(N+2) = v(N+1);
    elseif leftboundary ==1 && rightboundary == 0
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = -v(3);
        v(N+2) = v(N+1);
    elseif leftboundary == 0 && rightboundary == 1
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = v(2);
        v(N+2) = -v(N);
    else
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = -v(3);
        v(N+2) = -v(N);
    end
elseif Choice == 3 % Lax-Wendroff
    if leftboundary == 0 && rightboundary == 0
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = v(2);
        v(N+2) = v(N+1);
    elseif leftboundary ==1 && rightboundary == 0
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = -v(3);
        v(N+2) = v(N+1);
    elseif leftboundary == 0 && rightboundary == 1
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = v(2);
        v(N+2) = -v(N);
    else
        h(1) = h(2);
        h(N+2) = h(N+1);
        v(1) = -v(3);
        v(N+2) = -v(N);
    end
end
end
%=========================== End of Program ===============================