% This is the top script that will run ROSnode and call all the functions

% 78-82, 95-103, 14-15


%% 1. Initializing
clc;
close all;
clear;


%% 2. Run ROS Node
rosshutdown;
% rosinit('http://192.168.1.1:11311');
rosinit('http://localhost:11311');
r = robotics.Rate(30);


%% 3. Create 4 Camera Objects & Subscribers
nn_cam = CameraModel([-5,-5],[384,640,3]);
np_cam = CameraModel([-5,5],[384,640,3]);
pn_cam = CameraModel([5,-5],[384,640,3]);
pp_cam = CameraModel([5,5],[384,640,3]);

nn_sub = rossubscriber('/nn_cam/image_raw');
np_sub = rossubscriber('/np_cam/image_raw');
pn_sub = rossubscriber('/pn_cam/image_raw');
pp_sub = rossubscriber('/pp_cam/image_raw');

GT_sub = rossubscriber('/ground_truth/state');


%% 4. Setup for Plotting
% Enviroment Plotting.
t = -6:0.01:6;
fig = figure(1); grid on; hold on; view(3);
plot3(0.*t+5,t,0.*t,'b'); plot3(0.*t-5,t,0.*t,'b'); plot3(t,0.*t+5,0.*t,'b'); plot3(t,0.*t-5,0.*t,'b');
fill3([-6,6,6,-6],[-6,-6,6,6],[0,0,0,0],'g'); alpha(0.3); % adss a green floor
cams = stem3(0,0,0,'--blacksquare','filled');
set(cams,'xdata',[-5,-5,5,5],'ydata',[-5,5,-5,5],'zdata',[2,2,2,2]);
zlim([0 3]); xlim([-6 6]); ylim([-6 6]);

% Drone Plotting.
drone_ph = [0,0,0];% Drone Place Holder
trackHead = stem3(drone_ph(1),drone_ph(2),drone_ph(3),'-.or','filled');
trackTail = plot3(drone_ph(1),drone_ph(2),drone_ph(3),'r','LineWidth',2);

a = [-5,-5,2;drone_ph(end,:)];
b = [-5,5,2;drone_ph(end,:)];
c = [5,-5,2;drone_ph(end,:)];
d = [5,5,2;drone_ph(end,:)];

A = plot3(a(:,1),a(:,2),a(:,3),'b');
B = plot3(b(:,1),b(:,2),b(:,3),'b');
C = plot3(c(:,1),c(:,2),c(:,3),'b');
D = plot3(d(:,1),d(:,2),d(:,3),'b');


%% 5. The MAIN LOOP
while true
    %% 6. Receive camera data & Location Data
    nn_cam.frame = readImage(receive(nn_sub));
    np_cam.frame = readImage(receive(np_sub));
    pn_cam.frame = readImage(receive(pn_sub));
    pp_cam.frame = readImage(receive(pp_sub));

    nn_cam.findDrone();
    np_cam.findDrone();
    pn_cam.findDrone();
    pp_cam.findDrone();

    
    %% 7. Compute the line equations from all objects
    
    
    %% 8. Find the closest point of all four lines
    
    
    %% 9. %% %% Apply Kalman Filtering on the found data.


    %% 10. Plotting 
    % Temporary % % % % % % %
%     updated_x = drone_ph(end,1)+0.001;
%     updated_y = drone_ph(end,2)+0.001;
%     updated_z = drone_ph(end,3)+0.001;
    updated_x = pp_cam.drone_pose(1);
    updated_y = pp_cam.drone_pose(2);
    updated_z = pp_cam.drone_pose(3);
    % % % % % % % % % % % % %

    drone_ph = [drone_ph; [updated_x updated_y updated_z]];

    a = [-5,-5,2;drone_ph(end,:)];
    b = [-5,5,2;drone_ph(end,:)];
    c = [5,-5,2;drone_ph(end,:)];
    d = [5,5,2;drone_ph(end,:)];

    set(A,'xdata',a(:,1),'ydata',a(:,2),'zdata',a(:,3));
    set(B,'xdata',b(:,1),'ydata',b(:,2),'zdata',b(:,3));
    set(C,'xdata',c(:,1),'ydata',c(:,2),'zdata',c(:,3));
    set(D,'xdata',d(:,1),'ydata',d(:,2),'zdata',d(:,3));

    set(trackTail,'xdata',drone_ph(:,1),'ydata',drone_ph(:,2),'zdata',drone_ph(:,3));
    set(trackHead,'xdata',drone_ph(end,1),'ydata',drone_ph(end,2),'zdata',drone_ph(end,3));

    
    %% 12. Go back to 5th step
    waitfor(r);
    
    % Subject to scrutiny % % %
    if strcmp(get(fig,'CurrentCharacter'),' ')
        close(fig);
        break
    end

    figure(fig)
    drawnow
    % % % % % % % % % % % % % %
end

rosshutdown;