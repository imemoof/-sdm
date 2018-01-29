function  [ gx ] = obs_000_evo_pairwise(x,P,u,in)
    inv_temp = safepos(P(1));

    % get the value variables
    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    % the prediction needs to be aglined with the dimension of the input y,
    % although some y values have been ignored due to trial property
    p = zeros(6);
    p(1,1) = 1;
    for n = 1:length(v_zero) - 1
        for i = 1:n
            p(n+1,i) = p(n,i)*exp(v_zero(i).*inv_temp)/exp((v_zero(i).*inv_temp) + exp(v_zero(n+1).*inv_temp));
        end
        p(n+1,n+1) = 1 - sum(p(n+1,1:n));
    end
    gx = p(n+1,:)';
    
%    gx = zeros(1,6);
%     for k = 1:length(v_zero)
%         gx(k) = (exp(v_zero(k).*inv_temp)./nansum(exp(v_zero.*inv_temp)));
%     end
%    gx = gx';
end