function [ boundary ] = check_room_boundary_team216( pos )
%check_room_boundary_team216 Check if pos is within boundary of room
%   return based on which wall

    global roomMinX;
    global roomMaxX;
    global roomMinY;
    global roomMaxY;
    global roomMinZ;
    global roomMaxZ;
    
    global ZMIN_WALL;
    global ZMAX_WALL;
    global XMIN_WALL;
    global XMAX_WALL;
    global YMIN_WALL;
    global YMAX_WALL;

    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( z < roomMinZ )
       
        boundary = ZMIN_WALL;
    
    elseif ( z > roomMaxZ )
       
        boundary = ZMAX_WALL;
        
    elseif ( y < roomMinY )
       
        boundary = YMIN_WALL;
        
    elseif ( y > roomMaxY )
       
        boundary = YMAX_WALL;
        
    elseif ( x < roomMinX )
       
        boundary = XMIN_WALL;
        
    elseif ( x > roomMaxX )
       
        boundary = XMAX_WALL;
        
    end

end

