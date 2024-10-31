#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#_data_and_control_files: vermilion.dat // vermilion.ctl
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
3 #_Nblock_Patterns
 3 4 1 #_blocks_per_pattern 
# begin and end years of blocks
 1990 2004 2005 2007 2008 2017
 1990 1996 1997 2004 2005 2007 2008 2017
 2008 2016
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
3 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
 #_Age_natmort_by sex x growthpattern (nest GP in sex)
 0.234 0.342 0.287 0.257 0.239 0.228 0.22 0.215 0.212 0.209 0.207 0.206 0.205 0.204 0.204
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
0.5 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
999 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
1 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
2 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
# Sex: 1  BioPattern: 1  Growth
 0.0001 1e+06 11.83 11.83 0 0 -1 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 0.0001 1e+06 34.4 34.4 0 0 -1 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0 1e+06 0.3254 0.3254 0 0 -1 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0 1e+06 0.2535 0.0001 0 0 -1 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0 1e+06 0.2535 0.0001 0 0 -1 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 0 1e+06 2.19e-05 2.19e-05 0 0 -1 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 0 1e+06 2.916 2.916 0 0 -1 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 0 1e+06 14.087 14.087 0 0 -1 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -1 1e+06 -0.574 -0.574 0 0 -1 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 0 1e+06 278.715 278.715 0 0 -1 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 0 1e+06 3.042 3.042 0 0 -1 0 0 0 0 0 0 0 # Eggs_exp_len_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -1 0 0 0 0 0 0 0 # FracFemale_GP_1
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
1  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             0         13.82       10.2109          6.91             0             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
          0.22          0.96      0.729779           0.6          0.74             0          2          0          0          0          0          0          0          0 # SR_BH_steep
             0             2           0.3           0.2             0             0         -3          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             0             0         -3          0          0          0          0          0          0          0 # SR_regime
             0           0.5             0             0             0             0         -2          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1994 # first year of main recr_devs; early devs can precede this era
2017 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1970 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1999.3 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2014.7 #_last_yr_fullbias_adj_in_MPD
 2018.2 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.9293 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
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
#  1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018F 2019F 2020F 2021F 2022F 2023F 2024F 2025F 2026F 2027F
#  -0.499171 -0.25246 -0.243284 -0.173488 -0.274908 0.272084 0.18231 0.154795 0.113741 0.108373 -0.159756 -0.0260478 0.198589 -0.24105 -0.319785 -0.487078 -0.184548 0.139296 0.247648 0.108629 0.260079 0.837106 0.393242 -0.154316 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.5 # F ballpark value in units of annual_F
-2001 # F ballpark year (neg value to disable)
4 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
3 # max F (methods 2-4) or harvest fraction (method 1)
# read list of fleets that do F as parameter; unlisted fleets stay hybrid, bycatch fleets must be included with start_PH=1, high F fleets should switch early
# (A) fleet, (B) F_starting_value (used if start_PH=1), (C) start_PH for parms (99 to stay in hybrid, <0 to stay at starting value)
# (A) (B) (C)  (terminate list with -9999 for fleet)
 1 0.01 2 # CM_E
 2 0.01 2 # CM_W
 3 0.01 2 # REC
 4 0.01 1 # SMP_BYC
