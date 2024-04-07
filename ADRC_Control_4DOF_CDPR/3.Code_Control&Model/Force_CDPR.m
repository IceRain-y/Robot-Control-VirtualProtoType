%  % 悬索机器人圆周轨迹对应悬索拉力求解
clc;
clear all;

% %参数初始化
A=2.2;B=3.0;C=1.5;
a=0.2;b=0.05;h=0.1; 
r0=0.02; 
K0=1000;
al=0;be=0;dal=0;dbe=0;

% %定义的零位置的悬索（未形变）长度L00：
L0=[2.0992   1.9280    1.5225    1.6912    2.0992    1.9280    1.5225    1.6912]';
l01=L0(1,1);l02=L0(2,1);l03=L0(3,1);l04=L0(4,1);l05=L0(5,1);l06=L0(6,1);l07=L0(7,1);l08=L0(8,1);

B1=[A/2;B/2;  C];B2=[-A/2;B/2;  C];B3=[-A/2;-B/2;  C];B4=[A/2;-B/2;  C];
B5=[A/2;B/2; C-h];B6=[-A/2;B/2; C-h];B7=[-A/2;-B/2; C-h];B8=[A/2;-B/2; C-h];
p1=[a/2;b/2;h/2];p2=[-a/2;b/2;h/2];p3=[-a/2;-b/2;h/2];p4=[a/2;-b/2;h/2];
p5=[a/2;b/2;-h/2];p6=[-a/2;b/2;-h/2];p7=[-a/2;-b/2;-h/2];p8=[a/2;-b/2;-h/2];
%ode45计算初始化
X0=[0.2,0,0,0,1.3,0,0, 0, 0, 0, -0.001, 0]'; 
Q0=[0 , 2,  0, 4 , 0, -2 , 0,  -4]';
Y0=[X0;Q0];
global wc1
wc1=0.85;   
Y1=zeros(11253,20);

for i = 1:1:11253

[t1,Y1]=ode45(@Control_CDPR,[0 12],Y0);
xx(i)=Y1(i,1);yy(i)=Y1(i,3);zz(i)=Y1(i,5);ga(i)=Y1(i,11);
q1(i)=Y1(i,13);q2(i)=Y1(i,15);q3(i)=Y1(i,17);q4(i)=Y1(i,19);

P=[xx(i);yy(i);zz(i)];
R=[cos(ga(i))*cos(be),  cos(ga(i))*sin(be)*sin(al)-sin(ga(i))*cos(al),  cos(ga(i))*sin(be)*cos(al)+sin(ga(i))*sin(al);  
   sin(ga(i))*cos(be),  sin(ga(i))*sin(be)*sin(al)+cos(ga(i))*cos(al),  sin(ga(i))*sin(be)*cos(al)-cos(ga(i))*sin(al);   
          -sin(be),                          cos(be)*sin(al),                        cos(be)*cos(al)   ];     
      


L1=P+R*p1-B1;L2=P+R*p2-B2;L3=P+R*p3-B3;L4=P+R*p4-B4;
L5=P+R*p5-B5;L6=P+R*p6-B6;L7=P+R*p7-B7;L8=P+R*p8-B8;

le1(i)=norm(L1);le2(i)=norm(L2);le3(i)=norm(L3);le4(i)=norm(L4);
le5(i)=norm(L5);le6(i)=norm(L6);le7(i)=norm(L7);le8(i)=norm(L8);

lo1(i)=l01+r0*q1(i);lo2(i)=l02+r0*q2(i);lo3(i)=l03+r0*q3(i);lo4(i)=l04+r0*q4(i);
lo5(i)=l05+r0*q1(i);lo6(i)=l06+r0*q2(i);lo7(i)=l07+r0*q3(i);lo8(i)=l08+r0*q4(i);

Lo=[lo1(i);lo2(i);lo3(i);lo4(i);lo5(i);lo6(i);lo7(i);lo8(i)];
Le=[le1(i);le2(i);le3(i);le4(i);le5(i);le6(i);le7(i);le8(i)];

K =diag([K0/lo1(i),K0/lo2(i),K0/lo3(i),K0/lo4(i),K0/lo5(i),K0/lo6(i),K0/lo7(i),K0/lo8(i)]);
F=K*(Le-L0);
f1=F(1);f2=F(2);f3=F(3);f4=F(4);f5=F(5);f6=F(6);f7=F(7);f8=F(8);
F1=[f1,f2,f3,f4];F2=[f1,f2,f3,f4];

Data_1(:,i)=F1;Data_2(:,i)=F2;

end

%悬索拉力变化
maker_idx = 1:600:11253;
figure(1);
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_1(1,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx);
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_1(2,:),'+-','Color','b','linewidth',0.5,'MarkerIndices',maker_idx);
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_1(3,:),'*-','Color','g','linewidth',0.5,'MarkerIndices',maker_idx);
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_1(4,:),'^-','Color','k','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('time(s)'),ylabel('upper_rope_force(N)');
hold off

figure(2);
plot(t1,Data_2(1,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx); 
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_2(2,:),'+-','Color','b','linewidth',0.5,'MarkerIndices',maker_idx); 
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_2(3,:),'*-','Color','g','linewidth',0.5,'MarkerIndices',maker_idx); 
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t1,Data_2(4,:),'^-','Color','k','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('time(s)'),ylabel('lower_rope_force(N)');


