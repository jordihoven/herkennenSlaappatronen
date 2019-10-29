%% Inladen en plotten van de trainingsdataset

%% Leegmaken van command window 
clc;
clearvars -except data file; %leegmaken van workspace behalve de dataset

%% Checken of er al een dataset is ingeladen
if exist('data', 'var') %als er al een dataset is ingeladen...
    %doe niks en ga verder met de code...
    
else
    %verkenner openen om de dataset te selecteren...
    [file,path] = uigetfile('*');
    if isequal(file,0)
        disp('Bestand selectie afgebroken');
    else
        disp(['Gekozen trainingsdataset: ', fullfile(path,file)]);
    end

    %toevoegen van gekozen path aan *script*
    addpath (path);

    %de dataset naar de workspace inladen
    data = load(file);
end

%% Inladen van de versnellingsdata en tijd data
%dataset opdelen in x, y, z waarde en tijd
x = data(1:2500000, 2); %x waarde kolom
y = data(1:2500000, 3); %y waarde kolom
z = data(1:2500000, 4); %z waarde kolom
t = data(1:2500000, 1); %tijd kolom
tijd = datetime(t, 'ConvertFrom', 'datenum'); %omzetten van tijd kolom naar datetime
[numInst,numDims] = size(x); %tonen aantal rijen en kolommen van x versnelling (zie workspace)

%% Highpass filter 
filtX = highpass(x, 12, 25); %x is de dataset, 12 de passband frequentie en 25 de samplefrequentie
filtY = highpass(y, 12, 25);
filtZ = highpass(z, 12, 25);

%% Plotten van de ongefilterde data
figure
plot(tijd, x); %plotten van de tijd (x-as) tegenover de intensiteit x (y-as)
hold on
plot(tijd, y);
hold on
plot(tijd, z);
hold off
%Titel en assen van de grafiek...
title(sprintf('%s: Ongefilterde grafiek', file)); %s staat voor de naam van de ingelezen dataset
xlabel('Tijd')
ylabel('Intensiteit')
legend('x', 'y', 'z')

%% Plotten van de gefilterde data
figure
plot(tijd, filtX);
hold on
plot(tijd, filtY);
hold on 
plot(tijd, filtZ);
hold off
title(sprintf('%s: Gefilterde grafiek', file));
xlabel('Tijd')
ylabel('Intensiteit')
legend('x', 'y', 'z')

%% K-means
%k = 2; %op advies van docent Big Data!
%clusterFiltX = kmeans(filtX, k);
%clusterFiltY = kmeans(filtY, k);
%clusterFiltZ = kmeans(filtZ, k);

%% Plotten van clusters
%figure
%plot(tijd, clusterFiltX, 'r')
%hold on
%plot(tijd, clusterFiltY, 'm')
%hold on
%plot(tijd, clusterFiltZ, 'c')
%hold off
%title('Gefilterde clusters')
%xlabel('Tijd')
%ylabel('Cluster')
%legend('x', 'y', 'z')