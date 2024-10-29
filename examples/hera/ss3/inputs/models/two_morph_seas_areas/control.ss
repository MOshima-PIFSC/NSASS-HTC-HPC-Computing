#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#C growth parameters are estimated
#C spawner-recruitment bias adjustment Not tuned For optimality
#_data_and_control_files: data.ss // control.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
2  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
3 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
2 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 1 1 0
 2 1 2 0
#
4 #_N_movement_definitions
1 # first age that moves (real age at begin of season, not integer)
# seas,GP,source_area,dest_area,minage,maxage
 1 1 1 2 4 10
 1 1 2 1 4 10
 1 2 1 2 4 10
 1 2 2 1 4 10
#
1 #_Nblock_Patterns
 1 #_blocks_per_pattern 
# begin and end years of blocks
 1970 1970
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
0 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
25 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
1 #_First_Mature_Age
1 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms;  if N_GP>1, then nest GP within sex in parameters below
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.05 0.15 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 -10 45 20.0023 36 10 6 2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 40 90 71.2679 70 10 6 4 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.05 0.25 0.157608 0.15 0.8 6 4 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 2.44e-06 2.44e-06 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -3 4 3.34694 3.34694 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 50 60 55 55 0.8 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -3 3 -0.25 -0.25 0.8 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -3 3 1 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_1
 -3 3 0 0 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_1
# Sex: 1  BioPattern: 2  NatMort
 0.05 0.15 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_2
# Sex: 1  BioPattern: 2  Growth
 -10 45 19.5063 36 10 6 2 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_2
 40 90 70.6148 70 10 6 4 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_2
 0.05 0.25 0.164439 0.15 0.8 6 4 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_2
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_2
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_2
# Sex: 1  BioPattern: 2  WtLen
 -3 3 2.44e-06 2.44e-06 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_2
 -3 4 3.34694 3.34694 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_2
# Sex: 1  BioPattern: 2  Maturity&Fecundity
 50 60 55 55 0.8 0 -3 0 0 0 0 0 0 0 # Mat50%_Fem_GP_2
 -3 3 -0.25 -0.25 0.8 0 -3 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_2
 -3 3 1 1 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_inter_Fem_GP_2
 -3 3 0 0 0.8 0 -3 0 0 0 0 0 0 0 # Eggs/kg_slope_wt_Fem_GP_2
# Sex: 2  BioPattern: 1  NatMort
 0.05 0.15 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 -10 45 22.0052 36 10 6 2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 40 90 69.5894 70 10 6 4 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.05 0.25 0.16149 0.15 0.8 6 4 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 -3 3 2.44e-06 2.44e-06 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 -3 4 3.34694 3.34694 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Sex: 2  BioPattern: 2  NatMort
 0.05 0.15 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_2
# Sex: 2  BioPattern: 2  Growth
 -10 45 21.9515 36 10 6 2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_2
 40 90 69.1762 70 10 6 4 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_2
 0.05 0.25 0.16525 0.15 0.8 6 4 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_2
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_young_Mal_GP_2
 0.05 0.25 0.1 0.1 0.8 0 -3 0 0 0 0 0 0 0 # CV_old_Mal_GP_2
# Sex: 2  BioPattern: 2  WtLen
 -3 3 2.44e-06 2.44e-06 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_2
 -3 4 3.34694 3.34694 0.8 0 -3 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_2
# Hermaphroditism
#  Recruitment Distribution 
 -5 5 0 0 0 0 -4 0 0 0 0 0 0 0 # RecrDist_GP_1_area_1_month_1
 -5 5 0 0 0 0 -4 0 2 1971 2001 5 0 0 # RecrDist_GP_2_area_2_month_1
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_A_seas_1_GP_1from_1to_2
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_B_seas_1_GP_1from_1to_2
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_A_seas_1_GP_1from_2to_1
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_B_seas_1_GP_1from_2to_1
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_A_seas_1_GP_2from_1to_2
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_B_seas_1_GP_2from_1to_2
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_A_seas_1_GP_2from_2to_1
 -8 5 -6 0 0 0 -4 0 0 0 0 0 0 0 # MoveParm_B_seas_1_GP_2from_2to_1
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_2
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 0.0001 2 0.05 0.5 0.5 6 -5 # RecrDist_GP_2_area_2_month_1_dev_se
 -0.99 0.99 0 0 0.5 6 -6 # RecrDist_GP_2_area_2_month_1_dev_autocorr
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
1  #  SR_update_SSBpR0
#  0 - OK, but only if no timevary biology or SR parm
#  1 - best: update SSBpR0 for benchmark and for time series only if SRparm R0 or h (not regime) is set to have time-varying property
#  2 - incorrect (old, incorrect SS3 approach):  always update SSBpR0 for benchmark's use of spawner-recruitment, but only for the time series if there is a timevary SR parm
#  3 - option:  do not update SSBpR0 (do keep start year SSBpR0), even if R0 or h is set to have time-varying property
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             3            31       9.50866          10.3            10             0          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.2             1       0.63828           0.7          0.05             1          4          0          0          0          0          0          0          0 # SR_BH_steep
             0             2           0.6           0.8           0.8             0         -4          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0             1             0         -4          0          0          0          0          0          0          0 # SR_regime
             0             0             0             0             0             0        -99          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
