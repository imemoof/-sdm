function  [fx] = evo_001(x,P,u,in)
    
    bonus_recency = P(1);    
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    % the last appeared item get a bonus
    v_zero(end) = v_zero(end) + bonus_recency;
    x(ID_items(end)) = v_zero(end);
    
    fx = x;
   
end
