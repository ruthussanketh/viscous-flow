# Viscous Flow Theory

Codes to some popular problems and methods in Viscous Flow Theory.


## 1. mynumdiff - ##

Computes the derivative of the function _f(x)_ where _x_ is the grid on which _f(x)_ has been computed. We assume _f(x) = sin(x)_, but this is customizable for different functions.

a. Computes the derivative using the forward difference, backward difference and central difference formula and plots the analytical derivative on the same graph.
b. Computes the error at each point for different values of dx and plots on a separate log-log graph for each difference formula.
c. Plots max error in the entire domain as function of dx for all the three difference formulae on the same graph.

## 2. mynumintegrate - ##

Computes the integral of the function _f(x)_ between the lower limit _a_ and upper limit _b_. Here _x_ is the grid on which _f(x)_ has been computed. We assume _f(x) = sin(x)_, but this is customizable for different functions.

a. Computes the integral using the trapezoidal rule and Simpson’s rule and plots the analytical derivative on the same graph.
b. Computes the error at each point for different values of dx and plots it on a separate graph.
c. Computes the integral using inbuilt functions trapz and compare it with the calculated integrals.

## 3. mystreamline - ##

Creates a function, mystreamline(u,v,x,y) to compute the streamlines for a given velocity field _u(x,y)_ and _v(x,y)_, where - 

_u(x,y) = cx/(x^2 + y^2)
v(x,y) = cy/(x^2 + y^2)_

where _c_ is a constant. These functions are customizable. 

a. Computes the streamlines analytically.
b. Computes the streamlines numerically and compares them with the analytical solution in a domain _[x, y] ⊆ [[−1,1],[−1,1]]_, which is also customizable based on the fields chosen. The inbuilt matlab function is used to compare the streamlines. 
c. Computes the pathlines numerically using a similar method mypathline(u,v,x,y,t) for 20 particles starting from random locations on the domain and shows that they lie on the streamlines. Identifies stagnation points, if any.

## 4. hagen_poiseuille - ##

Solves the ordinary differential equation numerically and compares with the analytical solution of the Hagen-Poiseuille flow. For more information on this flow, please read [this](https://www.annualreviews.org/doi/pdf/10.1146/annurev.fl.25.010193.000245) article.

## 5. rotating_cylinders - ##

Considers the flow between two rotating cylinders rotating with angular velocity _Ω1, Ω2_ such that _r1 ≤ r ≤ r2_. Here the subscripts 1, 2 refer to the inner and the outer cylinders respectively. The streamlines are assumed to be circular so that the only component of velocity is the tangential velocity, _uθ_. Furthermore, _uθ_ is only a function of radial distance _r_, and time _t_.

a. Solves the ordinary differential equation numerically and compares with the analytical solution of the flow between two rotating cylinders. 

To learn more about the stability of such flows, please watch [this](https://www.youtube.com/watch?v=10bamwZtU7w) video.

## 6. paintbrush_problem - ##

a. Computes the numerical solution of the model Paintbrush problem _(Page 183 of “An Introduction to Fluid Dynamics” by G K Batchelor)_ and compares it with the analytical solution. 
b. Plots the error and the residual as a function of iterations and the grid resolution.

## 7. TDMA_solver - ##

Is a function to implement the tridiagonal matrix algorithm (TDMA). For more information on the TDMA solver, please read [this](https://www.cfd-online.com/Wiki/Tridiagonal_matrix_algorithm_-_TDMA_(Thomas_algorithm)) article.
