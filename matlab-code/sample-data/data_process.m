clc;
clear;

%% ��ȡ����
% [hdr, record] = edfread('F:\sleep\code\matlab-code\sample-data\SC4001E0-PSG.edf', 'targetSignals', [1,2]);
%[hdr, record] = edfread('F:\sleep\code\matlab-code\sample-data\SC4001E0-PSG.edf', 'targetSignals', {'EEG Fpz-Cz','EEG Pz-Oz'});
[hdr, record] = edfread('F:\sleep\code\matlab-code\sample-data\SC4001E0-PSG.edf', 'targetSignals', {'EEG Fpz-Cz'});
disp(hdr);
disp(size(record));
%% �źŲ���
fs=200;%����Ƶ��
N=7950000;
n=0:N-1;
t=n/fs;

s=record;%ģ�����ԭʼ����
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
%% �������ͼ
figure(4);
subplot(211);plot(record(1,:));title(1); 
subplot(212);plot(sF);title(2);




