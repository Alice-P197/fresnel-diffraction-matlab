function E = LG_beam(r,theta,z,beam_waist,lambda,dx,dy,p,l)
    %%------ LG_beam 光束--------------------
    % r和theta为二维极坐标
    % beam_waist 束腰
    % z 传输距离
    % lambda 波长 λ
    % p, l 径向和法向指数
    % dx dy x和y方向微分
    %% --------------------------------------
    % 光束参数
    k = 2*pi/lambda;                    % 波数
    zR = beam_waist^2*pi/lambda;        % 瑞利距离
    w_z = beam_waist*sqrt(1+z.^2/zR^2); % z位置高斯项束宽
    %% 生成涡旋光
    % 振幅项
    A =  (sqrt(2)*r/w_z).^abs(l).*exp(-r.^2 /w_z.^2).*laguerre(p,abs(l),2*r.^2/w_z.^2);
    % 球面相位
    if z == 0
        P1 = 1;                         % 如果z是0则判断为源平面
    else
        R = z.*(1+zR.^2/z^2);           % z不为零时的球面波前
         P1 = exp(1i*k*r.^2/2/R);
    end
    % 古伊相位
    P2 = exp(1i*(abs(l)+2*p+1)*atan(z/zR));
    % 螺旋波相位因子
    P3 = exp(-1i*l*theta);
    E= A.*P1.*P2.*P3;
    % 归一化光场
    E = E/sqrt(sum(abs(E(:)).^2) * dx.*dy);
    function result = laguerre(p,l,x)
        % 拉盖尔多项式
        if p == 0
            result = 1;
        elseif p == 1
            result = 1+abs(l)-x;
        else
            result = (1/p)*((2*p+l-1-x).*laguerre(p-1,abs(l),x)-(p+l-1)*laguerre(p-2,abs(l),x));
        end
    end
end