%        task_practice

% Instruction session structures
Screen('DrawTexture',window, Training_SessionStructure,[],Training_SessionStructure_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end


% ratings

Screen('DrawTexture',window, Training_Rating1,[],Training_Rating1_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end

Screen('DrawTexture',window, Training_Rating2,[],Training_Rating2_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end

    Screen('TextSize', window, displayConfig.text.bigfont);
    DrawFormattedText(window, 'is rating 18 items enough? what items? ', 'center', displayConfig.yCenter, [255 255 255], [], [], [], [], []);
    Screen('Flip', window);
    WaitSecs(1)
    keyIsDown = 0;
    while keyIsDown == 0
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
    end
    
    
% choices
Screen('DrawTexture',window, Training_Choice1,[],Training_Choice1_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end

Screen('DrawTexture',window, Training_Choice2,[],Training_Choice2_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end

    Screen('TextSize', window, displayConfig.text.bigfont);
    DrawFormattedText(window, '4*4 = 16 trials', 'center', displayConfig.yCenter, [255 255 255], [], [], [], [], []);
    Screen('Flip', window);
    WaitSecs(1)

    keyIsDown = 0;
    while keyIsDown == 0
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
    end
% consequences

Screen('DrawTexture',window, Training_Consequence1,[],Training_Consequence1_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end


Screen('DrawTexture',window, Training_Consequence2,[],Training_Consequence2_rect);
Screen(window,'Flip');
WaitSecs(task_instruction_duration)
keyIsDown = 0;
while keyIsDown == 0
    [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
end
