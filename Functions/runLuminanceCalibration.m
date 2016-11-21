function [inVals, outVals] = runLuminanceCalibration(display, test)
    
    if (nargin < 2) || ~isfield(test,'stepsPerChannel')
        test.stepsPerChannel = 64;         % Number of luminance steps per channel
    end
    
    if (nargin < 1) || ~isfield(display,'gamma')
        display.gamma = 1.0; 
        warningText = 'No display gamma given! Using [1, 1, 1].';
        warning('runLuminanceCalibration:noDisplayGamma',warningText);
    end
    
    if (nargin < 1) || ~isfield(display,'centre')
        display.gamma = 1.0; 
        warningText = 'No display centre given! Using [640, 512].';
        warning('runLuminanceCalibration:noDisplayCentre',warningText);
    end
    
    inVals = linspace(0,1,test.stepsPerChannel);
    outVals = NaN(1,test.stepsPerChannel);
    
    mainRect = CenterRectOnPoint([0 0 400 400], display.centre(1), display.centre(2));
    flankRects = [mainRect(1)-201 mainRect(2) mainRect(1)-1 mainRect(4);
                  mainRect(3)+1 mainRect(2) mainRect(3)+201 mainRect(4)]';
    
    for thisStep = 1:test.stepsPerChannel
       
        Screen('FillRect', display.ptbWindow, inVals(thisStep), mainRect);
        Screen('FillRect', display.ptbWindow, (1-inVals(thisStep)), flankRects);
        Screen('Flip', display.ptbWindow);       
        
        goodVal = 0;
        
        while ~goodVal
            try
                thisVal = input('Measured value: ');
                if ~isempty(thisVal) && ~isnan(thisVal) && isnumeric(thisVal)
                    outVals(thisStep) = thisVal;
                    goodVal = 1;
                else
                    fprintf('\nInvalid value!\n\n')
                end
            catch
                fprintf('\nInvalid value!\n\n')
            end
        end
        
    end
    
end