1 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1971 # first year of main recr_devs; early devs can precede this era
2001 # last year of main recr_devs; forecast devs start in following year
2 #_recdev phase 
1 # (0/1) to read 13 advanced options
 0 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 -4 #_recdev_early_phase
 0 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1900 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1900 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2001 #_last_yr_fullbias_adj_in_MPD
 2002 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 1 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
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
#  1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 1980R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R
#  0.0618202 -0.0109003 0.0906261 -0.220163 0.124909 0.68784 -0.0754579 0.0186113 0.324604 0.123436 0.0546181 -0.203232 -0.478855 -0.39098 0.507898 0.362641 0.348551 0.0318673 -0.375789 0.545755 -0.518636 -0.686157 -0.410671 0.117448 -0.485283 0.583759 0.855842 -0.486369 -0.301148 -0.131941 -0.0646449#
#Fishing Mortality info 
0.3 # F ballpark value in units of annual_F
-2001 # F ballpark year (neg value to disable)
3 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
2.95 # max F (methods 2-4) or harvest fraction (method 1)
4  # N iterations for tuning in hybrid mode; recommend 3 (faster) to 5 (more precise if many fleets)
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 0
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet x season
# Yr:  1971 1971 1972 1972 1973 1973 1974 1974 1975 1975 1976 1976 1977 1977 1978 1978 1979 1979 1980 1980 1981 1981 1982 1982 1983 1983 1984 1984 1985 1985 1986 1986 1987 1987 1988 1988 1989 1989 1990 1990 1991 1991 1992 1992 1993 1993 1994 1994 1995 1995 1996 1996 1997 1997 1998 1998 1999 1999 2000 2000 2001 2001
# seas:  1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2 1 2
# FISH_A1 0 0 0.00225799 0 0.0113502 0 0.0114537 0 0.0232347 0 0.035695 0 0.0492111 0 0.0642055 0 0.0811051 0 0.115413 0 0.157364 0 0.174141 0 0.193766 0 0.217351 0 0.246856 0 0.285316 0 0.337329 0 0.362558 0 0.379895 0 0.381701 0 0.363226 0 0.255098 0 0.260218 0 0.268501 0 0.28209 0 0.303333 0 0.243128 0 0.254557 0 0.26429 0 0.269477 0 0.270956 0
# FISH_A2 0 0 0.00223554 0 0.0112372 0 0.01134 0 0.0230063 0 0.0353524 0 0.0487615 0 0.0636553 0 0.0804507 0 0.114526 0 0.156218 0 0.172959 0 0.192552 0 0.216111 0 0.245637 0 0.284315 0 0.336947 0 0.363192 0 0.381316 0 0.383153 0 0.36418 0 0.255323 0 0.260033 0 0.268059 0 0.28168 0 0.303331 0 0.243652 0 0.255644 0 0.265623 0 0.270374 0 0.270929 0
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_survey: 7 Depletion is a depletion fleet
#_Q_setup(f,2)=0; add 1 to phases of all parms; only R0 active in new phase 1
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         2         1         0         1         0         1  #  SURV_A1
         3         1         0         0         0         1  #  RECRSVY_A1
         5         1         0         1         0         1  #  SURV_A2
         6         1         0         0         0         1  #  RECRSVY_A2
         7         1         0         0         0         0  #  Depletion
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
            -7             5       0.52723             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_SURV_A1(2)
             0           0.5    0.00496268          0.05             1             0          4          0          0          0          0          0          0          0  #  Q_extraSD_SURV_A1(2)
           -11             5      -8.65326             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_RECRSVY_A1(3)
            -7             5      0.531522             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_SURV_A2(5)
             0           0.5    0.00309005          0.05             1             0          4          0          0          0          0          0          0          0  #  Q_extraSD_SURV_A2(5)
           -11             5      -8.64901             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_RECRSVY_A2(6)
            -7             5             0             0             1             0         -1          0          0          0          0          0          0          0  #  LnQ_base_Depletion(7)
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
 1 0 0 0 # 1 FISH_A1
 1 0 0 0 # 2 SURV_A1
 0 0 0 0 # 3 RECRSVY_A1
 1 0 0 0 # 4 FISH_A2
 1 0 0 0 # 5 SURV_A2
 0 0 0 0 # 6 RECRSVY_A2
 0 0 0 0 # 7 Depletion
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
 10 0 0 0 # 1 FISH_A1
 10 0 0 0 # 2 SURV_A1
 10 0 0 0 # 3 RECRSVY_A1
 10 0 0 0 # 4 FISH_A2
 10 0 0 0 # 5 SURV_A2
 10 0 0 0 # 6 RECRSVY_A2
 10 0 0 0 # 7 Depletion
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   FISH_A1 LenSelex
            19            80       54.0757            50          0.01             1          2          0          0          0          0          0          0          0  #  Size_inflection_FISH_A1(1)
          0.01            60       20.1908            15          0.01             1          3          0          0          0          0          0          0          0  #  Size_95%width_FISH_A1(1)
