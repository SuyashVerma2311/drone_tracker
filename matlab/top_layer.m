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

% Enviroment Plotting.
t = -6:0.01:6;

figure(1); grid on; hold on; view(3);
plot3(0.*t+5,t,0.*t,'b'); plot3(0.*t-5,t,0.*t,'b'); plot3(t,0.*t+5,0.*t,'b'); plot3(t,0.*t-5,0.*t,'b');
fill3([-6,6,6,-6],[-6,-6,6,6],[0,0,0,0],'g'); alpha(0.3); % adss a green floor
cams = stem3(0,0,0,'--blacksquare','filled');
set(cams,'xdata',[-5,-5,5,5],'ydata',[-5,5,-5,5],'zdata',[2,2,2,2]);
zlim([0 3]); xlim([-6 6]); ylim([-6 6]);

% Drone Plotting.

drone_ph = [0,0,0];         % Drone Place Holder
trackHead = stem3(drone_ph(1),drone_ph(2),drone_ph(3),'-.or','filled');
trackTail = plot3(drone_ph(1),drone_ph(2),drone_ph(3),'r','LineWidth',2);


% while true
for k = 1 : length(t)
    a = [-5,-5,2;drone_ph(end,:)];
    b = [-5,5,2;drone_ph(end,:)];
    c = [5,-5,2;drone_ph(end,:)];
    d = [5,5,2;drone_ph(end,:)];
    
    A = plot3(a(:,1),a(:,2),a(:,3),'b');
    B = plot3(b(:,1),b(:,2),b(:,3),'b');
    C = plot3(c(:,1),c(:,2),c(:,3),'b');
    D = plot3(d(:,1),d(:,2),d(:,3),'b');

    drone_ph = [drone_ph; [sin(t(k)) cos(t(k)) t(k)/6+1]];
    % drone+ph = [drone_ph; [updated_x updated_y updated_z]];

    set(trackTail,'xdata',drone_ph(:,1),'ydata',drone_ph(:,2),'zdata',drone_ph(:,3));
    set(trackHead,'xdata',drone_ph(end,1),'ydata',drone_ph(end,2),'zdata',drone_ph(end,3));
    pause(1/60);

    delete(A); delete(B); delete(C); delete(D);
end

