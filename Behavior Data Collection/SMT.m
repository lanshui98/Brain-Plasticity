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
%                       Keyboard information
%----------------------------------------------------------------------

% Define the keyboard keys that are listened for.
KbName('UnifyKeyNames');
escapeKey = KbName('ESCAPE');
oneKey = KbName('1!');
twoKey = KbName('2@');
threeKey = KbName('3#');
fourKey = KbName('4$');

waitframes = 1;

numSecs = 5;
numFrames = round(numSecs / ifi);
HideCursor;

for trial = 1:5
    
    % A start screen
        DrawFormattedText(window,'Press all four keys','center', 'center', black)
        Screen('Flip', window);
        [lastsecs, keyCode, deltaSecs] = KbStrokeWait();
    
    % Wait stage
    
    vbl = Screen('Flip', window);
    
    for frame = 1:numFrames
        DrawFormattedText(window, 'x x x x x',...
            'center', 'center', black);
        vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
    end
    
    if keyCode(escapeKey)
            sca;
            ShowCursor;    
    end
    
end
Screen('CloseAll');
ShowCursor;

catch
  ShowCursor;
  Screen('CloseAll');
  Priority(0);
  psychrethrow(psychlasterror);
end