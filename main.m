% This program is used prepare the input dataset for MCM.
% Coordinate systerm: Cartesian coordinate, X-North, Y-East, Z-Vertical down.
% For vertical down axis, it is relative to the sea-level.


% Parameter setting--------------------------------------------------------

% set file names 
file_seismic='./input_file_examples/day_001.h5'; % path and file name of the seismic data
file_stations='./input_file_examples/stations_0.6rad.txt'; % path and file name of the station information
file_velocity='./input_file_examples/velocity_CIA.txt'; % path and file name of the velocity model

% set required parameters
search.north=[270000 470000]; % North component range for source imaging points, in meter
search.east=[4590000 4790000]; % East component range for source imaging points, in meter
search.depth=[0 20000]; % Depth range for source imaging points, in meter
search.dn=1000; % spatial interval of source imaging points in the North direction, in meter
search.de=1000; % spatial interval of source imaging points in the East direction, in meter
search.dd=1000; % spatial interval of source imaging points in the Depth direction, in meter

% earthquake information (optional)
earthquake.latitude=42.34; % latitude of the earthquake in degree
earthquake.longitude=13.38; % longitude of the earthquake in degree 
earthquake.depth=8000; % depth of the earthquake in meter (below surface)
%--------------------------------------------------------------------------



% visualize the model, can help to set the required parameters
modelgeo_show(file_stations,file_velocity,search,earthquake);

% generate binary files for MCM inputs
mcm_genei(file_seismic,file_stations,file_velocity,search);
