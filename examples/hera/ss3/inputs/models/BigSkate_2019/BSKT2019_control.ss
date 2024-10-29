#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#C Control file Big Skate 2019
#_data_and_control_files: BSKT2019_data.ss // BSKT2019_control.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
 1 13 #_blocks_per_pattern 
# begin and end years of blocks
 1995 2004
 2005 2005 2006 2006 2007 2007 2008 2008 2009 2009 2010 2010 2011 2011 2012 2012 2013 2013 2014 2014 2015 2015 2016 2016 2017 2030
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
8 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
999 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
2 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
5 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
2 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.1 0.6 0.449208 -1.02165 0.438 3 3 0 0 0 0 0.5 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 10 40 20.0821 20 99 0 2 0 0 0 0 0.5 0 0 # L_at_Amin_Fem_GP_1
 100 300 175.663 200 99 0 2 0 0 0 0 0.5 0 0 # Linf_Fem_GP_1
 0.005 30 12.1407 0.15 99 0 1 0 0 0 0 0.5 0 0 # VonBert_K_Fem_GP_1
 0.1 10 5.61009 1 99 0 3 0 0 0 0 0.5 0 0 # Cessation_Fem_GP_1
 1 20 5.70274 0.1 99 0 5 0 0 0 0 0.5 0 0 # SD_young_Fem_GP_1
 1 20 7.08412 0.1 99 0 5 0 0 0 0 0.5 0 0 # SD_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 3 7.49e-06 7.49e-06 99 0 -3 0 0 0 0 0.5 0 0 # Wtlen_1_Fem_GP_1
 2 4 2.9925 2.9925 99 0 -3 0 0 0 0 0.5 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 10 150 148.245 148.245 99 0 -3 0 0 0 0 0.5 0 0 # Mat50%_Fem_GP_1
 -0.15 -0.05 -0.13155 -0.13155 99 0 -3 0 0 0 0 0.5 0 0 # Mat_slope_Fem_GP_1
 -3 3 1 1 99 0 -3 0 0 0 0 0.5 0 0 # Eggs/kg_inter_Fem_GP_1
 -3 3 0 0 99 0 -3 0 0 0 0 0.5 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 -3 3 0 0 99 0 -2 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 -1 1 0 0 99 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 -1 1 -0.373076 0 99 0 2 0 0 0 0 0 0 0 # Linf_Mal_GP_1
 -10 20 0.100981 0 99 0 3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 -3 3 0.2 0 99 0 -3 0 0 0 0 0 0 0 # Cessation_Mal_GP_1
 -1 1 0 0 99 0 -5 0 0 0 0 0 0 0 # SD_young_Mal_GP_1
 -1 1 0 0 99 0 -5 0 0 0 0 0 0 0 # SD_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 0 3 7.49e-06 7.49e-06 99 0 -3 0 0 0 0 0.5 0 0 # Wtlen_1_Mal_GP_1
 2 4 2.9925 2.9925 99 0 -3 0 0 0 0 0.5 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0 2 1 1 99 0 -5 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 0.001 0.999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             5            15       8.90469          11.1            10             0          3          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1           0.4           0.6           0.2             0         -3          0          0          0          0          0          0          0 # SR_BH_steep
             0           0.4           0.3           0.3           0.8             0         -2          0          0          0          0          0          0          0 # SR_sigmaR
            -2             2             0             0            99             0         -1          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1995 # first year of main recr_devs; early devs can precede this era
