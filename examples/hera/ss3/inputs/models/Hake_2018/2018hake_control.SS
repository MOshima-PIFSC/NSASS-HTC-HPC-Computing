#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#C 2018 Hake control file
#_data_and_control_files: 2018hake_data.SS // 2018hake_control.SS
1  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
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
0 #_Nblock_Patterns
#_Cond 0 #_blocks_per_pattern 
# begin and end years of blocks
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
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
20 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
5 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
#_Age_Fecundity by growth pattern from wt-at-age.ss now invoked by read bodywt flag
2 #_First_Mature_Age
# NOTE: maturity options 4 and 5 cause fecundity_at_length to be ignored, but parameters still needed 
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.05 0.4 0.213686 -1.60944 0.1 3 4 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 2 15 5 32 99 0 -5 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 45 60 53.2 50 99 0 -3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.2 0.4 0.3 0.3 99 0 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.03 0.16 0.066 0.1 99 0 -5 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.03 0.16 0.062 0.1 99 0 -5 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 7e-06 7e-06 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -3 3 2.9624 2.9624 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 -3 43 36.89 36.89 99 0 -50 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -3 3 -0.48 -0.48 99 0 -50 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -3 3 1 1 99 0 -50 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -3 3 0 0 99 0 -50 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-05 0.99999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
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
            13            17       14.5614            15            99             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1      0.861909         0.777         0.113             2          4          0          0          0          0          0          0          0 # SR_BH_steep
             1           1.6           1.4           1.1            99             0         -6          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0            99             0        -50          0          0          0          0          0          0          0 # SR_regime
             0             2             0             1            99             0        -50          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1970 # first year of main recr_devs; early devs can precede this era
2016 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1946 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 3 #_recdev_early_phase
 5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1965 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1971 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2016 #_last_yr_fullbias_adj_in_MPD
 2017 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.87 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -6 #min rec_dev
 6 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1946E 1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017F 2018F 2019F 2020F
#  -0.652158 -0.23564 -0.279309 -0.329064 -0.385211 -0.447967 -0.516524 -0.593691 -0.674842 -0.757133 -0.84299 -0.926225 -1.00458 -1.06973 -1.10329 -1.07724 -0.966061 -0.800415 -0.551746 -0.205043 -0.101222 0.791404 0.562396 -0.413666 1.82572 -0.192694 -0.739378 1.5444 -1.06491 0.382804 -1.6166 1.70875 -2.06718 0.150865 2.74609 -1.45731 -1.39627 -0.803724 2.50866 -2.12682 -1.76929 1.75507 0.684724 -2.00698 1.35957 0.205055 -1.94599 1.10207 1.16316 0.244121 0.593069 0.0123531 0.652865 2.55536 -0.955923 0.174651 -3.41841 0.460271 -2.43791 0.91498 0.648703 -3.67234 1.62022 0.244874 2.54511 -0.794883 0.24732 -0.7757 2.00364 -1.75939 0.947235 0 0 0 0
#
#Fishing Mortality info 
0.1 # F ballpark value in units of annual_F
-1999 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
1.5 # max F (methods 2-4) or harvest fraction (method 1)
5  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery 0.117847 0.208163 0.127462 0.185258 0.229759 0.142019 0.0966724 0.111166 0.136934 0.11332 0.094803 0.0615097 0.055639 0.0639834 0.0496808 0.0808971 0.0636506 0.0528505 0.0581786 0.04495 0.0708399 0.0858776 0.0919926 0.129909 0.0978337 0.162105 0.151082 0.126301 0.259021 0.204917 0.267377 0.268941 0.329774 0.360761 0.268804 0.215929 0.141601 0.123246 0.287262 0.315628 0.309268 0.341842 0.425452 0.269046 0.447197 0.395864 0.230735 0.23582 0.216035 0.122181 0.187685 0.396998 0.412046 0.412046 0.412046
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         2         1         0         1         0         1  #  Acoustic_Survey
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -15            15      0.127308             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Acoustic_Survey(2)
          0.05           1.2      0.257245        0.0755           0.1             0          4          0          0          0          0          0          0          0  #  Q_extraSD_Acoustic_Survey(2)
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
 0 0 0 0 # 1 Fishery
 0 0 0 0 # 2 Acoustic_Survey
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
 17 0 0 20 # 1 Fishery
 17 0 0 20 # 2 Acoustic_Survey
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Fishery LenSelex
# 2   Acoustic_Survey LenSelex
# 1   Fishery AgeSelex
         -1002             3         -1000            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P1_Fishery(1)
            -1             1             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P2_Fishery(1)
            -5             9       2.48649            -1          0.01             0          2          0          2       1991       2017          5          0          0  #  AgeSel_P3_Fishery(1)
            -5             9      0.928256            -1          0.01             0          2          0          2       1991       2017          5          0          0  #  AgeSel_P4_Fishery(1)
            -5             9      0.392144            -1          0.01             0          2          0          2       1991       2017          5          0          0  #  AgeSel_P5_Fishery(1)
            -5             9      0.214365            -1          0.01             0          2          0          2       1991       2017          5          0          0  #  AgeSel_P6_Fishery(1)
            -5             9      0.475473            -1          0.01             0          2          0          2       1991       2017          5          0          0  #  AgeSel_P7_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P8_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P9_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P10_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P11_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P12_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P13_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P14_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P15_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P16_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P17_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P18_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P19_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P20_Fishery(1)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P21_Fishery(1)
