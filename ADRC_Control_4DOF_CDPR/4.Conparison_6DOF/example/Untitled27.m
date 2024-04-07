tspan=[0 10];
y0=[0 0 0 0 0 0 0 0 0 0 0 0];
[t,X]=ode45(@odefun,tspan,y0);
subplot(2,2,1)
plot(t,X(:,1),t,X(:,2),t,X(:,3))
legend('x','y','z','Location','northwest')
xlabel('时间');
ylabel('位移');
subplot(2,2,2)
plot(t,X(:,4),t,X(:,5),t,X(:,6))
legend('ψ','θ','Φ','Location','northwest')
xlabel('时间');
ylabel('角度');
subplot(2,2,3)
plot(t,X(:,7),t,X(:,8),t,X(:,9))
legend('xdot','ydot','zdot','Location','northwest')
xlabel('时间');
ylabel('速度');
subplot(2,2,4)
plot(t,X(:,10),t,X(:,11),t,X(:,12))
legend('ψdot','θdot','Φdot','Location','northwest')
xlabel('时间');
ylabel('角速度');
sim1=[t X(:,1)];
sim2=[t X(:,2)];
sim3=[t X(:,3)];
sim4=[t X(:,4)];
sim5=[t X(:,5)];
sim6=[t X(:,6)];

function dx=odefun(t,X)
%动平台质量
m=5;
g=9.8;
%角速度转换矩阵
P1=[cosd(X(5))*cosd(X(6)) -sind(X(6)) 0;cosd(X(5))*sind(X(6)) cosd(X(6)) 0;-sind(X(5)) 0 1];
R = [cosd(X(5))*cosd(X(6)) sind(X(4))*sind(X(5))*cosd(X(6))-sind(X(6))*cosd(X(4)) cosd(X(4))*sind(X(5))*cosd(X(6))+sind(X(6))*sind(X(4));cosd(X(5))*sind(X(6)) sind(X(4))*sind(X(5))*sind(X(6))+cosd(X(6))*cosd(X(4)) cosd(X(4))*sind(X(5))*sind(X(6))-cosd(X(6))*sind(X(4));-sind(X(5)) sind(X(4))*cosd(X(5)) cosd(X(4))*cosd(X(5))]; % XYZ旋转矩阵
R1 = 5; % 动平台铰点的外接圆半径
r = 50; % 静平台铰点的外接圆半径
%转动惯量
Ix=10;
Iy=10;
Iz=31.25;
Ixy=0;
Ixz=0;
Iyz=0;
Ib=[Ix -Ixy -Ixz;-Ixy Iy -Iyz;-Ixz -Iyz Iz];
I=R*Ib*R';
M=[m*eye(3) zeros(3);zeros(3) P1'*I*P1];
%P矩阵的导数
P11=[0 0 -cosd(X(5))*X(11);0 -sind(X(4))*X(10) cosd(X(4))*cosd(X(5))*X(10)-sind(X(4))*sind(X(5))*X(11);0 -cosd(X(4))*X(10) -sind(X(4))*cosd(X(5))*X(10)-cosd(X(4))*sind(X(5))*X(11)];
Q1=[X(10);X(11);X(12)];
H=[zeros(3,1);P1'*(I*P11*Q1+cross((P1*Q1),I*P1*Q1))];
G=[0;0;m*g;zeros(3,1)];
% 动平台铰点的安装角度
up_angle1 = -120;
up_angle2 = 0;
up_angle3 = 120;
% 静平台铰点的安装角度
down_angle1 = -60.0;
down_angle2 = 60.0;
down_angle3 = 180.0;
%动平台的3个铰点，在动平台坐标系中的位置矢量
bR1 = [ R1*cosd( up_angle1 ); R1*sind( up_angle1 ); 0 ];
bR2 = [ R1*cosd( up_angle2 ); R1*sind( up_angle2 ); 0 ];
bR3 = [ R1*cosd( up_angle3 ); R1*sind( up_angle3 ); 0 ];
%静平台的3个铰点，在静坐标系中的位置矢量
Br1 = [ r*cosd( down_angle1 );r*sind( down_angle1 ); 100 ];
Br2 = [ r*cosd( down_angle2 );r*sind( down_angle2 ); 100 ];
Br3 = [ r*cosd( down_angle3 );r*sind( down_angle3 ); 100 ];
P=[X(1);X(2);X(3)];
%动平台的3个铰点，在静坐标系中的位置矢量
br1 = R * bR1 + P;
br2 = R * bR2 + P;
br3 = R * bR3 + P;
%--动平台的6个铰点位置矢量，减去，静平台的6个铰点位置矢量，得到每个杆长矢量
L1 = br1 - Br1;
L2 = br2 - Br1;
L3 = br2 - Br2;
L4 = br3 - Br2;
L5 = br3 - Br3;
L6 = br1 - Br3;
%求模，得到每个杆的杆长
LenL1 = norm(L1);
LenL2 = norm(L2);
LenL3 = norm(L3);
LenL4 = norm(L4);
LenL5 = norm(L5);
LenL6 = norm(L6);
%绳索单位矢量
u1=L1/LenL1;
u2=L2/LenL2;
u3=L3/LenL3;
u4=L4/LenL4;
u5=L5/LenL5;
u6=L6/LenL6;
% u=[9.048 0 0 9.048 9.048 9.048]';
u=[10 10 10 10 10 10]';
J=[eye(3) zeros(3);zeros(3) P1']*[u1  u2  u3  u4  u5  u6;cross(R*bR1,u1) cross(R*bR2,u2) cross(R*bR2,u3) cross(R*bR3,u4) cross(R*bR3,u5) cross(R*bR1,u6)];
t=-J*u;
dx=zeros(12,1);
dx(1)=X(7);
dx(2)=X(8);
dx(3)=X(9);
dx(4)=X(10);
dx(5)=X(11);
dx(6)=X(12);
A=inv(M)*(t-G-H);
dx(7)=A(1);
dx(8)=A(2);
dx(9)=A(3);
dx(10)=A(4);
dx(11)=A(5);
dx(12)=A(6);
end