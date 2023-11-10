tic
 clear;
 close all;
 clc;
    RawMT=load('100-102ATS5EY.dat');
    MT_Low=load('100-102ATS5EYMMFLow.dat');
    MTMMFSVMKSVD=load('100-102ATS5EYMMFSVMKSVD.dat');
    RawMT=RawMT(134751:139250);
    average=sum(RawMT)/length(RawMT);
    RawMT=RawMT-average;
    MTMMFSVMKSVD=MTMMFSVMKSVD-average;
    RawMT=RawMT-average;
    MT_Low=MT_Low-average;
    fs=15;
    N=150;
    Length=length(RawMT);
    k=30;
    fs=15;
    t=0:1/fs:(Length-1)/fs;
%% ��̬�˲�ȥ��
     High=RawMT-MT_Low; %������Ч��Ƶ�źźͺ���ĸ�Ƶ�ź�
  
 %% SVM����
     x=High;
     data0=yuzhices(x,N,k);%%���Լ�
     data00=xlsread('E1.xlsx','B1:M3001');%%ѵ����
     wine=data00(:,1:4);
     wine_labels=data00(:,5);
     classnumber=2;
%% ��ջ�������
     format compact;
%% ������ȡ
% ѡ��ѵ�����Ͳ��Լ�
% ����һ���1-30,�ڶ����60-95,�������131-153��Ϊѵ����
     train_wine=[wine(1:3000,:)];
% ��Ӧ��ѵ�����ı�ǩҲҪ�������
     train_wine_labels=[wine_labels(1:3000);];
% ����һ���31-59,�ڶ����96-130,�������154-178��Ϊ���Լ�
     test_wine=[data0(1:k,1:4)];
% ��Ӧ�Ĳ��Լ��ı�ǩҲҪ�������
     test_wine_labels=[wine_labels(1:k)];
%% ����Ԥ����
% ����Ԥ����,��ѵ�����Ͳ��Լ���һ����[0,1]����
     [mtrain,ntrain]=size(train_wine);
     [mtest,ntest]=size(test_wine);
     dataset=[train_wine;test_wine];
% mapminmaxΪMATLAB�Դ��Ĺ�һ������
     [dataset_scale,ps]=mapminmax(dataset',0,1);
     dataset_scale=dataset_scale';
     train_wine=dataset_scale(1:mtrain,:);
     test_wine=dataset_scale((mtrain+1):(mtrain+mtest),:);
%% SVM����ѵ��
     model=svmtrain(train_wine_labels,train_wine, '-c 2 -g 1');
%% SVM����Ԥ��
     [predict_label,accuracy]=svmpredict(test_wine_labels,test_wine,model);
     datao=[data0(1:k,1:2),predict_label];
%% �������
% ���Լ���ʵ�ʷ����Ԥ�����ͼ
   figure(2)
     hold on;
     plot(test_wine_labels,'o');
     plot(predict_label,'r*');
     xlabel('���Լ�����','FontSize',12);
     ylabel('����ǩ','FontSize',12);
     legend('ʵ�ʲ��Լ�����','Ԥ����Լ�����');
     title('���Լ���ʵ�ʷ����Ԥ�����ͼ','FontSize',12);
     grid on;
%%�������ź��������ź�
   figure(3)
     for i=1:k
       P(i,:)=x(N*(i-1)+1:N*i);
       if(datao(i,3:3)==1)%% ǿ����
          plot((N*(i-1)+1:N*i),P(i,:),'r');axis([0 Length -max(x) max(x)]);
          set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
       else
          plot((N*(i-1)+1:N*i),P(i,:),'b');axis([0 Length -max(x) max(x)]);
          set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
       hold on
       end
     end
   figure(4)
    
     subplot(511);
     plot(t,RawMT,'k');legend('Noisy');
     set(gca,'FontName','Times New Roman','FontSize',10);ylabel('Amplitude');
     subplot(512);
     plot(t,MT_Low,'k');legend('Low');
     set(gca,'FontName','Times New Roman','FontSize',10);ylabel('Amplitude');
     subplot(515);
     plot(t,MTMMFSVMKSVD,'k');legend('MMFSVMKSVD');
     set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
     a=zeros(1,4500);
     b=zeros(1,4500);
     for i=1:k
       P(i,:)=x(N*(i-1)+1:N*i);
       if(datao(i,3:3)==1) 
         a(N*(i-1)+1:N*i)=P(i,:);
         subplot(514);
         plot((N*(i-1)+1:N*i),P(i,:),'k');axis([ 0 length(x) -max(x) max(x)]);legend('SVM-Noisy');
         set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
         hold on;
       else
         b(N*(i-1)+1:N*i)=P(i,:);
         subplot(513); 
         plot((N*(i-1)+1:N*i),P(i,:),'k');axis([ 0 length(x) -max(x) max(x)]);legend('SVM-Good');
         set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');
         hold on
       end
     end

%% KSVD�ֵ�ѧϰȥ��
    N=length(a);
    for Step=0:00;
      Dataspan=1:N;
      x1=a;
%% KSVD���ȥ��
      origSignal=x1;
      signal_2=(sum(origSignal(:).^2));
      Data=im2colstep(x1,[1,9],[1,1]);
      rperm=randperm(size(Data,2));
      patchData=Data(:,rperm(1:900));
      param.L=100;   % number of elements in each linear combination.
      param.displayProgress=1;  
      param.InitializationMethod='DataElements';
      param.errorFlag=1; % decompose signals until a certain error is reached. do not use fix number of coefficients.
      param.errorGoal=0; 
      param.preserveDCAtom=1;
      param.numIteration=1; % number of iteration to EXecute the K-SVD algorithm.
      param.K=900;  % number of dictionary elements
      [Dictionary,output]=KSVD(patchData,param);
      a=OMPerr(Dictionary,Data ,200); %2 %4 %3
      y=Dictionary*a;
      A=col2imstep(y,size(x1),[1,9],[1,1]);% 90  106 120
      Y=countcover(size(x1),[1,9],[1,1]);% 90  106 120
      dnoise=A./Y;
      mse1=sqrt(sum((x1-dnoise).^2)/N)
%%  �������
    figure(5)
      subplot(311);
      plot(t,x1,'b');
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      subplot(312);plot(t,dnoise,'r');
      legend('��ȡ������������');ylabel('Amplitude');title('(b)'); 
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      subplot(3,1,3);plot(t,x1-dnoise,'k');
      legend('���õĸ�Ƶ����ź�');xlabel('Samples');ylabel('Amplitude');title('(c)');
    figure(6)
      plot(t,x1,'b');hold on;%�����ź�
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('SVM-Noisy');
      plot(t,dnoise,'r');hold on;%��������
      set(gca,'FontName','Times New Roman','FontSize',10);xlabel('Time(s)');ylabel('Amplitude');legend('contour');
      Mtdata=x1-dnoise;
      SVMNoisy(Dataspan)=Mtdata;%% ������òв��滻ԭʼ����
    end

toc
11