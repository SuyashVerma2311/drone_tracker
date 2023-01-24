clc;
clear;
close all;

a = CameraModel;
a.frame = 7;

disp(a.frame);
a.findDrone();

disp(a.drone_loc);