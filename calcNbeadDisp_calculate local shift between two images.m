function [ux,uy] = calcNbeadDisp(im1,im2,blkSize,minCorr,minBeadInt)
%% Read the images 
im1 = imread('relaxedIm_multibeadsTest.tif');
im2 = imread('stressedIm_multibeadsTest.tif');

% Plot the bead images (overlapping)
%displayBeadOverlapping(im1,im2)

%% Calculate the displacements
blkSize = 64; 
minCorr = 0.6;
minBeadInt = 40;

%% Calculate blkNum
%blkNum: variable that provide the number of blocks that fit in the image

Info_Im1 = imfinfo('relaxedIm_multibeadsTest.tif'); 
Height_Im1 = Info_Im1.Height;
blkNum(1)= Height_Im1/blkSize;

Info_Im1 = imfinfo('stressedIm_multibeadsTest.tif'); 
Width_Im1 = Info_Im1.Width; 
blkNum(2) = Width_Im1/blkSize;

%% Define ux and uy

ux=zeros(blkNum(1),blkNum(2));
uy=zeros(blkNum(1),blkNum(2));

%% Scan im1 and im2 block by block (TO DO)

for n = 1:blkNum(1) % from 1 to 8
     for m = 1:blkNum(2) % from 1 to 8
         
         % Extracting current block for im1 -> blkIm1
         blkIm1 = imcrop(im1,[n-1 8-m 64 64]);
         % Extracting current block for im2 -> blkIm2
         blkIm2 = imcrop(im2,[n-1 8-m 64 64]);
         % Calculating shift between blocks 
         [s, CorrVal] = shiftCalcModif(blkIm1, blkIm2);
        
         if CorrVal>minCorr
             M1 = max(blkIm1);
             M2 = max(blkIm2); 
             if M1 > minBeadInt & M2 > minBeadInt
                 ux(n,m) = s(1); 
                 uy(n,m) = s(2);
              end
         end
     end
end

ux 
uy
%% Plot displacements
displayDispField(ux,uy,1,0);
displayDispArrow(ux,uy,1,0);
