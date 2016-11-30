load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl"
load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

begin

;===============================================================
; This script contains a panel of 2 plots of:
; 1) Shortwave Cloud Radiative Effect (CERES observations & Model CRE)
; 2) Parasol Reflectance (PARASOL observations & Model with Parasol simulator)
; for tropical (30N to 30S) non-verlapped low-level cloud conditions (where high and mid level clouds are less than 5%).
;
; This NCL script has been made for example data 2008. Variable names follow CMIP5 convention.
; 
; You need to make the following changes (find 'Metric'): 
; 1)File format of output file (example: pdf or eps) & Choose color table
; 2)Title of output file
; 3)Directories of input files and working directory
; 4)Input files
;
; Christine Nam
;    Laboratoire de Météorologie Dynamique
;    Institut Pierre Simon Laplace
;    Centre National de la Recherche Scientifique
;    Paris, France
;    Nov. 2012
; 
; Support of this work came from the EUCLIPSE project - European Union, Seventh Framework Programme (FP7/2007–2013) grant 244067. 
;
;===============================================================
; FILE INFORMATION
; --------------------------------------------------------------
; example: wks = gsn_open_wks("Metric1","Metric2")
  wks = gsn_open_wks("pdf","IPSL5Bamip_SWCRE_LowCld_2008")  ;file type: "x11";"pdf";"eps"

  plot = new(3,graphic)              ; create plot array

  cmap = RGBtoCmap("RGBmatlab.txt")     ; CNam: personalized color table.
  gsn_define_colormap(wks, cmap) 	;
;  gsn_define_colormap(wks,"matlab_jet"); CNam: uncomment for NCL predefined table


;===============================================================
; MODELS with COSP Calipso and Parasol satellite simulators
; --------------------------------------------------------------
; example: directoryA = "/Metric3/" ; Directory of CRE data
;	   directoryB = "/Metric3/" ; Directory of COSP simulator
;	   directoryC = "/Metric3/" ; Working Directory
  directoryA = "/prodigfs/esg/CMIP5/merge/IPSL/IPSL-CM5B-LR/amip/mon/atmos/Amon/r1i1p1/v20120526/"
  directoryB = "/prodigfs/esg/CMIP5/merge/IPSL/IPSL-CM5B-LR/amip/mon/atmos/cfMon/r1i1p1/v20120526/"
  directoryC = "/data/cnlmd/CMIP5_AMIP_Metric/"

; --------------------------------------------------------------
; Extracting variables for 2008 from original AMIP files. 
; --------------------------------------------------------------
; example: systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryA+"Metric4_origfile "+directoryC+"Metric4_2008file"
     extract1=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryA+"rsut/rsut_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"rsut_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract2=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryA+"rsutcs/rsutcs_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"rsutcs_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract3=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,50000 -selyear,2008 "+directoryA+"wap/wap_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"wap500_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract4=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,70000 -selyear,2008 "+directoryA+"wap/wap_Amon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"wap700_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")


     extract5=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"clhcalipso/clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract6=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"clmcalipso/clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract7=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"cllcalipso/cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")
     extract8=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryB+"parasolRefl/parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_197901-200812.nc "+directoryC+"parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc")


; --------------------------------------------------------------
; Cloud Radiative Effect files
; --------------------------------------------------------------
	file101="wap500_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc" 	; "Metric4"
	file102="wap700_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file103="rsut_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file104="rsutcs_Amon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
   apple  = addfile(directoryC+file101,"r")
   pear   = addfile(directoryC+file102,"r")
   orange = addfile(directoryC+file103,"r")
   cherry = addfile(directoryC+file104,"r")

; --------------------------------------------------------------
; COSP simulator files
; --------------------------------------------------------------
	file201 = "clhcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc" ; "Metric4"
	file202 = "clmcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
	file203 = "cllcalipso_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc" 
	file204 = "parasolRefl_cfMon_IPSL-CM5B-LR_amip_r1i1p1_Tropic2008.nc"
   lychee   = addfile(directoryC+file201,"r")
   pineapple= addfile(directoryC+file202,"r")
   starfruit= addfile(directoryC+file203,"r")
   plum     = addfile(directoryC+file204,"r")


