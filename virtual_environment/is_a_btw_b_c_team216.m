function [ bool ] = is_a_btw_b_c_team216( a, b, c )
%is_a_btw_b_c_team216 Check if value a is between b and c
%   returns 1 if true, 0 if false

    minVal = min(b, c);
    maxVal = max(b, c);
    
    if a >= minVal && a <= maxVal
       
        bool = 1;
        
    else
       
        bool = 0;
        
    end

end

