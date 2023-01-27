clc;
clear;
close all;


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


% b = plot3(t(1),t(1),y(1)+1,'r','LineWidth',2);
% 
% for k = 1:length(t)
%     set(b,'xdata',t(1:k),'ydata',t(1:k),'zdata',y(1:k)+1);
%     pause(1/60);
% end
% 
% delete(b);

