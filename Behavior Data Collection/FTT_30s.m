close all;
clearvars;
sca;

try
%----------------------------------------------------------------------
%                       Screen preparation
%----------------------------------------------------------------------
PsychDefaultSetup(2);
screenNumber = max(Screen('Screens'));
white = WhiteIndex(screenNumber);
grey = white / 2;
black = BlackIndex(screenNumber);
Screen('Preference', 'SkipSyncTests', 1);
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, grey);
Screen('Flip',window);
[screenXpixels,screenYpixels] = Screen('WindowSize',window);
[xCenter,yCenter] = RectCenter(windowRect);
ifi = Screen('GetFlipInterval', window);
topPriorityLevel = MaxPriority(window);
Priority(topPriorityLevel);
Screen('TextSize', window, 70);
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
Screen('Preference','TextEncodingLocale','UTF-8');
Screen('TextFont',window,'Arial');

%----------------------------------------------------------------------
%                       Sound preparation
%----------------------------------------------------------------------
InitializePsychSound(1);
nrchannels = 2;
freq = 48000;
repetitions = 1;
beepLengthSecs = 1;
startCue = 0;
waitForDeviceStart = 1;

% Open Psych-Audio port, with the follow arguements
% (1) [] = default sound device
% (2) 1 = sound playback only
% (3) 1 = default level of latency
% (4) Requested frequency in samples per second
% (5) 2 = stereo putput
pahandle = PsychPortAudio('Open', [], 1, 1, freq, nrchannels);

% Set the volume to half for this demo
PsychPortAudio('Volume', pahandle, 0.5);

% Make a beep which we will play back to the user
myBeep = MakeBeep(500, beepLengthSecs, freq);

% Fill the audio playback buffer with the audio data, doubled for stereo
% presentation
PsychPortAudio('FillBuffer', pahandle, [myBeep; myBeep]);

% Calculate how long the beep and pause are in frames
beepLengthFrames = round(beepLengthSecs / ifi);

% Numer of frames to wait before re-drawing
waitframes = 1;

%----------------------------------------------------------------------
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for.
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
oneKey = KbName('1!');
twoKey = KbName('2@');
threeKey = KbName('3#');
fourKey = KbName('4$');

%----------------------------------------------------------------------
%                     Make a response matrix
%----------------------------------------------------------------------

respMat = cell(1,12);
timeMat = cell(1,12);
numSecs = 30;
numFrames = round(numSecs / ifi);
ListenChar(2);


%----------------------------------------------------------------------
%                       Experimental loop
%----------------------------------------------------------------------

% Animation loop: we loop for the total number of trials
HideCursor;
for trial = 1:12

    % A start screen
        DisableKeysForKbCheck(22);
        DrawFormattedText(window,'Press all four keys to start','center', 'center', black)
        Screen('Flip', window);
        [oldsecs, keyCode, deltaSecs] = KbStrokeWait(6);
        respToBeMade = true;
    
     % Execuing stage
    while respToBeMade == true
        DrawFormattedText(window, '4 1 3 2 4',...
            'center', 'center', black);
        vbl = Screen('Flip', window);
        
        [secs, key] = KbGet();
        respMat{trial} = strcat(respMat{trial},num2str(key));
        timeMat{trial} = strcat(timeMat{trial},num2str(secs),' ');
        if secs-oldsecs >=30 && key ~= KbName('s')
            respToBeMade = false;
        end
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end
    
    % Wait stage
    vbl = Screen('Flip', window);
    
    for frame = 1:numFrames
        DrawFormattedText(window, 'x x x x x',...
            'center', 'center', black);
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end
    
end

PsychPortAudio('Close', pahandle);
Screen('CloseAll');
ShowCursor;
ListenChar(0);

catch
  ShowCursor;
  Screen('CloseAll');
  Priority(0);
  psychrethrow(psychlasterror);
end