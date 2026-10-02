function show_results(data,d,L0)
    left = 0.03;  width = 0.3;  gap = 0;
    bottom = 0.08; height = 0.8; 
    pos2 =[left + 3*width + 2*gap + 0.02, 0.3, 0.015, 0.3];
    ax = gobjects(1, 3);
    Imax = max(max(data{1,1}));
    %% ========== 显示 ==========
    for k = 1:3
        pos1 =[left + (k-1)*(width+gap), bottom, width, height];
        ax(k) = subplot(1,3,k);
         set(ax(k), 'Position',pos1);
        imagesc(data{k,2}, data{k,3}, data{k,1});
        axis equal; axis xy; axis manual;
        hold on;
        intensity_1D_profile(gca,data{k,2}, data{k,3}, ...
            0.5,data{k,1},L0,"w","xy")
        xlim([-L0/2, L0/2]); ylim([-L0/2, L0/2]);
        title(data{k,4}, 'FontName', 'Times New Roman', 'FontSize', 14);
        colormap(ax(k), gray(255));
        clim(ax(k), [0, Imax]);
        set(ax(k), 'XTick', [], 'YTick', []);
    end
    %% ========== 右侧独立 colorbar, 绑定第一个图 ==========
    cb = colorbar(ax(1), 'Position', pos2);
    cb.Limits   = [0, Imax];
    cb.FontName = 'Times New Roman';
    cb.FontSize = 16;
    cb.Ticks    = [0,Imax];
    cb.TickLabels = {"0","$I_{\rm max}$"};
    cb.Label.FontSize = 16;
    cb.TickLabelInterpreter = "latex";
    cb.Label.String = "Intensity";
    sgtitle(['d=',num2str(round(d*1e1)*1e-1),'mm'], ...
        'fontname','times new roman','fontsize',20)
end