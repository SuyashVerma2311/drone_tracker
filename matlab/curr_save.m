clc;
clear;
close all;

rosshutdown;
rosinit('http://192.168.1.2:11311/');
r = robotics.Rate(10);

% nn_image_raw = rossubscriber('/nn_cam/image_raw');
% np_image_raw = rossubscriber('/np_cam/image_raw');
pn_image_raw = rossubscriber('/pn_cam/image_raw');
% pp_image_raw = rossubscriber('/pp_cam/image_raw');


% vid1 = vision.DeployableVideoPlayer;
% vid2 = vision.DeployableVideoPlayer;
vid3 = vision.DeployableVideoPlayer;
% vid4 = vision.DeployableVideoPlayer;

while true
%     nn_img = receive(nn_image_raw);
%     np_img = receive(np_image_raw);
    pn_img = receive(pn_image_raw);
%     pp_img = receive(pp_image_raw);

%     nn = readImage(nn_img);
%     np = readImage(np_img);
    pn = readImage(pn_img);
%     pp = readImage(pp_img);

%     nn_loc = find_drone(nn)
%     np_loc = find_drone(np)
    pn_loc = find_drone(pn)
%     pp_loc = find_drone(pp)
    
%     vid1(nn);
%     vid2(np);
    vid3(pn);
%     vid4(pp);
    waitfor(r);
end