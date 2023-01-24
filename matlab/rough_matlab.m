clc;
clear;
close all;

rosshutdown
% rosinit('http://ASUS-TF-Gaming-A15-FA506IC:11311/');
rosinit('http://crazy-ubuntu:11311/');
r = robotics.Rate(10);

nn_image_raw = rossubscriber('/nn_cam/image_raw');
np_image_raw = rossubscriber('/np_cam/image_raw');
pn_image_raw = rossubscriber('/pn_cam/image_raw');
pp_image_raw = rossubscriber('/pp_cam/image_raw');

receive(pp_image_raw, 10);
receive(pn_image_raw, 10);
receive(np_image_raw, 10);
receive(nn_image_raw, 10);



while true
    pp = readImage(pp_image_raw.LatestMessage);
    pn = readImage(pn_image_raw.LatestMessage);
    np = readImage(np_image_raw.LatestMessage);
    nn = readImage(nn_image_raw.LatestMessage);
    ultra = [pp pn; np nn];
    imshow(ultra);
    waitfor(r);
end


////
function rough
% Create figure window and components

fig = uifigure('Position',[100 100 350 275]);

cg = uigauge(fig,'Position',[100 100 120 120]);

sld = uislider(fig,...
               'Position',[100 75 120 3],...
               'ValueChangingFcn',@(sld,event) sliderMoving(event,cg));

end

% Create ValueChangingFcn callback
function sliderMoving(event,cg)
cg.Value = event.Value;
end