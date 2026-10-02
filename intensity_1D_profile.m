function intensity_1D_profile(ax, x, y, I, m, s, choice)
% ax     = gca
% x      长度为 Nx 的向量 (对应 I 的列)
% y      长度为 Ny 的向量 (对应 I 的行)
% I      Ny × Nx 强度矩阵
% m      缩放因子 (峰值相对画幅的比例)
% s      线型, 如 'w-'
% choice "x" / "y" / "xy"

    [Ny, Nx] = size(I);
    assert(numel(x) == Nx, 'x 长度与 I 的列数不匹配');
    assert(numel(y) == Ny, 'y 长度与 I 的行数不匹配');

    [X, Y] = meshgrid(x, y);
    dx = x(2) - x(1);
    dy = y(2) - y(1);

    % 强度加权质心
    q1 = X .* I;  q2 = Y .* I;
    g  = sum(I(:)) * dx * dy;
    a  = sum(q1(:)) * dx * dy / g;
    b  = sum(q2(:)) * dx * dy / g;

    % 画幅边界
    l1 = min(x);  l2 = max(x);  Lx = l2 - l1;
    l3 = min(y);  l4 = max(y);  Ly = l4 - l3;

    % 独立定位行列索引
    kx = round((a - l1) / Lx * (Nx - 1)) + 1;
    ky = round((b - l3) / Ly * (Ny - 1)) + 1;
    kx = max(1, min(Nx, kx));
    ky = max(1, min(Ny, ky));

    % 提取过中心的剖面
    I_x = I(ky, :);      % 沿 x 方向的剖面, 长度 Nx
    I_y = I(:, kx);      % 沿 y 方向的剖面, 长度 Ny

    % 独立缩放: x 剖面按 Ly 缩放, y 剖面按 Lx 缩放
    I_x = I_x / max(I_x(:)) * Ly * m;
    I_y = I_y / max(I_y(:)) * Lx * m;

    hold(ax, 'on');
    if any(strcmpi(choice, {'x', 'xy'}))
        plot(ax, x, l4 - I_x, s, 'LineWidth', 2);
    end
    if any(strcmpi(choice, {'y', 'xy'}))
        plot(ax, l1 + I_y, y, s, 'LineWidth', 2);
    end
end