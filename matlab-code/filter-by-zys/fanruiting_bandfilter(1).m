% ������˹��ͨ�˲�����ƣ�����Ƶ���޶�150-250Hz,ע��Ŷ��Ƶ�������Ѿ��޶���0-fs/2��Χ�ˡ�
% �����ֻҪ�ĸĲ��������ˡ��������Ƶ��̫̫����(0.5-35Hz)��ͨ�������˥��Ӧ��Ҫ�����У������ⲿ�ֲ���Ҫϸ��
% ��������������Ŷ
%% �źŲ���
fs=1200;%����Ƶ��
N=300;
n=0:N-1;
t=n/fs;
fL=20;fH=200;%�ź�Ƶ��
s=cos(2*pi*fL*t)+cos(2*pi*fH*t);%ģ�����ԭʼ���ݣ�����������20Hz��200HzƵ��
sfft=(fft(s));
figure(1)
plot((1:length(sfft)/2)/length(sfft)*fs,abs(sfft(1:length(sfft)/2)))
grid on
xlabel('Ƶ��/Hz');ylabel('Ƶ�׷���');title('�ź�Ƶ��');
%% ��ƴ�ͨ�˲���
Wp=[300/fs,500/fs];Ws=[250/fs,550/fs];%��ͨ�˲�������Ԫʸ������ֹƵ��Wp,�����ֹƵ��Ws(ע�⣡���˴��Ѿ��Բ����ʹ�һ���ˣ�����������Ƶ�������һ��Ƶ��)����Ϊ��������Ƶ���0-fs/2Ƶ�ʣ����Դ˴��Ľ���Ƶ�ʺ��������Ƶ�ʶ�Ҫ����2����Wp=[150/fs,250/fs];Ws=[125/fs,275/fs]��
[n,Wn]=buttord(Wp,Ws,1,10);  %���˥������10dB,ͨ��˥��С��1dB
%����õ�Butterworth��ͨ�˲�������С����N��3dB��ֹƵ��Wn
[a,b]=butter(n,Wn);   %���Butterworth��ͨ�˲���
[h,f]=freqz(a,b,'whole',fs); %�����ִ�ͨ�˲�����Ƶ����Ӧ
f=(0:length(f)-1)'*fs/length(f);  %���ж�Ӧ��Ƶ��ת��
figure(2)
plot(1:length(f)/2,abs(h(1:length(f)/2)));%�޶�Ƶ����0-fs/2���˳�200Hz�ź�
grid on
title('��ʽ��ͨ�˲���');xlabel('Ƶ��/Hz');ylabel('����');
%% �źŴ�ͨ�˲�
sF=filter(a,b,s); %����s������ͨ�˲���
SF=fft(sF);
figure(3)
subplot(121)
plot(t,sF);title('����ź�');xlabel('t/s');ylabel('����');
subplot(122)
plot((1:length(SF)/2)*fs/length(SF),abs(SF(1:length(SF)/2)));
title('��ͨ�˲���Ƶ��');xlabel('Ƶ��/Hz');ylabel('����');