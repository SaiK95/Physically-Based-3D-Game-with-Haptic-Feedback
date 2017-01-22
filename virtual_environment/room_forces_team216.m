function [ force ] = room_forces_team216( pos, vel, acc, mass )
%room_forces_team216 Check what room forces must act
%   Compute boundary conditions and compute forces if necessary

    global roomMinX;
    global roomMaxX;
    global roomMinY;
    global roomMaxY;
    global roomMinZ;
    global roomMaxZ;
    
    global roomSpringCoeff;
    
    global ZMIN_WALL; ZMIN_WALL = 1;
    global ZMAX_WALL; ZMAX_WALL = 2;
    global XMIN_WALL; XMIN_WALL = 3;
    global XMAX_WALL; XMAX_WALL = 4;
    global YMIN_WALL; YMIN_WALL = 5;
    global YMAX_WALL; YMAX_WALL = 6;
    
    boundary = check_room_boundary_team216(pos);
    
    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    
    if boundary == ZMIN_WALL
        
        Fz = Fz + calculate_spring_force_team216(roomMinZ-z, roomSpringCoeff);
        
    elseif boundary == ZMAX_WALL
        
        Fz = Fz + calculate_spring_force_team216(roomMaxZ-z, roomSpringCoeff);
        
    elseif boundary == YMIN_WALL
        
        Fy = Fy + calculate_spring_force_team216(roomMinY-y, roomSpringCoeff);
        
    elseif boundary == YMAX_WALL
        
        Fy = Fy + calculate_spring_force_team216(roomMaxY-y, roomSpringCoeff);
        
    elseif boundary == XMIN_WALL
        
        Fx = Fx + calculate_spring_force_team216(roomMinX-x, roomSpringCoeff);
        
    elseif boundary == XMAX_WALL
        
        Fx = Fx + calculate_spring_force_team216(roomMaxX-x, roomSpringCoeff);
        
    end
    
    force = [Fx Fy Fz]';
    
end