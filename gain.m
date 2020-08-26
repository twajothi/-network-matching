s11 = 0.61*exp(j*165/180*pi);
s21 = 3.72*exp(j*59/180*pi);
s12 = 0.05*exp(j*42/180*pi);
s22 = 0.45*exp(j*(-48/180)*pi);
sparam = [s11 s12; s21 s22];
z0 = 50;
zs = 10 + j*20;
zl = 30 - j*40;
%Calculate the transducer power gain of the network
Gt = powergain(sparam,z0,zs,zl,'Gt')
%Calculate the available power gain of the network
Ga = powergain(sparam,z0,zs,'Ga')
%Calculate the operating power gain of the network
Gp = powergain(sparam,z0,zl,'Gp')
%Calculate the maximum available power gain of the network
Gmag = powergain(sparam,'Gmag')
%Calculate the maximum stable power gain of the network
Gmsg = powergain(sparam,'Gmsg')