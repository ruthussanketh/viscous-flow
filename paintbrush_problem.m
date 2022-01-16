% L u = 0 where L is the Laplacian.
% u(0,z) = u(b,z) = 0   INITIAL CONDITIONS
% u(y,0) = 1; u(y,h) = 0  BOUNDARY CONDITIONS

k = 1;
f = 1;
 
for dy = [0.01, 0.05, 0.1]
    
    dz = dy;

    % h>>b ideally, but works even if h is 1
    b = 1;
    h = 1;

    max_iter = 1e4;
    tolerance = 1e-6;

    % grid
    y = 0:dy:b;
    z = 0:dz:h;
    Ny = length(y);
    Nz = length(z);
    [Y_grid, Z_grid] = meshgrid(y,z);

    % Analytical solution
    N = 151;
    u_analytical = zeros(Ny, Nz);
    for n = 1:2:N
        value = 4/(n*pi)*sin(n*pi*Y_grid/b).*exp(-n*pi*Z_grid/b);
        u_analytical = value' + u_analytical;
    end

    figure(k);
    contourf(y,z,u_analytical');
    colorbar;
    title("Analytical solution when grid resolution is "+ dy);
    xlabel("y"); ylabel("z");
    k = k + 1;

    % Numerical solution
    u = zeros(Ny,Nz);

    % BCs
    u(1,:) = 0;
    u(Ny,:) = 0;
    u(:,1) = 1;
    u(:,Nz) = u_analytical(:,Nz);

    % iterations
    iter = 1;
    residual = 1;
    res = [];
    max_err_iter = [];
    while (iter < max_iter && residual > tolerance)
        for i = 2:Ny-1
            for j = 2:Nz-1
                Lux(i,j) = (1/2)*(dy^2*dz^2)/(dy^2 + dz^2)*(u(i-1,j)/dy^2 + u(i+1,j)/dy^2 + u(i,j+1)/dz^2 + u(i,j-1)/dz^2);
            end
        end
        res(iter) = max(max(Lux(2:Ny-1,2:Nz-1) - u(2:Ny-1, 2:Nz-1))); %#ok<*SAGROW>
        residual = res(iter);
        u(2:Ny-1, 2:Nz-1) = Lux(2:Ny-1, 2:Nz-1);
        max_err_iter(iter) = max(max(u_analytical - u));
        iter = iter + 1;
    end

    err_val = abs(u_analytical - u);
    
    figure(k);
    contourf(y,z,u');
    colorbar;
    title("Numerical solution when grid resolution is "+ dy);
    xlabel("y"); ylabel("z");
    k = k + 1;

    figure(k);
    contourf(y,z,err_val');
    colorbar;
    title("Error when grid resolution is "+ dy);
    xlabel("y"); ylabel("z");
    k = k + 1;

    figure(k);
    x = 1:1:iter;
    res(iter) = res(iter-1);
    loglog(x, res');
    title("Residual variation with each iteration when grid resolution is "+ dy);
    xlabel("Iteration"); ylabel("Residual");
    k = k + 1;

    figure(k);
    max_err_iter(iter) = max_err_iter(iter-1);
    loglog(x, max_err_iter');
    title("Max error variation with each iteration when grid resolution is "+ dy);
    xlabel("Iteration"); ylabel("Max error");
    k = k + 1;
    
    res_grid(f) = res(iter);
    f = f + 1;
end

figure(k);
f = [0.01, 0.05, 0.1];
plot(f, res_grid);
title("Residual variation with grid resolution");
xlabel("Grid Resolution"); ylabel("Residual");