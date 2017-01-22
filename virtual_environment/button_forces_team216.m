function [ force ] = button_forces_team216( pos, vel, acc, mass )
%button_forces_team216 Check what button forces must act
%   Compute boundary conditions and compute forces if necessary

    global buttonZ;
    global buttonHeight;
    global buttonSpringCoeff;
    
    boundary = check_button_boundary_team216(pos);
    
    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    
    if boundary == 1
        
        Fz = Fz + calculate_spring_force_team216((buttonZ+buttonHeight-z), buttonSpringCoeff);
        
    end
    
    force = [Fx Fy Fz]';
    
end