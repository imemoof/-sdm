% Rating task for different items
clear all;       
    number_subjects = input('subject identification number?');
    practice_or_not = input('Is this a practice session?'); 
    
    if practice_or_not == 0
        do_rating_task = input('will there be a rating session?');
        do_choice_task = input('will there be a choice session?');
    
    %     if do_rating_task == 1
    %        rating_rec = input ('will you use keyboard to place a rating?');       % 1 = use keyboard, 0 = use mouse or touch screen
    %     end
        rating_rec = 1; % use key board to place a rating
        response_rec = 0; % use mouse/touch screen to make a choice
        if do_choice_task == 1
    %       response_rec = input('Will you use number key pad to make a choice?'); % 1 = use number key pad, 0 = use mouse or touch screen
            mask_options = input('Do you want to mask choice options?')   % decide whether or not choice options are going to ba masked
        end
    elseif prectice_or_not == 1
        mask_options = input('Do you want to mask choice options?')       
    end
    
    
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
        addpath('C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior')
        root = 'C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior'
        cd(root)
        displayConfig.imageLocation = ['C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior\'];  
        resultdir = ['C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior\results_sdm\'];        
        instruction_dir = ['C:\Users\chen.hu\Documents\MATLAB\experiment\SDM_behavior\instructions_sdm\'];

    end


%% screen configuration
    screens = Screen('Screens');
    HideCursor()
    whichScreen =  max(screens);

    Screen('Preference', 'SkipSyncTests', 0);
    window = Screen('OpenWindow',whichScreen,[0 0 0]);
    Screen('Preference','VisualDebugLevel', 2);    
    backgroud = BlackIndex(whichScreen);
    surface = WhiteIndex(whichScreen);
    
    displayConfig.text.smallfont = 18;
    displayConfig.text.mediumfont = 20;  
    Screen('TextSize', window, displayConfig.text.mediumfont);
%    Font_Type = 'garamond';
%    Screen('TextFont', window, Font_Type);

    [L, H] = Screen('WindowSize',whichScreen);
    displayConfig.xCenter = L/2; 
    displayConfig.yCenter = H/2;

%%  Global variables
    scale.half_x = 400;
    scale.position_y = 200;
    scale.line_width = 3;
    scale.line_width_horizental = 4;
    scale.line_width_thin = 1;
    scale.word_gap = 50;
    scale.word_width = 180;

    scale.gap = 10;
    scale.stepsize = 2 * scale.half_x * 0.01;  % 100 steps in total
    scale.totalprice = 100;
    scale.step_price = scale.totalprice/100;  
    
    % fixationcross
    pic_cross = Screen('MakeTexture',window,imread('cross.bmp'));
    rect_cross = CenterRectOnPoint(Screen('Rect',pic_cross),displayConfig.xCenter,displayConfig.yCenter); 
    
    %------- response related --------------
    KbName('UnifyKeyNames')
    key.space = KbName('space');
    key.left = KbName('LeftArrow');
    key.right = KbName('RightArrow');
    key.escape = KbName('escape');
   
    % reset random generator
    rand('state',sum(100*clock));
    
    %------- trial configuaration
    item_perCate = 86;
    total_cate = 10;
    FoodorConf = 1;  % 0 = confidence rating, 1= food rating.
    items_y_up = 150 % move the food item up from the center to place scales underneath
    trials_perCate = 3;
    
    rect_linewidth = 3;
    rect_linegap = 3;
    color.frame = [255, 245, 157];
    color.ready = [121, 134, 203];
    color.chosen = [255, 160, 0];
    
    % intervals
    interval.minimum_itemdisp = 0.5;
    interval.time_out = 3;
    inverval.feedback = 1;
%     % Load  and display instructions
%     Load_instructions;    
%     DisplayInstru3(displayConfig, instru, 1)  


% Display instructions
    Load_instructions_sdm
    Screen('DrawTexture',window, Bien_Lire,[],Bien_Lire_rect);
    Screen(window,'Flip');
%    onsetB.instruction_on = GetSecs;
    WaitSecs(task_instruction_duration)
%    onsetB.instruction_off = GetSecs;



% Practice Session


% Main Task
    % put session 1- session 5 together
    % which tasks to do
        if do_rating_task == 1
            task_rating
        end
        if do_choice_task == 1
            load([resultdir,'pleasantRating_subject_',num2str(number_subjects),'.mat']);
            if response_rec == 1
                task_choice_keyboard 
            elseif response_rec == 0
                task_choice_mouse
            end
        end
    
    sca