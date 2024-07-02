% 显示螺旋轨迹上每个点的坐标
X = out.PositionX;
Y = out.PositionY;
Z = out.PositionZ;

SetX=out.PositionSetX;
SetY=out.PositionSetY;
SetZ=out.PositionSetZ;

%起始点
startX=0;
startY=0;
startZ=0;

%参考轨迹起始点
startSetX=2;
startSetY=1;
startSetZ=0;

% 创建三维图形
figure;
plot3(X, Y, Z, 'b-', SetX, SetY, SetZ,'r-',startX,startY,startZ,'.',startSetX,startSetY,startSetZ,'.','LineWidth', 2,'MarkerSize',35,'MarkerSize',35);

grid on;
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
title('螺旋轨迹');
% 图例
legend('实际轨迹','设定轨迹','ROV起点','轨迹起点');
% 设置坐标轴的纵横比，确保轨迹不会变形
axis equal;

