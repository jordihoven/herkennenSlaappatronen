# herkennenSlaappatronen
Matlab script dat versnellings data omzet in een periode van slaap door gebruik te maken van Machine Learning.

## Hoe het script werkt

### eersteDatasetInlezen.m
De trainingsdataset wordt ingeladen door middel van uigetfile. 
Een highpass filter met een passband frequentie van Fs/2 filtert de ruis uit de data zonder essentiele data te verwijderen. 
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
tabulate(VoorspellingTestdataset)
  Value    Count   Percent
      0    777466     31.10%
      1    1722534     68.90%
```

## Gebruiken van het script

### Trainen van het model
Run eersteDatasetInlezen.m en selecteer in de verkenner de trainingsdataset. Kies vervolgens in trainModel.m de rijen die door het model gezien moeten worden als 'slaap'. 

```
%% Invoeren van handmatig gecategoriseerde slaap/wakker classificatie
data(695480:1271500, 5) = 1;
```

*Optioneel: veranderen van het aantal nearest neigbours door NumNeigbors aan te passen:*
```
Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',10,'Standardize',1);
```
### Voorspellen van nieuwe dataset
Run tweedeDatasetInlezen.m en selecteer in de verkenner de dataset waarvan de classificatie voor 'slaap' en 'wakker' voorspelt dient te worden. Kies de rijen die voorspelt moeten worden:
```
teVoorspellenRijen = data2(1:2500000, 2:4);
voorspellingModel2 = predict(Mdl2, teVoorspellenRijen);
```

Om de resultaten van de voorspelling te tonen run ```tabulate(voorspellingTestdataset)``` in de command window. 


