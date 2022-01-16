% limits - we set a and b as the desired limits inside each condition

f = @y;

prompt = "Enter a for the answer to part 2a, b for the answer to part 2b, and c for the answer to part 2c: ";
ip = input(prompt, 's');

if strcmp(ip,'a')
    % finding the integrals and plotting the antiderivative function
    a = -2*pi;
    b = 2*pi;
    i = 1;
    for n = [5, 50, 100, 500] % n determines the grid space dx (dx = (b-a)/n)
        x = linspace(a,b,n);
        [ti, si, ai] = my_num_integrate(f, x, a, b);
        disp(newline + "The value of the integral using the Trapezoidal rule when n is " + n+ " is " + ti);
        disp(newline + "The value of the integral using the Simpson's rule when n is " + n + " is " + si);
        disp(newline + "The actual value of the integral when n is " + n + " is " + ai);
        figure(i);
        plot(x, -cos(x), 'Linewidth', 1.25); hold on;
        grid on;
        title("Antiderivative function of sin(x) when n is " + n);
        legend("- cos(x)");
        xlabel("x"); ylabel("Integral");
        xlim([-2*pi, 2*pi]); hold off;
        i = i+1;
    end
elseif strcmp(ip,'b')
    a = 0;
    b = 2*pi;
    % plotting the error of each integral separately, for different dx values
    all_error_ti = [];
    all_error_si = [];
    for n = 2:1:500
        x = linspace(a,b,n);
        [error_ti, error_si] = find_err(f,x,a,b);
        %#ok<*AGROW>
        all_error_ti = [all_error_ti, error_ti];
        all_error_si = [all_error_si, error_si];
    end
    n = 2:1:500;
    dx = (b-a)./n;
    plot(dx, all_error_ti, 'Linewidth', 1.25); hold on;
    plot(dx, all_error_si, 'Linewidth', 1.25); hold on;
    title("Error as a function of dx");
    legend("Trapezoidal rule", "Simpson's rule");
    xlabel("dx"); ylabel("Error");
    grid on;
elseif strcmp(ip, 'c')
    a = -2*pi;
    b = 2*pi;
    for n = [5, 50, 100, 500] % n determines the grid space dx (dx = (b-a)/n)
        x = linspace(a,b,n);
        mat_ti = trapz(x,sin(x));
        [ti, si, ai] = my_num_integrate(f, x, a, b);
        disp(newline + "The value of the integral using the Trapezoidal rule when n is " + n+ " is " + ti);
        disp(newline + "The value of the integral using the Simpson's rule when n is " + n + " is " + si);
        disp(newline + "The actual value of the integral when n is " + n + " is " + ai);
        disp(newline + "The value of the integral using the inbuilt trapz function when n is " + n+ " is " + mat_ti);
    end
else
    disp("Undefined input");
    return;
end

function [func] = y(val)
func = sin(val);
end

function [ti, si, ai] = my_num_integrate(f, x, a, b)
dx = x(2) - x(1);

%computing the integral using the trapezoidal rule
x0 = a;
sum = f(x0);
while x0<b
    x0 = x0 + dx;
    sum = sum + 2*f(x0);
end
ti = sum*(dx/2);

%computing the integral using the Simpson's rule
x0 = a;
sum = f(x0);
while x0<(b - dx)
    x0 = x0 + dx;
    sum = sum + 4*f(x0) + 2*f(x0 + dx);
end
si = (sum + f(b))*(dx/3);

% computing the analytical integral of sin(x), which is -cos(x)
ai = -cos(a) + cos(b);
end

function [error_ti, error_si] = find_err(f,x,a,b)
[ti, si, ai] = my_num_integrate(f,x,a,b);
error_ti = abs(ai - ti);
error_si = abs(ai - si);
end