-9999 1 1 # end of list
4 #_number of loops for hybrid tuning; 4 good; 3 faster; 2 enough if switching to parms is enabled
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1950 1951 1952 1953 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# CM_E 3.37475e-05 6.74468e-05 0.000102276 0.000137745 0.000174588 0.000212665 0.000251783 0.000292951 0.000336355 0.000382099 0.000431083 0.000481528 0.000531717 0.000579523 0.000641224 0.000644776 0.000340632 0.000699134 0.00140952 0.0018236 0.0017303 0.00192144 0.00172019 0.00293507 0.00281599 0.00619971 0.00551136 0.00756801 0.00660966 0.00512449 0.00380841 0.00561256 0.00591158 0.00947612 0.0136313 0.0178835 0.0192576 0.0157872 0.0153961 0.0156593 0.0394761 0.0335012 0.0451572 0.0667086 0.0688994 0.0722381 0.0613844 0.0609124 0.0510699 0.0625273 0.0496802 0.0557823 0.0648573 0.0728401 0.0576948 0.0852313 0.0910478 0.0919464 0.102781 0.152237 0.0732149 0.142 0.102495 0.0588205 0.0657597 0.0352964 0.0381924 0.038187 0.025589 0.0257864 0.0259762 0.0880878 0.0880878 0.0880878 0.0880878 0.0880878 0.0880878 0.0880878
# CM_W 2.99223e-05 5.99393e-05 9.03009e-05 0.000121407 0.000153529 0.000186752 0.000221128 0.000256858 0.000294201 0.000333598 0.000375431 0.000419737 0.000465634 0.000511236 0.000542103 0.000484045 0.000157082 0.000376457 0.00121814 0.000666328 0.0011102 0.00122231 0.00120266 0.00144267 0.00177821 0.00294881 0.0016532 0.00540741 0.00459511 0.00630138 0.00430919 0.00341012 0.00440949 0.00497415 0.0268228 0.0242879 0.0325368 0.0369959 0.0391729 0.0420968 0.0429874 0.0379924 0.052591 0.0551027 0.0604511 0.041218 0.0442978 0.0797198 0.0732012 0.0981861 0.0727526 0.0900966 0.101084 0.123284 0.114968 0.105299 0.0702682 0.125993 0.0855903 0.0795672 0.061405 0.05723 0.072561 0.0445692 0.0585831 0.0571557 0.0558789 0.0433953 0.0352564 0.032137 0.0291329 0.106743 0.106743 0.106743 0.106743 0.106743 0.106743 0.106743
# REC 0.000146869 0.000398634 0.000660954 0.00093438 0.00121774 0.00151265 0.00181963 0.00214228 0.00248758 0.00286047 0.00325807 0.00365677 0.00401397 0.00433062 0.00465634 0.00500651 0.005382 0.00577466 0.00618858 0.00662743 0.00709657 0.00756465 0.00798697 0.00838221 0.00877352 0.00918035 0.00959678 0.0100504 0.010572 0.0111451 0.0117417 0.0123383 0.0276482 0.0106644 0.0165882 0.0325787 0.0468192 0.0604066 0.0919002 0.0509585 0.069821 0.0913921 0.116275 0.090312 0.0796309 0.117546 0.0504767 0.0910966 0.0486661 0.0978382 0.0578225 0.149132 0.118609 0.10891 0.109214 0.134381 0.125936 0.122281 0.058252 0.0832546 0.0611133 0.147031 0.114565 0.198349 0.17568 0.136378 0.123186 0.140689 0.131923 0.103738 0.111508 0.285922 0.285922 0.285922 0.285922 0.285922 0.285922 0.285922
# SMP_BYC 0.0498025 0.0679097 0.0802092 0.0843452 0.109352 0.113995 0.145763 0.166919 0.204479 0.22049 0.220479 0.166982 0.160828 0.183445 0.193874 0.215364 0.212075 0.231295 0.235266 0.267891 0.252673 0.241416 0.236463 0.240708 0.240163 0.242293 0.252188 0.277413 0.294156 0.308794 0.316241 0.287171 0.273557 0.276559 0.313499 0.303118 0.330869 0.274674 0.251512 0.276154 0.242706 0.253443 0.319617 0.362349 0.554456 0.427143 0.402656 0.414599 0.503302 0.328667 0.263139 0.291188 0.360472 0.308645 0.28453 0.237246 0.154609 0.10701 0.0763106 0.122599 0.091546 0.10958 0.0976433 0.108939 0.0869571 0.0714355 0.073489 0.0796822 0.10078 0.10078 0.10078 0.10078 0.10078 0.10078 0.10078 0.10078 0.10078 0.10078
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         1         1         0         0         0         1  #  CM_E
         2         1         0         0         0         1  #  CM_W
         3         1         0         0         0         1  #  REC
         4         1         0         0         0         0  #  SMP_BYC
         5         1         0         0         0         1  #  HB_E
         6         1         0         0         0         1  #  HB_W
         7         1         0         0         0         1  #  LARVAL
         8         1         0         0         0         1  #  VIDEO
         9         1         0         0         0         1  #  SEAMAP
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -25            25      -8.91224             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CM_E(1)
           -25            25      -8.55918             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_CM_W(2)
           -25            25       -9.5031             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_REC(3)
           -10            20       1.38481             0             0             0          2          0          0          0          0          0          0          0  #  LnQ_base_SMP_BYC(4)
           -25            25      -9.88309             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_HB_E(5)
           -25            25      -9.80357             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_HB_W(6)
           -27            25      -26.2165             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_LARVAL(7)
           -25            25      -10.4736             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_VIDEO(8)
           -25            25      -10.5629             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_SEAMAP(9)
