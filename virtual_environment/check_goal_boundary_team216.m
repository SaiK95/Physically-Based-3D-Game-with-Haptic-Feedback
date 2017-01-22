function [ boundary ] = check_goal_boundary_team216( pos )
%check_goal_boundary_team216 Check if pos is touching the goal
%   return 0 if outside

    global goalPostX;
    global goalPostThickness;
    global goalPostLength;
    global goalPostY;
    global goalPostHeight;
    global platformPositionZ;

    goalMinX = goalPostX;
    goalMaxX = goalPostX + goalPostThickness;
    goalMinY = goalPostY;
    goalMaxY = goalPostY + goalPostLength;

    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( is_a_btw_b_c_team216(x, goalMinX, goalMaxX) )...
        && ( is_a_btw_b_c_team216(y, goalMinY, goalMaxY) )...
        && ( is_a_btw_b_c_team216(z, platformPositionZ, platformPositionZ+goalPostHeight) )
    
            boundary = 1;
            return;
             
    end

end

