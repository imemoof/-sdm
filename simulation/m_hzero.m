function  [ gx ] = m_hzero(x_t,P,u_t,in)
    inv_temp = abs( P(1));   
    u_t = u_t';
    max_value    = u_t(10);
    option_values = u_t(3:8);
    

% Choice :   
gx = [exp(max_value.*inv_temp)./nansum(exp(option_values.*inv_temp),2)]';