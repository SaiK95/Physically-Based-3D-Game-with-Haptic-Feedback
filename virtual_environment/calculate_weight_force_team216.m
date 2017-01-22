function [ F ] = calculate_weight_force_team216( mass )
%calculate_weight_force_team216 Compute weight force

    global gravity;
    
    Fx = 0;
    Fy = 0;
    Fz = -mass*gravity;
    
    F = [Fx, Fy, Fz];

end

