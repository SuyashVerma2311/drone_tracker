% Define rotation matrix and translation vector
% R = [0.7071 -0.7071 0; 0.7071 0.7071 0; 0 0 1];
R = eul2rotm([3*pi/4,pi,pi/2]);
t = [-5; -5; 2];

% Define intrinsic matrix
f = 320; % focal length in pixels
cx = 320; % principal point in pixels
cy = 192;
K = [f 0 cx; 0 f cy; 0 0 1];

% Compute rotation-translation matrix
RT = [R t];

% Compute projection matrix
P = K * RT;

P


% function R = eul2rotm2(in)
%     Rx = [1, 0, 0; 0, cos(in(1)), -sin(in(1)); 0, sin(in(1)), cos(in(1))];
%     Ry = [cos(in(2)), 0, sin(in(2)); 0, 1, 0; -sin(in(2)), 0, cos(in(2))];
%     Rz = [cos(in(3)), -sin(in(3)), 0; sin(in(3)), cos(in(3)), 0; 0, 0, 1];
%     R = Rx * Ry * Rz;
% 
%     R_ = eul2rotm(in);
%     disp(R - R_);
% end