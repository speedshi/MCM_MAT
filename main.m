% This program is used to prepare the input dataset for MCM.
% Coordinate systerm: Cartesian coordinate, X-North, Y-East, Z-Vertical down.
% For vertical down axis, it is relative to the sea-level.
clear;

% Parameter setting--------------------------------------------------------

% set file names
file.seismic ='/home/shipe/projects_going/Aquila_data/data_50.0hz/daily/AQ/2009/day_093.h5'; % path and file name of the seismic data
file.stations='/home/shipe/projects_going/Aquila_data/stations/stations_0.6rad.txt'; % path and file name of the station information
file.velocity='/home/shipe/projects_going/Aquila_data/velocity/velocity_CIA.txt'; % path and file name of the velocity model

% set required parameters
search.north=[4640000 4740000]; % North component range for source imaging points, in meter
search.east=[320000 420000]; % East component range for source imaging points, in meter
search.depth=[0 15000]; % Depth range for source imaging points, in meter
search.dn=500; % spatial interval of source imaging points in the North direction, in meter
search.de=500; % spatial interval of source imaging points in the East direction, in meter
search.dd=1000; % spatial interval of source imaging points in the Depth direction, in meter

% mcm parameters
mcm.migtp=0; % migration method; 0 for MCM, 1 for conventional migration.
mcm.phasetp=0; % phase used for migration; 0 for P-phase only, 1 for S-phase only, 2 for P+S-phases.
mcm.cfuntp=0; % characteristic function; 0 for original data, 1 for envelope, 2 for absolute value, 3 for non-negative value, 4 for square value
mcm.tpwind=20; % P-phase time window length in second (s) used for migration.
mcm.tswind=20; % S-phase time window length in second (s) used for migration.
mcm.dt0=0.2; % time sampling interval of searching origin times in second (s).
mcm.mcmdim=2; % the dimension of MCM
mcm.workfolder='test'; % the working folder for output and MCM program 

% optional input parameters
mcm.filter.freq=[12 22]; % frequency band used to filter the seismic data, a vector containing 1 or 2 elements, in Hz
mcm.filter.type='bandpass'; % filter type, can be 'low', 'bandpass', 'high', 'stop'
mcm.filter.order=4; % order of Butterworth filter, for bandpass and bandstop designs are of order 2n
mcm.prefile='/home/shipe/projects_going/Aquila_data/mcm_cata/traveltimes/stations_traveltime_search.mat'; % file name of the pre-calculated traveltime tables and the related station and search information
mcm.datat0=datetime('2009-04-03 00:00:00'); % The starting time of all traces, reset the t0 if the t0 in the input seismic files are not correct
mcm.stationid=1; % show the seismogram and spectrogram of this station

% earthquake information (optional)
earthquake.latitude=42.34; % latitude of the earthquake in degree
earthquake.longitude=13.38; % longitude of the earthquake in degree
earthquake.depth=8000; % depth of the earthquake in meter (below surface)

% set parameters for MCM testing (optional)
mcm.run=4; % specify which MCM program to run: 0 for testing MCM parameters; 1 for MCM frequency band testing; 2 for MCM Matlab testing with catalog input; 3 for MCM Matlab testing with input time range; 4 for Run MCM Matlab program
mcm.test.cataname='/home/shipe/projects_going/Aquila_data/catalog/INGV_catalog_1year_0.txt'; % catalog file name
mcm.test.cataid=3; % specify test which event in the catalog (required by run=0-2)
mcm.test.twind=30; % time window length around the selected event origin time, in second (required by run=2)
mcm.test.mtrg=[datetime('2009-04-03 06:00:00') datetime('2009-04-03 06:00:01')]; % the input time range for migration (required by run=3)
%--------------------------------------------------------------------------



% visualize the model, can help to set the required parameters
modelgeo_show(file.stations,file.velocity,search,earthquake);

% generate input files for MCM
[trace,search,mcm]=mcm_genei(file,search,mcm);
