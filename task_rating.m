    Screen('DrawTexture',window, Main_Rating,[],Main_Rating_rect);
    Screen(window,'Flip');
    WaitSecs(task_instruction_duration)
    keyIsDown = 0;
    while keyIsDown == 0
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
    end
    
    n = randperm(item_perCate);
    itemOnset = [];
    cursorFinal = [];
    stoptask = 0;
    
    i = 1;
        while i<= item_perCate,
            if stoptask
                break
            end          
            % fixation
            Screen('DrawTexture',window,pic_cross,[],rect_cross);
            Screen('Flip', window);
            onsetE.cross_start{i} = GetSecs;
            jitter_cross = 1 + 3*rand(1);
            WaitSecs(jitter_cross);
            onsetE.cross_end{i} = GetSecs;
                        
            
            ItemImage = imread([displayConfig.imageLocation, 'cate',num2str(category_number),'\cate', num2str(category_number), '_', num2str(n(i)),'.jpeg']);
            [s1, s2, s3] = size(ItemImage);    
            ItemTexture = Screen('MakeTexture', window, ItemImage);
            positionItem = [displayConfig.xCenter-s2/2, displayConfig.yCenter - s1/2- items_y_up, displayConfig.xCenter+s2/2, displayConfig.yCenter + s1/2 - items_y_up];           

            % Draw scale and cursor. Cursor movement is not continuous. 
            xCursor = displayConfig.xCenter + randi([-25,25])*scale.stepsize;
            if rating_rec == 1
                Scale_rating
            elseif rating_rec == 0
                Scale_rating_mouse
            end
            
            
            onsetE.response(i) = GetSecs - 0.5;    % after press space, waited 0.5 seconds
            cursorFinal(i) = ((ansRating - displayConfig.xCenter + scale.half_x)/scale.stepsize)* scale.step_price;     
            % the distance between the cursor positiona and scale left
            % 100 steps whole scale, 10 cents to 10 euros, 10 cent/setp       
            ratingItem(n(i)) = cursorFinal(i);
            i = i + 1;
        end
        
        sca
        % pleasData=[[1:i];n(1:i);itemOnset;cursorFinal].';  
        resultname = ['pleasantRating_subject_',num2str(number_subjects),'cat_',num2str(category_number)];
        cd(resultdir)
        save(resultname,'ratingItem','n');

%         Screen('TextSize', window, displayConfig.text.smallfont);
%         DrawFormattedText(window, ['Lorsque le test est fini,'],'center', displayConfig.yCenter, displayConfig.color_surface);
%         DrawFormattedText(window, ['appuyer sur n', char(39),'importe quelles touches du clavier pour passer à la deuxième session.'],'center', displayConfig.yCenter + 70, displayConfig.color_surface);
%         Screen('Flip', window);

%         keyIsDown=0;
%             while ~keyIsDown
%                 [keyIsDown, secs, keyCode, deltaSecs] = KbCheck(-1);
%             end
            
            
        