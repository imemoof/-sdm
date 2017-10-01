%display rectangle at random position
%wait for user click
%if click is inside, the rectangle become green
%if outside, red
%recation time is displayed and printed on console
%while the green or red rectangle is displayed, user can exit the loop by
%pressing any key on keyboard

% By Gilles Rautureau, September 2017

clear all

% Get the screen numbers
screens = Screen('Screens');

% Select the external screen if it is present, else revert to the native
% screen
screenNumber = max(screens);

%open screen
[windowPtr,windowRect]=Screen('OpenWindow',screenNumber, [255 255 255]);

% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[screenXpixels, screenYpixels] = Screen('WindowSize', windowPtr);

%define a small rectangle
baseRect = windowRect/6;

%calculate min/max position on screen
sizeRect = SizeOfRect(baseRect);
xPosMin = windowRect(1)+sizeRect(1)/2;
xPosMax = windowRect(1)+windowRect(3)-sizeRect(1)/2;
yPosMin = windowRect(2)+sizeRect(2)/2;
yPosMax = windowRect(2)+windowRect(4)-sizeRect(2)/2;


exit = 0;
while(exit == 0) 
    
    xPos = randi([xPosMin xPosMax]);
    yPos = randi([yPosMin yPosMax]);

    %display something
    Screen('FillRect', windowPtr,0); % clear screen
    rect=CenterRectOnPoint(baseRect,xPos,yPos); %create a rect at position xPos,yPos based on baseRect
    Screen('Framerect', windowPtr, [127 127 127], rect, 5 ); %display a small rectangle
    Screen('Flip', windowPtr);
    
    %display time
    start = GetSecs();
    
    % wait for subjet click. Don't wait for multiple click  (2nd parameter = 0)
    [nbClick,xClick,yClick,buttonClick] = GetClicks(windowPtr, 0); 
    responseTime = GetSecs() - start;
    
    %result
    % display the rectangle in green color if click inside. red otherwise
    color = [255 0 0];
    if IsInRect(xClick, yClick, rect)
        color = [0 255 0];
    end
    Screen('FillRect', windowPtr,0); % clear screen
    Screen('Framerect', windowPtr, color, rect, 5 ); %display a small rectangle at center
    
    %display reaction time
    % rTstring = [sprintf('button %d\n', buttonClick), sprintf('%d ms',round(responseTime*1000))];
    rTstring = [sprintf('%d ms',round(responseTime*1000))];

    %rTstring = [sprintf('%d ms (%d)', round(responseTime*1000), buttonClick )];
    disp(rTstring); 
    DrawFormattedText(windowPtr, rTstring, 'center', 'center', color, [], [], [], [], [], rect);
    Screen('Flip', windowPtr);
    
    %check keyboard to exit
    start = GetSecs();
    while(GetSecs()<start+2)
        WaitSecs(.05);
        [ keyIsDown, ~, ~ ] = KbCheck;
        if keyIsDown
            exit = 1;
            break;
        end
    end
    
end


Screen('CloseAll');