# 2   SURV_A1 LenSelex
            19            70       36.6089            30          0.01             1          2          0          0          0          0          0          0          0  #  Size_inflection_SURV_A1(2)
          0.01            60       6.57897            10          0.01             1          3          0          0          0          0          0          0          0  #  Size_95%width_SURV_A1(2)
# 3   RECRSVY_A1 LenSelex
# 4   FISH_A2 LenSelex
            19            80       53.7237            50          0.01             1          2          0          0          0          0          0          0          0  #  Size_inflection_FISH_A2(4)
          0.01            60       19.0143            15          0.01             1          3          0          0          0          0          0          0          0  #  Size_95%width_FISH_A2(4)
# 5   SURV_A2 LenSelex
            19            70       36.2187            30          0.01             1          2          0          0          0          0          0          0          0  #  Size_inflection_SURV_A2(5)
          0.01            60       5.00691            10          0.01             1          3          0          0          0          0          0          0          0  #  Size_95%width_SURV_A2(5)
# 6   RECRSVY_A2 LenSelex
# 7   Depletion LenSelex
# 1   FISH_A1 AgeSelex
# 2   SURV_A1 AgeSelex
# 3   RECRSVY_A1 AgeSelex
# 4   FISH_A2 AgeSelex
# 5   SURV_A2 AgeSelex
# 6   RECRSVY_A2 AgeSelex
# 7   Depletion AgeSelex
#_No_Dirichlet parameters
#_no timevary selex parameters
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
#      1    42     1     0     0     0     0     1     2  1971  2001     5 0.178304 0.0133838 0.00571515 0.0197992 0.0600324 -0.00271921 -0.00421091 0.0362068 0.0628854 -0.0288154 -0.0273585 -0.0137865 -0.0117394 0.0188156 0.0276946 0.0217052 0.0218122 0.000800275 0.0109036 0.00332611 -0.0467698 -0.0373716 -0.0201192 -0.0019611 0.00180078 0.0335577 0.0220834 -0.00658228 0.00868573 -0.0285819      0
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
4 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 2 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 10 1 1 2 1
 1 7 3 0 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  0 1 1 1 #_CPUE/survey:_2
#  0 1 1 1 #_CPUE/survey:_3
#  0 0 0 0 #_CPUE/survey:_4
#  0 1 1 1 #_CPUE/survey:_5
#  0 1 1 1 #_CPUE/survey:_6
#  1 1 0 0 #_CPUE/survey:_7
#  0 1 1 1 #_lencomp:_1
#  0 1 1 1 #_lencomp:_2
#  0 0 0 0 #_lencomp:_3
#  0 0 0 0 #_lencomp:_4
#  0 0 0 0 #_lencomp:_5
#  0 0 0 0 #_lencomp:_6
#  0 0 0 0 #_lencomp:_7
#  0 1 1 1 #_agecomp:_1
#  0 1 1 1 #_agecomp:_2
#  0 0 0 0 #_agecomp:_3
#  0 1 1 1 #_agecomp:_4
#  0 1 1 1 #_agecomp:_5
#  0 0 0 0 #_agecomp:_6
#  0 0 0 0 #_agecomp:_7
#  0 1 1 1 #_sizefreq:_1
#  0 1 1 1 #_sizefreq:_2
#  0 1 1 1 #_size-age:_1
#  0 1 1 1 #_size-age:_2
#  0 0 0 0 #_size-age:_3
#  0 1 1 1 #_size-age:_4
#  0 1 1 1 #_size-age:_5
#  0 0 0 0 #_size-age:_6
#  0 0 0 0 #_size-age:_7
#  0 1 1 1 #_init_equ_catch1
#  0 1 1 1 #_init_equ_catch2
#  0 1 1 1 #_init_equ_catch3
#  0 1 1 1 #_init_equ_catch4
#  0 1 1 1 #_init_equ_catch5
#  0 1 1 1 #_init_equ_catch6
#  0 1 1 1 #_init_equ_catch7
#  2 2 2 2 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
#  0 0 0 0 # F_ballpark_lambda
1 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 1 1 -1 5 # Selectivity: (1) 0 to skip or fleet, (2) 1=len/2=age/3=combined, (3) year, (4) N selex bins; NOTE: combined reports in age bins
 1 5 # Growth: (1) 0 to skip or growth pattern, (2) growth ages; NOTE: does each sex
 1 -1 5 # Numbers-at-age: (1) 0 or area(-1 for all), (2) year, (3) N ages;  NOTE: sums across morphs
 5 15 25 35 43 # vector with selex std bins (-1 in first bin to self-generate)
 1 2 14 26 40 # vector with growth std ages picks (-1 in first bin to self-generate)
 1 2 14 26 40 # vector with NatAge std ages (-1 in first bin to self-generate)
999
