function [ force ] = user_2_ball_force_team216( posUser, velUser, posBall )
%user_2_ball_force_team216 Check what forces user exerts on ball
%   Compute boundary conditions and compute forces if necessary

    global userBallForceScale;
    
    boundary = check_ball_boundary_team216(posUser, posBall);
    
    Vx = velUser(1);
    Vy = velUser(2);
    Vz = velUser(3);
    
    Fx = 0;
    Fy = 0;
    Fz = 0;
    
    
    if boundary == 1
         
        Fx = Fx + Vx;
        Fy = Fy + Vy;
        Fz = Fz + Vz;
    
    end
    
    force = ([Fx Fy Fz]').*userBallForceScale;
    
end