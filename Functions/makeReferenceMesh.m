function makeReferenceMesh( viewDist_m, xSize_m ,ySize_m ,xDots_n ,yDots_n, gridColour )
%MAKEREFERENCEMESH generates a figure for use in monitor geometry
%calibration.
%
%The flat surface of a monitor means that the angle that is
%subtended by a given distance on the screen changes a function of
%position on the screen. This isn't a big issue at standard viewing
%distances, but for very close viewing distances (< 0.5 m) it becomes more
%important. The figure should be exported as a vector image, then imported
%into e.g. Illustrator or Inkscape to get the scaling right before
%printing. Once it's printed onto a transparency, stick it on the front of
%the screen and run the DisplayUndistortionBVL routine.
%
%   MAKEREFERENCEMESH displays a mesh with (sensible) default values.
%
%   MAKEREFERENCEMESH( viewDist_m, xSize_m, ySize_m, xDots_n, yDots_n,
%   gridColour) lets you specify:
%
%   viewDist_m, the viewing distance in metres. Defaults to 0.500.
%
%   xSize_m, the full horizontal subtense of the calibration grid in 
%   metres. A good way to set this is to run the DisplayUndistortionBVL
%   routine, and measure the distance between the most extreme dots.
%   Defaults to 0.440.
%
%   ySize_m, the full vertical subtense of the grid in metres. Defaults to
%   0.352.
%
%   xDots_n, the number of columns of dots. Defaults to 37, which is also
%   the default for DisplayUndistortionBVL.
%
%   yDots_n, the number of rows of dots. Defaults to 27, which is also the
%   default for DisplayUndistortionBVL.
%
%   gridColour, the colour of the grid lines. Can be a character (see help
%   plot for a list) or an RGB triplet. Defaults to 'r' for red.

if (nargin < 6) || isempty(gridColour)
    gridColour = 'r';
end

if (nargin < 5) || isempty(yDots_n)
    yDots_n = 27;
end

if (nargin < 4) || isempty(xDots_n)
    xDots_n = 37;
end

if (nargin < 3) || isempty(ySize_m)
    ySize_m = .352;
end

if (nargin < 2) || isempty(xSize_m)
    xSize_m = .440;
end

if (nargin < 1) || isempty(viewDist_m)
    viewDist_m = .500;
end

% Calculate angular subtense at widest point
xMax_m = xSize_m/2;
yMax_m = ySize_m/2;

xMax_dva = rad2deg(atan(xMax_m/viewDist_m));
yMax_dva = rad2deg(atan(yMax_m/viewDist_m));

xAngles_dva = linspace(-xMax_dva,xMax_dva,xDots_n);
yAngles_dva = linspace(-yMax_dva,yMax_dva,yDots_n);

xVect_m = tan(deg2rad(xAngles_dva))*viewDist_m;
yVect_m = tan(deg2rad(yAngles_dva))*viewDist_m;

figure('Color','white');

for thisX = 1:xDots_n
    line(xVect_m(thisX)*ones(1,2), [-yMax_m yMax_m], 'color', gridColour);
end

for thisY = 1:yDots_n
    line([-xMax_m xMax_m], yVect_m(thisY)*ones(1,2), 'color', gridColour);
end

axis equal;
box on;
axis([(-1.1*xMax_m) (1.1*xMax_m) (-1.1*yMax_m) (1.1*yMax_m)]);
set(gca, 'TickDir','out','XMinorTick','on','YMinorTick','on');