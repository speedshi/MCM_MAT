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

% optional input parameters
freq_seis=[2 22]; % frequency band used to filter the seismic data, in Hz

% mcm parameters
mcm.migtp=0; % migration method; 0 for MCM, 1 for conventional migration.
mcm.phasetp=2; % phase used for migration; 0 for P-phase only, 1 for S-phase only, 2 for P+S-phases.
mcm.cfuntp=0; % characteristic function; 0 for original data, 1 for envelope, 2 for absolute value, 3 for non-negative value, 4 for square value
mcm.tpwind=10; % P-phase time window length in second (s) used for migration.
mcm.tswind=10; % S-phase time window length in second (s) used for migration.
mcm.dt0=0.1; % time sampling interval of searching origin times in second (s).
mcm.mcmdim=2; % the dimension of MCM

% earthquake information (optional)
earthquake.latitude=42.34; % latitude of the earthquake in degree
earthquake.longitude=13.38; % longitude of the earthquake in degree 
earthquake.depth=8000; % depth of the earthquake in meter (below surface)
%--------------------------------------------------------------------------



% visualize the model, can help to set the required parameters
modelgeo_show(file_stations,file_velocity,search,earthquake);

% generate binary files for MCM inputs
mcm_genei(file_seismic,file_stations,file_velocity,search,freq_seis,mcm);
