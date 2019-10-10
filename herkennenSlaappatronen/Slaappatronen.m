clc %leegmaken van command window

%aanmaken variabelen
x = moxData(1:2500000, 2);
y = moxData(1:2500000, 3);
z = moxData(1:2500000, 4);
[numInst,numDims] = size(x); %tonen aantal rijen en kolommen (zie workspace)

%plotten van x, y en z versnellingen
figure, hold on
plot(x)
hold on
plot(y)
hold on
plot(z)
hold off

%k-means
k = 3; %aantal clusters
[clusterX, A] = kmeans(x, k);
[clusterY, B] = kmeans(y, k);
[clusterZ, C] = kmeans(z, k);

%plot clusters
figure
plot(clusterX)
hold on
plot(clusterY)
hold on
plot(clusterZ)
%legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid')

hold off
title('X, Y en Z clusters')







%%%%%plot k-means
%clr = lines(k);
%figure, hold on
%plot(clusterX)
%hold off
%title('X cluster')

%plot tweede k-means
%figure, hold on
%plot(A)
%hold off
%title('Y cluster')
