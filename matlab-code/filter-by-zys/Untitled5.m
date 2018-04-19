%% �źŲ���
fs=200;%����Ƶ��
N=100;
n=0:N-1;
t=n/fs;
fL=60;fH1=20,fH2=80,fH3=30;%�ź�Ƶ��
s=cos(2*pi*fL*t)+cos(2*pi*fH1*t)+cos(2*pi*fH2*t)+cos(2*pi*fH3*t);%ģ�����ԭʼ����
sfft=(fft(s));
figure(1)
plot((1:length(sfft)/2)/length(sfft)*fs,abs(sfft(1:length(sfft)/2)))
grid on
xlabel('Ƶ��/Hz');ylabel('Ƶ�׷���');title('�ź�Ƶ��');
%% ��ƴ�ͨ�˲���
Wp=[1/fs,70/fs];Ws=[0.5/fs,72.5/fs];%��ͨ�˲�������Ԫʸ������ֹƵ��Wp,�����ֹƵ��Ws(ע�⣡���˴��Ѿ��Բ����ʹ�һ���ˣ�����������Ƶ�������һ��Ƶ��)
[n,Wn]=buttord(Wp,Ws,1,1.5);  %���˥��1.5dB,ͨ��˥��1dB
%����õ�Butterworth��ͨ�˲�������С����N��3dB��ֹƵ��Wn
[a,b]=butter(n,Wn);   %���Butterworth��ͨ�˲���
[h,f]=freqz(a,b,'whole',fs); %�����ִ�ͨ�˲�����Ƶ����Ӧ
f=(0:length(f)-1)'*fs/length(f);  %���ж�Ӧ��Ƶ��ת��
figure(2)
plot(1:length(f)/2,abs(h(1:length(f)/2)));%�޶�Ƶ����0-fs/2
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