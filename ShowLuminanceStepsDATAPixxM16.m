%% Define test parameters
test.stepsPerLine = 10;                                     % Number of luminance steps per channel
test.rectSize_pix = 50;
test.totalRects = test.stepsPerLine^2;
test.luminances = linspace(0,1,test.totalRects);

%% Define display parameters
display.gamma = 1.0;                                            % Display gamma (RGB)
display.refreshRate_Hz = 100;                                   % Display refresh rate (Hz)
display.spatialResolution_ppm = 3300;                           % Display spatial resolution (pixels per m)
display.viewingDistance_m = 0.5;                                % Viewing distance (m)
display.width_m = 0.41;                                         % Width of the display (m)
display.screenNo = 1;                                           % Screen number
display.dummyMode = 0;                                          % Set to 1 to run without DATAPixx and skip sync tests
display.backgroundVal = 0.5;                                    % Background luminance in range [0,1]

%% Initialise imaging pipeline
display = initialiseImagingPipelineDATAPixxM16(display);

%% Show a black screen
Screen('FillRect', display.ptbWindow, 0);
Screen('Flip', display.ptbWindow);
KbWait([],2);

%% Make rects
baseRect = [1 1 2 2] * test.rectSize_pix;
allRects = NaN(4, test.totalRects);
thisRect = 1;

for thisRow = 1:test.stepsPerLine
    for thisCol = 1:test.stepsPerLine
        allRects(:,thisRect) = baseRect + repmat([test.rectSize_pix*(thisCol-1)...
            test.rectSize_pix*(thisRow-1)], [1 2]);
        thisRect = thisRect + 1;
    end
end

Screen('FillRect', display.ptbWindow, repmat(test.luminances,[3 1]), allRects);
Screen('Flip', display.ptbWindow);
KbWait([],2);

%% Show a white screen
Screen('FillRect', display.ptbWindow, 1);
Screen('Flip', display.ptbWindow);
KbWait([],2);

%% Show a mid-gray screen
Screen('FillRect', display.ptbWindow, 0.5);
Screen('Flip', display.ptbWindow);
KbWait([],2);

%% Show a square
Screen('FillRect', display.ptbWindow, 1, [display.centre(1)-200 display.centre(2)-200 display.centre(1)+200 display.centre(2)+200]);
DrawFormattedText(display.ptbWindow, '400 pixels', 'center', 'center', 0);
Screen('Flip', display.ptbWindow);
KbWait([],2);

%% Tidy up
Screen('CloseAll');