function  [fx] = evo_100(x,P,u,in)
    bonus_primacy = P(1);
    
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    % the first appeared item acquirs a bonus
    v_zero(1) = v_zero(1) + bonus_primacy;
    x(ID_items(1)) = v_zero(1);
    
    fx = x;
   
end