;===============================================================
;===============================================================
; MODEL 
;===============================================================
;===============================================================
; -------------------------------------------------------------
; Import variables
; -------------------------------------------------------------
   IPSL5B_lat=apple->lat
     print(IPSL5B_lat)
     nlat=dimsizes(IPSL5B_lat)  ;
   IPSL5B_lon=apple->lon
     ;print(IPSL5B_lon)
     nlon=dimsizes(IPSL5B_lon)

   IPSL5B_time=apple->time(:)
      ntime = dimsizes(IPSL5B_time)

   IPSL5B_SW_full=orange->rsut(:,:,:)  
   IPSL5B_SW_clear=cherry->rsutcs(:,:,:) 
	IPSL5B_SW_full@_FillValue=1e20
	IPSL5B_SW_clear@_FillValue=1e20

   IPSL5B_omega500= apple->wap(time|:,plev|0,lat|:,lon|:)
   IPSL5B_omega700= pear->wap(time|:,plev|0,lat|:,lon|:)
	IPSL5B_omega500@_FillValue=1.e+20
	IPSL5B_omega700@_FillValue=1.e+20		
   printVarSummary(IPSL5B_omega500)


   IPSL5B_Highcld=lychee->clhcalipso(:,:,:)
	IPSL5B_Highcld@_FillValue=1e20
   IPSL5B_Midcld=pineapple->clmcalipso(:,:,:)
	IPSL5B_Midcld@_FillValue=1e20
   IPSL5B_Lowcld=starfruit->cllcalipso(:,:,:)
	IPSL5B_Lowcld@_FillValue=1e20
   IPSL5B_parasol=plum->parasolRefl(:,:,:,:)
	IPSL5B_parasol@_FillValue=1e20

;---------------------------------------------------------------
; Parasol Linear Interpolation of COSP output
;---------------------------------------------------------------
   sza=fspan(0,80,5)
        nsza=dimsizes(sza)
        print(sza)

        tadpole=asciiread("/home/cnlmd/NCL_scripts/parasol_sza_30S30N.txt",(/32,12/),"float")
        tadpole!0="lat"
        tadpole!1="month"
        tadpole&lat=IPSL5B_lat
        tadpole&lat@units = "degrees_north"
        printVarSummary(tadpole)
        printMinMax(tadpole,True)
        tadpolelat=tadpole&lat

; CNam: 'Frog' is for non-ipsl models with different 'nlat'
        frog=linint1_Wrap(tadpolelat,tadpole(month|:,lat|:),False,IPSL5B_lat, 0) 
        printVarSummary(frog)
        printMinMax(frog,True)

        ;---------------------------------------------------------------
        IPSL5B_PRefl=new((/ntime,nlat,nlon/),float)
        IPSL5B_PRefl!0="time"
        IPSL5B_PRefl!1="lat"
        IPSL5B_PRefl!2="lon"
        IPSL5B_PRefl&lat=IPSL5B_lat
        IPSL5B_PRefl&lon=IPSL5B_lon
        ;---------------------------------------------------------------

   do m=0,(ntime-1)
     do l=0,(nlat-1)
     do k=0,(nlon-1)
     do i=0,(nsza-2)
         if (frog(m,l).ge. sza(i) .and. frog(m,l).lt.sza(i+1)) then
            IPSL5B_PRefl(m,l,k)= IPSL5B_parasol(m,i,l,k) + ((frog(m,l)-sza(i))*((IPSL5B_parasol(m,i+1,l,k)-IPSL5B_parasol(m,i,l,k))/(sza(i+1)-sza(i))))
         end if
     end do ; i         
     end do ;k
     end do ;l 
  end do ;m

  printVarSummary(IPSL5B_PRefl)
        delete(frog)
        delete(IPSL5B_parasol)


; -------------------------------------------------------------
; Define Variables for Calculations
; -------------------------------------------------------------
   ;----- 1. Define Variables for CRE Calculations -----
   CldRange=fspan(0,100,21)
     ;print(CldRange)
     ncld=dimsizes(CldRange)

   IPSL5B_SW_CRE=IPSL5B_SW_clear-IPSL5B_SW_full
	IPSL5B_SW_CRE@_FillValue=1e20
	IPSL5B_SW_CRE!0      = "time"            ; assign dimension names
	IPSL5B_SW_CRE!1      = "lat"             ; assign dimension names
	IPSL5B_SW_CRE!2      = "lon"             ; assign dimension names
        IPSL5B_SW_CRE&time   = apple->time(:)    		
	IPSL5B_SW_CRE&lat    = apple->lat(:)           
	IPSL5B_SW_CRE&lon    = apple->lon(:)
	IPSL5B_SW_CRE&lat@units="degrees_north"
	IPSL5B_SW_CRE&lon@units="degrees_east"
	printVarSummary(IPSL5B_SW_CRE)

   IPSL5B_SW_CREavg=dim_avg_Wrap(IPSL5B_SW_CRE(lat|:,lon|:,time|:))


   IPSL5B_avg_SWcre=new((/ncld/),float)
     IPSL5B_avg_SWcre(:)=0.0
     IPSL5B_avg_SWcre@_FillValue=-999
   IPSL5B_cnt_SWcre=new((/ncld/),float)
     IPSL5B_cnt_SWcre(:)=0.0
     IPSL5B_cnt_SWcre@_FillValue=-999
   IPSL5B_ind_SWcre=new((/ncld/),integer)
     IPSL5B_ind_SWcre(:)=0
     IPSL5B_ind_SWcre@_FillValue=-999


   ;----- 3. Define Variables for Parasol Calculations -----     

   IPSL5B_avg_PRefl=new((/ncld/),float)
     IPSL5B_avg_PRefl(:)=0.0
     IPSL5B_avg_PRefl@_FillValue=-999
   IPSL5B_cnt_PRefl=new((/ncld/),float)
     IPSL5B_cnt_PRefl(:)=0.0
     IPSL5B_cnt_PRefl@_FillValue=-999
   IPSL5B_ind_PRefl=new((/ncld/),integer)
     IPSL5B_ind_PRefl(:)=0
     IPSL5B_ind_PRefl@_FillValue=-999



