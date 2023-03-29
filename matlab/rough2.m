clc;
clear;
close all;

cam_params = [320,   0, 320; 
                0, 320, 320; 
                0,   0,  1];

nn_cam = CameraModel([-5,-5,2,3*pi/4,pi,pi/2],[640,384,3], ...
                     'backgrounds/nn_back.png',cam_params);
np_cam = CameraModel([-5,5,2,pi/4,pi,pi/2],[640,384,3], ...
                     'backgrounds/np_back.png',cam_params);
pn_cam = CameraModel([5,-5,2,-3*pi/4,pi,pi/2],[640,384,3], ...
                     'backgrounds/pn_back.png',cam_params);
pp_cam = CameraModel([5,5,2,-pi/4,pi,pi/2],[640,384,3], ...
                     'backgrounds/pp_back.png',cam_params);

location = [320, 192];

figure; hold on; view(3);
xlabel('X');
ylabel('Y');
zlabel('Z');
plotCamera("AbsolutePose",rigidtform3d(eul2rotm(nn_cam.origin(4:6)),nn_cam.T'),'Size',0.2,'Label','Testing','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(eul2rotm(np_cam.origin(4:6)),np_cam.T'),'Size',0.2,'Label','Testing','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(eul2rotm(pn_cam.origin(4:6)),pn_cam.T'),'Size',0.2,'Label','Testing','AxesVisible',true);
plotCamera("AbsolutePose",rigidtform3d(eul2rotm(pp_cam.origin(4:6)),pp_cam.T'),'Size',0.2,'Label','Testing','AxesVisible',true);

nn_proj = cameraProjection(cameraIntrinsics([320,320],[320,192],[640,640]),rigidtform3d(eul2rotm(nn_cam.origin(4:6)),nn_cam.T'));
np_proj = cameraProjection(cameraIntrinsics([320,320],[320,192],[640,640]),rigidtform3d(eul2rotm(np_cam.origin(4:6)),np_cam.T'));

x = triang(location, location, nn_proj, np_proj);
disp(x);

stem3(x(1),x(2),x(3));

x = triangulate(location, location, nn_proj, np_proj);
disp(x);

stem3(x(1),x(2),x(3));

function out = triang(imPt1, imPt2, P1, P2)
    A = [imPt1(2)*P1(3,1)-P1(2,1), imPt1(2)*P1(3,2)-P1(2,2), imPt1(2)*P1(3,3)-P1(2,3);
         imPt1(1)*P1(3,1)-P1(1,1), imPt1(1)*P1(3,2)-P1(1,2), imPt1(1)*P1(3,3)-P1(1,3);
         imPt2(2)*P2(3,1)-P2(2,1), imPt2(2)*P2(3,2)-P2(2,2), imPt2(2)*P2(3,3)-P2(2,3);
         imPt2(1)*P2(3,1)-P2(1,1), imPt2(1)*P2(3,2)-P2(1,2), imPt2(1)*P2(3,3)-P2(1,3)];
    b = [-imPt2(2)*P1(3,4)+P1(2,4); -imPt1(1)*P1(3,4)+P1(1,4); -imPt2(2)*P2(3,4)+P2(2,4); -imPt2(1)*P2(3,4)+P2(1,4)];
    [U, S, V] = svd(A);
    out = V * pinv(S) * U' * b;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A = [1 1 1; 1 2 3; 2 3 5; 3 5 7; 5 7 11];
% b = [6; 10; 17; 26; 40];
% 
% [U, S, V] = svd(A);
% 
% x = V * pinv(S) * U' * b;
% disp(x)