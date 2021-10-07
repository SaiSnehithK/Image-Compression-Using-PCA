clc
clear all
close all

gpo= rgb2gray(imread('pikachu3.jpg'));
figure, imshow(gpo),title('Original image');
% getting image dimensions
gpo3=double(gpo); %converting to double precision
% display image
axis off, axis equal
[m n]=size(gpo3);
mn = mean(gpo3,2); %row matrix computation
X = gpo3-repmat(mn,1,n); %subtract row mean
Z=1/sqrt(n-1)*X';
covZ=Z'*Z; % covariance matrix
%% SVD
[U,S,V] = svd(covZ);
variances=diag(S).*diag(S);
% Scree plot of variances
figure,bar(variances(1:30)),title('Scree plot of variances')
% Plot Variances and cdf
% VariancesCdf=0;
% SumVariances = sum(variances);
% str1= sprintf(
%% Extracting principal components

PComps=100;
VV=V(:,1:PComps);
Y=VV'*X; %projecting data onto PCs
ratio=256/(2*PComps+1); %compression ratio
XX=VV*Y; %converting back to original basis
XX=uint8(XX+repmat(mn,1,n)); %add the row means back on
figure, imshow(XX),axis off,title('reconstructed image')