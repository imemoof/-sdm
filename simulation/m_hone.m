function  [ gx ] = m_hone(x_t,P,u_t,in)
    inv_temp = abs(P(1));   
    beta_fit = abs(P(2));
    u_t = u_t';
    
%     option_values   =   NaN(180,6);
%     max_value = NaN(180,1);
    
%   for i = [1: 180];                     % for each trials
%          v_zero = u_t(i,3:8);                               % per trial rating eg. [29, 0,0]

           v_zero = u_t(3:8);                               % per trial rating eg. [29, 0,0]
           v_zero =  v_zero (~isnan( v_zero ));
           winning_index = 1;
           defeat_index = 0;
           win_record = zeros (1, length(v_zero));
           defeat_record = zeros(1, length(v_zero));
           k = 1;  
            
           while k <= length(v_zero) -1
               if v_zero(winning_index) > v_zero(k+1)                                                                % the previous winning option is the better of the two 
                    defeat_index = k+ 1;       
                    winning_index = winning_index;                   
                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta_fit.*(-1);                     
                    defeat_record (defeat_index) = defeat_record(defeat_index) +1;           
                    v_zero(winning_index) = v_zero(winning_index) + beta_fit.*1;
                    win_record(winning_index) = win_record(winning_index) +1;
                    
               elseif v_zero(winning_index) < v_zero(k+1)  % if the new option is winning
                    defeat_index = winning_index;     
                    winning_index = k + 1;  
                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta_fit*(-1);                     
                    defeat_record (defeat_index) = defeat_record(defeat_index) +1;
                    v_zero(winning_index) = v_zero(winning_index) + beta_fit*1;
                    win_record(winning_index) = win_record(winning_index) +1;
                    
               elseif v_zero(winning_index) == v_zero(k+1)  % if the two options have the same value, flip a coin to decide which wins
                   coin = rand(1);
                   if        coin >= 0.5, winning_index = winning_index; defeat_index = k+1;
                   elseif coin <0.5, defeat_index = winning_index; winnng_index = k+1; end
                    v_zero(defeat_index ) = v_zero(defeat_index ) + beta_fit*(-1);                     
                    defeat_record (defeat_index) = defeat_record(defeat_index) +1; 
                    v_zero(winning_index) = v_zero(winning_index) + beta_fit*1;
                    win_record(winning_index) = win_record(winning_index) +1;                
               end
               k = k +  1;
           end
%           max_value(i)   = v_zero(winning_index);
%           option_values(i,1:length(v_zero)) = v_zero;     
          max_value   = v_zero(winning_index);
          option_values(:,1:length(v_zero)) = v_zero; 
%       end
    

% Choice:   
gx = [exp(max_value.*inv_temp)./nansum(exp(option_values.*inv_temp),2)]';