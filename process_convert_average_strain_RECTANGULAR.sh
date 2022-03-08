#!/bin/bash

for i in {1..150}; do

cp average_strain_4_mo_"$i".out average_strain_input.out

./average_strain_RECTANGULAR

cp average_strain_RECTANGULAR.out average_strain_4_mo_RECTANGULAR_"$i".out

done
