%% Polar to Cartesian Coordinates
% Convert the polar coordinates defined by corresponding entries in the
% matrices |theta| and |rho| to two-dimensional Cartesian coordinates |x|
% and |y|.
theta = [0 pi/4 pi/2 pi]
    
%%
rho = [5 5 10 10]

%%
[x,y] = pol2cart(theta,rho)