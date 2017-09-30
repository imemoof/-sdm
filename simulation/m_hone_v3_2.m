function  [ gx ] = m_hone_v3_2(x_t,P,u_t,in)
    inv_temp = abs(P(1));   
    beta_fit = abs(P(2));
    u_t = u_t';
        
           chosen_index = u_t(1);
           % if max_value skip this line
           
           v_zero = u_t(3:8);                               % per trial rating eg. [29, 0,0]
           v_zero =  v_zero (~isnan( v_zero ));
           wins = u_t(11:16);
           defs = u_t(17:22);
           wins = wins(~isnan(wins));
           defs = defs(~isnan(defs));
           for k = 1: length(v_zero)
               v_zeronew(k) = v_zero(k) + beta_fit.*wins(k) - beta_fit.*defs(k);
           end
           
           
%            winning_index = 1;
%            defeat_index = 0;
%            win_record = zeros (1, length(v_zero));
%            defeat_record = zeros(1, length(v_zero));
%            k = 1;  
%             
%            while k <= length(v_zero) -1
%                if v_zero(winning_index) > v_zero(k+1)                                                                % the previous winning option is the better of the two 
%                     defeat_index = k+ 1;       
%                     winning_index = winning_index;                   
%                     v_zero(defeat_index ) = v_zero(defeat_index ) + beta_fit.*(-1);                     
%                     defeat_record (defeat_index) = defeat_record(defeat_index) +1;           
%                     v_zero(winning_index) = v_zero(winning_index) + beta_fit.*1;
%                     win_record(winning_index) = win_record(winning_index) +1;
%                     
%                elseif v_zero(winning_index) < v_zero(k+1)  % if the new option is winning
%                     defeat_index = winning_index;     
%                     winning_index = k + 1;  
%                     v_zero(defeat_index ) = v_zero(defeat_index ) + beta_fit*(-1);                     
%                     defeat_record (defeat_index) = defeat_record(defeat_index) +1;
%                     v_zero(winning_index) = v_zero(winning_index) + beta_fit*1;
%                     win_record(winning_index) = win_record(winning_index) +1;
%                     
%                elseif v_zero(winning_index) == v_zero(k+1)  % if the two options have the same value, flip a coin to decide which wins
%                    coin = rand(1);
%                    if        coin >= 0.5, winning_index = winning_index; defeat_index = k+1;
%                    elseif coin <0.5, defeat_index = winning_index; winnng_index = k+1; end
%                     v_zero(defeat_index ) = v_zero(defeat_index ) + beta_fit*(-1);                     
%                     defeat_record (defeat_index) = defeat_record(defeat_index) +1; 
%                     v_zero(winning_index) = v_zero(winning_index) + beta_fit*1;
%                     win_record(winning_index) = win_record(winning_index) +1;                
%                end
%                k = k +  1;
%            end

%           max_value(i)   = v_zero(winning_index);
%           option_values(i,1:length(v_zero)) = v_zero;     

          chosen_value   = v_zeronew(chosen_index);
         % max_value = v_zero(winning_index)
          option_values(:,1:length(v_zeronew)) = v_zeronew; 
%       end
    

% Choice:   
gx = [exp(chosen_value.*inv_temp)./nansum(exp(option_values.*inv_temp),2)]';
%gx = [exp(max_value.*inv_temp)./nansum(exp(option_values.*inv_temp),2)]';