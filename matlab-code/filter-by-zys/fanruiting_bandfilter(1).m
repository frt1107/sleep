% 巴特沃斯带通滤波器设计，截至频率限定150-250Hz,注意哦，频率轴我已经限定在0-fs/2范围了。
% 其余的只要改改参数就行了。但是你的频率太太低了(0.5-35Hz)对通带和阻带衰减应该要很敏感，所以这部分参数要细调
% 看不懂的在找我哦
%% 信号产生
fs=1200;%采样频率
N=300;
n=0:N-1;
t=n/fs;
fL=20;fH=200;%信号频率
s=cos(2*pi*fL*t)+cos(2*pi*fH*t);%模拟你的原始数据，数据设置了20Hz和200Hz频率
sfft=(fft(s));
figure(1)
plot((1:length(sfft)/2)/length(sfft)*fs,abs(sfft(1:length(sfft)/2)))
grid on
xlabel('频率/Hz');ylabel('频谱幅度');title('信号频谱');
%% 设计带通滤波器
Wp=[300/fs,500/fs];Ws=[250/fs,550/fs];%带通滤波器，二元矢量；截止频率Wp,阻带截止频率Ws(注意！！此处已经以采样率归一化了，类似于数字频率里面归一化频率)（因为我下面绘制的是0-fs/2频率，所以此处的截至频率和阻带截至频率都要除以2，即Wp=[150/fs,250/fs];Ws=[125/fs,275/fs]）
[n,Wn]=buttord(Wp,Ws,1,10);  %阻带衰减大于10dB,通带衰减小于1dB
%估算得到Butterworth带通滤波器的最小阶数N和3dB截止频率Wn
[a,b]=butter(n,Wn);   %设计Butterworth带通滤波器
[h,f]=freqz(a,b,'whole',fs); %求数字带通滤波器的频率响应
f=(0:length(f)-1)'*fs/length(f);  %进行对应的频率转换
figure(2)
plot(1:length(f)/2,abs(h(1:length(f)/2)));%限定频率轴0-fs/2，滤出200Hz信号
grid on
title('巴式带通滤波器');xlabel('频率/Hz');ylabel('幅度');
%% 信号带通滤波
sF=filter(a,b,s); %函数s经过带通滤波器
SF=fft(sF);
figure(3)
subplot(121)
plot(t,sF);title('输出信号');xlabel('t/s');ylabel('幅度');
subplot(122)
plot((1:length(SF)/2)*fs/length(SF),abs(SF(1:length(SF)/2)));
title('带通滤波后频谱');xlabel('频率/Hz');ylabel('幅度');