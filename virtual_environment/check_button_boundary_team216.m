function [ boundary ] = check_button_boundary_team216( pos )
%check_button_boundary_team216 Check if pos is within boundary of button
%   return 0 if outside, 1 if top half of button, 0 if bottom half
%   this is to simulate a 'click'

    global buttonWidth;
    global buttonMinX;
    global buttonMinY;
    global buttonZ;
    global buttonHeight;
    buttonMaxX = buttonMinX + buttonWidth;
    buttonMaxY = buttonMinY + buttonWidth;
    global ballActivated;

    x = pos(1);
    y = pos(2);
    z = pos(3);
    
    boundary = 0;
    
    if ( is_a_btw_b_c_team216(x, buttonMinX, buttonMaxX) )...
        && ( is_a_btw_b_c_team216(y, buttonMinY, buttonMaxY) )...
        && ( is_a_btw_b_c_team216(z, buttonZ+(buttonHeight/2), buttonZ+buttonHeight) )
       
        boundary = 1;
        return;
        
    elseif ( is_a_btw_b_c_team216(x, buttonMinX, buttonMaxX) )...
        && ( is_a_btw_b_c_team216(y, buttonMinY, buttonMaxY) )...
        && ( is_a_btw_b_c_team216(z, buttonZ, buttonZ - buttonHeight) )
       
        ballActivated = 1;
        
    end

end

