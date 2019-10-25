%% Inladen en plotten van de dataset

%% Leegmaken van command window 
clc;
clearvars -except data; %leegmaken van workspace behalve de dataset

%% Checken of er al een dataset is ingeladen
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

%% Inladen van de versnellingsdata en tijd data
%aanmaken variabelen
x = data(1:2500000, 2); %x waarde kolom
y = data(1:2500000, 3); %y waarde kolom
z = data(1:2500000, 4); %z waarde kolom
t = data(1:2500000, 1); %tijd kolom
tijd = datetime(t, 'ConvertFrom', 'datenum'); %omzetten van tijd kolom naar datetime
[numInst,numDims] = size(x); %tonen aantal rijen en kolommen van x versnelling (zie workspace)

%% Invoeren handmatig gecategoriseerde slaap/wakker data
%data(390451:1115400, 5) = 1; %390451 tot 1115400

%% Highpass filter 
filtX = highpass(x, 12, 25); %x is de dataset, 12 de passband frequentie en 25 de samplefrequentie
filtY = highpass(y, 12, 25);
filtZ = highpass(z, 12, 25);

%% Plotten van de ongefilterde data
figure
plot(tijd, x);
hold on
plot(tijd, y);
hold on
plot(tijd, z);
hold off
title('Ongefilterde dataset grafiek');
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
title('Gefilterde dataset grafiek');
xlabel('Tijd')
ylabel('Intensiteit')
legend('x', 'y', 'z')

%% K-means
k = 2; %op advies van docent Big Data!
clusterFiltX = kmeans(filtX, k);
clusterFiltY = kmeans(filtY, k);
clusterFiltZ = kmeans(filtZ, k);

%% Plotten van clusters
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

%% //
%%k-nearest-neighbour
%versnellingsData = data(1:2500000, 2:4); %x, y en z waardes
%classificatieData = data(1:2500000, 5); %de zelf ingevoerde slaap waardes
%Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',5,'Standardize',1); %het getrainde model

%%Voorspellen op getrainde data
%test = [0.268292680000000,-0.265151520000000,0.956349210000000];
%test2 = [0.955284550000000,-0.132575760000000,-0.297619050000000];
%test3 = [0.288617890000000,-0.121212120000000,0.972222220000000];
%label = predict(Mdl, test);
%label2 = predict(Mdl, test2);
%label3 = predict(Mdl, test3);












%%3d grafiek clusters
%figure
%scatter3(x, y, z)
%hold on
%scatter3(clusterFiltX, clusterFiltY, clusterFiltZ)
%hold off
%view(3), axis vis3d, box on, rotate3d on
%xlabel 'x'
%ylabel 'y'
%zlabel 'z'
%title '3d grafiek'

%m = numInst
%textCol = cell(numInst,1);
%upperIndex = data(50:100,5);
%textCol(upperIndex) = {'Upper'};
%textCol(not(upperIndex)) = {'Lower'};
%outputCell = [num2cell(data),textCol];