2018 # last year of main recr_devs; forecast devs start in following year
-3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 -4 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1995 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1970 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2016 #_last_yr_fullbias_adj_in_MPD
 2018 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.3 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F 2028F 2029F 2030F
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.2 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
4 # max F (methods 2-4) or harvest fraction (method 1)
4  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1916 1917 1918 1919 1920 1921 1922 1923 1924 1925 1926 1927 1928 1929 1930 1931 1932 1933 1934 1935 1936 1937 1938 1939 1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery_current 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00820125 0.0236213 0.0406443 0.0150063 0.0215979 0.0275518 0.0165284 0.0157468 0.0254428 0.0187679 0.021822 0.0259376 0.0173257 0.0241431 0.0125687 0.0120808 0.0158286 0.0148761 0.00845097 0.0228761 0.0171259 0.0229867 0.0150539 0.00977745 0.0177086 0.0177041 0.0793707 0.0785533 0.0778268 0.0771003 0.0763738 0.0756473 0.0750116 0.0742851 0.0735586 0.0729229
# Discard_historical 0 0.000609734 0.00122028 0.00183729 0.00245138 0.00306793 0.0036873 0.00431482 0.00494083 0.00557065 0.00620462 0.00684813 0.00749141 0.00813978 0.00879351 0.00945794 0.0101231 0.0107942 0.0114714 0.0121602 0.0128504 0.0135474 0.0142515 0.0125769 0.0139753 0.0135514 0.0155838 0.0174114 0.0184764 0.0191218 0.0197412 0.0203841 0.0208412 0.0215702 0.0217079 0.0218153 0.0219192 0.0220617 0.0221944 0.0222931 0.0223882 0.0224627 0.0225329 0.0226003 0.0226682 0.0227606 0.0228689 0.0229608 0.0230463 0.0231062 0.0231489 0.023204 0.0232862 0.0233646 0.0233946 0.0233961 0.0234058 0.0234315 0.0234555 0.023479 0.0235141 0.0235581 0.0236487 0.0238024 0.0238898 0.0239387 0.0240085 0.0240292 0.024018 0.0240079 0.0240127 0.0240123 0.0240117 0.0240023 0.0239977 0.0240027 0.0240052 0.0240068 0.0240136 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# Fishery_historical 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.00480353 0.0034925 0.00585052 0.00330289 0.00115139 0.000515796 0.000736292 0.00103584 0.00132772 0.00201099 0.00217875 0.00203967 0.00170626 0.00265362 0.00726658 0.00242913 0.00477052 0.00266416 0.00301513 0.0022626 0.0027594 0.00232885 0.00586346 0.00458085 0.00507935 0.00481271 0.003018 0.00340601 0.00452221 0.00658194 0.00439669 0.00170296 0.00130448 0.00215086 0.00252218 0.00168318 0.00253336 0.0031684 0.00394662 0.00910176 0.0120671 0.00350885 0.00984365 0.00607959 0.00486291 0.00202733 0.00406536 0.002343 0.00265908 0.00164251 0.00156752 0.00215571 0.00275715 0.00223693 0.00311084 0.00314272 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# Fishery_tribal 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 6.19831e-05 7.4378e-05 0 6.19456e-06 6.19585e-06 0 3.71813e-05 6.19866e-06 6.15541e-06 6.10197e-06 1.22474e-05 1.22533e-05 2.43433e-05 1.82259e-05 2.42265e-05 0.00028879 0.00032404 0.00027574 0.000939154 0.00149123 0.0011912 0.000191181 0.0010418 0.000738623 0.00155225 0.0024403 0.000513697 0.00166624 0.00447577 0.00456022 0.00353266 0.00178613 0.00318284 0.00318239 0.0144993 0.01435 0.0142172 0.0140845 0.0139518 0.0138191 0.013703 0.0135703 0.0134375 0.0133214
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         5         1         0         1         0         0  #  WCGBTS
         6         1         0         1         0         0  #  Triennial
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -2             2     -0.403308        -0.355         0.326             6          1          0          0          0          0          0          0          0  #  LnQ_base_WCGBTS(5)
             0             2      0.163264          0.01            99             0          1          0          0          0          0          0          0          0  #  Q_extraSD_WCGBTS(5)
           -10             2       -1.2524             0            99             0          1          0          0          0          0          0          1          2  #  LnQ_base_Triennial(6)
             0             2      0.365954          0.01            99             0          1          0          0          0          0          0          0          0  #  Q_extraSD_Triennial(6)
# timevary Q parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type     PHASE  #  parm_name
            -7             0     -0.934511             0            99             0      1  # LnQ_base_Triennial(6)_BLK1repl_1995
# info on dev vectors created for Q parms are reported with other devs after tag parameter section 
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 2 4 0 # 1 Fishery_current
 15 0 0 1 # 2 Discard_historical
 15 0 0 1 # 3 Fishery_historical
 15 0 0 1 # 4 Fishery_tribal
 24 0 4 0 # 5 WCGBTS
 24 0 4 0 # 6 Triennial
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 0 0 0 0 # 1 Fishery_current
 0 0 0 0 # 2 Discard_historical
 0 0 0 0 # 3 Fishery_historical
 0 0 0 0 # 4 Fishery_tribal
 0 0 0 0 # 5 WCGBTS
 0 0 0 0 # 6 Triennial
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Fishery_current LenSelex
            80           150       94.1114            85            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_Fishery_current(1)
           -15             4           -15           -15            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Fishery_current(1)
            -1             9       7.15331           5.8            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Fishery_current(1)
            -1            20            20           6.7            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Fishery_current(1)
          -999             9          -999          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Fishery_current(1)
          -999             9          -999          -999            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Fishery_current(1)
            15           150       66.2144            67            99             0          2          0          0          0          0          0          0          0  #  Retain_L_infl_Fishery_current(1)
           0.1            10       4.87637             8            99             0          2          0          0          0          0          0          0          0  #  Retain_L_width_Fishery_current(1)
           -10            20       2.05182            10            99             0          3          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_Fishery_current(1)
             0             0             0             0            99             0         -3          0          0          0          0          0          0          0  #  Retain_L_maleoffset_Fishery_current(1)
             5            15             5             5            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_infl_Fishery_current(1)
             0            10             0             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_Fishery_current(1)
             0             1           0.5           0.5            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_level_old_Fishery_current(1)
             0             0             0             0            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_Fishery_current(1)
           -50            50      -5.52193             0            99             0          4          0          0          0          0          0          0          0  #  SzSel_Fem_Peak_Fishery_current(1)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Ascend_Fishery_current(1)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Descend_Fishery_current(1)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Final_Fishery_current(1)
           0.5           1.5      0.743963             1            99             0          4          0          0          0          0          0          0          0  #  SzSel_Fem_Scale_Fishery_current(1)
