#!/bin/bash

### BEFORE THE LOOP
### 0. GENERATE the time labels
./time_label_JK

### 0. create a subdirectory where inverted figures will be stored. 
mkdir -p figures_monthly_solutions


for i in {1..150}; do

### 1. PREPARE the input files

## the NGL time series
cp geometry_hard_wiring.dat geometry.dat

## DISPLACEMENTS
cp fnl_files/fnl_no_TOWG_"$i".dat .
cp fnl_no_TOWG_"$i".dat GPS_raw.dat
rm fnl_no_TOWG_"$i".dat


### 2. PREPARE FOR SPARSE PROGRAMS
make_sparse_geometry

make_raw_spline_fit_dat

cp spline_fit.dat spline_fit_makeraw.dat

make_x_for_fit <<!
0 0 0
!

## smoothing parameter; the smaller, the smoother.
make_null_input_with_variance <<!
0.0002
0.25
!

cp spline_fit.dat spline_fit_null.dat

## ADD STRAIN CONSTRAINTS (steady-state tectonic signal)
## 'average_strain_ref.out'
## 0.3260  =  4 month
## 0.5     =  6 momth
## 1       =  1 year
./add_strain_constraints <<! 
0.3260 0.65
!

cp spline_fit_ref_scaled.dat spline_fit.dat

make_x_for_fit <<!
0 0 0
!

## 7237 : GNSS FRAME is hard wired in
prepare_gps_sparse2 <<!
7237
!

cp latlong_gps.dat output.dat
cp latlong_gps.dat latlong_gps_$i.dat


make_x_for_output <<!
0 0 0
!

### 3. Inversion

sparse_fit_with_GPS <<!
Y
Y
Y
!

## The 3rd Y/N: Uncertainty in strain field
sparse_average_strain <<!
Y
Y
N
Y
!


cp average_strain.out average_strain_4_mo.out
cp average_strain_4_mo.out average_strain_4_mo_"$i".out

## The 2nd Y/N: Uncertainty in displacement field 
## at stations
sparse_velocity<<!
Y
N
0 0 0
!

velocity

sparse_rotation_solution<<!
Y
N
0 0 0
!

cp rotation_solution.out rotation_solution_4_mo_"$i".out

## If you get error, replace 0 with 0.0
gps_rotation_sparse

velocity_diff -o GPS_rotated.out -m velocity.out -e 1 > stat_15.out
cp vel1.gmt vel_obs_4_mo_"$i".gmt
cp vel1.gmt vel_obs_4_mo.gmt
cp vel2.gmt vel_mod_4_mo_"$i".gmt
cp vel2.gmt vel_mod_4_mo.gmt
cp stat_15.out stat_4_mo_"$i".out


prepare_knotpoints

cp knotpoints.dat output.dat
cp knotpoints.dat nout.dat

make_x_for_output<<!
0 0 0
!

## The 2nd Y/N: Uncertainty in displacement field
sparse_velocity<<!
Y
N
0 0 0
!

velocity

cp vel.gmt vel_4_mo_knotpoints.gmt
cp vel.gmt vel_4_mo_knotpoints_"$i".gmt


### 4. PLOT monthly solutions

## sample time label
sed -n "$i"p time_label_all.dat | \
awk '{printf "%.2f %.2f %i %i %i %i %.2d%s%.4d\n", \
$1,$2,$3,$4,$5,$6,$8,"/",$7}'  > time_label.dat

## sample displacements at 0.5 degree intervals
cp vel_4_mo_knotpoints_"$i".gmt vel_dense.gmt
python vel_less_dense_05.py
cp vel_less_dense.gmt vel_4_mo_knotpoints_plot_"$i".gmt

## plot images & copy them 
sh image_monthly_solution.sh 
cp displacement_monthly.png displacement_monthly_"$i".png
cp displacement_monthly_"$i".png figures_monthly_solutions
rm displacement_monthly_"$i".png displacement_monthly.png

done

rm time_label_all.dat
rm vel_obs_4_mo.gmt vel_mod_4_mo.gmt  
rm vel1.gmt vel2.gmt stat_15.out
rm vel_dense.gmt vel_less_dense.gmt
