function CDPR = Control_CDPR_smc(t1,v)
% %机器人系统含弹性的动力学模型方程---→D2Y=[Xddot,qddot]'.
% %二阶微分方程，状态量：x,y,z,al,be,ga,q1,q2,q3,q4;dx,dy,dz,dal,dbe,dga,dq1,dq2,dq3,dq4.


A=2.2;B=3.0;C=1.5;a=0.2;b=0.05; h=0.1; 
m=3.5;g=9.8; r0=0.1; m0=7.52*10^(-4);  
% K0=687223.0;
% K0=215494.0;
% K0=137445.0;
K0=1000 ;

% %定义的零位置的悬索（未形变）长度L00：
L0=[2.0992    1.9280    1.5225    1.6912    2.0992    1.9280    1.5225    1.6912]';
l01=L0(1,1);l02=L0(2,1);l03=L0(3,1);l04=L0(4,1);l05=L0(5,1);l06=L0(6,1);l07=L0(7,1);l08=L0(8,1);

% %①期望电机转角轨迹
% %电机转角初始值q0，终端值q0d
% qd0=[ 0    0   0   0 ]';  % %期望轨迹的初始转角
% q1d0=qd0(1,1);q2d0=qd0(2,1);q3d0=qd0(3,1);q4d0=qd0(4,1);
q1d=-(-0.5*(t1-2)^2+2).*(0<=t1&&t1<4) - (0.5*(t1-8)^2-8).*(4<=t1&&t1<12);
q4d=(-0.5*(t1-4)^2+8).*(0<=t1&&t1<8) + (0.5*(t1-10)^2-2).*(8<t1&&t1<12);
q3d=-(0.5*(t1-2)^2-2).*(0<t1&&t1<=4) - (-0.5*(t1-8)^2+8).* (4<t1&&t1<12);
q2d=(0.5*(t1-4)^2-8).*(0<t1&&t1<=8) + (-0.5*(t1-10)^2+2).* (8<t1&&t1<12);

dq1d=-(-t1+2).*(0<=t1&&t1<=4) - (t1-8).*(4<=t1&&t1<=12);
dq4d=(-t1+4).*(0<=t1&&t1<=8) + (t1-10).*(8<=t1&&t1<=12);
dq3d=-(t1-2).*(0<=t1&&t1<=4) - (-t1+8).*(4<=t1&&t1<=12);
dq2d=(t1-4).*(0<=t1&&t1<=8) + (-t1+10).*(8<=t1&&t1<=12);

ddq1d=-(-1).*(0<=t1&&t1<=4) - (1).*(4<=t1&&t1<=12);
ddq4d=(-1).*(0<=t1&&t1<=8) + (1).*(8<=t1&&t1<=12);
ddq3d=-(1).*(0<=t1&&t1<=4) - (-1).*(4<=t1&&t1<=12);
ddq2d=(1).*(0<=t1&&t1<=8) + (-1).*(8<=t1&&t1<=12);

CDPR=zeros(20,1);
x=v(1);dx=v(2);y=v(3);dy=v(4);z=v(5);dz=v(6);
al=v(7);dal=v(8);be=v(9);dbe=v(10);ga=v(11);dga=v(12);
q1=v(13);dq1=v(14);q2=v(15);dq2=v(16);q3=v(17);dq3=v(18);q4=v(19);dq4=v(20);

qd=[q1d;q2d;q3d;q4d];
dqd=[dq1d;dq2d;dq3d;dq4d];
ddqd=[ddq1d;ddq2d;ddq3d;ddq4d];
q=[q1;q2;q3;q4];dq=[dq1;dq2;dq3;dq4];
P=[x;y;z];dP=[dx;dy;dz];dth=[dal;dbe;dga];
X=[x;y;z;al;be;ga];dX=[dx;dy;dz;dal;dbe;dga];
R=[cos(ga)*cos(be),  cos(ga)*sin(be)*sin(al)-sin(ga)*cos(al),  cos(ga)*sin(be)*cos(al)+sin(ga)*sin(al);  
   sin(ga)*cos(be),  sin(ga)*sin(be)*sin(al)+cos(ga)*cos(al),  sin(ga)*sin(be)*cos(al)-cos(ga)*sin(al);   
          -sin(be),                          cos(be)*sin(al),                        cos(be)*cos(al)   ];       
