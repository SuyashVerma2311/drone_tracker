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
cam_params = [320,   0, 320.5; 
                0, 320, 192.5; 
                0,   0,  1];

nn_cam = CameraModel([-5,-5,2,-0.5*pi,0.25*pi,0],[640,384,3], ...
                     'backgrounds/nn_back.png',cam_params);
np_cam = CameraModel([-5,5,1.5,0.5*pi,0.25*pi,pi],[640,384,3], ...
                     'backgrounds/np_back.png',cam_params);
pn_cam = CameraModel([5,-5,1.75,-0.5*pi,-0.25*pi,0],[640,384,3], ...
                     'backgrounds/pn_back.png',cam_params);
pp_cam = CameraModel([5,5,1.25,0.5*pi,-0.25*pi,pi],[640,384,3], ...
                     'backgrounds/pp_back.png',cam_params);

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
fill3([-6,6,6,-6],[-6,-6,6,6],[0,0,0,0],'g'); alpha(0.3); % adds a green floor
cams = stem3(0,0,0,'--blacksquare','filled');
set(cams,'xdata',[-5,-5,5,5],'ydata',[-5,5,-5,5],'zdata',[2,1.5,1.75,1.25]);
zlim([0 3]); xlim([-6 6]); ylim([-6 6]);

plotCamera("AbsolutePose",rigidtform3d(nn_cam.R,nn_cam.T'),'Size',0.2,'Label','','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(np_cam.R,np_cam.T'),'Size',0.2,'Label','','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(pn_cam.R,pn_cam.T'),'Size',0.2,'Label','','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(pp_cam.R,pp_cam.T'),'Size',0.2,'Label','','AxesVisible',true);

% Drone Plotting.
drone_plotter = [0,0,0];% Drone Place Holder
gt_plotter = [0, 0, 0];
trackHead = stem3(drone_plotter(1),drone_plotter(2),drone_plotter(3),'-.ob','filled');
trackTail = plot3(drone_plotter(1),drone_plotter(2),drone_plotter(3),'b','LineWidth',2);
gt_trackHead = stem3(gt_plotter(1),gt_plotter(2),gt_plotter(3),'-.or','filled');
gt_trackTail = plot3(gt_plotter(1),gt_plotter(2),gt_plotter(3),'r','LineWidth',2);

a = [-5,-5,2;drone_plotter(end,:)];
b = [-5,5,1.5;drone_plotter(end,:)];
c = [5,-5,1.75;drone_plotter(end,:)];
d = [5,5,1.25;drone_plotter(end,:)];

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
    M1 = triangulate(nn_cam.drone_loc, np_cam.drone_loc, nn_cam.model, np_cam.model);
%     M2 = triangulate(nn_cam.drone_loc, pn_cam.drone_loc, nn_cam.model, pn_cam.model);
%     M3 = triangulate(nn_cam.drone_loc, pp_cam.drone_loc, nn_cam.model, pn_cam.model);
% 
%     M = (M1 + M2 + M3) ./ 3
    M = M1
% 
%     nn_cam.computeLine();
%     np_cam.computeLine();
%     pn_cam.computeLine();
%     pp_cam.computeLine();

%     M = M1
%     disp(nn_cam.R);

    nn_cam.drone_loc
    np_cam.drone_loc



    %% 8. Find the closest point of all four lines
%     v1 = nn_cam.line;
%     v2 = np_cam.line;
%     v3 = pn_cam.line;
%     v4 = pp_cam.line;

    %% 9. %% %% Apply Kalman Filtering on the found data.


    %% 10. Plotting 
    drone_X = M(1);
    drone_Y = M(2);
    drone_Z = M(3);

    gt = GT_sub.receive();
    gtX = gt.Pose.Pose.Position.X;
    gtY = gt.Pose.Pose.Position.Y;
    gtZ = gt.Pose.Pose.Position.Z;

    drone_plotter = append(drone_plotter, [drone_X, drone_Y, drone_Z], 50, 'unlimited');
    gt_plotter = append(gt_plotter, [gtX, gtY, gtZ], 50, 'unlimited');

    a = [-5,-5,2;drone_plotter(end,:)];
    b = [-5,5,2;drone_plotter(end,:)];
    c = [5,-5,2;drone_plotter(end,:)];
    d = [5,5,2;drone_plotter(end,:)];

    set(A,'xdata',a(:,1),'ydata',a(:,2),'zdata',a(:,3));
    set(B,'xdata',b(:,1),'ydata',b(:,2),'zdata',b(:,3));
    set(C,'xdata',c(:,1),'ydata',c(:,2),'zdata',c(:,3));
    set(D,'xdata',d(:,1),'ydata',d(:,2),'zdata',d(:,3));

    set(trackTail,'xdata',drone_plotter(:,1),'ydata',drone_plotter(:,2),'zdata',drone_plotter(:,3));
    set(trackHead,'xdata',drone_plotter(end,1),'ydata',drone_plotter(end,2),'zdata',drone_plotter(end,3));
    set(gt_trackTail,'xdata',gt_plotter(:,1),'ydata',gt_plotter(:,2),'zdata',gt_plotter(:,3));
    set(gt_trackHead,'xdata',gt_plotter(end,1),'ydata',gt_plotter(end,2),'zdata',gt_plotter(end,3));

    
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



function out = append(in, appendend, size, mode)
    % Instead of adding and adding... just append only to a certain limit.
    if strcmp(mode,'limited')
        % Perform shortening list.
        if length(in) >= size-1
            in = in(end-size+1);
        end
    end
    out = [in; appendend];
end