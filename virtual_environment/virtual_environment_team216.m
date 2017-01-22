%% virtual_environment_team216
%
% This script is the starter code for Part 2 of Project 2, where you
% build an interactive virtual environment that can be touched using
% the Phantom.
%
% Written by Katherine J. Kuchenbecker for MEAM 520 at the University
% of Pennsylvania.

%% Instructions, and comments about the game
% small dot -> A red dot that tracks user position is present
% flat virtual surface -> We have the walls of the room and the platform 
%       which have a spring force that acts on the user and ball
% viscous friction -> The water below the platform and in the holes of 
%       the platform
% haptic texture -> The laser wall 'zaps' the user when he touches it. 
%       The platform has a fritction force associated with it which gives 
%       it a texture. Try rubbing the top or bottom of the platform.
% button -> 'click' the button to release the ball
% ball -> 'kick' the ball into the goal!
% attractive point -> The water hole on the left of the platform has an 
%       attractive force at the bottom to direct the user towards it
% 
% HOW TO PLAY
% 
% The user starts in the water in zero pose. He must navigate through the 
% water holes to reach the button. Once he clicks the button the ball drops
% down and becomes active. He then must navigate to the ball.
% DANGER - He must avoid the 'laser wall', the game ends if the user touches
% the wall
% To win, the user must kick the ball into the goal.
%%


%% Clean up

clear
close all
clc


%% Set hardware mode, duration, and warnings

% Set whether to use the actual PHANToM hardware.  If this variable is
% set to false, the software will simulate the presence of a user by
% reading a pre-recorded trajectory.  You should use this mode to
% debug your code before running anything on the PHANToM computer.
% Once you are on the PHANToM/PUMA computer in Towne B2, you may set
% this variable to true.  Be sure to run your code with the emergency
% stop down to prevent the application of forces to make sure
% everything works correctly on the real robot.  Make sure to hold
% onto the PHANToM tightly and keep a hand on the emergency stop.
hardware = true;

% Set how many times we want our servo loop to run.  Each cycle takes
% about two milliseconds on the computer in Towne B2.
nCycles = 10000000;

% If not using the hardware, turn off warnings triggered when you
% command joint torques above the limits.
if (~hardware)
    warning('off','PHANToM:JointTorque')
else
    warning('on','PHANToM:JointTorque')
end


%% Define global variables for keyboard control

global keyacctime amag adur

% A matrix that holds the list of currently active pulses applied by
% the keyboard.  Each time the user presses a key, an additional pulse
% is added to the right side of this 5 x n matrix.  The first three
% rows are acceleration in x, y, and z directions.  The fourth row is
% the time when the pulse starts, and the last row is the time when
% the pulse ends.  The minimum number of columns is one, with a zero
% acceleration pulse that is always active.
keyacctime = [0 0 0 0 inf]'; % mm/s^2, mm/s^2, mm/s^2, s, s

% Set the magnitude of the acceleration pulse caused by a key press.
amag = 10; % mm/s^2

% Set the duration of the acceleration pulse caused by a key press.
adur = 0.25; % s


% PUT MORE VARIABLES HERE

% Set the scale of the force vector in millimeters per newton.
fScale = 40;


%% Set up the figure for graphing

% Open figure 1 and clear it, keeping the handle.
f = figure(1);
clf

% Plot a small red dot to represent the position of the PHANToM.  For
% now, we just put it at the origin.  We keep the handle to this plot
% (hPhantomDot) so that we can move the dot later.
hPhantomDot = plot3(0, 0, 0,'r.','markersize',15);

% Call tic to latch the time.
masterTime = tic;
tic;

% If we are not using hardware, set the key press function to enable
% keyboard control of the virtual Phantom.
if (~hardware)
    set(f,'keypressfcn',@setAccTime)
end

% Turn hold on to let us put more things on the graph.
hold on

% Plot a thick black line to represent the force vector.  For now, we
% just have it go from the origin to [10 10 10]; later we will set it
% to be a scaled version of the commanded force vector.  We keep the
% handle to this plot (hForceLine) so we can move the line later.
hForceLine = plot3([0 10], [0 10], [0 10],'k-','linewidth',2);
hBallForceLine = plot3([0 10], [0 10], [0 10],'k-','linewidth',2);

% Set the axis limits, the viewing direction, and other properties of
% the view.
global roomMinX; roomMinX = 66;
global roomMaxX; roomMaxX = 200;
global roomMinY; roomMinY = -67;
global roomMaxY; roomMaxY = 67;
global roomMinZ; roomMinZ = 0;
global roomMaxZ; roomMaxZ = 200;