;==================== 3D-CloudFraction Histo ================================
; *NOTE: .ge.0.0001 specific to IPSL_5B model
;	".ge. & .lt." in ".gt.CldRange(i) .and. .le.CldRange(i)+5"
;=============================================================================
 do m=0,(ntime-1)
   do l=0,(nlat-1)
   do k=0,(nlon-1)
        ;*** ONLY LOW: High and Mid < 5% *** 
 	if (.not.ismissing(IPSL5B_Lowcld(m,l,k)) .and. .not.ismissing(IPSL5B_PRefl(m,l,k))) then
	if (IPSL5B_Lowcld(m,l,k).ge.0.0001 .and. IPSL5B_Midcld(m,l,k).le.5 .and. IPSL5B_Highcld(m,l,k).le.5) then
        ;*** Find Subsidence ***
        if ((IPSL5B_omega700(m,l,k)*864.).ge.10. .and.(IPSL5B_omega500(m,l,k)*864.).ge.10.) then   
        do i=0,(ncld-1)
          if (IPSL5B_Lowcld(m,l,k).ge. CldRange(i) .and. IPSL5B_Lowcld(m,l,k).lt.CldRange(i)+5) then
		IPSL5B_cnt_PRefl(i) = IPSL5B_cnt_PRefl(i) + IPSL5B_PRefl(m,l,k)
		IPSL5B_ind_PRefl(i) = IPSL5B_ind_PRefl(i) + 1
		IPSL5B_cnt_SWcre(i) = IPSL5B_cnt_SWcre(i) + IPSL5B_SW_CRE(m,l,k)
		IPSL5B_ind_SWcre(i) = IPSL5B_ind_SWcre(i) + 1
	  end if
	end do ; i
        end if
	;*** 
	end if
	end if
   end do ;k
   end do ;l
   end do ;m



;********** Cloud Radiative Effect **********
;------------- Shallowocumulus ---------------
  do i=0,(ncld-1)
	if (IPSL5B_ind_SWcre(i).eq.0) then
           IPSL5B_cnt_SWcre(i) = -999
	   IPSL5B_ind_SWcre(i) = 1
	end if    
; If there are fewer than X points, set to missing value
;       if (IPSL5B_ind_SWcre(i).le.X) then
;           IPSL5B_cnt_SWcre(i) = -999
;       end if
  end do

  print(IPSL5B_ind_SWcre)
  IPSL5B_avg_SWcre=IPSL5B_cnt_SWcre/IPSL5B_ind_SWcre
  print(IPSL5B_avg_SWcre)
 

; ********** Parasol Refl  **********
;------------- Shallow Cumulus -------------
  do i=0,(ncld-1)
	if (IPSL5B_ind_PRefl(i).eq.0) then
           IPSL5B_cnt_PRefl(i) = -999
	   IPSL5B_ind_PRefl(i) = 1
	end if
  end do

  print(IPSL5B_ind_PRefl)
  IPSL5B_avg_PRefl=IPSL5B_cnt_PRefl/IPSL5B_ind_PRefl
  print(IPSL5B_avg_PRefl)



