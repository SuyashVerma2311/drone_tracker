clc;
clear;
close all;

rosshutdown
rosinit('http://crazy-ubuntu:11311/');

nn_image_raw = rossubscriber('/nn_cam/image_raw');
np_image_raw = rossubscriber('/np_cam/image_raw');
pn_image_raw = rossubscriber('/pn_cam/image_raw');
pp_image_raw = rossubscriber('/pp_cam/image_raw');

while(1)
    nn_image_latest = nn_image_raw.LatestMessage;
    disp(nn_image_latest);
    nn_image = rosReadImage(nn_image_latest);
    imshow(nn_image);
end