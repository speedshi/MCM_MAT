function [data,travelp,travels,soup]=mcm_genei(file_seismic,file_stations,file_velocity,search,freq,mcm,precision)
% This function is used to generate the required input files for MCM.
% Unit: meter, m/s, degree.
%
% Accepted seismic data format: h5
% Accepted station file format: IRIS text
%
% INPUT--------------------------------------------------------------------
% file_seismic: file name (including path) of the seismic data;
% file_stations: file name (including path) of the stations;
% file_velocity: file name (including path) of the velocity model;
% search: matlab structure, describe the imaging area,
% search.north: 1*2, imaging area in the north direction, in meter,
% search.east: 1*2, imaging area in the east direction, in meter,
% search.depth: 1*2, imaging area in the depth direction, in meter;
% search.dn: spatial interval in the north direction, in meter;
% search.de: spatial interval in the east direction, in meter;
% search.dd: spatial interval in the depth direction, in meter;
% freq: vector, 1*2, frequency band used to filter seismic data;
% mcm: matlab structure, specify MCM parameters, used to generate 'migpara.dat';
% precision: 'single' or 'double', specify the precision of the output
% binary files.
%
% OUTPUT-------------------------------------------------------------------
% waveform.dat: binary file of seismic data for MCM input;
% travelp.dat: binary file of P-wave traveltimes for MCM input;
% travels.dat: binary file of S-wave traveltimes for MCM input;
% soupos.dat: binary file of source imaging positions for MCM input;
% migpara.dat: text file for MCM parameters;
% data: seismic data, correspond to waveform.dat;
% travelp: P-wave traveltime table, correspond to travelp.dat;
% travels: S-wave traveltime table, correspond to travels.dat;
% soup: source imaging positions, correspond to soupos.dat.

% set default value
if nargin<5
    freq=[];
    mcm=[];
    precision='double';
elseif nargin==5
    mcm=[];
    precision='double';
elseif nargin==6
    precision='double';
end

if isempty(precision)
    precision='double';
end

% Load data from files
% read in seismic data
if strcmp(file_seismic(end-2:end),'.h5')
    % read in the H5 format data
    seismic=read_seish5(file_seismic);
else
    error('Unrecognised format of seismic data.');
end


% read in station information
stations=read_stations(file_stations); % read in station information in IRIS text format


% read in velocity infomation
model=read_velocity(file_velocity); % read in velocity model, now only accept homogeneous and layered model


% obtain MCM required input files
% generate binary file of source imaging positions
soup=gene_soup(search.north,search.east,search.depth,search.dn,search.de,search.dd,precision);

% generate traveltime tables
[tvt_p,tvt_s]=gene_traveltime(model,stations,soup,precision,[],[]);

% generate binary files for seismic data and traveltimes
[data,dt,travelp,travels]=gene_wavetime(seismic,stations,tvt_p,tvt_s,freq,precision);

% generate text files for mcm parameters
if ~isempty(mcm)
    mcm.nre=size(data,1); % number of stations
    mcm.nsr=size(soup,1); % number of imaging points
    mcm.dfname='waveform.dat'; % file name of seismic data
    mcm.dt=dt; % time sampling interval, in second
    mcm.tdatal=(size(data,2)-1)*dt; % time length of the whole seismic data in second (s)
    mcm.vthrd=0.001; % threshold value for identifying seismic event in the migration volume
    mcm.spaclim=0; % the space limit in searching for potential seismic events, in meter (m)
    mcm.timelim=0; % the time limit in searching for potential seismic events, in second (s)
    mcm.nssot=1; % the maximum number of potential seismic events can be accept for a single origin time
    gene_migpara(mcm); % generate the text file
end

end