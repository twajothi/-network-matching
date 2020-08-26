%%%%%%%%%%%%
% Functions %
%%%%%%%%%%%%%
function Gp_gammaL_to_gammaS(s,del,Cp_rl,Rp_rl,Gp)
Cp_rs = (((1-s(2,2)*Cp_rl)*(s(1,1)-del*Cp_rl)')-((Rp_rl)^2*(del')*s(2,2)))/...
        ((abs(1-(s(2,2)*Cp_rl)))^2-Rp_rl^2*abs(s(2,2))^2);
    
Rp_rs = (Rp_rl*abs(s(1,2)*s(2,1)))/...
        (abs(abs(1-s(2,2)*Cp_rl)^2-Rp_rl^2*abs(s(2,2))^2));

disp('--');
disp(['Gp = ' Gp 'dB']);
disp(['Cp_rs = ' num2str(abs(Cp_rs)) ' < ' num2str((180/pi)*angle(Cp_rs))]);
disp(['Rp_rs = ' num2str(abs(Rp_rs))]);

% Convert points in rL plane to pts in rS plane
function rS = rLplane_to_rSplane(rL,s)
rS = (s(1,1)+(s(1,2)*s(2,1)*rL)/(1-s(2,2)*rL))';

% Gonzalez eq. 3.8.6
function rb_mag = calc_rb_mag(rL,rout)
rb_mag = abs((rout-(rL'))/(1-rout*rL));

function del = calc_del(s)
del = s(1,1)*s(2,2) - S(1,2)*S(2,1);

function k = calc_k(s)
del = s(1,1)*s(2,2) - S(1,2)*S(2,1);
k = (1-(abs(s(1,1)))^2-(abs(s(2,2)))^2+(abs(del))^2)/...
    (2*abs(s(1,2)*s(2,1)));

function rin = calc_rin(s,rL)
rin = s(1,1)+(s(1,2)*s(2,1)*rL)/...
             (1-s(2,2)*rL);
         
% Gonzalez eq. 2.6.5
function rout = calc_rout(s,rS)
rout = s(2,2)+(s(1,2)*s(2,1)*rS)/...
              (1-s(1,1)*rS);  
function VSWRin = calc_VSWRin(s,rS,rL)
rin = calc_rin(s,rL);
ra_mag = abs((rin-rS')/(1-rin*rS));
VSWRin = (1+ra_mag)/(1-ra_mag);

function VSWRout = calc_VSWRout(s,rS,rL)
rout = calc_rout(s,rS);
rb_mag = abs((rout-rL')/(1-rout*rL));
VSWRout = (1+rb_mag)/(1-rb_mag);

function Gp = calc_Gp(s,rL)
rin = calc_rin(s,rL);
Gp = (1/(1-(abs(rin)).^2)*(abs(s(2,1))).^2*(1-(abs(rL)).^2)/((abs(1-s(2,2)*rL)).^2));

% Calculate ra/rb
function rab = calc_rab(VSWR)
rab = (VSWR-1)/(VSWR+1);

function Ga = calc_Ga(s,rS)
rout = calc_rout(s,rS);
Ga = ((1-abs(rS)^2)/(abs(1-s(1,1)*rS))^2)*(abs(s(2,1)))^2*(1/(1-(abs(rout))^2));

% Calculates the Noise Figure in dB
function F = calc_NF(Fmin, rn, rOPT, rS)
F = 10.^(Fmin/10) + (4*rn*(abs(rS-rOPT))^2)/...
           ((1-(abs(rS))^2)*(abs(1+rOPT))^2); % Gonzalez 4.3.4
 F = 10 * log10(F);
% yS = (1-rS)/(1+rS); % Gonzalez eq 4.3.2
% yOPT = (1-rOPT)/(1+rOPT); 
% F = 10.^(Fmin/10) + (rn/(real(yS)))*(abs(yS-yOPT))^2; % Gonzalez eq 4.3.4

function Gt = calc_Gt(s,rS,rL)
rin = calc_rin(s,rL);
Gt = ((1-abs(rS)^2)/abs(1-rin*rS)^2) * (abs(s(2,1))^2) * ((1-abs(rL)^2)/(abs(1-s(2,2)*rL)^2));

% function Gp_circles_on_rS_plane(s)

% Calculates the reflection coefficient of a normalized impedance z
function r = z_to_r(z)
r = (z-1)/(z+1);

% plots the VSWRoutCircle and selects the minimum VSWRin on that circle.
function [VSWRin_min, rL_VSWRin_min, theta_VSWRin_min] = plot_VSWRoutCircle(rL_plane,s,rS,VSWRout,N)
rb = calc_rab(VSWRout);
rout = calc_rout(s,rS);
Cvo = (rout'*(1-abs(rb)^2))/...
      (1-abs(rb*rout)^2);
Rvo = (abs(rb)*(1-abs(rout)^2))/...
      (1-abs(rb*rout)^2);
smith_circles(Cvo,Rvo,'b-',256,rL_plane)
% Test 8 points on the constant VSWRout circle
for idx = 1:N
    theta(idx) = -pi+(2*pi/N)*idx; % -pi+pi/4:pi/4:pi
    rL(idx) = Cvo+Rvo*exp(j*theta(idx));
    VSWRin(idx) = calc_VSWRin(s,rS,rL(idx));
    
    disp_theta{idx} = ['theta = ' num2str(theta(idx)/pi) ' pi rad'];
    disp_rL{idx} = ['rL = ' num2str(abs(rL(idx))) ' < ' num2str((180/pi)*angle(rL(idx)))];
    disp_VSWRin{idx} = ['VSWRin = ' num2str(VSWRin(idx))];
    disp_spacing{idx} = [32 32 32];
    plot(rL_plane, rL, 'b*');
%     disp('-')
%     disp(['theta = ' num2str(theta/pi) ' pi rad'])
%     disp(['rL = ' num2str(abs(rL)) ' < ' num2str((180/pi)*angle(rL))]);
%     disp(['VSWRin = ' num2str(VSWRin)])
end
% Display Table of pts on VSWRout circle
disp_theta = char(disp_theta);
disp_rL = char(disp_rL);
disp_VSWRin = char(disp_VSWRin);
disp_spacing = char(cellfun(@char,disp_spacing','UniformOutput',false));
disp([disp_VSWRin disp_spacing disp_rL disp_spacing disp_theta]);

% Calculate min VSWRin
[VSWRin_min min_idx] = min(VSWRin);
theta_VSWRin_min = theta(min_idx);
rL_VSWRin_min = rL(min_idx);
plot(rL_plane, rL_VSWRin_min, 'g*');

% Print Solution
% Prints important information about a given rS, rL solution
function print_solution(s,rS,rL,Fmin,rn,rOPT)
F = calc_NF(Fmin, rn, rOPT, rS);
VSWRin = calc_VSWRin(s,rS,rL);
VSWRout = calc_VSWRout(s,rS,rL);
Gp = calc_Gp(s,rL);
Ga = calc_Ga(s,rS);
Gt = calc_Gt(s,rS,rL);

disp(['rS = ' num2str(abs(rS)) ' < ' num2str((180/pi)*angle(rS))]);
disp(['rL = ' num2str(abs(rL)) ' < ' num2str((180/pi)*angle(rL))]);
disp(['VSWRin = ' num2str(VSWRin)])
disp(['VSWRout = ' num2str(VSWRout)])
disp(['NF = ' num2str(F) 'dB'])
disp(['Gp = ' num2str(10*log10(Gp)) 'dB'])
disp(['Ga = ' num2str(10*log10(Ga)) 'dB'])
disp(['Gt = ' num2str(10*log10(Gt)) 'dB'])
