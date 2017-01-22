function [ boundary ] = check_ball_boundary_team216( posUser, posBall )
%check_ball_boundary_team216 Check if pos is within boundary of ball

    global ballRadius;
    
    dist = norm(posUser-posBall);
    
    boundary = 0;
    
    if ( dist <= ballRadius )

        boundary = 1;
        
    end

end