# 2   Acoustic_Survey AgeSelex
         -1002             3         -1000            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P1_Acoustic_Survey(2)
         -1002             3         -1000            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P2_Acoustic_Survey(2)
            -1             1             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P3_Acoustic_Survey(2)
            -5             9      0.568619            -1          0.01             0          2          0          0          0          0          0          0          0  #  AgeSel_P4_Acoustic_Survey(2)
            -5             9     -0.216172            -1          0.01             0          2          0          0          0          0          0          0          0  #  AgeSel_P5_Acoustic_Survey(2)
            -5             9      0.305286            -1          0.01             0          2          0          0          0          0          0          0          0  #  AgeSel_P6_Acoustic_Survey(2)
            -5             9      0.373829            -1          0.01             0          2          0          0          0          0          0          0          0  #  AgeSel_P7_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P8_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P9_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P10_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P11_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P12_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P13_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P14_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P15_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P16_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P17_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P18_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P19_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P20_Acoustic_Survey(2)
            -5             9             0            -1          0.01             0         -2          0          0          0          0          0          0          0  #  AgeSel_P21_Acoustic_Survey(2)
#_Dirichlet and/or MV Tweedie parameters for composition error
#_multiple_fleets_can_refer_to_same_parm;_but_list_cannot_have_gaps
            -5            20     -0.189215             0            99             0          2          0          0          0          0          0          0          0  #  ln(DM_theta)_Age_P1
            -5            20       2.42702             0            99             0         -2          0          0          0          0          0          0          0  #  ln(DM_theta)_Age_P2
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
        0.0001             2           1.4           0.5           0.5            -1      -5  # AgeSel_P3_Fishery(1)_dev_se
         -0.99          0.99             0             0           0.5            -1      -6  # AgeSel_P3_Fishery(1)_dev_autocorr
        0.0001             2           1.4           0.5           0.5            -1      -5  # AgeSel_P4_Fishery(1)_dev_se
         -0.99          0.99             0             0           0.5            -1      -6  # AgeSel_P4_Fishery(1)_dev_autocorr
        0.0001             2           1.4           0.5           0.5            -1      -5  # AgeSel_P5_Fishery(1)_dev_se
         -0.99          0.99             0             0           0.5            -1      -6  # AgeSel_P5_Fishery(1)_dev_autocorr
        0.0001             2           1.4           0.5           0.5            -1      -5  # AgeSel_P6_Fishery(1)_dev_se
         -0.99          0.99             0             0           0.5            -1      -6  # AgeSel_P6_Fishery(1)_dev_autocorr
        0.0001             2           1.4           0.5           0.5            -1      -5  # AgeSel_P7_Fishery(1)_dev_se
         -0.99          0.99             0             0           0.5            -1      -6  # AgeSel_P7_Fishery(1)_dev_autocorr
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
#      5     3     1     0     0     0     0     1     2  1991  2017     5 0.592354 -0.0215714 -0.0174073 0.0654067 -0.294918 0.494572 0.0560868 0.216799 1.12413 0.622038 0.0304448 0.0188383 -0.00360724 0.265221 -0.00505675 1.00298 0.623543 -0.0245485 0.470303 1.03985 0.0271776 0.108823 0.161674 0.424726 -0.645163 -0.0192438 -0.878769
#      5     4     3     0     0     0     0     2     2  1991  2017     5 0.335393 0.786876 0.788958 0.0998808 0.208178 -0.409939  1.264 0.918307 -0.179413 0.771853 0.932204 0.672251 0.644534 0.366936 0.587011 -0.615109 0.348454 0.355019 0.707846 0.118072 1.06925 0.129174 0.872688 0.299833 0.366352 -1.05568 -0.186413
#      5     5     5     0     0     0     0     3     2  1991  2017     5 -0.836257 -0.160481 0.060425 0.84767 0.236107 -0.263793 -0.132351 -0.613554 0.107826 -0.192513 0.323374 0.555672 0.59563 0.667786 0.637369 0.0501379 -0.264432 -0.524151 -0.136759 0.464491 -0.689207 0.220667 -0.263577 -0.285406 -0.0131412 0.168544 -0.0996913
#      5     6     7     0     0     0     0     4     2  1991  2017     5 -0.0369557 -0.505815 -0.0415495 -0.123593 0.70666 -0.0856415 -0.374172 0.361413 -0.391131 0.185572 -0.17954 0.174456 0.278663 -0.644594 0.399254 0.144839 -0.164821 0.400205 -0.35154 -0.420194 -0.188218 -0.469697 -2.35588e-05 -0.0430091 0.0545444 -0.0590339 0.00443619
#      5     7     9     0     0     0     0     5     2  1991  2017     5 -0.155169 0.0856562 -0.441156 0.105778 -0.126961 0.351942 0.157854 -0.486165 -0.236635 -0.0712506 -0.235559 -0.449424 -0.263695 -0.121808 -0.557894 -0.346538 -0.00502292 -0.177662 0.174912 -0.581363 -0.493821 -0.344713 0.0826472 0.00834964 -0.50342 -0.196723 0.215695
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
1 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 #_CPUE/survey:_1
#  1 #_CPUE/survey:_2
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_init_equ_catch1
#  1 #_init_equ_catch2
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  0 # F_ballpark_lambda
1 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 2 2 -1 4 # Selectivity: (1) 0 to skip or fleet, (2) 1=len/2=age/3=combined, (3) year, (4) N selex bins; NOTE: combined reports in age bins
 0 0 # Growth: (1) 0 to skip or growth pattern, (2) growth ages; NOTE: does each sex
 1 -1 1 # Numbers-at-age: (1) 0 or area(-1 for all), (2) year, (3) N ages;  NOTE: sums across morphs
 2 3 4 5 # vector with selex std bins (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 20 # vector with NatAge std ages (-1 in first bin to self-generate)
999

