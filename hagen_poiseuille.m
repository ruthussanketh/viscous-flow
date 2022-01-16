% The plotted graphs are scaled down by an order of 1e6.

G = 100;                  % Pressure gradient
mu = 8.9e-4;              % Viscosity
a = 50;                   % Radius of pipe
uz_0 = G*(a^2)/(4*mu);    % uz at r = 0
uz_a = 0;                 % uz at the boundary
n = 20;                   % Number of mesh points
r = linspace(0,a,n);      % mesh domain

% Analytical solution
uz_analytical = (G/(4*mu))*(a^2 - r.^2);

% Numerical solution
iter_max = 100;           % Maximum number of iterations

dr = a/(n-1);             % delta r

uz_numerical(1) = uz_0;
uz_numerical(n) = uz_a;

for i = 1:iter_max
    for j = 2:n-1
        
        uz_numerical(j) = ((G*((j-1)*a/(n-1))*(dr^2)/mu) + (((j+0.5-1)*a/(n-1))*uz_numerical(j+1)) + ...
            (((j-0.5-1)*a/(n-1))*uz_numerical(j-1)))/(((j+0.5-1)*a/(n-1))+((j-0.5-1)*a/(n-1)));
                
    end 
end 

figure(1);
plot(r, uz_analytical/1e6, 'Linewidth', 1.25);
title("Analytical and numerical velocity solutions");
xlabel("Radius  of the pipe");
ylabel("Velocity");
hold on;
plot(r, uz_numerical/1e6, 'Linewidth', 1.25);
legend("Analytical solution", "Numerical solution");
grid on;

figure(2);
plot(r, (abs(uz_numerical - uz_analytical))/1e6, 'Linewidth', 1.25);
title("Error in the velocity");
xlabel("Radius  of the pipe");
ylabel("Error");
grid on;

clear;
clc;
