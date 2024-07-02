close all;

%设置绘图变量
e=out.e_X;
de=out.de_X;
c=C;

%绘图
subplot(1,3,1);
plot(e,-c*e,'k',e,de,'r','LineWidth',2);
legend('s=0','s change');
xlabel('e');
ylabel('de');
title('Phase portrait X');

%设置绘图变量
e=out.e_Y;
de=out.de_Y;
c=C;

%绘图
subplot(1,3,2);
plot(e,-c*e,'k',e,de,'r','LineWidth',2);
legend('s=0','s change');
xlabel('e');
ylabel('de');
title('Phase portrait Y');

%设置绘图变量
e=out.e_Z;
de=out.de_Z;
c=C;

%绘图
subplot(1,3,3);
plot(e,-c*e,'k',e,de,'r','LineWidth',2);
legend('s=0','s change');
xlabel('e');
ylabel('de');
title('Phase portrait Z');

