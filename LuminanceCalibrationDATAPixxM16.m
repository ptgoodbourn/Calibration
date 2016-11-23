%% Define test parameters
test.stepsPerChannel = 32;                                     % Number of luminance steps per channel

%% Define display parameters
display.gamma = 0.423877;                                       % Display gamma (RGB)
display.minL = 0.003617;
display.maxL = 1.104823;
display.gain = 0.898791;
display.bias = 0.138418;

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
data.outVals = outVals/max(outVals);

%% Tidy up
Screen('CloseAll');

%% Fit a gamma function
    % First, plot to see which points to exclude (if any)
    figure('color','white');
    hold on;
    plot(data.inVals,data.outVals/max(data.outVals),'ro');
    plot(data.inVals,data.inVals,'r:');
    set(gca,'YScale','log');
    axis square;
    
    goodInput = 0;
    while ~goodInput
        excludedPoints = input('\nPoints to exclude: ');
        if ~isempty(excludedPoints) && isnumeric(excludedPoints)
            goodInput = 1;
        end
    end
    
    startPoint = excludedPoints+1;

    options = optimset;
    options = optimset(options,'Diagnostics','off','Display','off');
    options = optimset(options,'LargeScale','off');
    x = fminunc('fitExtendedGamma',[0, 1, 0, 1, 1],options,data.inVals(startPoint:end),data.outVals(startPoint:end));	
    predicted = computeExtendedGamma(x, data.inVals);
    err = ComputeFSSE(data.outVals',predicted');
    
    fprintf('\n\nMaximum luminance: %.2f cd/m^2', max(outVals));
    fprintf('\n\nFSSE: %f', err);
    fprintf('\n\nGamma:\t%f\nMinL:\t%f\nMaxL:\t%f\nGain:\t%f\nBias:\t%f\n\n', x([5 3 4 2 1]));
    
    transformedVals = real(computeExtendedGammaInv(x, data.outVals));
    plot(data.inVals,transformedVals,'bo');

    figure('color','white');
    hold on;
    plot(data.inVals,data.outVals/max(data.outVals),'ro');
    plot(data.inVals,data.inVals,'r:');
    axis square;