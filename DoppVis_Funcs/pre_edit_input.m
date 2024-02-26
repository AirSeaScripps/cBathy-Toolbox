function [XYZ, T, RAW, CAM, bathy] = pre_edit_input(XYZ, T, RAW, CAM, bathy)
% This is a debug helper function to pre-edit the input data for cBathy

% Clip time?
time_len = 255;

T = 0:0.5:time_len/2 - 0.5; % make T time_len long
RAW = RAW(1:time_len,:); % clip RAW to be time_len long


end