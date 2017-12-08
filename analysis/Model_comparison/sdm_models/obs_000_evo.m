function  [ gx ] = obs_000_evo(x,P,u,in)
    inv_temp = abs(P(1)); 

   ID_items = u(3:8);
   ID_items =(ID_items(~isnan(ID_items)));
   v_zero = x(ID_items);
     
    gx = zeros(1,6);
    for k = 1:length(v_zero)
        gx(k) = (exp(v_zero(k).*inv_temp)./nansum(exp(v_zero.*inv_temp)));
    end
    gx = gx';
%    disp(gx);
    
end