function GIF_generator(gcf,indices,folderpath)
    % GIF图片生成器
    I = frame2im(getframe(gcf));
    [A, map] = rgb2ind(I,256);
    if indices == 1
        imwrite(A,map, [folderpath,'.gif'],'gif', ...
            'loopcount',Inf,'Delaytime',0.002)
    else
        imwrite(A,map,  [folderpath,'.gif'],'gif', ...
            'writemode','append','Delaytime',0.002)
    end
end