B1=[A/2;B/2;  C];B2=[-A/2;B/2;  C];B3=[-A/2;-B/2;  C];B4=[A/2;-B/2;  C];B5=[A/2;B/2; C-h];B6=[-A/2;B/2; C-h];B7=[-A/2;-B/2; C-h];B8=[A/2;-B/2; C-h];
p1=[a/2;b/2;h/2];p2=[-a/2;b/2;h/2];p3=[-a/2;-b/2;h/2];p4=[a/2;-b/2;h/2];p5=[a/2;b/2;-h/2];p6=[-a/2;b/2;-h/2];p7=[-a/2;-b/2;-h/2];p8=[a/2;-b/2;-h/2];
L1=P+R*p1-B1;L2=P+R*p2-B2;L3=P+R*p3-B3;L4=P+R*p4-B4;L5=P+R*p5-B5;L6=P+R*p6-B6;L7=P+R*p7-B7;L8=P+R*p8-B8;
le1=norm(L1);le2=norm(L2);le3=norm(L3);le4=norm(L4);le5=norm(L5);le6=norm(L6);le7=norm(L7);le8=norm(L8);
u1=L1/norm(L1);u2=L2/norm(L2);u3=L3/norm(L3);u4=L4/norm(L4);u5=L5/norm(L5);u6=L6/norm(L6);u7=L7/norm(L7);u8=L8/norm(L8);
%%雅各比矩阵J
Jz=[            u1,            u2,            u3,            u4,            u5,            u6,            u7,           u8;
   cross(R*p1,u1),cross(R*p2,u2),cross(R*p3,u3),cross(R*p4,u4),cross(R*p5,u5),cross(R*p6,u6),cross(R*p7,u7),cross(R*p8,u8)];
Ix=(m*(b*b+h*h))/12;Iy=(m*(a*a+h*h))/12;Iz=(m*(a*a+b*b))/12;
I0=[Ix,0,0;0,Iy,0;0,0,Iz];
  
Q =[ 1,       0,       -sin(be);
     0, cos(al),sin(al)*cos(be);
     0,-sin(al),cos(al)*cos(be)  ];  
Qdot=[0,   0,    -cos(be)*dbe;
      0,-sin(al)*dal, cos(al)*cos(be)*dal-sin(al)*sin(be)*dbe;
      0,-cos(al)*dal,-sin(al)*cos(be)*dal-cos(al)*sin(be)*dbe ];
MM=R*I0*Q;
M =[m,0,0,0,0,0;
    0,m,0,0,0,0;
    0,0,m,0,0,0;
    zeros(3,3),MM];
% dP=[dx;dy;dz];dth=[dal;dbe;dga];
G=[0;0;m*g;0;0;0];
C0=(R)*(I0*Qdot*dth+cross((Q*dth),(I0*Q*dth)));
N=[zeros(3,1);C0]+G;
lo1=l01+r0*q1;lo2=l02+r0*q2;lo3=l03+r0*q3;lo4=l04+r0*q4;lo5=l05+r0*q1;lo6=l06+r0*q2;lo7=l07+r0*q3;lo8=l08+r0*q4;
Lo=[lo1;lo2;lo3;lo4;lo5;lo6;lo7;lo8];Le=[le1;le2;le3;le4;le5;le6;le7;le8];
Loe1=[lo1-le1;lo2-le2;lo3-le3;lo4-le4;];Loe2=[lo5-le5;lo6-le6;lo7-le7;lo8-le8;];
K =diag([K0/lo1,K0/lo2,K0/lo3,K0/lo4,K0/lo5,K0/lo6,K0/lo7,K0/lo8]);
K1=diag([K0/lo1,K0/lo2,K0/lo3,K0/lo4]);

D=r0*K1*(Loe1+Loe2);

Im=diag([m0,m0,m0,m0]);

%滑膜控制
c=0.5;
e=q-qd;
de=dq-dqd;
s=c*e+de;

J=10;
xite=10;
Dm=50;
epc=0.02;

Md=1;
if Md==1
    ut=J*(-c*de+ddqd-xite*s)-Dm*sign(s);
elseif Md==2
    ut=J*(-c*de+ddqd-xite*s)-Dm*tanh(s/epc);
end

tol=(Im*ut + D);

ddX=inv(M)*(-N+Jz*K*(Lo-Le));
ddq=inv(Im)*(-D+tol);

CDPR(1)=v(2);
CDPR(2)=ddX(1);
CDPR(3)=v(4);
CDPR(4)=ddX(2);
CDPR(5)=v(6);
CDPR(6)=ddX(3);
CDPR(7)=v(8);
CDPR(8)=ddX(4);
CDPR(9)=v(10);
CDPR(10)=ddX(5);
CDPR(11)=v(12);
CDPR(12)=ddX(6);
CDPR(13)=v(14);
CDPR(14)=ddq(1);
CDPR(15)=v(16);
CDPR(16)=ddq(2);
CDPR(17)=v(18);
CDPR(18)=ddq(3);
CDPR(19)=v(20);
CDPR(20)=ddq(4);         


end

