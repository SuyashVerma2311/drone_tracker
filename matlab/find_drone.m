function drone_loc = find_drone(inputImg)
    % Threshold image and produce the location of the drone.
    mask = createMask(inputImg);

    % Find center of the mask.
    stats = regionprops(mask);
    centroid = stats.Centroid;

    img_X = floor(centroid(1));
    img_Y = floor(centroid(2));
    drone_loc = [img_X, img_Y];
end

