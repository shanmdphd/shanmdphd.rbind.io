$PROBLEM  Parent drug, using ADVAN2 
$INPUT ID TIME AMT UVOL DV CMT MDV EVID L2
$DATA dextroparent.dat IGNORE=#
$SUBROUTINES ADVAN2 TRANS1
$PK
  K12=THETA(1)
  KA=K12
  MU_1=LOG(THETA(2))
  V2=EXP(MU_1+ETA(1))
  MU_2=LOG(THETA(3))
  CLP=EXP(MU_2+ETA(2)) ; RENAL CL FOR PARENT
  CLB=THETA(4)         ; METABOLIC CL FOR METABOLIC
  K23=CLP/V2+CLB/V2
  K=K23
  F0=CLP/(CLP+CLB)
  S2=V2
  S3=UVOL
$ERROR (EVERY EVENT)
  ACMT=ABS(CMT) ; output compartment may have negative value of CMT
  IF(ACMT.EQ.2) Y=F*(1+EPS(1))
  IF(ACMT.EQ.3) Y=F*(1+EPS(2))
$THETA
  (0.01,0.8,6) ;KA
  (0.01,43,1000);V2
  (0.0001,20,190);CLP
  (0.01,15,90);CLB
$OMEGA
  0.05  0.05
$SIGMA 
  .01 .01
  .01 .01 ; eps(3) and eps(4) for consistent EPS with sim_metab_a6 example
$SIM (111111) ONLYSIM
$TABLE ID TIME AMT UVOL DV SIMP=PRED CMT MDV EVID L2 NOAPPEND FILE=sim_parent_a2.tab
