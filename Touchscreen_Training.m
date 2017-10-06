<<<<<<< HEAD
   %display rectangle at random position
 %display rectangle at random position
=======
<<<<<<< HEAD
     %display rectangle at random position
=======
<<<<<<< HEAD
   %display rectangle at random position
=======
%display rectangle at random position
>>>>>>> 86542004fba64414caaad6889f7690a12a5696bb
>>>>>>> 7a8d1deb6d7f45543bf77a4321e98ebc44017b5d
>>>>>>> 2926f474a5087246f1edd090dc7a6605f8b8ce5c
%wait for user click
%if click is inside, the rectangle become green
%if outside, red
%recation time is displayed and printed on console
%while the green or red rectangle is displayed, user can exit the loop by
%pressing any key on keyboard

% By Gilles Rautureau, September 2017

clear all

% to judge which computer are we using
[~, hostname] = system('hostname')
if strcmp(hostname(1:5),'MBB31')
    addpath('C:\Users\chen.hu\Documents\GitHub\sdm')
    root = 'C:\Users\chen.hu\Documents\GitHub\sdm';
    cd(root)
    displayConfig.imageLocation = ['C:\Users\chen.hu\Documents\GitHub\sdm\'];
    resultdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];
    instruction_dir = ['C:\Users\chen.hu\Documents\GitHub\sdm\instructions_sdm\'];

elseif strcmp(hostname(1:6),'PRISME')
    addpath('C:\Users\chen.hu\Documents\GitHub\sdm')
    root = 'C:\Users\chen.hu\Documents\GitHub\sdm'
    cd(root)
    displayConfig.imageLocation = ['C:\Users\chen.hu\Documents\GitHub\sdm\'];  
    resultdir = ['C:\Users\chen.hu\Documents\GitHub\sdm\results_sdm\'];        
    instruction_dir = ['C:\Users\chen.hu\Documents\GitHub\sdm\instructions_sdm\'];
end

total_touch = 10;
cross_stay = 2;  % fixation cross presented on the screen for two seconds
task_instruction_duration = 3;
touch_timeout = 1.5;
% Get the screen numbers
screens = Screen('Screens');
screenNumber = max(screens);
%open screen
[window,windowRect]= Screen('OpenWindow',screenNumber, [0 0 0]);
% Get the size of the on screen window in pixels
% For help see: Screen WindowSize?
[L, H] = Screen('WindowSize', window);
displayConfig.xCenter = L/2;
displayConfig.yCenter = H/2;
  
pic_cross = Screen('MakeTexture',window,imread('cross.bmp'));
rect_cross = CenterRectOnPoint(Screen('Rect',pic_cross),displayConfig.xCenter,displayConfig.yCenter); 

%define a small rectangle
baseRect = windowRect/6;

%calculate min/max position on screen
sizeRect = SizeOfRect(baseRect);
xPosMin = windowRect(1)+sizeRect(1)/2;
xPosMax = windowRect(1)+windowRect(3)- sizeRect(1)/2;
yPosMin = windowRect(2)+sizeRect(2)/2;
yPosMax = windowRect(2)+windowRect(4)-sizeRect(2)/2;

% Display instructions
Load_instructions_sdm

Screen('DrawTexture',window, TouchScreen_Training,[],TouchScreen_Training_rect);
Screen(window,'Flip');
keyIsDown = 0;
WaitSecs(task_instruction_duration)
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end

%    onsetB.instruction_on = GetSecs;
    

passornot = 0;
while passornot == 0
% exit = 0;
% while(exit == 0) 
    k = 0;
    success_trials = 0;
    while k < total_touch
        k = k+1;
        Screen('DrawTexture',window,pic_cross,[],rect_cross);
        Screen('Flip', window);
        WaitSecs(cross_stay);

        xPos = randi([xPosMin xPosMax]);
        yPos = randi([yPosMin yPosMax]);

        %display something
        Screen('FillRect', window,0); % clear screen
        rect = CenterRectOnPoint(baseRect,xPos,yPos); %create a rect at position xPos,yPos based on baseRect
        Screen('Framerect', window, [127 127 127], rect, 5 ); %display a small rectangle
        Screen('Flip', window);

        %display time
        start = GetSecs();

        % wait for subjet click. Don't wait for multiple click  (2nd parameter = 0)
        % [nbClick,xClick,yClick,buttonClick] = GetClicks(window, 0); 
        MousePress=0; %initializes flag to indicate no response
        while MousePress == 0 %checks for completion
            [xClick,yClick,buttonClick] = GetMouse();
            MousePress = any(buttonClick); %sets to 1 if a button was pressed
        end
        responseTime = GetSecs() - start;

        if strcmp(hostname(1:5),'MBB31')
            xClick = xClick - 1920;
        end

        %result
        % display the rectangle in green color if click inside. red otherwise
        color = [255 0 0];
        if responseTime <= touch_timeout && IsInRect(xClick, yClick, rect)  
            color = [0 255 0];
        end
        Screen('FillRect', window,0); % clear screen
        Screen('Framerect', window, color, rect, 5 ); %display a small rectangle at center


        if responseTime <= touch_timeout && IsInRect(xClick, yClick, rect)
            success_trials = success_trials + 1;
        end
        %display reaction time
        % rTstring = [sprintf('button %d\n', buttonClick), sprintf('%d ms',round(responseTime*1000))];
        rTstring = [sprintf('%d ms',round(responseTime*1000))];
        total_trialinfo = [sprintf('nombre d''essais effectués: %d',k)];
        success_trialinfo = [sprintf('nombre d''essais réussis: %d',success_trials)];


        %rTstring = [sprintf('%d ms (%d)', round(responseTime*1000), buttonClick )];
        disp(rTstring); 
        DrawFormattedText(window, rTstring, 'center', 'center', color, [], [], [], [], [], rect);
        DrawFormattedText(window, total_trialinfo, 'center', displayConfig.yCenter*2 - 100, [255 255 255], [], [], [], [], []);
        DrawFormattedText(window, success_trialinfo, 'center',displayConfig.yCenter*2 - 50, [255 255 255], [], [], [], [], []);

        Screen('Flip', window);
        WaitSecs(1)
    %     %check keyboard to exit
    %     start = GetSecs();
    %     while(GetSecs()<start+2)
    %         WaitSecs(.05);
    %         [ keyIsDown, ~, ~ ] = KbCheck;
    %         if keyIsDown
    %             exit = 1;
    %             break;
    %         end
    %     end

    end
    
    % to estimate whether subjects needs to do the test again
    if success_trials>= 8
        passornot = 1;
    end
    
    if passornot == 0
        Screen('DrawTexture',window, TouchScreen_Fail,[],TouchScreen_Fail_rect);
        Screen(window,'Flip');
        keyIsDown = 0;
        WaitSecs(task_instruction_duration)
        while keyIsDown == 0
            [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
        end

        
    elseif passornot == 1 
        Screen('DrawTexture',window, TouchScreen_Success,[],TouchScreen_Success_rect);
        Screen(window,'Flip');
        keyIsDown = 0;
        while keyIsDown == 0
            [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
        end

    end 
        
end

Screen('CloseAll');