axis equal vis3d
axstep = 50;
axis([roomMinX roomMaxX roomMinY roomMaxY roomMinZ roomMaxZ])
view(86,10)
box on
grid on

% Label the axes.
xlabel('X (mm)')
ylabel('Y (mm)')
zlabel('Z (mm)')


%% Draw the graphics
setup_static_env_team216

%% Do final preparations

% Start the Phantom, passing in hardware (true or false).
phantomStart(hardware)

% Initialize a vector to hold the time stamp for each cycle.
t = zeros(nCycles,1);

% Initialize vectors to store tip position and force output for each
% cycle.
hx_history = zeros(nCycles,1);
hy_history = zeros(nCycles,1);
hz_history = zeros(nCycles,1);
Fx_history = zeros(nCycles,1);
Fy_history = zeros(nCycles,1);
Fz_history = zeros(nCycles,1);

% Initialize a variableCOG to hold the last time the graphics update was
% run.
lastGraphicsTime = 0;

% We need a flag to check first iteration of ball
ballFirstItr = 0;

%% Run the servo loop
for i = 1:nCycles
    % Measure the time and store it in our vector of time stamps.  
    % The units are seconds.
    t(i) = toc(masterTime);
    
    % Get the Phantom's joint angles in radians.
    theta123 = phantomJointAngles;

    % Use these joint angles to calculate the Phantom's tip position
    % in millimeters.
    pos = phantomTipPosition(theta123);
    
    % Split out the x, y, and z components of the tip position.
    hx = pos(1);
    hy = pos(2);
    hz = pos(3);
    
    ball_pos = [ballCenterX ballCenterY ballCenterZ]';
    % Check the haptic device's position against the location of the
    % different objects in the virtual environment, and calculate the
    % three components of the force.
    % YOU NEED TO WRITE THIS...
    
    % Compute velocity and acceleration
    if i == 1
        % Start timer
        velTime = tic;
        vel = [0 0 0];
        acc = [0 0 0];
        ball_vel = [0 0 0];
        ball_acc = [0 0 0];
        
    elseif i ~= 1
       
        time_elapsed = toc(velTime);
        
        prevVel = vel;
        
        vel(1) = (hx - hx_history(i-1))/time_elapsed;
        vel(2) = (hy - hy_history(i-1))/time_elapsed;
        vel(3) = (hz - hz_history(i-1))/time_elapsed;
        acc(1) = (vel(1) - prevVel(1))/time_elapsed;
        acc(2) = (vel(2) - prevVel(2))/time_elapsed;
        acc(3) = (vel(3) - prevVel(3))/time_elapsed;
        
        velTime = tic;
        
    end
    
    % Set the force components to zero for now.
    F_room = room_forces_team216(pos, vel, acc, userMass);
    F_platform = platform_forces_team216(pos, vel, acc, userMass);
    F_water = water_forces_team216(pos, vel, acc, userMass, userVolume, userRoh);
    F_button = button_forces_team216(pos, vel, acc, userMass);
    F_weight = calculate_weight_force_team216(userMass);
    F_laserwall = laserwall_forces_team216(pos, vel, acc, userMass);
    F_COG = COG_forces_team216(pos, COG_pos);
    Fx = F_room(1) + F_platform(1) + F_water(1) + F_button(1) + F_weight(1) + F_laserwall(1) + F_COG(1);
    Fy = F_room(2) + F_platform(2) + F_water(2) + F_button(2) + F_weight(2) + F_laserwall(2) + F_COG(2);
    Fz = F_room(3) + F_platform(3) + F_water(3) + F_button(3) + F_weight(3) + F_laserwall(3) + F_COG(3);
    
    % Forces on the ball
    Fball_room = room_forces_team216(ball_pos, ball_vel, ball_acc, ballMass);
    Fball_platform = platform_forces_team216([ball_pos(1) ball_pos(2) ball_pos(3)-ballRadius]', ball_vel, ball_acc, ballMass);
    Fball_water = water_forces_team216(ball_pos, ball_vel, ball_acc, ballMass, userVolume, userRoh);
    Fball_weight = calculate_weight_force_team216(ballMass);
    Fball_laserwall = laserwall_forces_team216(ball_pos, ball_vel, ball_acc, ballMass);
	Fball_user = user_2_ball_force_team216(pos, vel, ball_pos);
    Fball_COG = COG_forces_team216(ball_pos, COG_pos);
    ball_Fx = Fball_room(1) + Fball_platform(1) + Fball_water(1) + Fball_weight(1) + Fball_laserwall(1) + Fball_user(1) + Fball_COG(1);
    ball_Fy = Fball_room(2) + Fball_platform(2) + Fball_water(2) + Fball_weight(2) + Fball_laserwall(2) + Fball_user(2) + Fball_COG(2);
    ball_Fz = Fball_room(3) + Fball_platform(3) + Fball_water(3) + Fball_weight(3) + Fball_laserwall(3) + Fball_user(3) + Fball_COG(3);
    
    % Equal and opposite force on user from ball
    Fx = Fx - Fball_user(1);
    Fy = Fy - Fball_user(2);
    Fz = Fz - Fball_user(3);
    
    % Command the calculated tip force, also providing the joint
    % angles.
    phantomTipForce(Fx, Fy, Fz, theta123);
        
    % Store this cycle's values in the history vectors.
    hx_history(i) = hx;
    hy_history(i) = hy;
    hz_history(i) = hz;
    Fx_history(i) = Fx;
    Fy_history(i) = Fy;
    Fz_history(i) = Fz;
    
    % Check how much time has elapsed since we last updated the
    % graphics.
    if (t(i) - lastGraphicsTime > 0.03)
        % Enough time has passed.
        
        % Update the graph by setting the data for the PHANToM's dot
        % to the position of the haptic device.
        set(hPhantomDot, 'xdata', hx, 'ydata', hy, 'zdata', hz)

        % Update the graph by setting the data for the force line to
        % show a scaled version of the commanded force.
        set(hForceLine,'xdata',[hx hx+Fx*fScale],'ydata',[hy hy+Fy*fScale], 'zdata',[hz hz+Fz*fScale]);
        set(hBallForceLine,'xdata',[ballCenterX ballCenterX+ball_Fx*fScale],'ydata',[ballCenterY ballCenterY+ball_Fy*fScale], 'zdata',[ballCenterZ ballCenterZ+ball_Fz*fScale]);
        
        % Update ball based on physics
        if ballActivated == 1
            update_ball_physics_team216
        end
        
        % Store this time for future comparisons.
        lastGraphicsTime = t(i);
    end
    
    % If user scores a goal, game should stop
    if check_goal_boundary_team216(ball_pos) == 1
       
        disp('Good goal!')
        set(hBall,'xdata',ballRadius*xsphere+ballCenterX,'ydata',ballRadius*ysphere+ballCenterY,'zdata',ballRadius*zsphere+ballCenterZ,'facealpha',ballAlpha,'edgeAlpha',ballAlpha,'facecolor',[0 0 1])
        break
        
    end
    
    % If user collides with laser, game should end.
    if check_laserwall_boundary_team216(pos) == 1
        
        gameOver = 1;
        
        % Easter egg ;) Happy holidays!
        text(platformMinX,platformOffsetY,platformPositionZ + wallHeight + 20, 'Success without integrity is failure. No shorcuts please!','HorizontalAlignment','left','FontSize',50);
        
    end
    
    % Stop the game after gameOverItr number of iterations
    if gameOver == 1
       
        gameOverItr = gameOverItr - 1;
        
        if gameOverItr < 0
           
            disp('Game Over! Do not touch the laser wall!')
            break
            
        end
        
    end
    
    % Pause for one millisecond to keep things moving at a reasonable
    % pace.
    pause(.001)
end

% Stop the Phantom.
phantomStop


%% Plot the results

% Open figure 2 and clear it.
figure(2)
clf

% Plot positions over time in the top subplot.
subplot(2,1,1)
h = plot(t,[hx_history hy_history hz_history]);
set(h(1),'color',[0 .7 .7])
set(h(2),'color',[.7 .7 0])
set(h(3),'color',[.7 0 .7])
xlabel('Time (s)')
ylabel('Tip Position (mm)')
legend('h_x', 'h_y', 'h_z')

% Plot forces over time in the bottom subplot.
subplot(2,1,2)
h = plot(t,[Fx_history Fy_history Fz_history]);
set(h(1),'color',[0 .7 .7])
set(h(2),'color',[.7 .7 0])
set(h(3),'color',[.7 0 .7])
xlabel('Time (s)')
ylabel('Force (N)')
legend('F_x', 'F_y', 'F_z')