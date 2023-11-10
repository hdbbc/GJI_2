close all
clear all
clc
classnumber=2;
categories={'样本熵','模糊熵','近似熵','盒维数'};

data=xlsread('E.xlsx','B2:F1001');
wine=data(:,1:4);
wine_labels=data(:,5);

data=xlsread('E.xlsx','B2:F1001');
wine1=data(:,1:1);
wine_labels1=data(:,5);

data=xlsread('E.xlsx','B2:F1001');
wine2=data(:,2:2);
wine_labels2=data(:,5);

data=xlsread('E.xlsx','B2:F1001');
wine3=data(:,4:4);
wine_labels3=data(:,5);
%% 清空环境变量
format compact;

% 将第一类的1-30,第二类的60-95,第三类的131-153做为训练集
train_wine = [wine(1:475,:);wine(501:975,:)];
% 相应的训练集的标签也要分离出来
train_wine_labels = [wine_labels(1:475);wine_labels(501:975)];
% 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
test_wine = [wine(476:500,:);wine(976:1000,:)];
% 相应的测试集的标签也要分离出来
test_wine_labels = [wine_labels(476:500);wine_labels(976:1000)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain,ntrain] = size(train_wine);
[mtest,ntest] = size(test_wine);

dataset = [train_wine;test_wine];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale,ps] = mapminmax(dataset',0,1);
dataset_scale = dataset_scale';

train_wine = dataset_scale(1:mtrain,:);
test_wine = dataset_scale( (mtrain+1):(mtrain+mtest),: );
%% SVM网络训练
model = svmtrain(train_wine_labels, train_wine, '-c 2 -g 1');

%% SVM网络预测
[predict_label, accuracy] = svmpredict(test_wine_labels, test_wine, model);

%% 结果分析
% 测试集的实际分类和预测分类图
% 通过图可以看出只有一个测试样本是被错分的
figure;

plot(test_wine_labels,'o');hold on;
plot(predict_label,'r*');
xlabel('Number of samples','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Real label','Predicted label');
grid on;
train_wine1 = [wine1(1:475,:);wine1(501:975,:)];
% 相应的训练集的标签也要分离出来
train_wine_labels1 = [wine_labels1(1:475);wine_labels1(501:975)];
% 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
test_wine1 = [wine1(476:500,:);wine1(976:1000,:)];
% 相应的测试集的标签也要分离出来
test_wine_labels1 = [wine_labels1(476:500);wine_labels1(976:1000)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain1,ntrain1] = size(train_wine1);
[mtest1,ntest1] = size(test_wine1);

dataset1 = [train_wine1;test_wine1];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale1,ps] = mapminmax(dataset1',0,1);
dataset_scale1 = dataset_scale1';

train_wine1 = dataset_scale1(1:mtrain1,:);
test_wine1 = dataset_scale1( (mtrain1+1):(mtrain1+mtest1),: );
%% SVM网络训练
model1 = svmtrain(train_wine_labels1, train_wine1, '-c 2 -g 1');

%% SVM网络预测
[predict_label1, accuracy] = svmpredict(test_wine_labels1, test_wine1, model1);

%% 结果分析
% 测试集的实际分类和预测分类图
% 通过图可以看出只有一个测试样本是被错分的
subplot(222)
plot(test_wine_labels1,'o');hold on;
plot(predict_label1,'r*');
xlabel('Number of samples','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Real label','Predicted label');
grid on;
train_wine2 = [wine2(1:475,:);wine1(501:975,:)];
% 相应的训练集的标签也要分离出来
train_wine_labels2= [wine_labels2(1:475);wine_labels2(501:975)];
% 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
test_wine2 = [wine2(476:500,:);wine2(976:1000,:)];
% 相应的测试集的标签也要分离出来
test_wine_labels2 = [wine_labels2(476:500);wine_labels2(976:1000)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain2,ntrain2] = size(train_wine2);
[mtest2,ntest2] = size(test_wine2);

dataset2 = [train_wine2;test_wine2];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale2,ps] = mapminmax(dataset2',0,1);
dataset_scale2 = dataset_scale2';

train_wine2 = dataset_scale2(1:mtrain2,:);
test_wine2 = dataset_scale2( (mtrain2+1):(mtrain2+mtest2),: );
%% SVM网络训练
model2= svmtrain(train_wine_labels2, train_wine2, '-c 2 -g 1');

%% SVM网络预测
[predict_label2, accuracy] = svmpredict(test_wine_labels2, test_wine2, model2);

%% 结果分析
% 测试集的实际分类和预测分类图
% 通过图可以看出只有一个测试样本是被错分的
subplot(223)
plot(test_wine_labels2,'o');hold on;
plot(predict_label2,'r*');
xlabel('Number of samples','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Real label','Predicted label');
grid on;
train_wine3= [wine3(1:475,:);wine3(501:975,:)];
% 相应的训练集的标签也要分离出来
train_wine_labels3= [wine_labels3(1:475);wine_labels3(501:975)];
% 将第一类的31-59,第二类的96-130,第三类的154-178做为测试集
test_wine3= [wine3(476:500,:);wine3(976:1000,:)];
% 相应的测试集的标签也要分离出来
test_wine_labels3= [wine_labels3(476:500);wine_labels3(976:1000)];

%% 数据预处理
% 数据预处理,将训练集和测试集归一化到[0,1]区间

[mtrain3,ntrain3] = size(train_wine3);
[mtest3,ntest3] = size(test_wine3);

dataset3= [train_wine3;test_wine3];
% mapminmax为MATLAB自带的归一化函数
[dataset_scale3,ps] = mapminmax(dataset3',0,1);
dataset_scale3 = dataset_scale3';

train_wine3 = dataset_scale3(1:mtrain3,:);
test_wine3 = dataset_scale3( (mtrain3+1):(mtrain3+mtest3),: );
%% SVM网络训练
model3= svmtrain(train_wine_labels3, train_wine3, '-c 2 -g 1');

%% SVM网络预测
[predict_label3, accuracy] = svmpredict(test_wine_labels3, test_wine3, model3);

%% 结果分析
% 测试集的实际分类和预测分类图
% 通过图可以看出只有一个测试样本是被错分的
subplot(224)
plot(test_wine_labels3,'o');hold on;
plot(predict_label3,'r*');
xlabel('Number of samples','FontSize',12);
ylabel('Category label','FontSize',12);
legend('Real label','Predicted label');
grid on;