#_no timevary Q parameters
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
 0 2 0 0 # 1 CM_E
 0 2 0 0 # 2 CM_W
 0 2 0 0 # 3 REC
 0 3 0 0 # 4 SMP_BYC
 0 0 0 0 # 5 HB_E
 0 0 0 0 # 6 HB_W
 0 0 0 0 # 7 LARVAL
 24 0 0 0 # 8 VIDEO
 24 0 0 0 # 9 SEAMAP
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
 12 0 0 0 # 1 CM_E
 12 0 0 0 # 2 CM_W
 20 0 0 0 # 3 REC
 19 0 0 0 # 4 SMP_BYC
 15 0 0 3 # 5 HB_E
 15 0 0 3 # 6 HB_W
 0 0 0 0 # 7 LARVAL
 0 0 0 0 # 8 VIDEO
 0 0 0 0 # 9 SEAMAP
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   CM_E LenSelex
            10           100         10.16         10.16            -1             0         -3          0          0          0          0          0          1          2  #  Retain_L_infl_CM_E(1)
            -1            20         1e-06             1            -1             0         -3          0          0          0          0          0          0          0  #  Retain_L_width_CM_E(1)
           -10            10            10            10            -1             0         -2          0          0          0          0          0          1          2  #  Retain_L_asymptote_logit_CM_E(1)
            -1             2             0             0            -1             0         -4          0          0          0          0          0          0          0  #  Retain_L_maleoffset_CM_E(1)
           -10            10            -5            -5            -1             0         -2          0          0          0          0          0          0          0  #  DiscMort_L_infl_CM_E(1)
            -1             2         1e-06             1            -1             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_CM_E(1)
            -1             2          0.15          0.15            -1             0         -2          0          0          0          0          0          3          2  #  DiscMort_L_level_old_CM_E(1)
            -1             2             0             0            -1             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_CM_E(1)
# 2   CM_W LenSelex
            10           100         10.16         10.16            -1             0         -3          0          0          0          0          0          1          2  #  Retain_L_infl_CM_W(2)
            -1            20         1e-06             1            -1             0         -3          0          0          0          0          0          0          0  #  Retain_L_width_CM_W(2)
           -10            10            10            10            -1             0         -2          0          0          0          0          0          1          2  #  Retain_L_asymptote_logit_CM_W(2)
            -1             2             0             0            -1             0         -4          0          0          0          0          0          0          0  #  Retain_L_maleoffset_CM_W(2)
           -10            10            -5            -5            -1             0         -2          0          0          0          0          0          0          0  #  DiscMort_L_infl_CM_W(2)
            -1             2         1e-06             1            -1             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_CM_W(2)
            -1             2          0.15          0.15            -1             0         -2          0          0          0          0          0          3          2  #  DiscMort_L_level_old_CM_W(2)
            -1             2             0             0            -1             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_CM_W(2)
# 3   REC LenSelex
            10           100         10.16         10.16            -1             0         -3          0          0          0          0          0          2          2  #  Retain_L_infl_REC(3)
            -1            20         1e-06             1            -1             0         -3          0          0          0          0          0          0          0  #  Retain_L_width_REC(3)
           -10            10            10            10            -1             0         -2          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_REC(3)
            -1             2             0             0            -1             0         -4          0          0          0          0          0          0          0  #  Retain_L_maleoffset_REC(3)
           -10            10            -5            -5            -1             0         -2          0          0          0          0          0          0          0  #  DiscMort_L_infl_REC(3)
            -1             2         1e-06             1            -1             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_REC(3)
            -1             2          0.15          0.15            -1             0         -2          0          0          0          0          0          3          2  #  DiscMort_L_level_old_REC(3)
            -1             2             0             0            -1             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_REC(3)
# 4   SMP_BYC LenSelex
# 5   HB_E LenSelex
# 6   HB_W LenSelex
# 7   LARVAL LenSelex
# 8   VIDEO LenSelex
           7.5          52.5       19.2273          42.7          0.05             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_peak_VIDEO(8)
           -10             3      -1.57475          -0.4          0.05             0          3          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_VIDEO(8)
            -6            12       1.10006           5.5          0.05             0          3          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_VIDEO(8)
            -4             6       1.30636           5.1          0.05             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_VIDEO(8)
           -15             5      -1.47843          -4.2          0.05             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_VIDEO(8)
            -8             5      0.597499           0.4          0.05             0          2          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_VIDEO(8)
