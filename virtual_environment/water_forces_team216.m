function [ force ] = water_forces_team216( pos, vel, acc, mass, vol, roh )
%water_forces_team216 Check what water forces must act
%   Compute boundary conditions and compute forces if necessary

    global waterViscousCoeff;
    
    boundary = check_water_boundary_team216(pos);
    isHole = check_hole_boundary_team216(pos);
    
    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    
    if boundary == 1 || isHole == 1
        
        [Fxt, Fyt, Fzt] = calculate_viscous_force_team216(vel, waterViscousCoeff);
        Fx = Fx + Fxt;
        Fy = Fy + Fyt;
        Fz = Fz + Fzt;
        
        [Fzt] = calculate_buoyant_force_team216(vol, roh);
        Fz = Fz + Fzt;
        
    end
    
    force = [Fx Fy Fz]';
    
end