# 2   Discard_historical LenSelex
# 3   Fishery_historical LenSelex
# 4   Fishery_tribal LenSelex
# 5   WCGBTS LenSelex
            50           150       76.1473            85            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_WCGBTS(5)
           -15             4           -15           -15            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_WCGBTS(5)
            -1             9       6.49771           5.8            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_WCGBTS(5)
            -1            20       16.5483           6.7            99             0          5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_WCGBTS(5)
          -999             9            -5          -999            99             0         -4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_WCGBTS(5)
          -999             9          -999          -999            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_WCGBTS(5)
           -50            50       -7.9747             0            99             0          4          0          0          0          0          0          0          0  #  SzSel_Fem_Peak_WCGBTS(5)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Ascend_WCGBTS(5)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Descend_WCGBTS(5)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Final_WCGBTS(5)
           0.5           1.5      0.698111             1            99             0          4          0          0          0          0          0          0          0  #  SzSel_Fem_Scale_WCGBTS(5)
# 6   Triennial LenSelex
            50           200       187.543            75            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_peak_Triennial(6)
           -15             4           -15           -15            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Triennial(6)
            -1             9       8.47236             9            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Triennial(6)
            -1            20            20           7.2            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Triennial(6)
           -15             9      -4.79417            -5            99             0          4          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Triennial(6)
          -999             9          -999          -999            99             0         -5          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Triennial(6)
           -50            50             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Peak_Triennial(6)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Ascend_Triennial(6)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Descend_Triennial(6)
            -5             5             0             0            99             0         -4          0          0          0          0          0          0          0  #  SzSel_Fem_Final_Triennial(6)
           0.5           1.5      0.606512             1            99             0          4          0          0          0          0          0          0          0  #  SzSel_Fem_Scale_Triennial(6)
# 1   Fishery_current AgeSelex
# 2   Discard_historical AgeSelex
# 3   Fishery_historical AgeSelex
# 4   Fishery_tribal AgeSelex
# 5   WCGBTS AgeSelex
# 6   Triennial AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
           -10            20       2.30033           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2005
           -10            20       3.30395           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2006
           -10            20       3.96299           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2007
           -10            20       11.0793           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2008
           -10            20       4.91241           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2009
           -10            20       13.2418           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2010
           -10            20       14.6406           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2011
           -10            20       13.8921           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2012
           -10            20       3.45566           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2013
           -10            20       3.62006           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2014
           -10            20         3.405           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2015
           -10            20       2.88476           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2016
           -10            20       2.81719           0.6            99             0      4  # Retain_L_asymptote_logit_Fishery_current(1)_BLK2repl_2017
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      3     3     1     1     2     0     0     0     0     0     0     0
#      5     9     2     2     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      4      1  0.239885
      4      5   0.06742
      4      6         1
      5      1  0.084412
      5      5  0.053605
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 1 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 7 5 1 0 99
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  0 #_CPUE/survey:_2
#  0 #_CPUE/survey:_3
#  0 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  1 #_CPUE/survey:_6
#  1 #_discard:_1
#  0 #_discard:_2
#  0 #_discard:_3
#  0 #_discard:_4
#  0 #_discard:_5
#  0 #_discard:_6
#  1 #_meanbodywt:1
#  1 #_meanbodywt:2
#  1 #_meanbodywt:3
#  1 #_meanbodywt:4
#  1 #_meanbodywt:5
#  1 #_meanbodywt:6
#  1 #_lencomp:_1
#  0 #_lencomp:_2
#  0 #_lencomp:_3
#  0 #_lencomp:_4
#  1 #_lencomp:_5
#  1 #_lencomp:_6
#  1 #_agecomp:_1
#  0 #_agecomp:_2
#  0 #_agecomp:_3
#  0 #_agecomp:_4
#  1 #_agecomp:_5
#  0 #_agecomp:_6
#  0 #_size-age:_1
#  0 #_size-age:_2
#  0 #_size-age:_3
#  0 #_size-age:_4
#  0 #_size-age:_5
#  0 #_size-age:_6
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_init_equ_catch3
#  1 #_init_equ_catch4
#  1 #_init_equ_catch5
#  1 #_init_equ_catch6
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