;===============================================================
;===============================================================
; SATELLITE OBSERVATIONS
;===============================================================
;===============================================================
; Extracting variables for 2008 from original AMIP files. 
; --------------------------------------------------------------
   directoryD = "/data/cnlmd/Satellites_v20110323/GOCCP_Monthly/" ; Metric 3: GOCCP data
   directoryE = "/data/cnlmd/Satellites_v20110323/CERES/"	  ; Metric 3: CERES data
   directoryF = "/data/cnlmd/Satellites_v20110323/ERA_interim/"   ; Metric 3: ERA-Interim data

     extract9=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryD+"MapLowMidHigh330m_2008_avg_CFMIP2_sat_2.1.nc "+directoryC+"MapLowMidHigh330m_avg_CFMIP2_sat_2.1_Tropic2008.nc")
     extract10=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryD+"REFL1DIR_PARASOL_grid2x2_200606_200812_CFMIP2.nc "+directoryC+"REFL1DIR_PARASOL_grid2x2_CFMIP2_Tropic2008.nc")
     extract11=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryE+"rsut_CERES-EBAF_L4_Ed2-6_2008.nc "+directoryC+"rsut_CERES-EBAF_L4_Ed2-6_Tropic2008.nc")
     extract12=systemfunc("cdo sellonlatbox,-180,180,-30,30 -selyear,2008 "+directoryE+"rsutcs_CERES-EBAF_L4_Ed2-6_2008.nc "+directoryC+"rsutcs_CERES-EBAF_L4_Ed2-6_Tropic2008.nc")
     extract13=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,500 -selyear,2008 "+directoryF+"w3d_erai_200606-200812_S15.nc "+directoryC+"w3d500_erai_S15_Tropic2008.nc")
     extract14=systemfunc("cdo sellonlatbox,-180,180,-30,30 -sellevel,700 -selyear,2008 "+directoryF+"w3d_erai_200606-200812_S15.nc "+directoryC+"w3d700_erai_S15_Tropic2008.nc")

; --------------------------------------------------------------

      file301 = "MapLowMidHigh330m_avg_CFMIP2_sat_2.1_Tropic2008.nc"	  ; Metric 4
      file302 = "REFL1DIR_PARASOL_grid2x2_CFMIP2_Tropic2008.nc"  
   peach = addfile(directoryC+file301,"r")
   fig   = addfile(directoryC+file302,"r")
      printVarSummary(fig)   ; overview of var


      file401 = "rsut_CERES-EBAF_L4_Ed2-6_Tropic2008.nc"
      file402 = "rsutcs_CERES-EBAF_L4_Ed2-6_Tropic2008.nc"
   kiwi   = addfile(directoryC+file401,"r")
   banana = addfile(directoryC+file402,"r")


     file501 = "w3d500_erai_S15_Tropic2008.nc"
     file502 = "w3d700_erai_S15_Tropic2008.nc"
   grape    = addfile(directoryC+file501,"r")
   appricot = addfile(directoryC+file502,"r")

; -------------------------------------------------------------
; import variable: reorder the data's longitude coordinates
; -------------------------------------------------------------
   OBS_lat=peach->latitude
   OBS_lon=peach->longitude
       ilon=dimsizes(peach->longitude(:))
       jlat=dimsizes(peach->latitude(:))

   Satellite_Highcld_in=peach->clhcalipso(:,:,:)
     Satellite_Highcld_in@_FillValue = -9999
     Satellite_High=Satellite_Highcld_in*100
     Satellite_High!0="time"
     Satellite_High!1="latitude"
     Satellite_High!2="longitude"
     Satellite_High&latitude=peach->latitude(:)
     Satellite_High&longitude=peach->longitude(:)
     Satellite_High&latitude@units="degrees_north"
     Satellite_High&longitude@units="degrees_east"
     printVarSummary(Satellite_High)

   Satellite_Midcld_in=peach->clmcalipso(:,:,:)
     Satellite_Midcld_in@_FillValue = -9999
     Satellite_Mid=Satellite_Midcld_in*100
     Satellite_Mid!0="time"
     Satellite_Mid!1="latitude"
     Satellite_Mid!2="longitude"
     Satellite_Mid&latitude=peach->latitude(:)
     Satellite_Mid&longitude=peach->longitude(:)
     Satellite_Mid&latitude@units="degrees_north"
     Satellite_Mid&longitude@units="degrees_east"
     printVarSummary(Satellite_Mid)

   Satellite_Lowcld_in=peach->cllcalipso(:,:,:)
     Satellite_Lowcld_in@_FillValue = -9999
     Satellite_Low=Satellite_Lowcld_in*100
     Satellite_Low!0="time"
     Satellite_Low!1="latitude"
     Satellite_Low!2="longitude"
     Satellite_Low&latitude=peach->latitude(:)
     Satellite_Low&longitude=peach->longitude(:)
     Satellite_Low&latitude@units="degrees_north"
     Satellite_Low&longitude@units="degrees_east"
     printVarSummary(Satellite_Low)

   Satellite_PRefl=fig->reflectance(:,:,:)
   if (any(isnan_ieee(Satellite_PRefl))) then
      replace_ieeenan(Satellite_PRefl,-9999., 0)
   end if
     Satellite_PRefl@_FillValue = -9999   
     Satellite_PRefl&latitude=peach->latitude(:)
     Satellite_PRefl&longitude=peach->longitude(:) 
     Satellite_PRefl&latitude@units="degrees_north"
     Satellite_PRefl&longitude@units="degrees_east"
     printVarSummary(Satellite_PRefl)

