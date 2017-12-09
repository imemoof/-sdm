function  [fx] = evo_101(x,P,u,in)
    bonus_primacy = P(1);
    bonus_recency = P(2);
    
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    % the first appeared item acquirs a bonus
    v_zero(1) = v_zero(1) + bonus_primacy;
    
    % recency bonus goes to the last item
    v_zero(end) = v_zero(end) + bonus_recency;
    
    x(ID_items) = v_zero;
    fx = x;
end
