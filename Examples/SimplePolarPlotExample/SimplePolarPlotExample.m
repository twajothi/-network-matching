%% Simple Polar Plot
% Create a simple polar plot using a dashed red line.

% Copyright 2015 The MathWorks, Inc.


theta = 0:0.01:2*pi;
rho = sin(2*theta).*cos(2*theta);

figure
polar(theta,rho,'--r')

