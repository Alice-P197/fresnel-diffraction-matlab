%% ============================================================
function [U, x, y] = propagate(U0, x0, y0, lambda, d, varargin)
% PROPAGATE 光场传播 (统一接口, 返回复振幅)
%
% 用法:
%   [U, x, y] = propagate(U0, x0, y0, lambda, d, 'Method', 'S-FFT');
%   [U, x, y] = propagate(U0, x0, y0, lambda, d, 'Method', 'T-FFT');
%   [U, x, y] = propagate(U0, x0, y0, lambda, d, 'Method', 'D-FFT');

    p = inputParser;
    addParameter(p, 'Method', 'D-FFT', ...
        @(s) ismember(upper(s), {'S-FFT','T-FFT','D-FFT'}));
    parse(p, varargin{:});
    method = upper(p.Results.Method);

    N  = numel(x0);
    dx = x0(2) - x0(1);
    dy = y0(2) - y0(1);
    L0 = N * dx;
    k  = 2*pi/lambda;
    [X0, Y0] = meshgrid(x0, y0);

    switch method

        case 'S-FFT'
            % 输出面尺寸按采样定理自动扩展
            L_out = N*lambda*d/L0;
            x = linspace(-L_out/2, L_out/2, N);
            y = linspace(-L_out/2, L_out/2, N);
            [X, Y] = meshgrid(x, y);

            pre       = exp(1j*k*d) / (1j*lambda*d) * dx * dy;
            chirp_in  = exp(1j*k/(2*d) * (X0.^2 + Y0.^2));
            chirp_out = exp(1j*k/(2*d) * (X.^2  + Y.^2 ));

            U = pre * chirp_out .* fftshift(fft2(U0 .* chirp_in));

        case 'T-FFT'
            % 输出面与输入面同尺寸; 
            x = x0;  y = y0;
            [X, Y] = meshgrid(x, y);

            h = exp(1j*k*d) / (1j*lambda*d) ...
                * exp(1j*k/(2*d) * (X.^2 + Y.^2)) * dx * dy;

            h_shift = ifftshift(h);       

            U = ifft2( fft2(U0) .* fft2(h_shift) );

        case 'D-FFT'
            % 角谱法, 传递函数模长 = 1, 幺正变换
            x = x0;  y = y0;

            fx = (-N/2 : N/2-1) / L0;
            fy = (-N/2 : N/2-1) / L0;
            [Fx, Fy] = meshgrid(fx, fy);

            arg = 1 - (lambda*Fx).^2 - (lambda*Fy).^2;
            arg = max(arg, 0);             % 滤除倏逝波
            H = exp(1j*k*d*sqrt(arg));

            U = ifft2( fft2(U0) .* ifftshift(H) );
    end
end
