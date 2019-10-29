# herkennenSlaappatronen
Matlab script dat versnellings data omzet in een periode van slaap door gebruik te maken van Machine Learning.

## Hoe het script werkt

### eersteDatasetInlezen.m
De trainingsdataset wordt ingeladen door middel van uigetfile. 
Een highpass filter met een passband frequentie van Fs/2 filterd de ruis uit de data zonder belangrijke data uit te filteren. 
Vervolgens wordt de tijd tegenover de intensiteit van versnelling geplot om de verkregen dataset visueel te maken.

### trainModel.m
Om het k-nearest-neighbour model te trainen wordt de trainingsdataset opgedeeld in twee gelijke periodes die handmatig zijn geclassificeerd als 'wakker' en 'slaap', 0 en 1 respectievelijk. Deze trainingsset wordt vervolgens in het k-nearest-neighbour model gestopt die het model creert.

Het maken van het model gebeurt met de Matlab functie fitcknn:

```
Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',100,'Standardize',1);
```

### tweedeDatasetInlezen.m
Om het model te testen wordt een testdataset ingelezen. Deze dataset beschikt net zoals de trainingsdataset over een tijd en x,y en z versnellingsdata. Deze dataset krijgt dezelfde variabelen mee als de trainingsdataset echter wordt overal een '2' achter geplaats. Eg x2, y2, z2, tijd2. Vervolgens wordt de ruwe dataset en de gefilterde dataset geplot met bijbehorende titel en assen. 

### testModel.m
Het model wordt getest door de periode van slaap en wakker van de testdataset te voorspellen. Dit gebeurt simpelweg door de versnellingsdata in het getrainde model te stoppen. Het model creert dan een nieuw variabelen met de clusters 0 en 1, 'wakker' en 'slaap' respectievelijk.

Het voorspellen gebeurt door de predict functie van knn te gebruiken:
```
voorspellingTestdataset = predict(Mdl, teVoorspellenRijen);
```

Om de voorspelling te testen kan het commando tabulate(voorspellingTestdataset) uitgevoerd worden. Deze geeft een verdeling van de 1 (slaap) en 0 (wakker) waarde.

```
tabulate(VoorspellingVanDennis)
  Value    Count   Percent
      0    777466     31.10%
      1    1722534     68.90%
```
