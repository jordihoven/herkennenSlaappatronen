# herkennenSlaappatronen
Matlab script dat versnellings data omzet in een periode van slaap door gebruik te maken van Machine Learning.

## Hoe het script werkt
Als eerste wordt de dataset ingeladen door middel van uigetfile. 
Een highpass filter met een passband frequentie van Fs/2 filterd de ruis uit de data zonder belangrijke data uit te filteren. 
Vervolgens wordt de tijd tegenover de intensiteit van versnelling geplot om de verkregen dataset visueel te maken.

Om een classificatiemodel te kunnen gebruiken wordt handmatig een trainingsset gemaakt. Door de rijen te specificeren waarin is aangenomen dat een periode van slaap plaats vindt wordt de trainingsset opgebouwd. Deze trainingsset wordt vervolgens in een k-nearest-neigbour model gestopt die een model creert. 

```
versnellingsData = data(1:2500000, 2:4); %x, y en z waardes
classificatieData = data(1:2500000, 5); %de zelf ingevoerde slaap waardes
Mdl = fitcknn(versnellingsData, classificatieData, 'NumNeighbors',5,'Standardize',1); %het getrainde model
```
In een tweede script wordt het getrainde model gebruikt om in een nieuwe dataset de periode van slaap te herkennen...
