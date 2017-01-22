%% Game over flag
gameOver = 0;
gameOverItr = 30;

%% Define the virtual environment

global gravity; gravity = 9.8;
userMass = 0.01;
userVolume = 2;
userRoh = 0.01;
zShift = 150;

%% Plot the platform.

% The vertical position of the floor in millimeters.
global platformMinX;            platformMinX = 66;
global platformPositionZ;       platformPositionZ = zShift;
global platformThickness;       platformThickness = 50;
global platformWidth;           platformWidth = 200-66;
global platformOffsetY;         platformOffsetY = -(platformWidth/2);
global platformSpringCoeff;     platformSpringCoeff = 0.5;
global roomSpringCoeff;         roomSpringCoeff = 0.5;
global platformFrictionCoeff;   platformFrictionCoeff = 0.01;
% Set the color of the floor.
platformColor = [0.77 0.60 0];

% Set the alpha (transparency) of the floor.
platformAlpha = 1.0;

x=[0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]*platformWidth;
x=x+platformMinX;
y=[0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]*platformWidth;
y = y+platformOffsetY;
z=[0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]*-platformThickness;
z = z+zShift;
for i=1:6
    h=fill3(x(:,i),y(:,i),z(:,i),platformColor);
    set(h,'facealpha',platformAlpha)
end

%% Plot walls.
% The vertical position of the floor in millimeters.
global wallHeight; wallHeight = 40;
global wallThickness; wallThickness = 3;
global bottomWallY; bottomWallY = -(platformWidth/6);
topWallY = (platformWidth/6);

% Set the color of the floor.
wallColor = [0.8 0.2 0.2];

% Set the alpha (transparency) of the floor.
wallAlpha = 0.25;

% Plot bottom wall
x=[0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]*platformWidth;
x=x+platformMinX;
y=[0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]*wallThickness;
y = y+bottomWallY;
z=[0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]*wallHeight;
z = z+zShift;
for i=1:6
    h=fill3(x(:,i),y(:,i),z(:,i),wallColor);
    set(h,'facealpha',wallAlpha)
end

%% Fill water
global waterHeight; waterHeight = zShift;
global waterMinX; waterMinX = platformMinX;
global waterMinY; waterMinY = platformOffsetY;
global waterWidth; waterWidth = platformWidth;
global waterViscousCoeff; waterViscousCoeff = 0.0008;

waterColor = [0 .5 1];
waterAlpha = 0.1;

x=[0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]*waterWidth;
x = x+waterMinX;
y=[0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]*waterWidth;
y = y+waterMinY;
z=[0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]*waterHeight;
for i=1:6
    h=fill3(x(:,i),y(:,i),z(:,i),waterColor);
    set(h,'facealpha',waterAlpha)
end

%% Plot the first hole
global startHoleOffsetX;    startHoleOffsetX = -20;
global startHolePositionX;  startHolePositionX = platformMinX + ((platformWidth)/2) - startHoleOffsetX;
global startHolePositionY;  startHolePositionY = platformOffsetY + ((bottomWallY-platformOffsetY)/2);
global halfStartHoleSize;   halfStartHoleSize = 15;

global startHolePositionZ;          startHolePositionZ = platformPositionZ+1;
global startBottomHolePositionZ;    startBottomHolePositionZ = platformPositionZ-platformThickness-1;

% Set the alpha (transparency) of the hole.
holeAlpha = 0.7;

% Above the platform
hHoleM = fill3([startHolePositionX-halfStartHoleSize startHolePositionX-halfStartHoleSize startHolePositionX+halfStartHoleSize startHolePositionX+halfStartHoleSize], [startHolePositionY-halfStartHoleSize startHolePositionY+halfStartHoleSize startHolePositionY+halfStartHoleSize startHolePositionY-halfStartHoleSize], ...
    startHolePositionZ*[1 1 1 1], waterColor);
set(hHoleM,'facealpha', holeAlpha)

% Below the platform
hHoleM = fill3([startHolePositionX-halfStartHoleSize startHolePositionX-halfStartHoleSize startHolePositionX+halfStartHoleSize startHolePositionX+halfStartHoleSize], [startHolePositionY-halfStartHoleSize startHolePositionY+halfStartHoleSize startHolePositionY+halfStartHoleSize startHolePositionY-halfStartHoleSize], ...
    startBottomHolePositionZ*[1 1 1 1], waterColor);
set(hHoleM,'facealpha', holeAlpha)

%% Plot the middle hole
global holeOffsetX;         holeOffsetX = -20;
global holePositionX;       holePositionX = platformMinX + ((platformWidth)/2) - holeOffsetX;
global holePositionY;       holePositionY = bottomWallY + ((topWallY-bottomWallY)/2);
global halfHoleSize;        halfHoleSize = 15;

global holePositionZ;       holePositionZ = platformPositionZ+1;
global bottomHolePositionZ; bottomHolePositionZ = platformPositionZ-platformThickness-1;

