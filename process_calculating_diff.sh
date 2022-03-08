#!/bin/bash

cp vel_4_mo_knotpoints_average.gmt 1.gmt
cp average_strain_4_mo_RECTANGULAR_average.out 1.out

for i in {1..150}; do

cp vel_4_mo_knotpoints_"$i".gmt 2.gmt
cp average_strain_4_mo_RECTANGULAR_"$i".out 2.out

./vel_diff_epochs
./strain_diff_epochs

cp vel_diff_between_epochs.gmt vel_diff_"$i"_knotpoints.gmt
cp strain_diff_between_epochs.out strain_diff_"$i"_knotpoints.out
cp average_strain_with_error.out average_strain_diff_"$i"_knotpoints.out

done
