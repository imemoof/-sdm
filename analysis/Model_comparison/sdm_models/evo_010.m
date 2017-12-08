function  [fx] = evo_010(x,P,u,in)
%   function  [fx,dfdx,dfdP] = sm_010(x,P,u,in)
% IN:
%   - x_t : q-values (2x1)
%   - P : (inverse-sigmoid) learning-rate
%   - u : u(1)=previous action (1 or 0), u(2)=feedback
%   - in : [useless]
% OUT:
%   - fx: evolved q-values (2x1)
%   - dfdx/dfdP: gradient of the q-values evolution function, wrt q-avlues
%   and evolution parameter, respectively.

    alpha = P;
    % alpha = 1./(1+exp(-P));
    % learning rate is bounded between 0 and 1.
    % identity transition for unchosen items
    % fx = x;

    ID_items = u(3:8);
    ID_items =(ID_items(~isnan(ID_items)));
    v_zero = x(ID_items);
    
    winning_index = 1;
    defeat_index = 0;
    k = 1;

  while k <= length(v_zero) -1
        if v_zero(winning_index) >= v_zero(k+1)                                                                % the previous winning option is the better of the two
            defeat_index = k+ 1; % winning_index stay unchanged;
            v_zero(defeat_index) = v_zero(defeat_index) - alpha;
            v_zero(winning_index) = v_zero(winning_index) + alpha;

        elseif v_zero(winning_index) < v_zero(k+1)  % if the new option is winning
            defeat_index = winning_index;
            winning_index = k + 1;
            v_zero(defeat_index ) = v_zero(defeat_index ) - alpha;
            v_zero(winning_index) = v_zero(winning_index) + alpha;

%         elseif v_zero(winning_index) == v_zero(k+1)  % if the two options have the same value, flip a coin to decide which wins
%             coin = rand(1);
%             if coin >= 0.5
%                 defeat_index = k+1; % winning_index stay unchanged;
%             elseif coin <0.5
%                 defeat_index = winning_index; 
%                 winning_index = k+1; 
%             end
%             v_zero(defeat_index ) = v_zero(defeat_index ) - alpha;
%             v_zero(winning_index) = v_zero(winning_index) + alpha;
        end
        k = k + 1;
  end
   x(ID_items) = v_zero;
   fx = x;
   
end
