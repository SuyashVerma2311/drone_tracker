classdef CameraModel < handle
    properties
        frame
        drone_line
        drone_loc(1,2)
        drone_pose(1,3)
        theta {mustBeNumeric}
        phi {mustBeNumeric}
        frame_size(1,3)
        origin(1,6)
        background
    end

    methods
        function obj = CameraModel(origin,frame_size,back_location)
            obj.origin = origin;
            obj.frame_size = frame_size;
            obj.background = imread(back_location);
        end

        function findDrone(obj)
            obj.drone_loc = find_drone(obj.frame, obj.background);
            obj.theta = (obj.drone_loc(1)-obj.frame_size(2)/2)/90;
            obj.phi = (obj.drone_loc(2)-obj.frame_size(1)/2)/54;
            [a,b,c] = sph2cart(obj.theta,obj.phi,4);
            obj.drone_pose = [a,b,c];
        end

        function generateLine(obj)
            % Generate Line from theta and phi.
            
        end
    end
end