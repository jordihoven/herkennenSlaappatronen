%leegmaken van command window
clc;
clearvars -except data;

%dataset selecteren
[file,path] = uigetfile('*');
if isequal(file,0)
   disp('Bestand selectie afgebroken');
else
   disp(['Gekozen dataset: ', fullfile(path,file)]);
end

%de dataset naar de workspace inladen
data = load(file);

%aanmaken variabelen
x = data(1:2500000, 2);
y = data(1:2500000, 3);
z = data(1:2500000, 4);
t = data(1:250, 1); %tijd kolom inladen
tijd = datetime(t, 'ConvertFrom', 'datenum'); %omzetten van tijd kolom naar datetime
[numInst,numDims] = size(x); %tonen aantal rijen en kolommen (zie workspace)

%plotten van x, y en z versnellingen
figure
plot(tijd, x)
hold on
plot(tijd, y)
hold on
plot(tijd, z)
hold off

%k-means
k = 2; %aantal clusters
[clusterX, A] = kmeans(x, k);
[clusterY, B] = kmeans(y, k);
[clusterZ, C] = kmeans(z, k);

%plot clusters
figure
plot(tijd, clusterX)
hold on
plot(tijd, clusterY)
hold on
plot(tijd, clusterZ)
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
