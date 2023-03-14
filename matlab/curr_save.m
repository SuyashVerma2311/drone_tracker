clc;
clear;
close all;

rosshutdown;
% rosinit('http://192.168.1.2:11311/');
rosinit('http://localhost:11311');
r = robotics.Rate(10);

nn_image_raw = rossubscriber('/nn_cam/image_raw');
np_image_raw = rossubscriber('/np_cam/image_raw');
pn_image_raw = rossubscriber('/pn_cam/image_raw');
pp_image_raw = rossubscriber('/pp_cam/image_raw');

NN_back = imread("backgrounds/nn_back.png");
NP_back = imread("backgrounds/np_back.png");
PN_back = imread("backgrounds/pn_back.png");
PP_back = imread("backgrounds/pp_back.png");

vid1 = vision.DeployableVideoPlayer;
vid2 = vision.DeployableVideoPlayer;
vid3 = vision.DeployableVideoPlayer;
vid4 = vision.DeployableVideoPlayer;

while true
    nn_img = receive(nn_image_raw);
    np_img = receive(np_image_raw);
    pn_img = receive(pn_image_raw);
    pp_img = receive(pp_image_raw);

    nn = readImage(nn_img);
    np = readImage(np_img);
    pn = readImage(pn_img);
    pp = readImage(pp_img);

%     imwrite(nn, 'nn_back.png');
%     imwrite(np, 'np_back.png');
%     imwrite(pn, 'pn_back.png');
%     imwrite(pp, 'pp_back.png');
% 
%     break;
% 
%     nn_mask = rgb2gray(imabsdiff(NN_back,nn));
%     np_mask = rgb2gray(imabsdiff(NP_back,np));
%     pn_mask = rgb2gray(imabsdiff(PN_back,pn));
%     pp_mask = rgb2gray(imabsdiff(PP_back,pp));
% 
%     imwrite(nn_mask, 'temp.png');

    nn_mask = insertMarker(nn, find_drone(nn, NN_back));
    np_mask = insertMarker(np, find_drone(np, NP_back));
    pn_mask = insertMarker(pn, find_drone(pn, PN_back));
    pp_mask = insertMarker(pp, find_drone(pp, PP_back));
    
    vid1(nn_mask);
    vid2(np_mask);
    vid3(pn_mask);
    vid4(pp_mask);
    waitfor(r);
end