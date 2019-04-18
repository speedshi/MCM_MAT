function [data,travelp,travels,soup]=mcm_genei(file_seismic,file_stations,file_velocity,search,precision)
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
% precision: 'single' or 'double', specify the precision of the output
% binary files.
%
% OUTPUT-------------------------------------------------------------------
% waveform.dat: binary file of seismic data for MCM input;
% travelp.dat: binary file of P-wave traveltimes for MCM input;
% travels.dat: binary file of S-wave traveltimes for MCM input;
% soupos.dat: binary file of source imaging positions for MCM input;
% data: seismic data, correspond to waveform.dat;
% travelp: P-wave traveltime table, correspond to travelp.dat;
% travels: S-wave traveltime table, correspond to travels.dat;
% soup: source imaging positions, correspond to soupos.dat.

% set default value
if nargin==4
    precision='double';
end


% Load data from files
% read in seismic data
if strcmp(file_seismic(end-2,end),'.h5')
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
[data,travelp,travels]=gene_wavetime(seismic,stations,tvt_p,tvt_s,precision);


end