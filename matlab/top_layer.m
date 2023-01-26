% This is the top script that will run ROSnode and call all the functions



%% 1. Initializing


%% 2. Run ROS Node


%% 3. Create 4 Camera Objects


%% 4. Receive camera data


%% 5. Pass the frame data from ROS to camera objects


%% 6. Compute the line equations from all objects


%% 7. Find the closest point of all four lines


%% 8. %% %% Apply Kalman Filtering on the found data.


%% 9. Go back to 2nd step




%% Plotting Below:

t = -6:0.01:6;

figure(1);
grid on; hold on; view(3);
plot3(0.*t+5,t,0.*t,'b');
plot3(0.*t-5,t,0.*t,'b');
plot3(t,0.*t+5,0.*t,'b');
plot3(t,0.*t-5,0.*t,'b');
fill3([-6,6,6,-6],[-6,-6,6,6],[0,0,0,0],'g');
alpha(0.3);
cams = stem3(0,0,0,'--blacksquare','filled');
set(cams,'xdata',[-5,-5,5,5],'ydata',[-5,5,-5,5],'zdata',[2,2,2,2]);
zlim([0 3]); xlim([-6 6]); ylim([-6 6]);

