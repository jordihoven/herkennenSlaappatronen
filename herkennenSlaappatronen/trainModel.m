%% Trainen van het model

%% Invoeren van handmatig gecategoriseerde slaap/wakker classificatie
data(390451:1115400, 5) = 1; %390451 tot 1115400

%% K-nearest neighbour
versnellingsData = data(390451:1840349, 2:4); %x,y en z waarde van de trainingsset
classificatieData = data(390451:1840349, 5); %de zelf ingevoerde slaap waardes van de trainingsset
%maken van het model
Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',100,'Standardize',1); %het getrainde model

%% K-nearest neighbour test
%de testdata
%versnellingsData = data(1:2500000, 2:4); %x, y en z waardes
%de trainingsdata
%classificatieData = data(1:2500000, 5); %de zelf ingevoerde slaap waardes
%maken van het model
%Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',5,'Standardize',1); %het getrainde model