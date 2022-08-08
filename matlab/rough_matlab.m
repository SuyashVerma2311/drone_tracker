clc;
clear;
close all;

rosshutdown
rosinit('http://crazy-ubuntu:11311/');
mySub = rossubscriber('/temp_sub');
current_time = 0;


tic
while(current_time < 10)
    recvMsg = mySub.LatestMessage;
    current_time = toc;
    plot(current_time,recvMsg.Data);
    drawnow;
end
