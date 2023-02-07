% This is the top script that will run ROSnode and call all the functions



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
nn_cam = CameraModel([-5,-5],[768,1280,3]);
np_cam = CameraModel([-5,5],[768,1280,3]);
pn_cam = CameraModel([5,-5],[768,1280,3]);
pp_cam = CameraModel([5,5],[768,1280,3]);

nn_sub = rossubscriber('/nn_cam/image_raw');
np_sub = rossubscriber('/np_cam/image_raw');
pn_sub = rossubscriber('/pn_cam/image_raw');
pp_sub = rossubscriber('/pp_cam/image_raw');

GT_sub = rossubscriber('/ground_truth/state');


%% 4. Setup for Plotting
% Enviroment Plotting.
t = -6:0.01:6;
figure(1); grid on; hold on; view(3);
plot3(0.*t+5,t,0.*t,'b'); plot3(0.*t-5,t,0.*t,'b'); plot3(t,0.*t+5,0.*t,'b'); plot3(t,0.*t-5,0.*t,'b');
fill3([-6,6,6,-6],[-6,-6,6,6],[0,0,0,0],'g'); alpha(0.3); % adss a green floor
cams = stem3(0,0,0,'--blacksquare','filled');
set(cams,'xdata',[-5,-5,5,5],'ydata',[-5,5,-5,5],'zdata',[2,2,2,2]);
zlim([0 3]); xlim([-6 6]); ylim([-6 6]);

% Drone Plotting.
drone_ph = [0,0,0];% Drone Place Holder
trackHead = stem3(drone_ph(1),drone_ph(2),drone_ph(3),'-.or','filled');
trackTail = plot3(drone_ph(1),drone_ph(2),drone_ph(3),'r','LineWidth',2);


%% 5. The MAIN LOOP
while true

    %% 6. Receive camera data & Location Data
    
    
    %% 7. Pass the frame data from ROS to camera objects
    
    
    %% 8. Compute the line equations from all objects
    
    
    %% 9. Find the closest point of all four lines
    
    
    %% 10. %% %% Apply Kalman Filtering on the found data.


    %% 11. Plotting 
    a = [-5,-5,2;drone_ph(end,:)];
    b = [-5,5,2;drone_ph(end,:)];
    c = [5,-5,2;drone_ph(end,:)];
    d = [5,5,2;drone_ph(end,:)];
    
    A = plot3(a(:,1),a(:,2),a(:,3),'b');
    B = plot3(b(:,1),b(:,2),b(:,3),'b');
    C = plot3(c(:,1),c(:,2),c(:,3),'b');
    D = plot3(d(:,1),d(:,2),d(:,3),'b');

    %
    updated_x = drone_ph(end,1)+0.001;
    updated_y = drone_ph(end,2)+0.001;
    updated_z = drone_ph(end,3)+0.001;
    %

    drone_ph = [drone_ph; [updated_x updated_y updated_z]];

    set(trackTail,'xdata',drone_ph(:,1),'ydata',drone_ph(:,2),'zdata',drone_ph(:,3));
    set(trackHead,'xdata',drone_ph(end,1),'ydata',drone_ph(end,2),'zdata',drone_ph(end,3));

    
    %% 12. Go back to 5th step
    waitfor(r);
    
    delete(A); delete(B); delete(C); delete(D);

end
