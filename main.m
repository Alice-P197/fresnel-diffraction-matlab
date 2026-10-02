clc; clear; close all;
%% 参数
lambda = 632.8e-6;w  = 0.5;
%% 入射面尺寸
L0     = 5;N  = 512;
x0 = linspace(-L0/2, L0/2, N);
y0 = linspace(-L0/2, L0/2, N);
dx = x0(2)-x0(1);
dy = dx;
[X0, Y0] = meshgrid(x0, y0);
[theta, R] = cart2pol(X0, Y0);
%% 孔径和入射光
A  = annular_hole(0, 0.3, N, L0);
U0 = LG_beam(R, theta, 0, w, lambda, dx, dy, 0, 0) .* A;
%% 显示结果
fig = figure('Position', [100 100 1600 600], 'Color', 'w');
D = linspace(1,150,20);
for i = 1:length(D)
    d  = D(i);
    M = {'S-FFT','D-FFT','T-FFT'};
    for k = 1:3
        [U,x,y] = propagate(U0,x0,y0,lambda,d,'Method',M{k});
        data(k,:) = {abs(U).^2, x, y, M{k}};
    end
    show_results(data,d,L0)
    GIF_generator(gcf,i,'diffraction')
end