% Set the alpha (transparency) of the hole.
holeAlpha = 0.7;

% Above the platform
hHoleM = fill3([holePositionX-halfHoleSize holePositionX-halfHoleSize holePositionX+halfHoleSize holePositionX+halfHoleSize], [holePositionY-halfHoleSize holePositionY+halfHoleSize holePositionY+halfHoleSize holePositionY-halfHoleSize], ...
    holePositionZ*[1 1 1 1], waterColor);
set(hHoleM,'facealpha', holeAlpha)

% Below the platform
hHoleM = fill3([holePositionX-halfHoleSize holePositionX-halfHoleSize holePositionX+halfHoleSize holePositionX+halfHoleSize], [holePositionY-halfHoleSize holePositionY+halfHoleSize holePositionY+halfHoleSize holePositionY-halfHoleSize], ...
    bottomHolePositionZ*[1 1 1 1], waterColor);
set(hHoleM,'facealpha', holeAlpha)

%% Center of attraction
global COG_constant; COG_constant = 0.01;
global COG_radius; COG_radius = halfHoleSize*4;
COG_pos = [startHolePositionX startHolePositionY startBottomHolePositionZ]';

%% Plot button.
global buttonWidth; buttonWidth = 10;
global buttonOffsetFromHoleX; buttonOffsetFromHoleX = -50;
global buttonMinX; buttonMinX = holePositionX+buttonOffsetFromHoleX;
global buttonMinY; buttonMinY = startHolePositionY-(buttonWidth/2);
global buttonZ; buttonZ = platformPositionZ + 1;
global buttonHeight; buttonHeight = 10;
global buttonSpringCoeff; buttonSpringCoeff = 0.2;

x=[0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]*buttonWidth;
x = x+buttonMinX;
y=[0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]*buttonWidth;
y = y+buttonMinY;
z=[0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]*buttonHeight;
z=z+buttonZ;

buttonColor = [1 0 0];
buttonAlpha = 1.0;

for i=1:6
    h=fill3(x(:,i),y(:,i),z(:,i),buttonColor);
    set(h,'facealpha',buttonAlpha)
end

%% Plot goal posts
goalOffsetX = 60;
global goalPostX;           goalPostX = platformMinX + ((platformWidth)/2) - goalOffsetX;
global goalPostThickness;   goalPostThickness = 10;
global goalPostLength;      goalPostLength = 30;
goalPostYOffset = 10;
global goalPostY;           goalPostY = topWallY + goalPostYOffset;
global goalPostHeight;      goalPostHeight = 25;

goalColor = [0 1 0];
goalAlpha = 0.6;

x=[0 1 1 0 0 0;1 1 0 0 1 1;1 1 0 0 1 1;0 1 1 0 0 0]*goalPostThickness;
x = x+goalPostX;
y=[0 0 1 1 0 0;0 1 1 0 0 0;0 1 1 0 1 1;0 0 1 1 1 1]*goalPostLength;
y = y+goalPostY;
z=[0 0 0 0 0 1;0 0 0 0 0 1;1 1 1 1 0 1;1 1 1 1 0 1]*goalPostHeight;
z= z+platformPositionZ;
for i=[ 1 3 4 6 ]
    h=fill3(x(:,i),y(:,i),z(:,i),goalColor);
    set(h,'facealpha',goalAlpha)
end

%% Plot sphere

% The location of the center of the ball, relative to the origin of
% the Phantom's coordinate frame.  X is positive toward the user, Y is
% positive to the right, and Z is positive up. All dimensions are in
% millimeters.
% Set the radius of the ball in millimeters..
ballMass = 0.01;
global userBallForceScale; userBallForceScale = 0.1;
global ballRadius; ballRadius = 5;
battStartZ = 20;
ballCenterOffsetX = -30;
global ballCenterX; ballCenterX = platformMinX + ((platformWidth)/2) - ballCenterOffsetX;
global ballCenterY; ballCenterY = topWallY + goalPostYOffset + (goalPostLength/2);
global ballCenterZ; ballCenterZ = platformPositionZ+ballRadius+battStartZ;
global ballActivated; ballActivated = 0;
% Set the color of the ball.
ballColor = [1.0 0.2 0];

% Set the alpha (transparency) of the ball.
ballAlpha = 1.0;

% Get the coordinates of the points on a unit sphere with resolution
% 20.
[xsphere, ysphere, zsphere] = sphere(20);

% Plot the ball as a surface at its center location, with its radius.
hBall = surf(ballRadius*xsphere+ballCenterX, ballRadius*ysphere+ballCenterY, ballRadius*zsphere+ballCenterZ);

% Set the transparency of the ball's faces and edges.
set(hBall,'facealpha',ballAlpha,'edgeAlpha',ballAlpha,'facecolor',ballColor)

% Turn hold off to stop allowing more graphing.
hold off