; -------------------------------------------------------------
; CERES observations have different lat lon co-ordinates than GOCCP
; -------------------------------------------------------------
   CERES_SW_full=f2fsh_Wrap(kiwi->rsut(:,:,:),(/jlat,ilon/))
   CERES_SW_full@_FillValue=1.e+20
     CERES_SW_full!1="latitude"
     CERES_SW_full!2="longitude"
     CERES_SW_full&latitude=peach->latitude(:)
     CERES_SW_full&longitude=peach->longitude(:) 
     CERES_SW_full&latitude@units="degrees_north"
     CERES_SW_full&longitude@units="degrees_east"
        printVarSummary(CERES_SW_full)

   CERES_SW_clear=f2fsh_Wrap(banana->rsutcs(:,:,:),(/jlat,ilon/))
   CERES_SW_clear@_FillValue=1.e+20
     CERES_SW_clear!0="time"
     CERES_SW_clear!1="latitude"
     CERES_SW_clear!2="longitude"
     CERES_SW_clear&time=peach->time(:)
     CERES_SW_clear&latitude=peach->latitude(:)
     CERES_SW_clear&longitude=peach->longitude(:) 
     CERES_SW_clear&latitude@units="degrees_north"
     CERES_SW_clear&longitude@units="degrees_east"
        printVarSummary(CERES_SW_clear)


   CERES_SW_CRE=CERES_SW_clear-CERES_SW_full
     CERES_SW_CRE!0      = "time"             ; assign dimension names
     CERES_SW_CRE!1      = "latitude"             ; assign dimension names
     CERES_SW_CRE!2      = "longitude"             ; assign dimension names  
     CERES_SW_CRE&latitude=peach->latitude(:)
     CERES_SW_CRE&longitude=peach->longitude(:) 
     CERES_SW_CRE&latitude@units="degrees_north"
     CERES_SW_CRE&longitude@units="degrees_east"
     printVarSummary(CERES_SW_CRE)

   CERES_SW_CREavg=dim_avg_Wrap(CERES_SW_CRE(latitude|:,longitude|:,time|:))
     printMinMax(CERES_SW_CREavg, True)


; -------------------------------------------------------------
; ERA-Interim have different lat lon co-ordinates than GOCCP
; -------------------------------------------------------------
   ERA_omega500_inA=short2flt(grape->w(:,0,::-1,:))
   ERA_omega500=f2fsh_Wrap(ERA_omega500_inA,(/jlat,ilon/))
        ERA_omega500@_FillValue=-32767
        ERA_omega500!1="lat"
        ERA_omega500!2="lon"
        ERA_omega500&lat=peach->latitude(:)
        ERA_omega500&lon=peach->longitude(:) 
        ERA_omega500&lat@units="degrees_north"
        ERA_omega500&lon@units="degrees_east"
	printVarSummary(ERA_omega500)

   ERA_omega700_inA=short2flt(grape->w(:,0,::-1,:))
   ERA_omega700=f2fsh_Wrap(ERA_omega700_inA,(/jlat,ilon/))
        ERA_omega700@_FillValue=-32767
        ERA_omega700!1="lat"
        ERA_omega700!2="lon"
        ERA_omega700&lat=peach->latitude(:)
        ERA_omega700&lon=peach->longitude(:) 
        ERA_omega700&lat@units="degrees_north"
        ERA_omega700&lon@units="degrees_east"
        ;printVarSummary(ERA_omega700)


; -------------------------------------------------------------
; ERA-Interim have different lat lon co-ordinates than GOCCP
; -------------------------------------------------------------
   ERA_omega500_inA=short2flt(grape->w(:,0,::-1,:))
   ERA_omega500=f2fsh_Wrap(ERA_omega500_inA,(/jlat,ilon/))
	printVarSummary(ERA_omega500)
        ERA_omega500@_FillValue=-32767
        ERA_omega500!1="latitude"
        ERA_omega500!2="longitude"
        ERA_omega500&latitude=peach->latitude(:)
        ERA_omega500&longitude=peach->longitude(:) 
        ERA_omega500&latitude@units="degrees_north"
        ERA_omega500&longitude@units="degrees_east"
	printVarSummary(ERA_omega500)

   ERA_omega700_inA=short2flt(grape->w(:,0,::-1,:))
   ERA_omega700=f2fsh_Wrap(ERA_omega700_inA,(/jlat,ilon/))
        ERA_omega700@_FillValue=-32767
        ERA_omega700!1="latitude"
        ERA_omega700!2="longitude"
        ERA_omega700&latitude=peach->latitude(:)
        ERA_omega700&longitude=peach->longitude(:) 
        ERA_omega700&latitude@units="degrees_north"
        ERA_omega700&longitude@units="degrees_east"
        ;printVarSummary(ERA_omega700)