# 9   SEAMAP LenSelex
           7.5          52.5       14.7632            13          0.05             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_peak_SEAMAP(9)
           -10             3      -4.08901          -1.1          0.05             0          3          0          0          0          0        0.5          0          0  #  Size_DblN_top_logit_SEAMAP(9)
            -6            12       1.26273           3.1          0.05             0          3          0          0          0          0        0.5          0          0  #  Size_DblN_ascend_se_SEAMAP(9)
            -4             6       3.14557             5          0.05             0         -3          0          0          0          0        0.5          0          0  #  Size_DblN_descend_se_SEAMAP(9)
           -15             5      -1.21335          -4.5          0.05             0         -2          0          0          0          0        0.5          0          0  #  Size_DblN_start_logit_SEAMAP(9)
            -8             5      -5.30605           0.1          0.05             0          2          0          0          0          0        0.5          0          0  #  Size_DblN_end_logit_SEAMAP(9)
# 1   CM_E AgeSelex
           0.5            14       2.11995          2.66             0             0          3          0          0          0          0          0          0          0  #  Age_inflection_CM_E(1)
           0.5            14      0.916154        7.2774             0             0          1          0          0          0          0          0          0          0  #  Age_95%width_CM_E(1)
# 2   CM_W AgeSelex
           0.5            14       3.68075          2.66             0             0          3          0          0          0          0          0          0          0  #  Age_inflection_CM_W(2)
           0.5            14       2.09661        7.2774             0             0          1          0          0          0          0          0          0          0  #  Age_95%width_CM_W(2)
# 3   REC AgeSelex
             1            10       3.33276           4.3          0.05             0          2          0          0          0          0        0.5          0          0  #  Age_DblN_peak_REC(3)
           -10             3      -9.16507          -4.6          0.05             0          3          0          0          0          0        0.5          0          0  #  Age_DblN_top_logit_REC(3)
            -6            12      0.549862           0.7          0.05             0          3          0          0          0          0        0.5          0          0  #  Age_DblN_ascend_se_REC(3)
            -4             6       2.95273           2.7          0.05             0          3          0          0          0          0        0.5          0          0  #  Age_DblN_descend_se_REC(3)
           -15             5      -12.1035         -11.2          0.05             0          2          0          0          0          0        0.5          0          0  #  Age_DblN_start_logit_REC(3)
            -8             5      -1.82948          -3.3          0.05             0          2          0          0          0          0        0.5          0          0  #  Age_DblN_end_logit_REC(3)
# 4   SMP_BYC AgeSelex
         1e-07             2           0.5           0.5             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P1_SMP_BYC(4)
           0.5         1e+07           100           100             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P2_SMP_BYC(4)
           0.3             3           1.5           1.5             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P3_SMP_BYC(4)
           0.5         1e+07        2.4096        2.4096             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P4_SMP_BYC(4)
            -1             1             0             0             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P5_SMP_BYC(4)
            -1             1             0             0             0             0         -4          0          0          0          0          0          0          0  #  AgeSel_P6_SMP_BYC(4)
