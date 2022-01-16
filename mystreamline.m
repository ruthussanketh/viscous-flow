% u(x,y) = cx/(x^2 + y^2)
% v(x,y) = cy/(x^2 + y^2)
% where c is a constant, taken to be 100.

x = linspace(-1,1,20);
y = linspace(-1,1,20);   
c = 100;
u = @(x,y) c*x/(x^2 + y^2);
v = @(x,y) c*y/(x^2 + y^2);

[a, b] = my_streamline(u,v,x,y);

figure(1);
quiver(x,y,(a.*cos(b))', (a.*sin(b))');
title('Numerically calculated streamlines when c = 100');
grid on;
xlabel("x"); ylabel("y");
xlim([-1,1]); ylim([-1,1]);

figure(2);
hold on;
quiver(x,y,(a.*cos(b))', (a.*sin(b))');
title('Numerically calculated pathlines along with streamlines, c = 100');
grid on;
xlabel("x"); ylabel("y");

q1 = rand(2,5);
q2 = rand(2,5);
q3 = rand(2,5);
q4 = rand(2,5);

q2(2,:) = q2(2,:)*-1;
q3(1,:) = q3(1,:)*-1;
q3(2,:) = q3(2,:)*-1;
q4(1,:) = q4(1,:)*-1;

t = 0:.0001:.05;

for i = 1:5
    
    [a1,b1,c1] = mypathline(u,v,q1(1,i),q1(2,i),t);
    [a2,b2,c2] = mypathline(u,v,q2(1,i),q2(2,i),t);
    [a3,b3,c3] = mypathline(u,v,q3(1,i),q3(2,i),t);
    [a4,b4,c4] = mypathline(u,v,q4(1,i),q4(2,i),t);
    
    plot(a1,b1);
    plot(a2,b2);
    plot(a3,b3);
    plot(a4,b4);
    
    plot(q1(1,i),q1(2,i),'o');
    plot(q2(1,i),q2(2,i),'o');
    plot(q3(1,i),q3(2,i),'o');
    plot(q4(1,i),q4(2,i),'o');
    
end

xlim([-1,1]); ylim([-1,1]);
hold off;

figure(3);
quiver(x,y,(a.*cos(b))', (a.*sin(b))');
hold on;

for k = 0:0.5:3
    plot(x, k*x);
    hold on;
end

for k = -3:0.5:0
    plot(x, k*x);
    hold on;
end

xlabel("x");
ylabel("y");
title("Numerical and analytical streamlines");
xlim([-1,1]); ylim([-1,1]);
hold off;

function [x_path, y_path, stag] = mypathline(u,v,x,y,t)

    n = length(t);
    dt = (t(n) - t(1))/(n - 1);
    
    flag = 0;
    stag = 'false';
    
    x_path(1) = x;
    y_path(1) = y;
    
    for i = 2:n
        
        x_path(i) = x_path(i-1) + u(x_path(i-1),y_path(i-1))*dt;
        y_path(i) = y_path(i-1) + v(x_path(i-1),y_path(i-1))*dt;
        
        if abs(x_path(i)) > 1
            break   
        end
        
        if abs(y_path(i)) > 1
            break   
        end
        
        if flag == 0
            if x_path(i) == x_path(i-1)
                if y_path(i) == y_path(i-1)
                    stag = [x_path(i-1), y_path(i-1)];
                    flag = 1;
                end
            end
        end 
    end 
end

function [v_t, theta] = my_streamline(u,v,x,y)

    nx = length(x);
    ny = length(y);
    
    for j = 1:ny
        for i = 1:nx
            
            v_t(i,j) = sqrt((u(x(i),y(j)))^2+(v(x(i),y(j)))^2); %#ok<*AGROW>
            
            theta(i,j) = atan((v(x(i),y(j)))/(u(x(i),y(j))));   
            
            if u(x(i),y(j)) < 0
                    theta(i,j) = theta(i,j) + pi;
            end               
        end
    end       
end