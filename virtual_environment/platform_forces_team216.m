function [ force ] = platform_forces_team216( pos, vel, acc, mass )
%platform_forces_team216 Check what platform forces must act
%   Compute boundary conditions and compute forces if necessary

    global platformPositionZ;
    global platformThickness;
    global platformSpringCoeff;
    global platformFrictionCoeff;
    boundary = check_platform_boundary_team216(pos);
    isHole = check_hole_boundary_team216(pos);
    
    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    Vx = vel(1);
    Vy = vel(2);
    Vz = vel(3);
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    
    
    if isHole == 1
        
        % Don't add any forces, as it has to pass through the hole
        force = [0 0 0]';
        return
        
    elseif boundary == 1
         
        Fz = Fz + calculate_spring_force_team216(platformPositionZ-z, platformSpringCoeff);
        
    elseif boundary == -1
        
        Fz = Fz + calculate_spring_force_team216(platformPositionZ-platformThickness-z, platformSpringCoeff);
        
    end
    
    % Texture force is common throughout.
    if Fz ~= 0
        Fx = Fx + -platformFrictionCoeff*abs(Fz)*Vx;
        Fy = Fy + -platformFrictionCoeff*abs(Fz)*Vy;
        
        if abs(Fx) >= 0.01 || abs(Fy) >= 0.01
            Fz = Fz + (rand(1)/3);
        end
    end
    
    force = [Fx Fy Fz]';
end