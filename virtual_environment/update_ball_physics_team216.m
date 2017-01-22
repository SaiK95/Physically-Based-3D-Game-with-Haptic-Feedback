% Calculate acceleration
ball_F = [ball_Fx ball_Fy ball_Fz]';
ballAcc = ball_F/ballMass;

% Compute velocity and acceleration
if ballFirstItr == 0
    
    % Start timer
    ballVelTime = tic;
    ballPrevVel = [0 0 0]';
    time_elapsed = 0;
    ballFirstItr = 1;

else

    time_elapsed = toc(ballVelTime);

    ballVel = ballPrevVel + (ballAcc.*time_elapsed);
    ballPrevVel = ballVel;

    ballVelTime = tic;

end

delPos = (ballPrevVel.*time_elapsed) + (0.5.*ballAcc.*(time_elapsed^2));

% Update ball position
ballCenterX = ballCenterX+delPos(1);
ballCenterY = ballCenterY+delPos(2);
ballCenterZ = ballCenterZ+delPos(3);

% Set the transparency of the ball's faces and edges.
set(hBall,'xdata',ballRadius*xsphere+ballCenterX,'ydata',ballRadius*ysphere+ballCenterY,'zdata',ballRadius*zsphere+ballCenterZ,'facealpha',ballAlpha,'edgeAlpha',ballAlpha,'facecolor',ballColor)
