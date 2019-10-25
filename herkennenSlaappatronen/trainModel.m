%% Trainen van het model

%% Invoeren van handmatig gecategoriseerde slaap/wakker classificatie
data(390451:1115400, 5) = 1; %390451 tot 1115400

%% K-nearest neighbour
%de testdata
versnellingsData = data(1:2500000, 2:4); %x, y en z waardes
%de trainingsdata
classificatieData = data(1:2500000, 5); %de zelf ingevoerde slaap waardes
%maken van het model
Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',5,'Standardize',1); %het getrainde model

%% Testen van het model
%Voorspellen op getrainde data
test = [0.268292680000000,-0.265151520000000,0.956349210000000];
test2 = [0.955284550000000,-0.132575760000000,-0.297619050000000];
test3 = [0.288617890000000,-0.121212120000000,0.972222220000000];
label = predict(Mdl, test);
label2 = predict(Mdl, test2);
label3 = predict(Mdl, test3);