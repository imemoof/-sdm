function  [ gx ] = obs_000(x,P,u,in)
    inv_temp = abs(P(1)); 
    
    % get the value variables
    ID_items = u(9:14);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = ID_items;
    
    % the prediction needs to be aglined with the dimension of the input y,
    % although some y values have been ignored due to trial property
    gx = zeros(1,6);
    for k = 1:length(v_zero)
        gx(k) = (exp(v_zero(k).*inv_temp)./nansum(exp(v_zero.*inv_temp)));
    end
    gx = gx';
%    disp(gx);
    
end