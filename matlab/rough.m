clc;
clear;
close all;

cam_params = [320,   0, 320; 
                0, 320, 192; 
                0,   0,  1];

nn_cam = CameraModel([-5,-5,2,-0.5*pi,0.25*pi,0],[640,384,3], ...
                     'backgrounds/nn_back.png',cam_params);
np_cam = CameraModel([-5,5,1.5,0.5*pi,0.25*pi,pi],[640,384,3], ...
                     'backgrounds/np_back.png',cam_params);
pn_cam = CameraModel([5,-5,1.75,-0.5*pi,-0.25*pi,0],[640,384,3], ...
                     'backgrounds/pn_back.png',cam_params);
pp_cam = CameraModel([5,5,1.25,0.5*pi,-0.25*pi,pi],[640,384,3], ...
                     'backgrounds/pp_back.png',cam_params);

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
set(cams,'xdata',[-5,-5,5,5],'ydata',[-5,5,-5,5],'zdata',[2,1.5,1.75,1.25]);
zlim([0 3]); xlim([-6 6]); ylim([-6 6]);

plotCamera("AbsolutePose",rigidtform3d(nn_cam.R,nn_cam.T'),'Size',0.2,'Label','','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(np_cam.R,np_cam.T'),'Size',0.2,'Label','','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(pn_cam.R,pn_cam.T'),'Size',0.2,'Label','','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(pp_cam.R,pp_cam.T'),'Size',0.2,'Label','','AxesVisible',true);


drone_ph = [0,1,0];
trackHead = stem3(drone_ph(1),drone_ph(2),drone_ph(3),'-.or','filled');
trackTail = plot3(drone_ph(1),drone_ph(2),drone_ph(3),'r','LineWidth',2);


a = [-5,-5,2;drone_ph(end,:)];
b = [-5,5,1.5;drone_ph(end,:)];
c = [5,-5,1.75;drone_ph(end,:)];
d = [5,5,1.25;drone_ph(end,:)];

A = plot3(a(:,1),a(:,2),a(:,3),'b');
B = plot3(b(:,1),b(:,2),b(:,3),'b');
C = plot3(c(:,1),c(:,2),c(:,3),'b');
D = plot3(d(:,1),d(:,2),d(:,3),'b');


for k = 1:length(t)
    a = [-5,-5,2;drone_ph(end,:)];
    b = [-5,5,2;drone_ph(end,:)];
    c = [5,-5,2;drone_ph(end,:)];
    d = [5,5,2;drone_ph(end,:)];

    set(A,'xdata',a(:,1),'ydata',a(:,2),'zdata',a(:,3));
    set(B,'xdata',b(:,1),'ydata',b(:,2),'zdata',b(:,3));
    set(C,'xdata',c(:,1),'ydata',c(:,2),'zdata',c(:,3));
    set(D,'xdata',d(:,1),'ydata',d(:,2),'zdata',d(:,3));

    drone_ph = [drone_ph; [sin(t(k)) cos(t(k)) t(k)/6+1]];

    set(trackTail,'xdata',drone_ph(:,1),'ydata',drone_ph(:,2),'zdata',drone_ph(:,3));
    set(trackHead,'xdata',drone_ph(end,1),'ydata',drone_ph(end,2),'zdata',drone_ph(end,3));
    pause(1/60);

end