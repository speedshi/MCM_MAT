% This program is used prepare the input dataset for MCM.
% Coordinate systerm: Cartesian coordinate, X-North, Y-East, Z-Vertical down.
% For vertical down axis, it is relative to the sea-level.
clear;

% Parameter setting--------------------------------------------------------

% set file names
file_seismic ='/home/pshi/projects_going/Aquila_data/data_50.0hz/daily/AQ/2009/day_090.h5'; % path and file name of the seismic data
file_stations='/home/pshi/projects_going/Aquila_data/stations/stations_0.6rad.txt'; % path and file name of the station information
file_velocity='/home/pshi/projects_going/Aquila_data/velocity/velocity_CIA.txt'; % path and file name of the velocity model

% set required parameters
search.north=[4640000 4740000]; % North component range for source imaging points, in meter
search.east=[320000 420000]; % East component range for source imaging points, in meter
search.depth=[0 15000]; % Depth range for source imaging points, in meter
search.dn=500; % spatial interval of source imaging points in the North direction, in meter
search.de=500; % spatial interval of source imaging points in the East direction, in meter
search.dd=1000; % spatial interval of source imaging points in the Depth direction, in meter

% mcm parameters
mcm.migtp=0; % migration method; 0 for MCM, 1 for conventional migration.
mcm.phasetp=2; % phase used for migration; 0 for P-phase only, 1 for S-phase only, 2 for P+S-phases.
mcm.cfuntp=0; % characteristic function; 0 for original data, 1 for envelope, 2 for absolute value, 3 for non-negative value, 4 for square value
mcm.tpwind=3; % P-phase time window length in second (s) used for migration.
mcm.tswind=3; % S-phase time window length in second (s) used for migration.
mcm.dt0=0.2; % time sampling interval of searching origin times in second (s).
mcm.mcmdim=2; % the dimension of MCM
mcm.workfolder='test1'; % the working folder for output and MCM program 

% optional input parameters
mcm.filter.freq=[2 18]; % frequency band used to filter the seismic data, a vector containing 1 or 2 elements, in Hz
mcm.filter.type='bandpass'; % filter type, can be 'low', 'bandpass', 'high', 'stop'
mcm.filter.order=3; % order of Butterworth filter, for bandpass and bandstop designs are of order 2n
mcm.prefile='/home/pshi/projects_going/Aquila_data/mcm_cata/traveltimes/stations_traveltime_search.mat'; % file name of the pre-calculated traveltime tables and the related station and search information

% earthquake information (optional)
earthquake.latitude=42.34; % latitude of the earthquake in degree
earthquake.longitude=13.38; % longitude of the earthquake in degree
earthquake.depth=8000; % depth of the earthquake in meter (below surface)

% set parameters for MCM testing (optional)
mcm.run=3; % specify which MCM program to run
mcm.test.cataname='/home/pshi/projects_going/Aquila_data/catalog/INGV_catalog_1year.txt'; % catalog file name
mcm.test.t0=datetime('2009-03-31 00:00:00'); % The starting time of all traces
mcm.test.timerg=[mcm.test.t0; mcm.test.t0+caldays(1)]; % obtain time range for loading catalog data
mcm.test.cataid=1; % specify test which event in the catalog
mcm.test.twind=20; % test time window length around the selected event origin time, in second
%--------------------------------------------------------------------------



% visualize the model, can help to set the required parameters
modelgeo_show(file_stations,file_velocity,search,earthquake);

% generate input files for MCM
[trace,search,mcm]=mcm_genei(file_seismic,file_stations,file_velocity,search,mcm);
