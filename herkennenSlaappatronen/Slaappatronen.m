%leegmaken van command window
clc;
clearvars -except data;

%checken of er al een dataset is ingeladen
if exist('data', 'var') %als er al een dataset is ingeladen...
    %doe niks en ga verder met de code...
    
else %anders
    %verkenner openen om de dataset te selecteren...
    [file,path] = uigetfile('*');
    if isequal(file,0)
        disp('Bestand selectie afgebroken');
    else
        disp(['Gekozen dataset: ', fullfile(path,file)]);
    end

    %toevoegen van gekozen path aan *script*
    addpath (path);

    %de dataset naar de workspace inladen
    data = load(file);
end

%aanmaken variabelen
x = data(1:2500000, 2);
y = data(1:2500000, 3);
z = data(1:2500000, 4);
t = data(1:2500000, 1); %tijd kolom inladen
tijd = datetime(t, 'ConvertFrom', 'datenum'); %omzetten van tijd kolom naar datetime
[numInst,numDims] = size(x); %tonen aantal rijen en kolommen (zie workspace)

%plotten van x, y en z versnellingen
figure
plot(tijd, x, 'r')
hold on
plot(tijd, y, 'g')
hold on
plot(tijd, z, 'b')
hold off

%k-means
k = 2; %op advies van docent Big Data!
clusterX = kmeans(x, k);
clusterY = kmeans(y, k);
clusterZ = kmeans(z, k);

%plot clusters in 2d
figure
plot(tijd, clusterX, 'r')
hold on
plot(tijd, clusterY, 'm')
hold on
plot(tijd, clusterZ, 'c')
%legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid')
hold off
title('X, Y en Z clusters')

%plot clusters in 3d
figure
scatter3(clusterX, clusterY, clusterZ);
title('3d X,Y en Z clusters')







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

%addpath 'C:\Users\Jordi\Desktop'
