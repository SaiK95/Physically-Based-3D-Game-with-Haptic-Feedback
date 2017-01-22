function [ boundary ] = check_laserwall_boundary_team216( pos )
%check_laserwall_boundary_team216 Check if pos is touching the wall
%   return 0 if outside

    global platformMinX;
    global platformWidth;
    global wallHeight;
    global wallThickness;
    global platformPositionZ;
    global bottomWallY;
    wallMinX = platformMinX;
    wallMaxX = platformMinX + platformWidth;
    wallMinY = bottomWallY;
    wallMaxY = wallMinY + wallThickness;

    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( is_a_btw_b_c_team216(x, wallMinX, wallMaxX) )...
        && ( is_a_btw_b_c_team216(y, wallMinY, wallMaxY) )...
        && ( is_a_btw_b_c_team216(z, platformPositionZ, platformPositionZ+wallHeight) )
    
            boundary = 1;
            return;
             
    end

end

