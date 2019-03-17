function [s, corrVal] = shiftCalcModif(image1, image2)

%The function calculate the 2D shifts between two images using the normalized cross-correlation algorithm
% max coefficients of matrix c 
% c is the matrix with the correlation cofficients (ranging from -1 to 1)
c = normxcorr2(image1, image2);
[ypeak, xpeak] = find(c==max(c(:))); 

%Plotting the graph
%figure 
%surf(c)
%shading flat

% Padding 
dispY = ypeak-size(image1,1);
dispX = xpeak-size(image2,2);

corrVal = c(xpeak, ypeak)

% Subpixel precision added to the previously s values 
[subpxXPeak,subpxYPeak] = subpxPeakCoord(xpeak,ypeak,c);
s = [dispX+subpxXPeak,dispY+subpxYPeak];
