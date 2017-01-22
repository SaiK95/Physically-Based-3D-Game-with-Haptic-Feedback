% TEST CASES
virtual_environment_team216

%% Platform boundary test cases
global platformMinX;
global platformPositionZ;
global platformThickness;
global platformWidth;
global platformOffsetY;
platformMaxX = platformMinX + platformWidth;

platformXC = (platformMinX + platformMaxX)/2;
platformYC = (platformWidth/2)+platformOffsetY;
platformZC = platformPositionZ-(platformThickness/2);

test_cases_platform = [...
                    platformXC      platformYC                          platformPositionZ+1                          0;...
                    platformMinX-1  platformYC                          platformZC                                   0;...
                    platformXC      platformYC                          platformPositionZ-platformThickness-1        0;...
                    platformMaxX+1  platformYC                          platformZC                                   0;...
                    platformXC      platformOffsetY+platformWidth+1     platformZC                                   0;...
                    platformXC      platformOffsetY-1                   platformZC                                   0;...
                    platformXC      platformYC                          platformZC+1                                 1;...
                    platformXC      platformYC                          platformZC-1                                -1;...
                    platformXC      platformYC                          platformPositionZ-1                          1;...
                    platformXC      platformYC                          platformPositionZ-platformThickness+1       -1;... 
                ];

for i=1:size(test_cases_platform,1)
    
    if (check_platform_boundary_team216(test_cases_platform(i,1:3)) ~= (test_cases_platform(i,4)))
        
        fprintf('Test case %d failed for platform\n', i)
        
    end
    
end

fprintf('platform boundary tests complete\n')

%% Water boundary test cases
global waterHeight;
global waterMinX;
global waterMinY;
global waterWidth;
waterMaxX = waterMinX + waterWidth;
waterMaxY = waterMinY + waterWidth;
    

waterXC = (waterMinX + waterMaxX)/2;
waterYC = (waterMinY+waterMaxY)/2;
waterZC = 0 + (waterHeight/2);

test_cases_water = [   
                    waterXC      waterYC    waterZC                 1;
                    waterXC      waterYC    waterZC+waterHeight     0;
                ];

for i=1:size(test_cases_water,1)
    
    if (check_water_boundary_team216(test_cases_water(i,1:3)) ~= (test_cases_water(i,4)))
        
        fprintf('Test case %d failed for water\n', i)
        
    end
    
end

fprintf('water boundary tests complete\n')

%% Hole boundary test cases
global startHolePositionX;
global startHolePositionY;
global startHolePositionZ;
global startBottomHolePositionZ;

global holePositionX;
global holePositionY;

global holePositionZ;
global bottomHolePositionZ;    

startHoleXC = startHolePositionX;
startHoleYC = startHolePositionY;

holeXC = holePositionX;
holeYC = holePositionY;

test_cases_hole = [   
                    startHoleXC         startHoleYC         startHolePositionZ+1                0;
                    startHoleXC         startHoleYC         startHolePositionZ-1                1;
                    startHoleXC         startHoleYC         startBottomHolePositionZ-1          0;
                    startHoleXC         startHoleYC         startBottomHolePositionZ+1          1;
                    holeXC              holeYC              holePositionZ+1                     0;
                    holeXC              holeYC              holePositionZ-1                     1;
                    holeXC              holeYC              bottomHolePositionZ-1               0;
                    holeXC              holeYC              bottomHolePositionZ+1               1;
                ];

for i=1:size(test_cases_hole,1)
    
    if (check_hole_boundary_team216(test_cases_hole(i,1:3)) ~= (test_cases_hole(i,4)))
        
        fprintf('Test case %d failed for hole\n', i)
        
    end
    
end

fprintf('hole boundary tests complete\n')

%% Button boundary test cases
global buttonWidth;
global buttonMinX;
global buttonMinY;
global buttonZ;
global buttonHeight;
buttonMaxX = buttonMinX + buttonWidth;
buttonMaxY = buttonMinY + buttonWidth; 

buttonXC = (buttonMinX+buttonMaxX)/2;
buttonYC = (buttonMinY+buttonMaxY)/2;

test_cases_button = [   
                    buttonXC         buttonYC         buttonZ+buttonHeight+1                0;
                    buttonXC         buttonYC         buttonZ+buttonHeight-1                1;
                    buttonXC         buttonYC         buttonZ-1                             0;
                    buttonXC         buttonYC         buttonZ+1                             0;
                ];

for i=1:size(test_cases_button,1)
    
    if (check_button_boundary_team216(test_cases_button(i,1:3)) ~= (test_cases_button(i,4)))
        
        fprintf('Test case %d failed for button\n', i)
        
    end
    
end

fprintf('button boundary tests complete\n')

%% Button boundary test cases

global roomMinX;
global roomMaxX;
global roomMinY;
global roomMaxY;
global roomMinZ;
global roomMaxZ;

global ZMIN_WALL;
global ZMAX_WALL;
global XMIN_WALL;
global XMAX_WALL;
global YMIN_WALL;
global YMAX_WALL;

roomXC = (roomMinX + roomMaxX)/2;
roomYC = (roomMinY + roomMaxY)/2;
roomZC = (roomMinZ + roomMaxZ)/2;

test_cases_room = [   
                    roomXC          roomYC        roomMinZ-1          ZMIN_WALL;
                    roomXC          roomYC        roomMaxZ+1          ZMAX_WALL;
                    roomXC          roomMinY-1    roomZC              YMIN_WALL;
                    roomXC          roomMaxY+1    roomZC              YMAX_WALL;
                    roomMinX-1      roomYC        roomZC              XMIN_WALL;
                    roomMaxX+1      roomYC        roomZC              XMAX_WALL;
                    roomXC          roomYC        roomZC              0;
                ];

for i=1:size(test_cases_room,1)
    
    if (check_room_boundary_team216(test_cases_room(i,1:3)) ~= (test_cases_room(i,4)))
        
        fprintf('Test case %d failed for room\n', i)
        
    end
    
end

fprintf('room boundary tests complete\n')