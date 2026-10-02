clc;clear;close all;

dx = 8e-3;  dy = dx;
res = [1900,1200];
[x,y] = makegrid(res,dx,dy);
[X,Y] = meshgrid(x,y);
[theta,r] = cart2pol(X,Y);
%% complex amplitude
lambda = 632.8e-6; % wavelength
w0 = 1; % beam waist radius
p = 2; % radial indice
l = 3; % azimuthal indice
E = LG_beam(r,theta,0,w0,lambda,dx,dy,p,l);
I = E.*conj(E);

imagesc(x,y,I)
axis equal;
axis([min(x),max(x),min(y),max(y)])
axis off;
colormap(lambda2rgb(lambda*1e6))
hold on;
intensity_1D_profile(gca,x,y,I,0.2,"w","xy")