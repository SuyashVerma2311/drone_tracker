classdef CameraModel < handle
    properties
        frame
        drone_loc(1,2)
        frame_size(1,3)
        origin(1,6)
        background
        mat(3,3)
        line
        T(1,3)
        R(3,3)
        model
    end

    methods
        function obj = CameraModel(origin,frame_size,back_location,cam_params)
            obj.origin = origin;
            obj.frame_size = frame_size;
            obj.background = imread(back_location);
            obj.mat = cam_params;
            
            obj.T = origin(1:3);
            Rx = [1, 0, 0; 0, cos(origin(4)), -sin(origin(4)); 0, sin(origin(4)), cos(origin(4))];
            Ry = [cos(origin(5)), 0, sin(origin(5)); 0, 1, 0; -sin(origin(5)), 0, cos(origin(5))];
            Rz = [cos(origin(6)), -sin(origin(6)), 0; sin(origin(6)), cos(origin(6)), 0; 0, 0, 1];
            
            obj.R = Rx * Ry * Rz;
            obj.model = cam_params * [obj.R obj.T'];
        end

        function findDrone(obj)
            obj.drone_loc = find_drone(obj.frame, obj.background);
        end

        function computeLine(obj)
            v = inv(obj.mat) * [obj.drone_loc 1]';
            v = obj.R' * v;
            obj.line = v / norm(v);
        end
    end
end