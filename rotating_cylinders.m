r1 = 5;                   % Inner radius
r2 = 10;                  % Outer radius
w1 = 25;                  % Inner cylinder's rotational speed
w2 = 50;                  % Outer cylinder's rotational speed
uz_r1 = r1*w1;            % uz at r = r1
uz_r2 = r2*w2;            % uz at r = r2
n = 10;                   % Number of mesh points
r = linspace(r1,r2,n);    % mesh domain

A = (r2^2*w2 - r1^2*w1)/(r2^2 - r1^2);
B = r1^2*r2^2*(w1 - w2)/(r2^2 - r1^2);

% Analytical solution
uz_analytical = A.*r + B./r;

% Numerical solution
iter_max = 100;           % Maximum number of iterations

dr = (r2 - r1)/(n-1);             % delta r

uz_numerical(1) = uz_r1;
uz_numerical(n) = uz_r2;

for i = 1:iter_max
    for j = 2:n-1
                
        uz_numerical(j) = (((j-1)*dr)^2*(uz_numerical(j+1) + uz_numerical(j-1)) ...
            + (j-1)*dr^2*uz_numerical(j+1))/(dr^2 + (j-1)*dr^2 + 2*((j-1)*dr)^2);
                
    end 
end 

figure(1);
plot(r, uz_analytical, 'Linewidth', 1.25);
title("Analytical and numerical velocity solutions");
xlabel("Radius  of the pipe");
ylabel("Velocity");
hold on;
plot(r, uz_numerical, 'Linewidth', 1.25);
legend("Analytical solution", "Numerical solution");
grid on;

figure(2);
plot(r, abs(uz_numerical - uz_analytical), 'Linewidth', 1.25);
title("Error in velocity");
xlabel("Radius  of the pipe");
ylabel("Error");
grid on;

clear;
clc;
