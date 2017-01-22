function [ boundary ] = check_platform_boundary_team216( pos )
%check_platform_boundary_team216 Check if pos is within boundary of platform
%   return 0 if outside, 1 if top half of platform, -1 if bottom half

    global platformMinX;
    global platformPositionZ;
    global platformThickness;
    global platformWidth;
    global platformOffsetY;
    platformMaxX = platformMinX + platformWidth;
    platformMaxY = platformOffsetY + platformWidth;

    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( is_a_btw_b_c_team216(x, platformMinX, platformMaxX) )...
        && ( is_a_btw_b_c_team216(y, platformOffsetY, platformMaxY) )...
        && ( is_a_btw_b_c_team216(z, platformPositionZ, platformPositionZ-platformThickness) )
       
        % Now check if in top half or bottom half
        if ( is_a_btw_b_c_team216(z, platformPositionZ, (platformPositionZ-platformThickness/2)) )
            
            % Top half
            boundary = 1;
            return;
            
        elseif ( is_a_btw_b_c_team216(z, (platformPositionZ-platformThickness/2), (platformPositionZ-platformThickness)) )
           
            % Bottom half
            boundary = -1;
            return;
            
        end
        
    end

end

