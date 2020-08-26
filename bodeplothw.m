
%
% Description:
% a) standard plotting and complex number capabilities,
% b) standard plotting and complex number capabilities for generating Bode plots, and
% c) built in Bode plot function.

% Transfer function:                   (10jw + 1)(10 + jw)
%                     H(jw) = ----------------------------------
%                              (jw/100 + 1)(1 + jw + (jw)^2)

% clear matlab memory and close all open figures
clear all; close all; 

%=======================================================================================
% a) plotting of frequency response using standard complex number and plotting functions
%=======================================================================================

% open figure 1 for first frequency response plots
figure(1);

% create vector of 200 equally spaced frequencies from 0.1rad/sec to 100rad/sec
% note 0rad/sec is not used because it causes a divide by zero (jw=0 is a pole)
w = linspace(0.1,100,500);

% define transfer function
H = ((1+10*j*w).*(10+j*w))./((j*w*0.01).*(1+j*w+(j*w).^2));

% divide figure window into two rows, one column, and plot magnitude response in top graph,
% phase response in bottom graph
subplot(2,1,1);
plot(w,abs(H));
grid; ylabel('|H(j\omega)|'); title('Magnitude Response');
subplot(2,1,2);
plot(w,unwrap(angle(H))*180/pi);
grid; xlabel('\omega (rad/sec)'); ylabel('\angleH(j\omega) (\circ)'); title('Phase Response');

%=======================================================================================
% b) plotting of frequency response as a Bode plot using standard complex number
% and plotting functions
%=======================================================================================

% open figure 2 for second frequency response plots
figure(2);

% create vector of 1000 logarithmically spaced (i.e., same number of points per decade)
% frequencies from 10^-1 = 0.1rad/sec to 10^3 = 1000rad/sec
w = logspace(-1,5,600);

% define transfer function
H = ((1+10*j*w).*(10+j*w))./((j*w*0.01).*(1+j*w+(j*w).^2));

% divide figure window into two rows, one column, and plot magnitude response in top graph,
% phase response in bottom graph
subplot(2,1,1);
semilogx(w,20*log10(abs(H)));
grid; ylabel('|H(j\omega)|'); title('Bode Plot: Magnitude Response');
subplot(2,1,2);
semilogx(w,unwrap(angle(H))*180/pi);
grid; xlabel('\omega (rad/sec)'); ylabel('\angleH(j\omega) (\circ)'); title('Bode Plot: Phase Response');

%=======================================================================================
% c) plotting of frequency response using Bode function
%=======================================================================================

% open figure 3 for third frequency response plots
figure(3);

% create vector of 200 logarithmically spaced (i.e., same number of points per decade)
% frequencies from 10^-1 = 0.1rad/sec to 10^3 = 1000rad/sec
w = logspace(-1,3,200);

% define transfer function using coefficients of jw in numerator and denominator
% starting with highest power of jw and working down - note conv() is used to
% multiply terms in denominator
numH = conv([1 10], [10 1]); 
denH =  conv([0.01 2], [1 1 1]);
% call bode() to plot frequency response as bode diagrams, then add grids
bode(numH,denH,w);






