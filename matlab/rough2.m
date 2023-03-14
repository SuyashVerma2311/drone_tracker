clc;
close all;
clear;

rosshutdown;
% rosinit('http://192.168.1.1:11311');
rosinit('http://localhost:11311');
r = robotics.Rate(30);

GT_sub = rossubscriber('/ground_truth/state');