%% Choice task, 18 trials per repetation, use the numeric keypad to make a response, correspondance
% 7 - up left,  8 - up middle,  9 - up right
% 1 - low left, 2 - low middle, 3- low right

k = 1;
stoptask = 0;
[per_trial, trials] = group_items(ratingItem)
while k <= trials_perCate;
      if stoptask; break; end    

    HideCursor()
  % fixation
    Screen('DrawTexture',window,pic_cross,[],rect_cross);
    Screen('Flip', window);
    jitter_cross = 1 + 3*rand(1);
    WaitSecs(jitter_cross);
   
% 6 position on the screen
    horizental_gap = (L - 300*3)/4;
    vertical_gap = (H - 225*2)/3;
    rect_pos(:,1) = [horizental_gap ;vertical_gap; horizental_gap + 300; vertical_gap + 225];
    rect_pos(:,2) = [2*horizental_gap + 300; vertical_gap; 2*horizental_gap + 600; vertical_gap + 225];
    rect_pos(:,3) = [3*horizental_gap + 600; vertical_gap ;3*horizental_gap + 900; vertical_gap + 225];
    rect_pos(:,4) = [horizental_gap ; 2*vertical_gap + 225 ; horizental_gap + 300; 2*vertical_gap + 450];
    rect_pos(:,5) = [2*horizental_gap + 300; 2*vertical_gap + 225; 2*horizental_gap + 600; 2*vertical_gap + 450];
    rect_pos(:,6) = [3*horizental_gap + 600;2*vertical_gap + 225; 3*horizental_gap + 900; 2*vertical_gap + 450];
    
    rect_line = ones(4,6)*rect_linegap.*[-1;-1;1;1];  % leave a 5 pixel border
    % first item appear, random location of the 6, click space to
    % proceed
    pos_perm = randperm(6);
    positions_item = rect_pos(:,pos_perm(1:trials.itemNumber{k}));
    items_whichones = trials.itemsordered{k};
    ItemImage = {};
    for n = 1: trials.itemNumber{k}
        if n == 1
            % rectangles
            Screen('FrameRect',window, color.frame,[rect_pos + rect_line],rect_linewidth) %light purple
            % photo
            ItemImage{n} = imread([displayConfig.imageLocation, 'cate1\cate1', '_', num2str(items_whichones(n)),'.jpeg']);
            [s1, s2, s3] = size(ItemImage{n});    
            ItemTexture = Screen('MakeTexture', window, ItemImage{n});
            positionItem = positions_item(:,n)';        
            Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);
            Screen('Flip', window);

        elseif n > 1
            % rectangles
            Screen('FrameRect',window, color.frame,[rect_pos + rect_line],rect_linewidth) %light purple
            % photo
            ItemImage{n} = imread([displayConfig.imageLocation, 'cate1\cate1', '_', num2str(items_whichones(n)),'.jpeg']);
            [s1, s2, s3] = size(ItemImage{n});    
            ItemTexture = Screen('MakeTexture', window, ItemImage{n});
            positionItem = positions_item(:,n)';        
            Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);           
            
            % filled rectange of the previous locations
            Screen('FillRect',window, color.frame,[positions_item(:,1:(n-1))])
            Screen('Flip', window);
        end
        
            % press the key to proceed to the next pic
            WaitSecs(interval.minimum_itemdisp) 
            keyIsDown = 0;
            while true
                [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
                if keyIsDown == 1
                        if response_rec == 1 % use keyboard to make a response 
                            if find(keyCode == 1) == 101; break;  end; % if key is pressed and the pressed key is 5 on the numeric keyboard
                        elseif response_rec == 0  % use mouse to make a response, press space key to continue
                            if find(keyCode == 1) == key.space; break; end;
                        end      
                end                
            end
            
            if keyCode(key.escape) == 1
                stoptask = 1;
            end

           
           
            % display the last item of the trial sequence, if already
            % reached to an end
            if mask_options == 0
                if  n == trials.itemNumber{k}
                    Screen('FrameRect',window, color.ready,[rect_pos + rect_line],rect_linewidth)             
                    ItemTexture1 = Screen('MakeTexture', window, ItemImage{1});
                    Screen('DrawTexture', window, ItemTexture1, [], positions_item(:,1), 0);
                    ItemTexture2 = Screen('MakeTexture', window, ItemImage{2});
                    Screen('DrawTexture', window, ItemTexture2, [], positions_item(:,2), 0);
                    ItemTexture3 = Screen('MakeTexture', window, ItemImage{3});
                    Screen('DrawTexture', window, ItemTexture3, [], positions_item(:,3), 0);
                    if n >= 4
                        ItemTexture4 = Screen('MakeTexture', window, ItemImage{4});
                        Screen('DrawTexture', window, ItemTexture4, [], positions_item(:,4), 0); 
                    end
                    if n >= 5
                        ItemTexture5 = Screen('MakeTexture', window, ItemImage{5});
                        Screen('DrawTexture', window, ItemTexture5, [], positions_item(:,5), 0); 
                    end      
                    if n == 6
                        ItemTexture6 = Screen('MakeTexture', window, ItemImage{6});
                        Screen('DrawTexture', window, ItemTexture6, [], positions_item(:,6), 0); 
                    end
                    Screen('Flip', window);
                end
            
            elseif mask_options == 1            
               if n == trials.itemNumber{k}
                        % filled rectange of the previous locations
                        Screen('FrameRect',window, color.ready,[rect_pos + rect_line],rect_linewidth)
                        Screen('FillRect',window, color.ready,[positions_item(:,1:n)])
                        Screen('Flip', window);
               end
            end
           
            WaitSecs(interval.minimum_itemdisp)  

            
            
            
            

    end  
    timer_start = GetSecs;
    
        % Record choice
        exit = 0;
        tooslow = 0;
        keyDown = 0;
        while exit == 0
            [keyDown, secs, response_keycode, deltaSecs] = KbCheck;
            slowOrnot = GetSecs;
        
            if (slowOrnot - timer_start) > interval.time_out
                exit = 1; choice = 100;
            end
            
            if  keyDown == 1 
                if response_keycode(103) == 1                   % 'number 7 is pressed'
                    exit = 1; choice = 1;                                             
                elseif response_keycode(104) == 1                         
                    exit = 1; choice = 2;                                            
                elseif response_keycode(105) == 1
                    exit = 1; choice = 3;          
                elseif response_keycode(97) == 1
                    exit = 1; choice = 4;               
                elseif response_keycode(98) == 1
                    exit = 1; choice = 5;                 
                elseif response_keycode(99) == 1
                    exit = 1; choice = 6;               
                else
                    exit = 1; choice = 1000;
                end
            end            
        end     


        % photo
        if choice <7
            ItemImage = imread([displayConfig.imageLocation, 'cate1\cate1', '_', num2str(items_whichones(find(pos_perm == choice))),'.jpeg']);
            ItemTexture = Screen('MakeTexture', window, ItemImage);
            positionItem = rect_pos (:,choice)'; 
            Screen('FrameRect',window, color.chosen,[positionItem + [-rect_linewidth, -rect_linewidth, rect_linewidth, rect_linewidth]], rect_linewidth) 
            Screen('DrawTexture', window, ItemTexture, [], positionItem, 0);       
        elseif choice == 100
            DrawFormattedText(window, 'Too slow!', 'center', 'center', surface, 60, 0, 0, 1.5, 0, [])
        elseif choice == 1000
            DrawFormattedText(window, 'Wrong key!', 'center', 'center', surface, 60, 0, 0, 1.5, 0, [])
        end
        % filled rectange of the previous locations 
        
        
        Screen('Flip', window); 
        WaitSecs(inverval.feedback)

    % confidence rating
        if choice <7
            FoodorConf = 0;
            xCursor = displayConfig.xCenter + randi([-25,25])*scale.stepsize;
            Scale_rating
            cursorFinal(k) = ((ansRating - displayConfig.xCenter + scale.half_x)/scale.stepsize)* scale.step_price;     
        else 
            cursorFinal(k) = -100;
        end
        
        k = k+1;  % to be confirmed whether do we repeat a trial if wrong key is pressed

end

