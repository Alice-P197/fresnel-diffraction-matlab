function [x,y] = makegrid(res,pitch_x,pitch_y)
% 给定像素尺寸pitch_x, pitch_y计算x和y
    minX = -res(1)*pitch_x;
    maxX =  res(1)*pitch_x;
    
    minY = -res(2)*pitch_y;
    maxY =  res(2)*pitch_y;
    
    x = minX:pitch_x:maxX;
    y = minY:pitch_y:maxY;
end