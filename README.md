# MCM_MAT
Matlab subroutines to initialize the MCM fortran codes

The Matlab package can generate the required input files in the correct format for the MCM fortran codes (seisloc), such as the waveform file, traveltime file, imaging position file and MCM parameter file. The package reqiures: 1. seismic data in H5 format; 2. velocity model file in text format (layered or homogeneous); 3. station information file in IRIS text format. For detailed file format, you can check the input file examples.

Note this package calculate traveltime tables using ray-tracing. Earth curvature is not considered. Therefore, this package only applies for local scale problems.

The codes are tested on Matlab in Linux environment. For windows environment, it may has problems.
'main.m' is the main script which will call some other subroutines in the 'libs' folder. So you should add the 'libs' folder into you Matlab path first before runing the program.

The code now only accept seismic data of HDF5 format. Other formats will be supported in the future.

The H5 data should be oganized as follows:

 /NETWORK_NAME (contains different stations)

 --/NETWORK_NAME/STATION_NAME (contains single component data)

 ----/NETWORK_NAME/STATION_NAME/COMPONENT_NAME (contains seismic data)

 /_metadata (contains sampling frequency and time information)

 --/_metadata/fe (sampling frequency)

 --/_metadata/t0_UNIX_timestamp (origin time of the data)

You can check the detailed format using the provided data example: 'day_001.h5'.
