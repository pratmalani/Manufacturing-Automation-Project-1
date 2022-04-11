%% Joseph Distefano 
% Manufactuirng Automation
% Lab 2: Automated Rejecting Conveyor System

close all; clear all; clc

%% Connecting to V-rep 

disp('Program started'); %Declare start of program

vrep=remApi('remoteApi'); %Remote connection to API
vrep.simxFinish(-1);  %Close all other ports and connections
clientID=vrep.simxStart('127.0.0.1',19999,true,true,5000,5); %Start V-rep simulation 
% [returnCode] = vrep.simxsynchronous(clientID,1);
% vrep.simxStart(19999,vrep.simx_opmode_blocking);


%% Knocking off all of the objects with the linear actuator

if (clientID>-1)
    disp('Connected to remote API server');
        
        pos = {[-0.7 .02 .55]; [-.5 -.02 .55] ; [-.3 0 .55] ; [-.1 0 .55] ; [.1 .01 .55] ; [.3 -.01 .55]}
        order = randperm(6);
        [returnCode0, item1] = vrep.simxGetObjectHandle(clientID,'Cuboid',vrep.simx_opmode_blocking);
        [returnCode01,item2] = vrep.simxGetObjectHandle(clientID,'Cuboid0',vrep.simx_opmode_blocking);
        [returnCode02, item3] = vrep.simxGetObjectHandle(clientID,'Cuboid1',vrep.simx_opmode_blocking);
        [returnCode03, item4] = vrep.simxGetObjectHandle(clientID,'Cylinder',vrep.simx_opmode_blocking);
        [returnCode04, item5] = vrep.simxGetObjectHandle(clientID,'Cylinder0',vrep.simx_opmode_blocking);
        [returnCode05, item6] = vrep.simxGetObjectHandle(clientID,'Cylinder1',vrep.simx_opmode_blocking);        
        [returnCodep0]= vrep.simxSetObjectPosition(clientID,item1,-1,cell2mat(pos(order(1))),vrep.simx_opmode_oneshot);
        [returnCodep1]= vrep.simxSetObjectPosition(clientID,item2,-1,cell2mat(pos(order(2))),vrep.simx_opmode_oneshot);
        [returnCodep2]= vrep.simxSetObjectPosition(clientID,item3,-1,cell2mat(pos(order(3))),vrep.simx_opmode_oneshot);
        [returnCodep3]= vrep.simxSetObjectPosition(clientID,item4,-1,cell2mat(pos(order(4))),vrep.simx_opmode_oneshot);
        [returnCodep4]= vrep.simxSetObjectPosition(clientID,item5,-1,cell2mat(pos(order(5))),vrep.simx_opmode_oneshot);
        [returnCodep5]= vrep.simxSetObjectPosition(clientID,item6,-1,cell2mat(pos(order(6))),vrep.simx_opmode_oneshot);
        [returnCodes1, prox1] = vrep.simxGetObjectHandle(clientID,'Proximity_sensor',vrep.simx_opmode_blocking);
        [returnCodes2, prox2] = vrep.simxGetObjectHandle(clientID,'Proximity_sensor0',vrep.simx_opmode_blocking);
        [returncodea1, LinearAct]=vrep.simxGetObjectHandle(clientID,'Prismatic_joint',vrep.simx_opmode_blocking);

        t=0;
        tic;
        while t<30
            t=toc;
            [returncodesj1,detectionState,detectedPoint]= vrep.simxReadProximitySensor(clientID,prox2,vrep.simx_opmode_blocking);
          
            if detectionState==1  
                vrep.simxSetJointPosition(clientID,LinearAct,0.2,vrep.simx_opmode_blocking);
            else
                vrep.simxSetJointPosition(clientID,LinearAct,0.0,vrep.simx_opmode_blocking);
            end
        end
        
            
            
        

end

   
        
       
       
       