; -------------------------------------------------------------
; Define Variables for Calculations
; -------------------------------------------------------------
    ;----- 1. Define Variables for CRE Calculations -----

   Satellite_avg_SWcre=new((/ncld/),float)
     Satellite_avg_SWcre(:)=0.0
     Satellite_avg_SWcre@_FillValue=-9999
   Satellite_cnt_SWcre=new((/ncld/),float)
     Satellite_cnt_SWcre(:)=0.0
     Satellite_cnt_SWcre@_FillValue=-9999
   Satellite_ind_SWcre=new((/ncld/),float)
     Satellite_ind_SWcre(:)=0

   ;----- 1. Define Variables for Parasol Calculations -----

   Satellite_avg_PRefl=new((/ncld/),float)
     Satellite_avg_PRefl(:)=0.0
     Satellite_avg_PRefl@_FillValue=-9999
   Satellite_cnt_PRefl=new((/ncld/),float)
     Satellite_cnt_PRefl(:)=0.0
     Satellite_cnt_PRefl@_FillValue=-9999
   Satellite_ind_PRefl=new((/ncld/),float)
     Satellite_ind_PRefl(:)=0


;===================================================================
; BEGIN CALCULATIONS
;===================================================================
 do m=0,(ntime-1)
   do l=0,(jlat-1)
   do k=0,(ilon-1)
        ;*** ONLY LOW: High and Mid < 5% ***
 	if (.not. ismissing(Satellite_Low(m,l,k)) .and. .not. ismissing(Satellite_Mid(m,l,k)) .and. .not. ismissing(Satellite_High(m,l,k)) .and. .not.ismissing( Satellite_PRefl(m,l,k))) then
	if (Satellite_Low(m,l,k).gt.0.0001 .and. Satellite_Mid(m,l,k).le.5 .and. Satellite_High(m,l,k).le.5) then 
        ;*** SEPERATE: Shallow Cu and Strato Cu ***
     do i=0,(ncld-1)
     if ((ERA_omega700(m,l,k)*864.).ge.10. .and.(ERA_omega500(m,l,k)*864.).ge.10.) then   
        if (Satellite_Low(m,l,k).ge. CldRange(i) .and. Satellite_Low(m,l,k).lt.CldRange(i)+5) then
	   Satellite_cnt_SWcre(i) = Satellite_cnt_SWcre(i) + CERES_SW_CRE(m,l,k)
	   Satellite_ind_SWcre(i) = Satellite_ind_SWcre(i) + 1
	   Satellite_cnt_PRefl(i) = Satellite_cnt_PRefl(i) + Satellite_PRefl(m,l,k)
	   Satellite_ind_PRefl(i) = Satellite_ind_PRefl(i) + 1
	end if
	;----------
     end if   ; separation of ShCu and StratCu
     end do ;i
        end if 
	end if
   end do ;k
   end do ;l
   end do ;m


; ********** Shortwave Cloud Radiative Effect  **********
  do i=0,(ncld-1)
	if (Satellite_ind_SWcre(i).eq.0) then
           Satellite_cnt_SWcre(i) = -9999
	   Satellite_ind_SWcre(i) = 1
	end if
; If there are fewer than X points, set to missing value
      if (Satellite_ind_SWcre(i).le.1) then
           Satellite_cnt_SWcre(i) = -9999
       end if
  end do

 print(Satellite_ind_SWcre)
 Satellite_avg_SWcre=Satellite_cnt_SWcre/Satellite_ind_SWcre
     print(Satellite_avg_SWcre)
    ;Satellite_onlylowshapePDF=Satellite_ind_SWcre/(sum(Satellite_ind_SWcre))



; ********** PRefl scatter  **********
  do i=0,(ncld-1)
	if (Satellite_ind_PRefl(i).eq.0) then
           Satellite_cnt_PRefl(i) = -9999
	   Satellite_ind_PRefl(i) = 1
	end if
      if (Satellite_ind_PRefl(i).le.1) then
           Satellite_cnt_PRefl(i) = -9999
       end if
  end do

  print(Satellite_ind_PRefl)
  Satellite_avg_PRefl=Satellite_cnt_PRefl/Satellite_ind_PRefl
     print(Satellite_avg_PRefl)
    ;Satellite_onlylowshapePDF=Satellite_ind_PRefl/(sum(Satellite_ind_PRefl))


