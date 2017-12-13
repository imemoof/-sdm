function  [ gx ] = rt_obs_000_evo(x,P,u,in)
    inv_temp = safepos(P(1)); 
    k_entropy = P(2);
    k_constant = P(3);
    
    % get the value variables
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    % the prediction needs to be aglined with the dimension of the input y,
    % although some y values have been ignored due to trial property
    p = [];
    for k = 1:length(v_zero)
        p(k) = (exp(v_zero(k).*inv_temp)./nansum(exp(v_zero.*inv_temp)));
    end
    
    gx = k_entropy * sum((-1).* p.*log(p)) + k_constant;
end