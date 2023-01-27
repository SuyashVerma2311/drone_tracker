classdef CameraModel < handle
    properties
        frame
        drone_line
        drone_loc
        frame_size
        origin
    end

    methods
        function obj = CameraModel(origin,frame_size)
            obj.origin = origin;
            obj.frame_size = frame_size;
            obj.drone_loc = [0,0];
        end

        function findDrone(obj)
            obj.drone_loc = find_drone(obj.frame);
        end

        function generateLine(obj)
            % Generate Line from theta and phi.
            obj.drone_line = obj;
        end
    end
end