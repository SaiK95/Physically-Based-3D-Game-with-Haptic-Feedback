function [ F ] = COG_forces_team216( pos, cog_pos)
%COG_forces_team216 Check what center of attraction forces must act
%   Compute boundary conditions and compute forces if necessary

    global COG_radius;
    global COG_constant;

    F = [0 0 0]';
    
    vec = pos-cog_pos;
    vec_norm = norm(cog_pos-pos);
    
    if vec_norm<=COG_radius
        
        F = F - (COG_radius-vec_norm).*(vec./vec_norm).*COG_constant;
            
    end
    
end