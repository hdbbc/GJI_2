tic
close all;
clear all;
clc;
   fs=15;Fs=15;
   N=4500;	
   t=0:1/fs:(N-1)/fs;
   f=0:fs*1/N:fs*(1-1/N);
  data1=load('100-102ATS5EY.dat');
  data1=data1(134751:139250);
  data3=load('100-102ATS5EYMMFSVMKSVD.dat');
  data2=data1-data3
  average=sum(data3)/length(data3);
  data1=data1-average;
  data3=data3-average;
%% ���ʱ���Ƶ���ź�
    x1=fft(data1); %ԭʼ�ź�
    fft_1=abs(x1);        
    fft_1(1)=0;
    angx1=angle(x1);   %Ƶ���źŵ���λ����任ʱҪ�õ�
    fftFFT1=(abs(fft(data1))/N)*2;
    figure
    subplot(321)
    plot(t,data1,'b');%ʱ��
    set(gca,'FontName','Times New Roman','FontSize',10);
    xlabel('Time(s)');ylabel('Amplitude');
    legend('Original');
    subplot(322)
    plot(f,fftFFT1,'b');%Ƶ��
    axis([0 fs/2 0 max(fftFFT1(1:length(data1)))*1.1]);
    set(gca,'FontName','Times New Roman','FontSize',10);
    xlabel('Frequency');ylabel('Amplitude');%�鿴Ƶ��
    legend('Original');
    
    x2=fft(data2); %�����ź�
    fft_2=abs(x2);        
    fft_2(1)=0;
    angx2=angle(x2);   %Ƶ���źŵ���λ����任ʱҪ�õ�
    fftFFT2=(abs(fft(data2))/N)*2;
    subplot(323)
    plot(t,data2,'r');%ʱ��
    set(gca,'FontName','Times New Roman','FontSize',10);
    xlabel('Time(s)');ylabel('Amplitude');
    legend('Noisy');
    subplot(324)
    plot(f,fftFFT2,'r');%Ƶ��
    axis([0 fs/2 0 max(fftFFT2(1:length(data2)))*1.1]);
    set(gca,'FontName','Times New Roman','FontSize',10);
    xlabel('Frequency');ylabel('Amplitude');%�鿴Ƶ��
    legend('Noisy');
    
    x3=fft(data3); %������ź�
    fft_3=abs(x3);        
    fft_3(1)=0;
    angx3=angle(x3);   %Ƶ���źŵ���λ����任ʱҪ�õ�
    fftFFT3=(abs(fft(data3))/N)*2;
    subplot(325)
    plot(t,data3,'k');%ʱ��
    set(gca,'FontName','Times New Roman','FontSize',10);
    xlabel('Time(s)');ylabel('Amplitude');
    legend('MMF-SVM-KSVD');
    subplot(326)
    plot(f,fftFFT3,'k');%Ƶ��
    axis([0 fs/2 0 max(fftFFT3(1:length(data3)))*1.1]);
    set(gca,'FontName','Times New Roman','FontSize',10);
    xlabel('Frequency');ylabel('Amplitude');%�鿴Ƶ��
    legend('MMF-SVM-KSVD');