%leegmaken van command window
clc;
clearvars -except data;

%checken of er al een dataset is ingeladen
if exist('data', 'var') %als er al een dataset is ingeladen...
    %doe niks en ga verder met de code...
    
else
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
[numInst,numDims] = size(x); %tonen aantal rijen en kolommen van x versnelling (zie workspace)

%highpass filter
filtX = highpass(x, 12, 25); %x is de dataset, 12 de passband frequentie en 25 de samplefrequentie
filtY = highpass(y, 12, 25);
filtZ = highpass(z, 12, 25);

%plotten van de gefilterde data
figure
plot(tijd, filtX);
hold on
plot(tijd, filtY);
hold on 
plot(tijd, filtZ);
hold off
title('Gefilterde dataset grafiek');
xlabel('Tijd')
ylabel('Intensiteit')
legend('x', 'y', 'z')

%k-means
k = 2; %op advies van docent Big Data!
clusterFiltX = kmeans(filtX, k);
clusterFiltY = kmeans(filtY, k);
clusterFiltZ = kmeans(filtZ, k);

%plot clusters
figure
plot(tijd, clusterFiltX, 'r')
hold on
plot(tijd, clusterFiltY, 'm')
hold on
plot(tijd, clusterFiltZ, 'c')
hold off
title('Gefilterde clusters')
xlabel('Tijd')
ylabel('Cluster')
legend('x', 'y', 'z')

%3d grafiek clusters
figure
scatter3(x, y, z)
hold on
scatter3(clusterFiltX, clusterFiltY, clusterFiltZ)
hold off
view(3), axis vis3d, box on, rotate3d on
xlabel 'x'
ylabel 'y'
zlabel 'z'
title '3d grafiek'

