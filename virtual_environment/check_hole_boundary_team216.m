function [ boundary ] = check_hole_boundary_team216( pos )
%check_hole_boundary_team216 Check if pos is within boundary of either hole
%   return 0 if outside, 1 if inside

    global startHolePositionX;
    global startHolePositionY;
    global halfStartHoleSize;
    global startHolePositionZ;
    global startBottomHolePositionZ;
    
    global holePositionX;
    global holePositionY;
    global halfHoleSize;

    global holePositionZ;
    global bottomHolePositionZ;

    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( is_a_btw_b_c_team216(x, startHolePositionX-halfStartHoleSize, startHolePositionX+halfStartHoleSize) )...
        && ( is_a_btw_b_c_team216(y, startHolePositionY-halfStartHoleSize, startHolePositionY+halfStartHoleSize) )...
        && ( is_a_btw_b_c_team216(z, startHolePositionZ, startBottomHolePositionZ) )
       
        % starting hole
        boundary = 1;
        
    elseif ( is_a_btw_b_c_team216(x, holePositionX-halfHoleSize, holePositionX+halfHoleSize) )...
        && ( is_a_btw_b_c_team216(y, holePositionY-halfHoleSize, holePositionY+halfHoleSize) )...
        && ( is_a_btw_b_c_team216(z, holePositionZ, bottomHolePositionZ) )
       
        % hole near the button
        boundary = 1;
        
    end

end

