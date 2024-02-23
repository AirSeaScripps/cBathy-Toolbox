%% DoppVis2cBathy
% This function converts the DoppVis "RES" datacube structure into a data
% structure expected by the cBathy code routine.
%
% Input:    RES:    Data cube structure (output from DoppVis)
%
% Output:   CAM:    cBathy "camera" (here always 1 - no scene stitching)
%           RAW:    Data structure for cBathy (time x spatial distance)
%           T:      Time [s]
%           XYZ:    Spatial vector Column 1 = x, column 2 = y, column 3 = z

function [CAM,RAW,T,XYZ] = DoppVis2cBathy(RES)
    % Create T
    T = (RES.UTC_time - RES.UTC_time(1)) * (24*60*60); % convert to seconds since start of record
    
    % Create XYZ
    % Convert RES.x and RES.y vectors to mapped grid of pixels
    Xgrid = squeeze(ones(size(RES.MAT(1,:,:)))) .* (RES.x - min(RES.x));
    Ygrid = squeeze(ones(size(RES.MAT(1,:,:)))) .* (RES.y - min(RES.y));
    
    XYZ = nan(numel(Xgrid),3);
    for i = 1:numel(Xgrid)
        XYZ(i,1) = Xgrid(i);
        XYZ(i,2) = Ygrid(i);
        XYZ(i,3) = 0;
    end
    
    % Create CAM
    CAM = ones(size(XYZ,1),1);
    
    % Create RAW
    RAW = nan(length(T),size(XYZ,1)); % Initialize
    for j = 1:length(T)
        RAW(j,:) = reshape(RES.MAT(j, :, :), 1, []);
    end

end