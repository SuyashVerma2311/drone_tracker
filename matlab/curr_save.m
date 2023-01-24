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


vid1 = vision.DeployableVideoPlayer;
vid2 = vision.DeployableVideoPlayer;
vid3 = vision.DeployableVideoPlayer;
vid4 = vision.DeployableVideoPlayer;

while true
    pp = readImage(pp_image_raw.LatestMessage);
    pn = readImage(pn_image_raw.LatestMessage);
    np = readImage(np_image_raw.LatestMessage);
    nn = readImage(nn_image_raw.LatestMessage);
    vid1(pp);
    vid2(pn);
    vid3(np);
    vid4(nn);
    waitfor(r);
end