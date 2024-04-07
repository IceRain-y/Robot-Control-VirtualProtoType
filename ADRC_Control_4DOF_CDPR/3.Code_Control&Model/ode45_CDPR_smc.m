clc
clear; 


X0=[0.2,0,0,0,1.3,0,0, 0, 0, 0, -0.001, 0]'; 
Q0=[0 , 2,  0, 4 , 0, -2 , 0,  -4]';
Y0=[X0;Q0];

tt0=12; tt=12;  [t1,Y1]=ode45(@Control_CDPR_smc,[0 tt],Y0);



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