# 5   HB_E AgeSelex
# 6   HB_W AgeSelex
# 7   LARVAL AgeSelex
# 8   VIDEO AgeSelex
# 9   SEAMAP AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
            10           100         20.32         20.32            -1             0      -4  # Retain_L_infl_CM_E(1)_BLK1repl_1990
            10           100         27.94         27.94            -1             0      -4  # Retain_L_infl_CM_E(1)_BLK1repl_2005
            10           100          25.4          25.4            -1             0      -4  # Retain_L_infl_CM_E(1)_BLK1repl_2008
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_CM_E(1)_BLK1repl_1990
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_CM_E(1)_BLK1repl_2005
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_CM_E(1)_BLK1repl_2008
            -1             2          0.15          0.15            -1             0      -4  # DiscMort_L_level_old_CM_E(1)_BLK3repl_2008
            10           100         20.32         20.32            -1             0      -4  # Retain_L_infl_CM_W(2)_BLK1repl_1990
            10           100         27.94         27.94            -1             0      -4  # Retain_L_infl_CM_W(2)_BLK1repl_2005
            10           100          25.4          25.4            -1             0      -4  # Retain_L_infl_CM_W(2)_BLK1repl_2008
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_CM_W(2)_BLK1repl_1990
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_CM_W(2)_BLK1repl_2005
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_CM_W(2)_BLK1repl_2008
            -1             2          0.15          0.15            -1             0      -4  # DiscMort_L_level_old_CM_W(2)_BLK3repl_2008
            10           100         20.32         20.32            -1             0      -4  # Retain_L_infl_REC(3)_BLK2repl_1990
            10           100          25.4          25.4            -1             0      -4  # Retain_L_infl_REC(3)_BLK2repl_1997
            10           100         27.94         27.94            -1             0      -4  # Retain_L_infl_REC(3)_BLK2repl_2005
            10           100          25.4          25.4            -1             0      -4  # Retain_L_infl_REC(3)_BLK2repl_2008
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_REC(3)_BLK2repl_1990
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_REC(3)_BLK2repl_1997
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_REC(3)_BLK2repl_2005
           -10            10            10            10            -1             0      -4  # Retain_L_asymptote_logit_REC(3)_BLK2repl_2008
            -1             2          0.15          0.15            -1             0      -4  # DiscMort_L_level_old_REC(3)_BLK3repl_2008
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
#      5     1     1     1     2     0     0     0     0     0     0     0
#      5     3     4     1     2     0     0     0     0     0     0     0
#      5     7     7     3     2     0     0     0     0     0     0     0
#      5     9     8     1     2     0     0     0     0     0     0     0
#      5    11    11     1     2     0     0     0     0     0     0     0
#      5    15    14     3     2     0     0     0     0     0     0     0
#      5    17    15     2     2     0     0     0     0     0     0     0
#      5    19    19     2     2     0     0     0     0     0     0     0
#      5    23    23     3     2     0     0     0     0     0     0     0
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
 -9999   1    0  # terminator
#
10 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 3 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 2 1 1 0 1
 2 2 1 0 1
 2 3 1 0 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_1
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_2
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_5
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_6
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_7
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_8
#  1 1 1 1 1 1 1 1 1 1 #_CPUE/survey:_9
#  0 0 0 0 0 0 0 0 0 0 #_discard:_1
#  0 0 0 0 0 0 0 0 0 0 #_discard:_2
#  0 0 0 0 0 0 0 0 0 0 #_discard:_3
#  1 1 1 1 1 1 1 1 1 1 #_discard:_4
#  0 0 0 0 0 0 0 0 0 0 #_discard:_5
#  0 0 0 0 0 0 0 0 0 0 #_discard:_6
#  0 0 0 0 0 0 0 0 0 0 #_discard:_7
#  0 0 0 0 0 0 0 0 0 0 #_discard:_8
#  0 0 0 0 0 0 0 0 0 0 #_discard:_9
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_1
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_2
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_3
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_4
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_5
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_6
#  0 0 0 0 0 0 0 0 0 0 #_lencomp:_7
#  1 1 1 1 1 1 1 1 1 1 #_lencomp:_8
#  1 1 1 1 1 1 1 1 1 1 #_lencomp:_9
#  1 1 1 1 1 1 1 1 1 1 #_agecomp:_1
#  1 1 1 1 1 1 1 1 1 1 #_agecomp:_2
#  1 1 1 1 1 1 1 1 1 1 #_agecomp:_3
#  0 0 0 0 0 0 0 0 0 0 #_agecomp:_4
#  0 0 0 0 0 0 0 0 0 0 #_agecomp:_5
#  0 0 0 0 0 0 0 0 0 0 #_agecomp:_6
#  0 0 0 0 0 0 0 0 0 0 #_agecomp:_7
#  0 0 0 0 0 0 0 0 0 0 #_agecomp:_8
#  0 0 0 0 0 0 0 0 0 0 #_agecomp:_9
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch1
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch2
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch3
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch4
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch5
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch6
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch7
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch8
#  1 1 1 1 1 1 1 1 1 1 #_init_equ_catch9
#  1 1 1 1 1 1 1 1 1 1 #_recruitments
#  1 1 1 1 1 1 1 1 1 1 #_parameter-priors
#  1 1 1 1 1 1 1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 1 1 1 1 1 1 #_crashPenLambda
#  0 0 0 0 0 0 0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

