%% Testen van het model

%% Te voorspellen deel van de data specificeren

%geef hier aan welke rijen voorspelt moeten worden
DennisZijnTest = data2(1:2500000, 2:4); %de gehele dataset
VoorspellingVanDennis = predict(Mdl, DennisZijnTest);