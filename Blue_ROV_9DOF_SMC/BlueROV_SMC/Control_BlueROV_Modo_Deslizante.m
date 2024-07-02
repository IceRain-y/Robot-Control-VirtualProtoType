%% Andres Lopez y Daniel Gomez---------------------------------------------
clc; clear all; close all
disp('Datos_BlueRov')
%% DATOS-SUMINISTRADOS-----------------------------------------------------
m=10.7668; 
xg=0;yg=0;zg=0;
xb=0;yb=0;zb=0.02;
%%惯性张量-----------------------------------------------------
Ix=0.1836;Iy=0.2181;Iz=0.1482;Ixy=0;Ixz=0;Iyz=-0.0021;   %惯性张量矩阵
%%重力、浮力-----------------------------------------------------
W=0;%重力
B=0;%浮力           正浮力状态

%% Hydrodynamic linear and quadratic damping coefficients       水动力阻尼，一阶和二阶
Xu=-0.0048;Yv=-0.2437;Zw=-0.0094;Kp=-5.005;Mq=-5.005;Nr=-0.004;
Xuu=-30.61;Yvv=-38.0036;Zww=-62.5364;Kpp=-80.25;Mqq=-80.25;Nrr=-0.2506;

%% Added mass (hydrodynamic derivatives),附加质量力
Xudot=-4.9063;Yvdot=-9.9210;Zwdot=-17.6159;Kpdot=-0.8576;Mqdot=-1.1214;Nrdot=-0.7399;
%------------Masas---------------------------------------------------------
Mrb=[   m,          0,         0,         0,         m*zg,       -m*yg;...%Matriz de inercia
              0,          m,        0,     -m*zg,        0,            m*xg;...
              0,           0,        m,      m*yg,    -m*xg,         0;...
              0,       -m*zg,   m*yg,    Ix,         -Ixy,           -Ixz;...
             m*zg,     0,     -m*xg,   -Ixy,         Iy,            -Iyz;...
           -m*yg,  m*xg,     0,        -Ixz,        -Iyz,            Iz];
Fmomento=[Xudot,Yvdot,Zwdot,Kpdot,Mqdot,Nrdot];%momento
Ma=-diag(Fmomento);%masa adicional

%Ma= M_A = [Xudot       0         0              0        0            0;
%                          0        Yvdot    0              0        0            0;
%                          0             0     Zwdot       0        0            0;
%                          0             0         0         Kpdot   0            0;
%                          0             0         0             0    Mqdot      0;
%                          0             0         0             0        0      Nrdot];

M= Mrb+Ma;%Matriz de masa total 
Minv = inv(M);
%--------------------------------------------------------------------------
% Computing the Coriolis and Centripetal Matrix C(v) 
%Crb=[0             0             0            0         m*w         -m*v;]
%         0             0             0         -m*w         0            m*u;
%         0             0             0           m*v      -m*u            0;
%         0           m*w      -m*v          0          Iz*r            -Iy*q;
%     -m*w           0          m*u       -Iz*r          0           Ix*p;
%       m*v         -m*u         0           Iy*q       -Ix*p            0]

%C_a = [0                  0                    0                   0            -Zwdot*w             0;
%           0                  0                    0           -Zwdot*w          0                -Xudot*u;
%           0                  0                    0           -Yvdot*v       Xudot*u              0;
%           0         -Zwdot*w   Yvdot*v              0           -Nrdot*r                Mqdot*q;
%   Zwdot*w         0            -Xudot*u       Nrdot*r            0                       -Kpdot*p;
%   -Yvdot*v    Xudot*u             0          -Mqdot*q       Kpdot*p                     0];

%% Computing Hydrodynamic Damping Matrix D(v)
%Dl =  [Xu,   0,   0,   0,  0,  0;
%           0,  Yv,   0,   0,  0,  0;
%          0,   0,  Zw,   0,  0,  0;
%          0,   0,   0,  Kp,  0,  0;
%          0,   0    0,   0, Mq,  0;
%          0,   0,   0,   0,  0,   Nr];

% Nonlinear Part
%Dnl =  [Xuu*abs(u),           0,           0,           0,           0,           0;
%              0,  Yvv*abs(v),           0,           0,           0,           0;
%                0,           0,  Zww*abs(w),           0,           0,           0;
%                0,           0,           0,  Kpp*abs(p),           0,           0;
%               0,           0,           0,           0,  Mqq*abs(q),           0;
%               0,           0,           0,           0,           0,  Nrr*abs(r)];
%D = Dl + Dnl;

%% Thruster configuration matrix，推力矩阵
tau_k = [0.707         0.707    -0.707   -0.707         0          0           0            0;
              -0.707        0.707    -0.707    0.707         0          0           0            0;
                  0               0             0           0          -1           1          1            -1;
                0.06        -0.06        0.06      -0.06    -0.218   -0.218    0.218     0.218;
                0.06         0.06       -0.06      -0.06      0.120   -0.120    0.120    -0.120;
             -0.1888     0.1888    0.1888    -0.1888      0          0          0              0];

%% 矩阵C
C=1;
%% 矩阵Epsilong
epsilong=1;
%% 矩阵K
K=5;
%% 矩阵K0  
K0=60;   %扰动观测器系数
%% 矩阵T
T=50;   %滤波器时间常数
%% beta
beta=-0.8315;   %NFTSM系数
