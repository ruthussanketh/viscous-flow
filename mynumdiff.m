% Note - dx has been passed as an argument to mynumdiff for ease of
% plotting for different dx values at the same time.

% limits set inside each condition - we set a and b as a little higher 
% than the desired limits, and then later we use xlim to set it between 
% -2*pi and 2*pi. In part b, we set a as 0 and b as a little higher than 
% the desired limit, and then later we use xlim to set it between 0 and 2*pi.

% Note - limits are customizable as well

f = @y;

prompt = "Enter a for the answer to part 1a, b for the answer to part 1b, and c for the answer to part 1c: ";
ip = input(prompt, 's');

if strcmp(ip,'a')
    % plotting all the derivatives on the same graph, for different dx values
    a = -6.5;
    b = 6.5;
    i = 1;
    for dx = [0.005, 0.05, 0.1, 0.5]
        x = a:dx:b;
        [fd, bd, cd, ad] = my_num_diff(f, x, dx);
        figure(i);
        plot(x, fd, 'Linewidth', 1.25); hold on;
        plot(x, bd, 'Linewidth', 1.25); hold on;
        plot(x, cd, 'Linewidth', 1.25); hold on;
        plot(x, ad, 'Linewidth', 1.25, 'color', 'm');
        grid on;
        title("Derivative of the sine function using different methods when dx is "+ dx);
        legend("Forward difference", "Backward difference", "Central difference", "Analytical derivative");
        xlabel("x"); ylabel("Derivative");
        xlim([-2*pi, 2*pi]); hold off;
        i = i+1;
    end
elseif strcmp(ip,'b')
    a = 0;
    b = 6.5;
    i = 1;
    % plotting the error of each derivative separately, for different dx values
    for dx = [0.005, 0.05, 0.1, 0.5]
        x = a:dx:b;
        [error_fd, error_bd, error_cd] = find_err(f,x,dx);
        figure(i);
        loglog(x, error_fd, 'Linewidth', 1.25);
        title("Error using the forward difference formula when dx is "+ dx);
        xlabel("x"); ylabel("Error");
        grid on; xlim([0, 2*pi]);
        i = i+1;
        figure(i);
        loglog(x, error_bd, 'Linewidth', 1.25);
        title("Error using the backward difference formula when dx is " + dx);
        xlabel("x"); ylabel("Error");
        grid on; xlim([0, 2*pi]);
        i = i+1;
        figure(i);
        loglog(x, error_cd, 'Linewidth', 1.25);
        title("Error using the central difference formula when dx is " + dx);
        xlabel("x"); ylabel("Error");
        grid on; xlim([0, 2*pi]);
        i = i+1;
    end
elseif strcmp(ip,'c')
    % plotting max error as a function of dx over the entire domain
    a = -6.5;
    b = 6.5;
    max_error_fd = (0);
    max_error_bd = (0);
    max_error_cd = (0);
    for dx = 0:0.001:1
        x = a:dx:b;
        [error_fd, error_bd, error_cd] = find_err(f,x, dx);
        %#ok<*AGROW>
        max_error_fd = [max_error_fd, max(error_fd)]; 
        max_error_bd = [max_error_bd, max(error_bd)];
        max_error_cd = [max_error_cd, max(error_cd)];
    end
    dx = 0:0.001:1;
    plot(dx, max_error_fd, 'Linewidth', 1.25); hold on;
    plot(dx, max_error_bd, 'Linewidth', 1.25); hold on;
    plot(dx, max_error_cd, 'Linewidth', 1.25); hold on;
    grid on;
    title("Maximum error as a function of dx");
    legend("Forward difference", "Backward difference", "Central difference");       
    xlabel("dx"); ylabel("Maximum error");

else
    disp("Undefined input");
    return;
end      

function [func] = y(val)
func = sin(val);
end

function [fd, bd, cd, ad] = my_num_diff(f,x,dx)
%computing the derivative using the forward difference formula
fd = (f(x+dx) - f(x))/dx;

%computing the derivative using the backward difference formula
bd = (f(x) - f(x-dx))/dx;

%computing the derivative using the central difference formula
cd = (f(x+dx) - f(x-dx))/(2*dx);

% computing the analytical derivative of sin(x), which is cos(x)
ad = cos(x);
end

function [error_fd, error_bd, error_cd] = find_err(f,x,dx)
[fd, bd, cd, ad] = my_num_diff(f,x,dx);
error_fd = abs(ad - fd);
error_bd = abs(ad - bd);
error_cd = abs(ad - cd);
end