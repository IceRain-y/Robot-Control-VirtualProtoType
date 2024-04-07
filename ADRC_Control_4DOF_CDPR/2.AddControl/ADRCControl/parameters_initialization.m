%--参数初始化--%
h = 0.01;
%微分跟踪器参数
r = 100;%r为速度因子
h0 = 5 * h;%h0为滤波因子
v1_last = 0;
v2_last = 0;
v0_last = 0;
%扩张状态观测器参数
beta01 =6;
beta02 = 24;
beta03 =4;
alpha1 = 0.5;
alpha2 = 0.25;
delta = 0.0025;
b=2;
z1_last = 0;
z2_last = 0;
z3_last = 0;
%非线性误差反馈?
nlsef_alpha1 = 0.7;
nlsef_alpha2  = 1;
