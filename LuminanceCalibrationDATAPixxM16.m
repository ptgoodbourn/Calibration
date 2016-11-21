%% Define test parameters
test.stepsPerChannel = 10;                                     % Number of luminance steps per channel

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

%% Make data structure
data = struct;

%% Run test
[inVals, outVals] = runLuminanceCalibration(display, test);
data.inVals = inVals;
data.outVals = outVals;

%% Tidy up
Screen('CloseAll');