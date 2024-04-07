function z=PSO_ADRC(x)
assignin('base','a',x(1));
assignin('base','b',x(2));
assignin('base','Kp',x(3));
assignin('base','Kd',x(4));
[~,~,y_out]=sim('ADRCControl_20220610',[0,12]);
z=y_out(end,1);   %%表示 取这个矩阵的第一列最后一行的数据。