;===================================================================
;===================================================================
; COLLECT ALL DATA TO PLOT
;===================================================================
;===================================================================
; Summary of SW CRE data
  data1      = new((/2,ncld/),float)   
  data1(0,:) = Satellite_avg_SWcre
  data1(1,:) = IPSL5B_avg_SWcre

; Summary of Parasol data
  data2      = new((/2,ncld/),float)   ;
  data2(0,:) = Satellite_avg_PRefl
  data2(1,:) = IPSL5B_avg_PRefl


;===================================================================
; Plot 1 : Scatter plot
;===================================================================
  res001                      = True              ; enable plot options
  res001@gsnMaximize          = True              ; Maximize plot in frame.
  res001@gsnDraw              = False              ; don't draw
  res001@gsnFrame             = False              ; don't advance frame

  res001@tiMainFont           =21		; hevelica
  res001@tiXAxisFont          =21
  res001@tiYAxisFont	      =21
  res001@tmXBLabelFont        =21
  res001@tmYLLabelFont        =21

  res001@tiMainString         = "SW CRE TROPICS 2008 (Monthly)"  ;Main title
  res001@tiXAxisString        = "Low Cloud Cover"  
  res001@tiYAxisString        = "SW CRE"
  res001@tiMainFontHeightF   = 0.035
  res001@tiXAxisFontHeightF   = 0.035
  res001@tiYAxisFontHeightF   = 0.035
  res001@tmXBLabelFontHeightF  = 0.035
  res001@tmYLLabelFontHeightF  = 0.035

  res001@xyMarkLineModes   = (/1,1,1,1,1,1,1,1,1,1/)        ; choose which have markers 0-"Lines",1-"Markers"
  res001@xyMarkers         = (/16,16,16,16,16,16,16,16,16,16/)                       ; choose type of marker  
  res001@xyMarkerSizeF     = (/0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02/)  
  res001@xyMarkerColors    = (/"black","red","blue","darkgreen","orange","brown","springgreen","steelblue3","grey"/) ; Marker color
  res001@xyLineThicknesses = (/5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0/)             ; make 2nd lines thicker
  res001@xyLineColors      = (/"black","red","blue","darkgreen","orange","brown","springgreen","steelblue3","grey"/)
  res001@xyDashPatterns    = (/0,0,0,0,0,0,0,0,0,0/)                         ; choose dash patterns                      ; choose dash patterns

  res001@pmLegendDisplayMode = "Always" 
  res001@lgPerimOn = False
  res001@pmLegendSide = "Top"
  res001@pmLegendOrthogonalPosF = -0.35
  res001@pmLegendParallelPosF = 0.70
  res001@pmLegendWidthF = 0.175
  res001@pmLegendHeightF = 0.10
  res001@lgLabelFont = 21
  res001@lgLabelFontHeightF = 0.018
  res001@xyExplicitLegendLabels = (/"CERES 2008","IPSL 5B"/)

  res001@xyLineThicknessF=3.0

  res001@tmXBMode       = "Explicit"
  res001@tmXBValues 	= (/0,20,40,60,80,100/)
  res001@tmXBLabels 	= (/"0","20","40","60","80","100"/)
  res001@trYMaxF	= 0
  res001@trYMinF	= -150

  res001@tmXTBorderOn      = True ; kills border line (x-axis top)
  res001@tmYRBorderOn      = True ; kills border line (y-axis right)
  res001@tmXTOn            = False ; kills tick marks (x-axis top)
  res001@tmYROn            = False ; kills tick marks (y-axis right)

  plot(0) = gsn_csm_xy(wks,CldRange,data1,res001) ;good


