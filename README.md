# MCM_MAT
Matlab subroutines to initialize the MCM fortran codes

The codes are tested on Matlab in Linux environment. For windows environment, it may has problems.
'main.m' is the main script which will call some other subroutines in the 'libs' folder. So you should add the 'libs' folder into you Matlab path first before runing the program.

The code now only accept seismic data of HDF5 format. Other formats will be supported in the future.

The H5 data should be oganized as follows:

 /NETWORK_NAME (contains different stations)

   /NETWORK_NAME/STATION_NAME (contains single component data)

   /NETWORK_NAME/STATION_NAME/COMPONENT_NAME (contains seismic data)

 /_metadata (contains sampling frequency and time information)

   /_metadata/fe (sampling frequency)
   
   /_metadata/t0_UNIX_timestamp (origin time of the data)
