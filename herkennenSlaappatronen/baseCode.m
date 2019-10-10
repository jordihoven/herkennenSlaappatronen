clc %leegmaken van command view

X = moxData(1:2500000, 2:4); %keuze voor rijen en kolommen
[numInst,numDims] = size(X); %tonen aantal rijen en kolommen (zie workspace)

%# K-means clustering
%# (K: number of clusters, G: assigned groups, C: cluster centers)
K = 3; %aantal clusters
%[G,C] = kmeans(X, K, 'distance','sqEuclidean', 'start','sample');
[G,C] = kmeans(X, K);

%# Teken van de gevonden clusters
clr = lines(K);
figure, hold on
scatter3(X(:,1), X(:,2), X(:,3), 36, clr(G,:), 'Marker','.')
scatter3(C(:,1), C(:,2), C(:,3), 100, clr, 'Marker','o', 'LineWidth',3)
hold off
view(3), axis vis3d, box on, rotate3d on
title('Mox Data')
xlabel('x')
ylabel('y')
zlabel('z')

%tabulate(G) toont hoe groot de clusters zijn
%unique(X(G==2,:),'rows') toont dubbele waardes van alle rijen
%unique(X),'rows') laat enkel unieke waardes zien
%clearvars -except moxData
