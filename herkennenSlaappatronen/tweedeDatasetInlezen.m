%% Inladen en plotten van de testdataset

%% Checken of er al een dataset is ingeladen
if exist('data2', 'var') %als er al een dataset is ingeladen...
    %doe niks en ga verder met de code...
    
else
    %verkenner openen om de dataset te selecteren...
    [file2,path] = uigetfile('*');
    if isequal(file2,0)
        disp('Bestand selectie afgebroken');
    else
        disp(['Gekozen testdataset: ', fullfile(path,file2)]);
    end

    %toevoegen van gekozen path aan *script*
    addpath (path);

    %de dataset naar de workspace inladen
    data2 = load(file2);
end

%% Inladen van de versnellingsdata en tijd data
%aanmaken variabelen
x2 = data2(1:2500000, 2); %x waarde kolom
y2 = data2(1:2500000, 3); %y waarde kolom
z2 = data2(1:2500000, 4); %z waarde kolom
t2 = data2(1:2500000, 1); %tijd kolom
tijd2 = datetime(t2, 'ConvertFrom', 'datenum'); %omzetten van tijd kolom naar datetime
[numInst2,numDims2] = size(x2); %tonen aantal rijen en kolommen van x versnelling (zie workspace)

%% Highpass filter 
filtX2 = highpass(x2, 12, 25); %x is de dataset, 12 de passband frequentie en 25 de samplefrequentie
filtY2 = highpass(y2, 12, 25);
filtZ2 = highpass(z2, 12, 25);

%% Plotten van de ongefilterde data
figure
plot(tijd2, x2);
hold on
plot(tijd2, y2);
hold on
plot(tijd2, z2);
hold off
title(sprintf('%s: Ongefilterde grafiek', file2));
xlabel('Tijd')
ylabel('Intensiteit')
legend('x', 'y', 'z')

%% Plotten van de gefilterde data
figure
plot(tijd2, filtX2);
hold on
plot(tijd2, filtY2);
hold on 
plot(tijd2, filtZ2);
hold off
title(sprintf('%s: Gefilterde grafiek', file2));
xlabel('Tijd')
ylabel('Intensiteit')
legend('x', 'y', 'z')
