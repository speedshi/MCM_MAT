# MCM_MAT
Matlab subroutines to initialize the MCM fortran codes

Developer: Peidong Shi; email: speedshi@hotmail.com

## References

More details about the theory and applications of MCM can be found in:

1. Shi, P., Angus, D., Rost, S., Nowacki, A. and Yuan, S., 2018a. Automated seismic waveform location using Multichannel Coherency Migration (MCM)–I. Theory. _Geophysical Journal International_, 216, 1842&ndash;1866.
doi:[10.1093/gji/ggy132](https://doi.org/10.1093/gji/ggy132)

2. Shi, P., Nowacki, A., Rost, S., Angus, D., 2018b. Automated seismic waveform location using Multichannel Coherency Migration (MCM)–II. Application to induced and volcano-tectonic seismicity. _Geophysical Journal International_, 216, 1608&ndash;1632.
doi:[10.1093/gji/ggy507](https://doi.org/10.1093/gji/ggy507)

Please cite these publications if you use the MCM in your work.

## Descriptions

The Matlab package can generate the required input files in the correct format for the MCM fortran codes (seisloc), such as the waveform file, traveltime file, imaging position file and MCM parameter file. The package reqiures: 
1. seismic data in HDF5 format; 
2. velocity model file in text format (layered or homogeneous); 
3. station information file in IRIS text format. 

For detailed file format, you can check the input file examples.

Note this package calculate traveltime tables using ray-tracing. Earth curvature is not considered. Therefore, this package only applies for local scale problems.

The codes are tested on Matlab 2018b in Linux environment. For windows environment, it may has problems.
'main.m' is the main script which will call some other subroutines in the 'libs' folder. So you should add the 'libs' folder into you Matlab path first before runing the program.

The code now only accept seismic data of HDF5 and SAC format. Other formats will be supported in the future. For the SAC format, a cell array containing the name of SAC files is used as the input for seismic data.

The HDF5 data should be oganized as follows:

 /NETWORK_NAME (contains different stations)

 --/NETWORK_NAME/STATION_NAME (contains different component data)

 ----/NETWORK_NAME/STATION_NAME/COMPONENT_NAME (contains seismic data)

 /_metadata (contains sampling frequency and time information)

 --/_metadata/fe (sampling frequency)

 --/_metadata/t0_UNIX_timestamp (origin time of the data)

You can check the detailed format using the provided data example: 'day_001.h5'.


## Related codes

For reading SAC format, I use rdsac.m which is developed by François Beauducel, [IPGP]
The liscence of rdsac.m is as follow:

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
