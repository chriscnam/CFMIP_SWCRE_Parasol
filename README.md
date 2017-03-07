# CFMIP_SWCRE_Parasol
Shortwave Cloud Radiative Effects and Parasol Reflectance for a given non-overlapped low-level cloud cover

The plots show the shortwave cloud radiative effects and Parasol reflectance for a given nonoverlapped
low-level cloud cover in tropical subsidence zones; more specifically, when omega500hPa and
omega700hPa is greater than 10 hPa day-1 and high- and mid-level cloud cover is less than 5%.

# REFERENCE:
Nam, C., S. Bony, J.-L. Dufresne, and H. Chepfer, The "too few, too bright" tropical low-cloud problem in CMIP5 models, Geophys. Res. Lett., 39, L21801, doi:10.1029/2012GL053421, 2012.

# Model Input Variables
| Frequency |	Variable |	Variable labels |	Unit |	Example File |
| ------------- | ------------- | ------------- | ------------- | ------------- |
| Monthly | Surface pressure | ps | Pa | ps_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Surface temperature | ts | K | ts_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Temperature | ta | K | ta_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Vertical Velocity | wap | Pa s-1 | wap_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | TOA Shortwave Cloud Radiative Effect | rsut |W m-2 | rsut_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | TOA Shortwave Cloud Radiative Effect (Clear Sky) | rsutcs | w | W m-2 | rsutcs_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | High-level Cloud Fraction COSP lidar simulator | clhcalipso | % | clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Mid-level Cloud Fraction COSP lidar simulator | clmcalipso | % | clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Low-level Cloud Fraction COSP lidar simulator | cllcalipso | % | cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc
| | Cloud Reflectance PARASOL | parasolRefl | 1 | parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc

# Era Interim Re-analysis Input Variables
| Frequency |	Variable |	Variable labels |	Unit |	
| ------------- | ------------- | ------------- | ------------- | 
| Monthly | Vertical velocity | w | Pa s-1 |

# Obs4MIPS Input Variables
| Frequency |	Variable |	Variable labels |	Unit |	
| ------------- | ------------- | ------------- | ------------- | 
| Monthly | High-level Cloud fraction CALIPSO-GOCCP |	clhcalipso |	% 	|
| | Mid-level Cloud fraction CALIPSO-GOCCP | clmcalipso |	% 	|
| |	Low-level Cloud Fraction CALIPSO-GOCCP |	cllcalipso |	% |
| | Cloud Reflectance PARASOL | parasolRefl | 1 | 
| | TOA Shortwave Cloud Radiative Effect CERES | rsut |W m-2 |
| | TOA Shortwave Cloud Radiative Effect (Clear Sky) CERES | rsutcs | w | W m-2 |
 


