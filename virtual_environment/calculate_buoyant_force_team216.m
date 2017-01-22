function [ Fz ] = calculate_buoyant_force_team216( vol, roh )
%calculate_buoyant_force_team216 Compute buoyant force

    global gravity;
    
    Fz = roh*vol*gravity;

end

