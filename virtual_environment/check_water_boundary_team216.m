function [ boundary ] = check_water_boundary_team216( pos )
%check_water_boundary_team216 Check if pos is within boundary of water
%   return 0 if outside, 1 if inside

    global waterHeight;
    global waterWidth;
    global waterMinX;
    global waterMinY;
    waterMaxX = waterMinX + waterWidth;
    waterMaxY = waterMinY + waterWidth;;
    
    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( is_a_btw_b_c_team216(x, waterMinX, waterMaxX) )...
        && ( is_a_btw_b_c_team216(y, waterMinY, waterMaxY) )...
        && ( is_a_btw_b_c_team216(z, 0, waterHeight) )
       
        boundary = 1;
        return;
        
    end

end

