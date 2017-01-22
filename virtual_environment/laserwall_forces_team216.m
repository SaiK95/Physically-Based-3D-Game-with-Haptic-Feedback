function [ force ] = laserwall_forces_team216( pos, vel, acc, mass )
%laserwall_forces_team216 Check what laser forces must act
%   Compute boundary conditions and compute forces if necessary

    global platformSpringCoeff;
    boundary = check_laserwall_boundary_team216(pos);
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    
    if boundary == 1
         
        Fz = Fz + calculate_spring_force_team216(20, platformSpringCoeff);
        
    end
    
    force = [Fx Fy Fz]';
    
end