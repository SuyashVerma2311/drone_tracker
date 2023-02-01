clc;
clear;
close all;

rosshutdown;
rosinit('http://localhost:11311/');
% rosinit('http://192.168.1.1:11311/');
r = robotics.Rate(10);

nn_sub = rossubscriber('nn_cam/image_raw');

vid1 = vision.DeployableVideoPlayer;
% fig = uifigure;

while true
    nn_img = receive(nn_sub);
    nn = readImage(nn_img);
    nn_hsv = rgb2hsv(nn);

    vid1(nn_hsv);
%     h_l = uislider(fig,'Position',[100 45 100 3]);
%     h_h = uislider(fig,'Position',[100 40 100 3]);
%     s_l = uislider(fig,'Position',[100 35 100 3]);
%     s_h = uislider(fig,'Position',[100 30 100 3]);
%     v_l = uislider(fig,'Position',[100 25 100 3]);
%     v_h = uislider(fig,'Position',[100 20 100 3]);

    waitfor(r);
end




% 
% function rough
% % Create figure window and components
% 
% fig = uifigure('Position',[100 100 350 275]);
% 
% cg = uigauge(fig,'Position',[100 100 120 120]);
% 
% sld = uislider(fig,...
%                'Position',[100 75 120 3],...
%                'ValueChangingFcn',@(sld,event) sliderMoving(event,cg));
% 
% end
% 
% % Create ValueChangingFcn callback
% function sliderMoving(event,cg)
% cg.Value = event.Value;
% end