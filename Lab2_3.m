
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
       
        [returncode1, LinearAct]=vrep.simxGetObjectHandle(clientID,'Prismatic_joint',vrep.simx_opmode_blocking);
        [returncode2,Visionsensor]=vrep.simxGetObjectHandle(clientID,'Vision_sensor',vrep.simx_opmode_blocking); 
      
        x=1;
        for i=1:100000
           
            [returncode3,resolution,I]=vrep.simxGetVisionSensorImage2(clientID,Visionsensor,0,vrep.simx_opmode_streaming);
            imshow(I)
            
            I=matrix_image;
            if max(I(:))==255
                Ib=I(:,:,3);
                Ib1=double(Ib);
                [Gx,Gy]=gradient(Ib1);    
                M = sqrt(Gx.^2+Gy.^2);    
                M = M./max(M(:));
                
                %Edge detection with thresholding
                
                Ip = M<0.02;
                conn = bwconncomp(Ip,8);
                nobj = conn.NumObjects;
                L = zeros(1,nobj);
                
                for i=1:nobj
                     L(i) = length(conn.PixelIdxList{i});
                end
                
                
                
                
        end
end
        
        
        
       
        