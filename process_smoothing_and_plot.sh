#!/bin/bash

mkdir -p figures_non_tectonic_solutions
./time_label_JK

for i in {1..150}; do

## smoothing strain field
cp strain_diff_"$i"_knotpoints.out strain.out
cp average_strain_diff_"$i"_knotpoints.out average_strain.out
cp average_strain.out avg_strain.dat
cp spline_fit_ref_scaled.dat spline_fit.dat
./make_spline_fit_dat
cp spline_fit1.dat spline_fit.dat

make_x_for_fit <<!
0 0 0
!

perform_smoothing_on_input <<!
1
1
0
!

./make_fake_average_strain_out_from_smoothed_spline_fit_dat

cp average_strain1.out average_strain_dff_"$i"_smoothed.out

## compute principal axes and dilatation of the strain
cp average_strain1.out average_strain_input.out
./average_strain_RECTANGULAR

python Proj2_make_principal_strain_01282022.py

cp principal_ext.out principal_axes_extensional_"$i".out
cp principal_con.out principal_axes_contractional_"$i".out
cp dilatation.out dilatational_strain_"$i".out
python strain_less_dense_05.py
cp principal_ext_less.out principal_axes_extensional_"$i"_less.out
cp principal_con_less.out principal_axes_contractional_"$i"_less.out


cp vel_diff_"$i"_knotpoints.gmt vel_dense.gmt
python vel_less_dense_05.py
cp vel_less_dense.gmt vel_diff_"$i"_knotpoints_less.gmt

## stations
awk '{print $1,$2}' vel_obs_4_mo_"$i".gmt > stations.dat

## sample time label
sed -n "$i"p time_label_all.dat | \
awk '{printf "%.2f %.2f %i %i %i %i %.2d%s%.4d\n", \
$1,$2,$3,$4,$5,$6,$8,"/",$7}'  > time_label.dat


## plot

sh image_non_tectonic_strain.sh
sh image_non_tectonic_disp.sh

cp displacement_non_tectonic.png displacement_non_tectonic_"$i".png
cp displacement_non_tectonic_"$i".png figures_non_tectonic_solutions
rm displacement_non_tectonic_"$i".png

cp strain_non_tectonic.png strain_non_tectonic_"$i".png
cp strain_non_tectonic_"$i".png figures_non_tectonic_solutions
rm strain_non_tectonic_"$i".png 

done