;===================================================================
; Plot 2: Scatter plot
;===================================================================
  res002                      = True              ; enable plot options
  res002@gsnMaximize          = True              ; Maximize plot in frame.
  res002@gsnDraw              = False              ; don't draw
  res002@gsnFrame             = False              ; don't advance frame

  res002@tiMainFont           =21		; hevelica
  res002@tiXAxisFont          =21
  res002@tiYAxisFont	      =21
  res002@tmXBLabelFont        =21
  res002@tmYLLabelFont        =21

  res002@tiMainString         = "Parasol TROPICS 2008 (monthly)"  ;Main title
  res002@tiXAxisString        = "Low Cloud Cover"  
  res002@tiYAxisString        = "Parasol Reflectivity"
  res002@tiMainFontHeightF   = 0.035
  res002@tiXAxisFontHeightF   = 0.035
  res002@tiYAxisFontHeightF   = 0.035
  res002@tmXBLabelFontHeightF  = 0.035
  res002@tmYLLabelFontHeightF  = 0.035

  res002@xyMarkLineModes   = (/1,1,1,1,1,1,1,1,1,1/)         ; choose which have markers 0-"Lines",1-"Markers"
  res002@xyMarkers         = (/16,16,16,16,16,16,16,16,16,16/)                       ; choose type of marker  
  res002@xyMarkerSizeF     = (/0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02,0.02/)  
  res002@xyMarkerColors    = (/"black","red","blue","darkgreen","orange","brown","springgreen","steelblue3","grey"/) ; Marker color
  res002@xyLineThicknesses = (/5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0,5.0/)             ; make 2nd lines thicker
  res002@xyLineColors      = (/"black","red","blue","darkgreen","orange","brown","springgreen","steelblue3","grey"/)
  res002@xyDashPatterns    = (/0,0,0,0,0,0,0,0,0,0/)                         ; choose dash patterns                     ; choose dash patterns

  res002@pmLegendDisplayMode = "Always" 
  res002@lgPerimOn = False
  res002@pmLegendSide = "Top"
  res002@pmLegendOrthogonalPosF = -0.35
  res002@pmLegendParallelPosF = 0.70
  res002@pmLegendWidthF = 0.175
  res002@pmLegendHeightF = 0.10
  res002@lgLabelFont = 21
  res002@lgLabelFontHeightF = 0.018
  res002@xyExplicitLegendLabels = (/"Parasol 2008","IPSL 5B"/)

  res002@xyLineThicknessF=3.0

  res002@tmXBMode       = "Explicit"
  res002@tmXBValues 	= (/0,20,40,60,80,100/)
  res002@tmXBLabels 	= (/"0","20","40","60","80","100"/)
  res002@trYMaxF	= 0.5
  res002@trYMinF	= 0

  res002@tmXTBorderOn      = True ; kills border line (x-axis top)
  res002@tmYRBorderOn      = True ; kills border line (y-axis right)
  res002@tmXTOn            = False ; kills tick marks (x-axis top)
  res002@tmYROn            = False ; kills tick marks (y-axis right)

  plot(1) = gsn_csm_xy(wks,CldRange,data2,res002) ;good



;======================================================================
; PANEL PLOT 
;======================================================================
  res_Panel                     = True      ; modify the panel plot
  res_Panel@gsnMaximize         = True      ; maximize plot 

  res_Panel@gsnPanelYWhiteSpacePercent = 3

  res_Panel@lbAutoManage                = False           ; manual   
              

;======================================================================
  gsn_panel(wks,plot,(/1,2/),res_Panel)             ; now draw as one plot




;======================================================================  
; Contour Map: For double checking purposes
;======================================================================  
  res003                      = True               ; enable plot options
  res003@gsnFrame             = True               ; advance frame
  res003@gsnDraw              = True               ; draw 
  res003@gsnMaximize          = True               ; Maximize plot in frame.
  res003@cnFillOn             = True               ; Fill contours
  res003@cnFillMode           = "RasterFill"       ; Blocks vs. Smooth
  res003@cnLinesOn            = False              ; Contour lines off
  res003@cnMinLevelValF       = 0.                 ; min contour
  res003@cnMaxLevelValF       = 100                ; max contour
  res003@cnLevelSpacingF      = 5              ; interval of contours
  res003@gsnSpreadColors      = True               ; spread colors around 0
  res003@gsnSpreadColorStart  = 1                  ; start at color XXX in colormap
  res003@tiMainString         = "CERES SW CRE 2008"  ;Main title
  res003@gsnLeftString        = ""                 ; string at left top of plot
  res003@lbTitlePosition      = 1                  ; colorbar title position
  res003@lbTitleString        = ""       ; colorbar title
  res003@lbOrientation        = "vertical"

  res003@tmXTBorderOn      = True ; kills border line (x-axis top)
  res003@tmYRBorderOn      = True ; kills border line (y-axis right)
  res003@tmXTOn            = False ; kills tick marks (x-axis top)
  res003@tmYROn            = False ; kills tick marks (y-axis right)
  res003@tmXBLabelFontHeightF  = 0.025
  res003@tmYLLabelFontHeightF  = 0.025
  res003@lbLabelFontHeightF    = 0.025

  res003@lbLabelFont		        =21
  res003@lbLabelStride =4

  res003@mpGridAndLimbOn   = False           ; turn on lat/lon lines
  res003@mpPerimOn         = False 	      ; turn off perimeter  
  res003@mpProjection = "Robinson"       
  res003@mpGeophysicalLineThicknessF = 3.0

  res003@cnLabelBarEndStyle = "ExcludeOuterBoxes"


  plot = gsn_csm_contour_map(wks,CERES_SW_CREavg,res003)            ; plot contour map


end
