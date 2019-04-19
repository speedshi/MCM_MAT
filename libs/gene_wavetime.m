function [data,travelp,travels]=gene_wavetime(seismic,stations,tvt_p,tvt_s,precision,fname_d,fname_p,fname_s,freq)
% This function is used to generate the binary files for the inputs of MCM.
% The binary files are waveforms and traveltimes (if needed).
%
% Note the structure 'seismic' (contain waveforms) and the structure
% 'stations' (contain station information) may have different number of
% stations. This program is used to select and output the waveforms
% that are also in the structure 'stations'.
%
% If empty file names ([]) are given, then do not output the corresponding
% binary files.
%
% INPUT--------------------------------------------------------------------
% seismic: matlab structure, contains waveform information;
% seismic.data: nrec*nt, seismic data;
% seismic.sname: cell array, 1*nrec, station names;
% seismic.fe: scaler, the sampling frequency of the data, in Hz;
% stations: matlab structure, contains station information;
% stations.name: cell array, 1*nr, station names;
% tvt_p: array, ns*nr, traveltime table for P-waves;
% tvt_s: array, ns*nr, traveltime table for S-waves;
% precision: string, 'single' or 'double', specifiy the outout presicion;
% fname_d: output filename for waveform data;
% fname_p: output binary file name for P-wave traveltimes;
% fname_s: output binary file name for S-wave traveltimes;
% freq: vector, 1*2, frequency band used to filter seismic data.
%
% OUTPUT-------------------------------------------------------------------
% data: seismic data;
% travelp: P-wave traveltime table;
% travels: S-wave traveltime table.


folder='data'; % name of the folder where output data are stored

% check if the output folder exists, if not, then create it
if ~exist(folder,'dir')
    mkdir(folder);
end

% set default values
if nargin<5
    precision='double';
    fname_d='waveform.dat';
    fname_p='travelp.dat';
    fname_s='travels.dat';
    freq=[];
elseif nargin==5
    fname_d='waveform.dat';
    fname_p='travelp.dat';
    fname_s='travels.dat';
    freq=[];
end

if isempty(precision)
    precision='double';
end

if ~isempty(fname_d)
    fname_d=['./' folder '/' fname_d];
end

if ~isempty(fname_p)
    fname_p=['./' folder '/' fname_p];
end

if ~isempty(fname_s)
    fname_s=['./' folder '/' fname_s];
end


nr=length(stations.name); % number of stations in the station file

% initialize
data=[];
travelp=[];
travels=[];

n_sta=0; % total number of effective stations

for ir=1:nr
    
    indx=strcmp(stations.name{ir},seismic.sname); % index of this station in the 'seismic' file
    
    if sum(indx)==1
        % find seismic data for this station
        fprintf("Found seismic data for the station '%s'.\n",stations.name{ir});
        n_sta=n_sta+1;
        data(n_sta,:)=seismic.data(indx,:); % seismic data
        if ~isempty(tvt_p)
            travelp(:,n_sta)=tvt_p(:,ir); % P-wave traveltime table
        end
        if ~isempty(tvt_s)
            travels(:,n_sta)=tvt_s(:,ir); % S-wave traveltime table
        end
    elseif sum(indx)==0
        % no seismic data for this station is found.
        fprintf("No seismic data are found for the station '%s'.\n",stations.name{ir});
    else
        error("Something wrong in the seismic structure! As least two traces have the same station name!");
    end
    
end

if n_sta==0
    warning("No seismic data in the 'sations' file is found!");
    return;
else
    fprintf("In total %d traces are found and stored.\n", n_sta);
end

% check if need filter seismic data
f_nyqt=0.5*seismic.fe; % Nyquist frequency of seismic data
if ~isempty(freq)
    % apply bandpass filter, Filter corners/order is 4
    fprintf('Apply bandpass filter of %f - %f Hz.\n',freq(1),freq(2));
    [bb,aa]=butter(4,[freq(1)/f_nyqt freq(2)/f_nyqt],'bandpass');
    for ir=1:n_sta
        data(ir,:)=filter(bb,aa,data(ir,:));
    end
end

% output binary files
% seismic data
if ~isempty(fname_d) && ~isempty(data)
    fid=fopen(fname_d,'w');
    fwrite(fid,data,precision);
    fclose(fid);
end

% P-wave traveltime table
if ~isempty(fname_p) && ~isempty(travelp)
    fid=fopen(fname_p,'w');
    fwrite(fid,travelp,precision);
    fclose(fid);
end

% S-wave traveltime table
if ~isempty(fname_s) && ~isempty(travels)
    fid=fopen(fname_s,'w');
    fwrite(fid,travels,precision);
    fclose(fid);
end

end