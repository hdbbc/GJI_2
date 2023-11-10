clc; 
clear; 
close all;
tic
   fs=15;
   x1=load('QH401804TS5EX.dat');
   x2=load('QH401804TS5EXMMFSVMKSVD.dat');
   average1=sum(x1)/length(x1);
   x1=x1-average1;
   x2=x2-average1;
   x3=load('QH401804TS5HY.dat');
   x4=load('QH401804TS5HYMMFSVMKSVD.dat');
   average2=sum(x3)/length(x3);
   x3=x3-average2;
   x4=x4-average2;
   x1=x1(125001:140000);x11=x1(946:1020);x111=x1(13426:13500);    
   x2=x2(125001:140000);x22=x2(946:1020);x222=x2(13426:13500);
   x3=x3(125001:140000);x33=x3(1201:1275);x333=x3(13816:13890);
   x4=x4(125001:140000);x44=x4(1201:1275);x444=x4(13816:13890);
   Length1=length(x1)
   t1=0:1/fs:(Length1-1)/fs;
   Length11=length(x11)
   t11=0:1/fs:(Length11-1)/fs;
   Length111=length(x111)
   t111=0:1/fs:(Length111-1)/fs;
 figure
   subplot(421)
    plot(t1,x1,'g');hold on;
    plot(t1,x2,'k');hold on;
    legend('Original','MMF-SVM-KSVD');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(423)
    plot(t11,x11,'g');hold on;
    plot(t11,x22,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(424)
    plot(t111,x111,'g');hold on;
    plot(t111,x222,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
    subplot(425)
    plot(t1,x3,'g');hold on;
    plot(t1,x4,'k');hold on;
    legend('Original','MMF-SVM-KSVD');
    xlabel('Time(s)');ylabel('Amplitude')
   subplot(427)
    plot(t11,x33,'g');hold on;
    plot(t11,x44,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
   subplot(428)
    plot(t111,x333,'g');hold on;
    plot(t111,x444,'k');hold on;
    xlabel('Time(s)');ylabel('Amplitude');
toc

    
