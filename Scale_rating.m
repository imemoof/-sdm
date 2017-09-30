% Draw a scale of money
% reset random generator
rand('state',sum(100*clock));

isvalidate = 0;                       
while isvalidate == 0;  
            % display the Scale
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x, displayConfig.yCenter + scale.position_y, displayConfig.xCenter + scale.half_x, displayConfig.yCenter + scale.position_y, scale.line_width_horizental)  % draw horizental line     
            Screen('DrawLine',window, surface, displayConfig.xCenter, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)               % vertical line in the middle
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter - scale.half_x, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)  % vertical position marker at the left
            Screen('DrawLine',window, surface, displayConfig.xCenter + scale.half_x, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter + scale.half_x, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)  % vertical postion marker at the right
            
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x/2, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter - scale.half_x/2, displayConfig.yCenter + (scale.position_y ), scale.line_width)   % 1/4 vertical marker at the left 
            Screen('DrawLine',window, surface, displayConfig.xCenter + scale.half_x/2, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter + scale.half_x/2, displayConfig.yCenter + (scale.position_y ), scale.line_width)   % 1/4 vertical marker on the right
            
            Screen('TextSize', window, displayConfig.text.smallfont);
            DrawFormattedText(window,['pas du tout'],displayConfig.xCenter - scale.half_x - scale.word_width/2, displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            if FoodorConf == 1,
                DrawFormattedText(window, ['enormement'], displayConfig.xCenter + (scale.half_x - scale.word_width/2), displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            elseif FoodorConf == 0,
                DrawFormattedText(window, ['totalement'], displayConfig.xCenter + (scale.half_x - scale.word_width/2), displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            end
            DrawFormattedText(window,['moyennement'], displayConfig.xCenter - scale.word_width/2, displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
                                    
            % display the cursor
            CursorImage = imread([displayConfig.imageLocation, 'Mark.bmp']);
            [cs1,cs2,cs3] = size(CursorImage);
            CursorTexture = Screen('MakeTexture', window, CursorImage);
            positionCursor = [(xCursor - cs2/2), (displayConfig.yCenter + (scale.position_y + scale.gap)), (xCursor + cs2/2), (displayConfig.yCenter + (scale.position_y + scale.gap) + cs1)];
            Screen('DrawTexture', window, CursorTexture, [], positionCursor, 0);
            
           
            if FoodorConf == 1,
                Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);
                Screen('TextSize', window, displayConfig.text.mediumfont);
                DrawFormattedText(window,['Combien aimez-vous cet aliment?'],'center', displayConfig.yCenter +  100, surface);
            elseif FoodorConf == 0,
                Screen('TextSize', window, displayConfig.text.mediumfont);
                DrawFormattedText(window,['Etes-vous sur(e) de votre choix?'],'center', displayConfig.yCenter - 200, surface); 
            end
            
            Screen('Flip', window);
            
            % Track keyboard events           
            while true
                [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
                    if keyIsDown && sum(keyCode == 1) == 1; break; end
            end
            
            WhichKeyDown = keyCode;            
            if keyCode(key.left)== 1,               %the left arrow is pressed
                 xCursor = xCursor - scale.stepsize;
                 if abs(xCursor - displayConfig.xCenter) > scale.half_x; xCursor = displayConfig.xCenter - scale.half_x; end
            elseif keyCode(key.right)== 1,           %the right arrow is pressed
                xCursor = xCursor + scale.stepsize;
                 if abs(xCursor - displayConfig.xCenter) > scale.half_x; xCursor = displayConfig.xCenter + scale.half_x; end
            elseif keyCode(key.space)== 1
                isvalidate = 1;
                WaitSecs(0.5);  
            elseif keyCode(key.escape) == 1
                stoptask = 1;
            end

                        
            %=========== Refresh the screen after key press

            % Update the scale and cursor position
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x, displayConfig.yCenter + scale.position_y, displayConfig.xCenter + scale.half_x, displayConfig.yCenter + scale.position_y, scale.line_width_horizental)  % draw horizental line     
            Screen('DrawLine',window, surface, displayConfig.xCenter, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)               % vertical line in the middle
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter - scale.half_x, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)  % vertical position marker at the left
            Screen('DrawLine',window, surface, displayConfig.xCenter + scale.half_x, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter + scale.half_x, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)  % vertical postion marker at the right
            
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x/2, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter - scale.half_x/2, displayConfig.yCenter + (scale.position_y ), scale.line_width)   % 1/4 vertical marker at the left 
            Screen('DrawLine',window, surface, displayConfig.xCenter + scale.half_x/2, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter + scale.half_x/2, displayConfig.yCenter + (scale.position_y ), scale.line_width)   % 1/4 vertical marker on the right
            
            Screen('TextSize', window, displayConfig.text.smallfont);
            DrawFormattedText(window,['pas du tout'],displayConfig.xCenter - scale.half_x - scale.word_width/2, displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            if FoodorConf == 1,
                DrawFormattedText(window,['enormement'], displayConfig.xCenter + (scale.half_x - scale.word_width/2), displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            elseif FoodorConf == 0,
                DrawFormattedText(window,['totalement'], displayConfig.xCenter + (scale.half_x - scale.word_width/2), displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            end
            DrawFormattedText(window,['moyennement'], displayConfig.xCenter - scale.word_width/2, displayConfig.yCenter + (scale.position_y - 1.5* scale.gap),surface);
         
                 
            positionCursor = [(xCursor - cs2/2), (displayConfig.yCenter + (scale.position_y + scale.gap)), (xCursor + cs2/2), (displayConfig.yCenter + (scale.position_y + scale.gap) + cs1)];
            Screen('DrawTexture', window, CursorTexture, [], positionCursor, 0);
            if FoodorConf == 1,
                Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);
                Screen('TextSize', window, displayConfig.text.mediumfont);
                DrawFormattedText(window,['Combien aimez-vous cet aliment?'],'center', displayConfig.yCenter +  100, surface);
            elseif FoodorConf == 0,
                Screen('TextSize', window, displayConfig.text.mediumfont);
                DrawFormattedText(window,['Etes-vous sur(e) de votre choix?'],'center', displayConfig.yCenter - 200, surface); 
            end

            Screen('Flip', window);
            
            % Wait 300ms or the key down to return up
            while isvalidate == 0 && (GetSecs - secs) < 0.3  && keyCode(WhichKeyDown == 1)
                [keyIsDown, pressSecs, keyCode, deltaSecs] = KbCheck;
            end
    
            % if down duration > 300ms, speed up the cursor movement
            while keyCode(WhichKeyDown == 1)                
                 if keyCode(key.left)== 1,               %the left arrow is pressed
                     xCursor = xCursor - scale.stepsize;
                     if abs(xCursor - displayConfig.xCenter) > scale.half_x; xCursor = displayConfig.xCenter - scale.half_x; end
                 
                 elseif keyCode(key.right)==1,           %the right arrow is pressed
                     xCursor = xCursor + scale.stepsize;
                     if abs(xCursor - displayConfig.xCenter) > scale.half_x; xCursor = displayConfig.xCenter + scale.half_x; end

                elseif keyCode(key.space)==1
                    isvalidate = 1;
                    WaitSecs(0.5); break;      
                elseif keyCode(key.escape) == 1
                    stoptask = 1;                
                 end
                                 
                
            
            
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x, displayConfig.yCenter + scale.position_y, displayConfig.xCenter + scale.half_x, displayConfig.yCenter + scale.position_y, scale.line_width_horizental)  % draw horizental line     
            Screen('DrawLine',window, surface, displayConfig.xCenter, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)               % vertical line in the middle
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter - scale.half_x, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)  % vertical position marker at the left
            Screen('DrawLine',window, surface, displayConfig.xCenter + scale.half_x, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter + scale.half_x, displayConfig.yCenter + (scale.position_y + scale.gap), scale.line_width)  % vertical postion marker at the right
            Screen('DrawLine',window, surface, displayConfig.xCenter - scale.half_x/2, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter - scale.half_x/2, displayConfig.yCenter + (scale.position_y ), scale.line_width)   % 1/4 vertical marker at the left 
            Screen('DrawLine',window, surface, displayConfig.xCenter + scale.half_x/2, displayConfig.yCenter + (scale.position_y - scale.gap), displayConfig.xCenter + scale.half_x/2, displayConfig.yCenter + (scale.position_y ), scale.line_width)   % 1/4 vertical marker on the right
            
      
            Screen('TextSize', window, displayConfig.text.smallfont);
            DrawFormattedText(window,['pas du tout'],displayConfig.xCenter - scale.half_x - scale.word_width/2, displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            if FoodorConf == 1,
                DrawFormattedText(window,['enormement'], displayConfig.xCenter + (scale.half_x - scale.word_width/2), displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            elseif FoodorConf == 0,
                DrawFormattedText(window,['totalement'], displayConfig.xCenter + (scale.half_x - scale.word_width/2), displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
            end
            DrawFormattedText(window,['moyennement'], displayConfig.xCenter - scale.word_width/2, displayConfig.yCenter + (scale.position_y - 1.5*scale.gap),surface);
           
                       
            positionCursor = [(xCursor - cs2/2), (displayConfig.yCenter + (scale.position_y + scale.gap)), (xCursor + cs2/2), (displayConfig.yCenter + (scale.position_y + scale.gap) + cs1)];
            Screen('DrawTexture', window, CursorTexture, [], positionCursor, 0);
            if FoodorConf == 1,
                Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);
                Screen('TextSize', window, displayConfig.text.mediumfont);
                DrawFormattedText(window,['Combien aimez-vous cet aliment?'],'center', displayConfig.yCenter +  100, surface);
            elseif FoodorConf == 0,
                Screen('TextSize', window, displayConfig.text.mediumfont);
                DrawFormattedText(window,['Etes-vous sur(e) de votre choix?'],'center', displayConfig.yCenter - 200, surface); 
            end
             
            Screen('Flip', window);
            WaitSecs('UntilTime', 0.01);
            [keyIsDown, pressSecs, keyCode, deltaSecs] = KbCheck;            
           
           end

        ansRating  = xCursor; 
end

