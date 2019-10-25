%%Voorbeeld script om de werking van k-nearest-neighbour te illustreren

%inladen van matlab dataset
load fisheriris;
%meas is de dataset
X = meas; 
%species is de getrainde classificatie
Y = species;
%gebruiken van knn
Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);

%invoeren van nieuwe data in het model
Xnew = [min(X);mean(X);max(X)];
Xnewer = [5.1, 3.5, 1.4, 0.2];
XevenNewer = [6.6, 2.9, 4.6, 1.3];
Xnewest = [6.9, 3.1, 5.1, 2.3];
%voorspellen van de nieuwe data en opslaan als label
label = predict(Mdl,Xnewest);



