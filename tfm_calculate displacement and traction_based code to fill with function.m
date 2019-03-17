clear;close all;clc;
%% User parameters

resXY = 0.15; % units in um/pixel
minCorr = 0.6;
minBeadInt = 60;
blkSize = 16; % units in pixels

filtKernelSize = 3; % units in pixels
filtSigma = 1;

poisson = 0.34;
young = 1.5; % units in kPa


im1File = 'C:\Users\Sandro\Documents\MATLAB\TFMassignment\code\relaxedIm_multibeadsTest.tif';
im2File = 'C:\Users\Sandro\Documents\MATLAB\TFMassignment\code\stressedIm_multibeadsTest.tif';
%% Read the input images
im1 = imread(im1File);
im2 = imread(im2File);

% Plot the bead images (overlapping)
displayBeadOverlapping(im1,im2)
%% Calculate the displacements

%the function calcNbeadDisp calculate the displacement along x or y from
%the bead image im1,im2: to calculate the local average shift (displacement) between two images.
%taken like input the two bead image ( with a changing in displacement, the
%block size of the image (size of block in pixel), the min correlation and
%the min Bead intensity.
[ux,uy] = calcNbeadDisp(im1,im2,blkSize,minCorr,minBeadInt);
% Convert the units of the displacements from px to um

ux = ux*resXY;
uy = uy*resXY;
dispResXY = resXY*blkSize;
% Plot displacements
displayDispField(ux,uy,dispResXY,0);
%% Filter the displacements
fltr = fspecial('gaussian',[filtKernelSize filtKernelSize],filtSigma);
uxFilt = imfilter(ux,fltr,'same');
uyFilt = imfilter(uy,fltr,'same');
% Plot fitered displacements
displayDispField(uxFilt,uyFilt,dispResXY,1);
displayDispArrow(uxFilt,uyFilt,dispResXY,1)
%% Retrieve the tractions
[tx,ty] = tractionRetrieval(uxFilt,uyFilt,young,poisson,dispResXY);
% Plot tractions
displayTracField(tx,ty,dispResXY);
displayTracArrow(tx,ty,dispResXY);