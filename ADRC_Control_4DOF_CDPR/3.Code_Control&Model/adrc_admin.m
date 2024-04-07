clc;
clear all;
close all;
 
%运行时间
time = 12;
%仿真步长
h = 0.01;
%时间定义
t  =0.01 : h : time;
%分配跟踪信号初始空间
v0 = zeros( 4 * time/h , 1 );
%随机噪声
%rand_noise = 0.05 * randn(1 , time/h);
%加入随机噪声
%vn = v0 + rand_noise;

%----------------------ADRC--------------------------%
%%
%--参数初始化--%
 
%跟踪微分器参数
r = 100;%r表示跟踪快慢
h0 = 5 * h;%h0代表信号平滑度（滤波效果）
v1_last = 0;
v2_last = 0;
v0_last = 0; % %扰动初始化
%扩张状态观测器参数
beta01 = 1;
beta02 = 3;
beta03 = 3;
alpha1 = 0.5;%文献里给了值，就别动了
alpha2 = 0.25;%文献里给了值，就别动了
delta = 0.0025;
b=1;
z1_last = 0;
z2_last = 0;
z3_last = 0;
%非线性误差反馈
nlsef_alpha1 = 0.7;
nlsef_alpha2  = 1;
%被控对象初始化
X0=[0.2,0,0,0,1.3,0,0, 0, 0, 0, -0.001, 0]'; 
Q0=[0 , 2,  0, 4 , 0, -2 , 0,  -4]';
temp_y=[X0;Q0];
u_last= [2;4;-2;-4] ;

%%
%--ADRC正式开始--%
for k=1  : time/h
    %第一轮迭代的处理
    %两个参数分别为控制量和当前时间
    parameter1 = u_last;
    parameter2 = k * h;
    tSpan=[0 0.01];
    %利用龙格库塔法求解微分方程
    [t1,total_y] = ode45('Control_CDPR_adrc',tSpan,temp_y,[],parameter1,parameter2);
    %total_state里的元素都是龙格库塔一点点计算的结果，直接用最后一列，即计算结果即可
    temp_y = total_y(length(total_y),:);
    %记录下输出和输出的微分值
    y = [temp_y(13);temp_y(15);temp_y(17);temp_y(19)];
    dy = [temp_y(14);temp_y(16);temp_y(18);temp_y(20)];
    %设置跟踪信号
    tt(k,1)= h * k;
    q1d=-(-0.5*(tt(k,1)-2)^2+2).*(0<=tt(k,1)&&tt(k,1)<4) - (0.5*(tt(k,1)-8)^2-8).*(4<=tt(k,1)&&tt(k,1)<12);
    q4d=(-0.5*(tt(k,1)-4)^2+8).*(0<=tt(k,1)&&tt(k,1)<8) + (0.5*(tt(k,1)-10)^2-2).*(8<tt(k,1)&&tt(k,1)<12);
    q3d=-(0.5*(tt(k,1)-2)^2-2).*(0<tt(k,1)&&tt(k,1)<=4) - (-0.5*(tt(k,1)-8)^2+8).* (4<tt(k,1)&&tt(k,1)<12);
    q2d=(0.5*(tt(k,1)-4)^2-8).*(0<tt(k,1)&&tt(k,1)<=8) + (-0.5*(tt(k,1)-10)^2+2).* (8<tt(k,1)&&tt(k,1)<12);
    v0=[q1d;q2d;q3d;q4d];
    vn = v0 ;
    %--跟踪微分器TD--%
    v1 = v1_last + h * v2_last;
    v2 = v2_last + h * fst(v1_last - vn , v2_last , r , h0);
%     v2(k) = v2_last + deltaT * fst(v1_last - v0(k) , v2_last , r , h0);
   % x3(k) = -v1_last^2; % %扰动估计输出
    v1_last = v1;
    v2_last = v2;
