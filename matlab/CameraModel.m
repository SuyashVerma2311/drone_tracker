classdef CameraModel < handle
    properties
        frame
        phi {mustBeNumeric}
        theta {mustBeNumeric}
        drone_line
        drone_loc
        frame_size = []
    end

    methods
        function obj = CameraModel()

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