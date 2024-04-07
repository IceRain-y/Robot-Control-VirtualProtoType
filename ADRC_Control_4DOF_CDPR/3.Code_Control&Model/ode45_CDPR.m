clc
clear; 
% Xd0=[-0.15; -0.25; 1.2; -0.15 ]; % %初始位置
% Xd =[ 0.15;  0.25; 1.3 ;  0.15 ]; % %终点位置
% %wc分别取值0.85和2.0的实验结果X，q的比较

% %wc=0.85情况下
X0=[0.2,0,0,0,1.3,0,0, 0, 0, 0, -0.001, 0]'; 
Q0=[0 , 2,  0, 4 , 0, -2 , 0,  -4]';
Y0=[X0;Q0];
global wc1
wc1=0.85;  ex=0.0;  exx=0.0; 
tt0=12; tt=12;  [t1,Y1]=ode45(@Control_CDPR,[0 tt],Y0);

% %wc=2.0情况下
% X0=[0.2,0,0,0,1.30,0,0, 0, 0, 0, -0.001, 0]'; 
% Q0=[0 , 0,  0, 0 , 2, 4 , -2,-4]';
% Y0=[X0;Q0];
% global wc2 ex2 exx2 
% wc2=4.0;  ex2=5.0;  exx2=2.0; 
% tt0=12; tt=12;  [t2,Y2]=ode45(@robot001_101ddX_ddq,[0 tt],Y0);


% %位置x y
figure(1);
%plot(t2,Y2(:,1),'k',t1,Y1(:,1),'--k','LineWidth',1.7);
plot(t1,Y1(:,1),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('x（m）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
axis([0 ,tt0,-0.2,0.2 ]);
 
 % %位置x y
figure(2);
%plot(t2,Y2(:,3),'k',t1,Y1(:,3),'--k','LineWidth',1.7);
plot(t1,Y1(:,3),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('y（m）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on; 
 axis([0 ,tt0,-0.2,0.2 ]);
 
 % %位置z
figure(3);
%plot(t2,Y2(:,5),'k',t1,Y1(:,5),'--k','LineWidth',1.7);
plot(t1,Y1(:,5),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('z（m）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on;  
axis([0 ,tt0,1.15,1.35 ]);
 
 
% %姿态γ
figure(4);
%plot(t2,Y2(:,7),'k',t1,Y1(:,7),'--k','LineWidth',1.7);
plot(t1,Y1(:,11),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('\gamma（rad）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on;  
axis([0 ,tt0,-0.005,0.005 ]);

% %转角q1
figure(5);
%plot(t2,Y2(:,7),'k',t1,Y1(:,7),'--k','LineWidth',1.7);
plot(t1,Y1(:,13),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('q1（rad）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on;  
axis([0 ,tt0,-0.005,0.005 ]);

% %转角q2
figure(6);
%plot(t2,Y2(:,7),'k',t1,Y1(:,7),'--k','LineWidth',1.7);
plot(t1,Y1(:,15),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('q2（rad）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on;  
axis([0 ,tt0,-0.005,0.005 ]);

% %转角q3
figure(7);
%plot(t2,Y2(:,7),'k',t1,Y1(:,7),'--k','LineWidth',1.7);
plot(t1,Y1(:,17),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('q3（rad）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on;  
axis([0 ,tt0,-0.005,0.005 ]);

% %转角q4
figure(8);
%plot(t2,Y2(:,7),'k',t1,Y1(:,7),'--k','LineWidth',1.7);
plot(t1,Y1(:,19),'k','LineWidth',1.7);
xlabel('时间（s）');ylabel('q4（rad）'); set(gca,'linewidth',1.3);
%legend('\omega_c=2.0','\omega_c=0.85');  grid on;  
legend('\omega_c=0.85');  grid on;  
axis([0 ,tt0,-0.005,0.005 ]);








