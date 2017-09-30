function  [ gx ] = m_hzero_v2(x_t,P,u_t,in)
    inv_temp = abs(P(1));   
    u_t = u_t';
    option_values = u_t(3:8);
    
%     max_index    = u_t(9);
%     max_value = option_values(max_index);
    chosen_index = u_t(1);
    chosen_value = option_values(chosen_index);
    
% Choice : 
gx = [exp(chosen_value.*inv_temp)./nansum(exp(option_values.*inv_temp),2)]';
% gx = [exp(max_value.*inv_temp)./nansum(exp(option_values.*inv_temp),2)]';