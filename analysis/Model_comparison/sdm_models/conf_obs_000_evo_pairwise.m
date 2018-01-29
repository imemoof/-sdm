function  [ gx ] = conf_obs_000_evo_pairwise(x,P,u,in)
    inv_temp = safepos(P(1)); 
    k_entropy = P(2);
    
    % get the value variables
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    % the prediction needs to be aglined with the dimension of the input y,
    % although some y values have been ignored due to trial property
    prob = zeros(6);
    pro(1,1) = 1;
    for n = 1:length(v_zero) - 1
        for i = 1:n
            pro(n+1,i) = pro(n,i)*exp(v_zero(i).*inv_temp)/exp((v_zero(i).*inv_temp) + exp(v_zero(n+1).*inv_temp));
        end
        pro(n+1,n+1) = 1 - sum(pro(n+1,1:n));
    end
    px = nonzeros(pro(n+1,:));

    
    system_entropy = sum((-1).* px.*log(px));
    gx = 100./(1 + exp((-1).*k_entropy.*system_entropy));
end