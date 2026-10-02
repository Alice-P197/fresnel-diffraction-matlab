function I = annular_hole(inner_radius, outer_radius,N,L)
% 创建环缝掩膜
x = linspace(-L/2, L/2, N);
y = linspace(-L/2, L/2, N);
[X, Y] = meshgrid(x, y);
R = sqrt(X.^2+Y.^2);
if inner_radius>outer_radius
    I = 1.*(R<outer_radius)+0.*(R>=outer_radius).*(R<=inner_radius)+1.*(R>inner_radius);
elseif inner_radius == outer_radius
    I = 0;
else
    I = 0.*(R<inner_radius)+1.*(R>=inner_radius).*(R<=outer_radius)+0.*(R>outer_radius);
end