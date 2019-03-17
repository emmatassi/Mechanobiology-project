clear; close all; clc;

% Read the images
im1 = imread('..\testIm\relaxedIm_1beadTest.tif');
im2 = imread('..\testIm\stressedIm_1beadTest.tif');

% Plot the bead images (overlapping)
displayBeadOverlapping(im1,im2)

% Calculate the displacements
[s,corrVal] = shiftCalcModif(im1,im2);