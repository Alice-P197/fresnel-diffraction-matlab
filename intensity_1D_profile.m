function intensity_1D_profile(ax,x,y,m,I,L,s,choice)
%% ax = gca
% x, y 向量坐标
% m 缩放因子
% I 强度矩阵
% L 画幅尺寸
% s "w-" 轮廓颜色和线型
% choice "x"，“y”或者"xy"
    [N,~] = size(I);
    [X,Y] = meshgrid(x,y);
    dx = x(2)-x(1); dy = y(2)-y(1);
    q1 = X.*I; q2 = Y.*I; g = sum(I(:)*dx*dy);
    a = sum(q1(:)*dx*dy)./g;
    b = sum(q2(:)*dx*dy)./g;
    l1 = min(x); l2 = max(x); Lx = l2-l1;
    l3 = min(y); l4= max(y); Ly = l2-l1;
    kx = round((a-l1)/Lx*N); ky  = round((b-l3)/Ly*N);
    I_x = I(ky,:);  I_y =I(:,kx);
    I_x = L/2*I_x./max(I_x(:))*m;
    I_y = L/2*I_y./max(I_y(:))*m;
    hold(ax,'on');
    if strcmpi(choice,'x')== 1
        plot(ax,x,I_x-L/2,s,'LineWidth',2);
    elseif strcmpi(choice,'y') == 1
        plot(ax,I_y-L/2,y,s,'LineWidth',2);
    elseif strcmpi(choice,'xy') == 1
        plot(ax,x,I_x-L/2,s,'LineWidth',2);
        plot(ax,I_y-L/2,y,s,'LineWidth',2);
    else

    end
end