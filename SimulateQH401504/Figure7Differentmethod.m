%%Curve comparison using different method
tic;clc;clear;close all;
   fs=15;Fs=15;
   N=4500;	
   t=0:1/fs:(N-1)/fs;
   f=0:fs*1/N:fs*(1-1/N);
   N=4500;
   x0=load('QH401504TS5EXSynData.dat');
   x0=x0(334501:339000);
   x1=load('QH401504TS5EY.dat'); % Original
   average=sum(x1)/length(x1);
   x1=x1-average;
   x0=x0-average;
   x2=load('QH401504TS5EYMMF.dat');x2=x2-1500-average;            % MMF
   x3=load('QH401504TS5EYKSVD.dat');x3=x3-3000-average;           % KSVD
   x4=load('QH401504TS5EYSVMKSVD.dat');x4=x4-4500-average;        % SVMKSVD
   x5=load('QH401504TS5EYMMFWaveletRuan.dat');x5=x5-6000-average; % MMFWaveletST
   x6=load('QH401504TS5EYMMFWaveletYing.dat');x6=x6-7500-average; % MMFWaveletHT
   x7=load('QH401504TS5EYMMFKSVD.dat');x7=x7-9000-average;        % MMFKSVD
   x8=load('QH401504TS5EYMMFSVMKSVD.dat');x8=x8-10500-average;    % MMFSVMKSVD
   x1=x1(334501:339000);x11=x1(551:700);x111=x1(2701:2850);    
   x2=x2(334501:339000);x22=x2(551:700);x222=x2(2701:2850);
   x3=x3(334501:339000);x33=x3(551:700);x333=x3(2701:2850);
   x4=x4(334501:339000);x44=x4(551:700);x444=x4(2701:2850);
   x5=x5(334501:339000);x55=x5(551:700);x555=x5(2701:2850);
   x6=x6(334501:339000);x66=x6(551:700);x666=x6(2701:2850);
   x7=x7(334501:339000);x77=x7(551:700);x777=x7(2701:2850);
   x8=x8(334501:339000);x88=x8(551:700);x888=x8(2701:2850);
   Length1=length(x1)
   t1=0:1/fs:(Length1-1)/fs;
   Length11=length(x11)
   t11=0:1/fs:(Length11-1)/fs;
   Length111=length(x111)
   t111=0:1/fs:(Length111-1)/fs;
 figure
  subplot(221)
    plot(t1,x1,'b');hold on;
    plot(t1,x2,'m');hold on;
    plot(t1,x3,'y');hold on;
    plot(t1,x4,'g');hold on;
    plot(t1,x5,'r');hold on;
    plot(t1,x6,'k');hold on;
    plot(t1,x7,'r');hold on;
    plot(t1,x8,'k');hold on;
    legend('Original','MMF','KSVD','SVMKSVD','MMFWaveletST','MMFWaveletHT','MMFKSVD','MMFSVMKSVD');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(223)
    plot(t11,x22,'m');hold on;
    plot(t11,x11,'b');hold on;
    plot(t11,x33,'y');hold on;
    plot(t11,x44,'g');hold on;
    plot(t11,x55,'r');hold on;
    plot(t11,x66,'k');hold on;
    plot(t11,x77,'r');hold on;
    plot(t11,x88,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(224)
    plot(t111,x333,'y');hold on;
    plot(t111,x111,'b');hold on;
    plot(t111,x222,'m');hold on;
    plot(t111,x444,'g');hold on;
    plot(t111,x555,'r');hold on;
    plot(t111,x666,'k');hold on;
    plot(t111,x777,'r');hold on;
    plot(t111,x888,'k');hold on;
    legend('KSVD');
    xlabel('Time(s)');ylabel('Amplitude');
   
   
toc