%     v0_last = v0(k);
    v0_last = vn;
    %--扩张状态观测器ESO--%
    e = z1_last - y;
    z1 = z1_last + h * (z2_last - beta01 * e);
    z2 = z2_last + h * (z3_last - beta02 * (fal(e , alpha1 , delta)) +b * u_last);
    z3 = z3_last - h * beta03 * (fal(e , alpha2 , delta));
    z1_last = z1;
    z2_last = z2;
    %--非线性误差反馈NLSEF--%
    e1 = v1 - z1;
    e2 = v2 - z2;
    %使用非线性误差反馈，其实就是非线性的PID
    u0 = beta01 * fal(e1 , nlsef_alpha1 , delta) + beta02 * fal(e2 , nlsef_alpha2 , delta);
    u = u0 - z3/b;
    u_last = u;
%     %%
%     %--可对比PD控制器--%
%     u(k) = kp * e1(k) + kd * e2(k);
%     u_last = u(k);
    Data1(:,k)=y;
    Data2(:,k)=u;
    MM=[temp_y(1);temp_y(3);temp_y(5);temp_y(11)];
    Data3(:,k)=MM;
end

%输入信号
maker_idx = 1:50:1200;
figure(1);
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data1(1,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx);
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data1(2,:),'+-','Color','b','linewidth',0.5,'MarkerIndices',maker_idx);
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data1(3,:),'*-','Color','g','linewidth',0.5,'MarkerIndices',maker_idx);
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data1(4,:),'^-','Color','k','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('time(s)'),ylabel('angle(rad)');
hold off
%控制量
figure(2);
plot(t,Data2(1,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx); 
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data2(2,:),'+-','Color','b','linewidth',0.5,'MarkerIndices',maker_idx); 
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data2(3,:),'*-','Color','g','linewidth',0.5,'MarkerIndices',maker_idx); 
hold on
% plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
plot(t,Data2(4,:),'^-','Color','k','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('time(s)'),ylabel('troque(N * m)');
% %位置x y,z,gamma
figure(3);
subplot(221)
plot(t,Data3(1,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('时间（s）');ylabel('x（m）'); set(gca,'linewidth',1.3);
subplot(222)
plot(t,Data3(2,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('时间（s）');ylabel('y（m）'); set(gca,'linewidth',1.3);
subplot(223)
plot(t,Data3(3,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx);
xlabel('时间（s）');ylabel('z（m）'); set(gca,'linewidth',1.3);
subplot(224)
plot(t,Data3(4,:),'o-','Color','r','linewidth',0.5,'MarkerIndices',maker_idx)
xlabel('时间（s）');ylabel('\gamma（rad）'); set(gca,'linewidth',1.3);


% figure(2);
% subplot(311);
% % plot(t,z1,'r',t,y,'k:',t,v0,'b','linewidth',2);
% plot(t,z1,'r',t,y,'k:',t,vn,'b','linewidth',2);
% xlabel('time(s)'),ylabel('z1,y');
% legend('估计输出信号', '实际输出信号');   
% subplot(312);
% plot(t,z2,'r',t,dy,'k:','linewidth',2);
% xlabel('time(s)'),ylabel('z2,dy');
% legend('估计输出微分信号', '实际输出微分信号');    
% subplot(313);
% plot(t,z3,'r',t,x3,'k:','linewidth',2);
% xlabel('time(s)'),ylabel('z3,x3');
% legend('估计扰动', '实际扰动'); 
 
%%
%---------------------------函数部分-----------------------------%
%sat函数
function y=sat(a,d)
    if abs(a)<=d
        y=a/d;
    else
        y=sgn(a);
    end
end
 
%符号函数
function y=sgn(x)
    if x>0
        y=1;
    elseif x<0
        y=-1;
    else 
        y=0;
    end
end
 
%fst函数
function fn=fst(x1,x2,r,h)
    d=h*r;
    d0=h*d;
    y=x1+h*x2;
    a0=sqrt(d^2+8*r*abs(y));
 
    if abs(y)<=d0
        a=x2+y/h;
    else
        a=x2+0.5*(a0-d)*sgn(y);
    end
    fn=-r*sat(a,d);
end
 
%fal函数
function y=fal(e,alpha,delta)
    if abs(e)>delta
        y=abs(e).^alpha.*sign(e);
    else
        y=e/(delta^(1-alpha));
    end
end
% %-----------------------------------------------------------------%

