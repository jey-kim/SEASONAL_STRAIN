#!/bin/bash


### 1. 4-month solutions
sh process_monthly_solution.sh


### 2. Convert average_strain.out into a rectangular format
sh process_convert_average_strain_RECTANGULAR.sh


### 3. Calculate 3-year average displacement and strain field
###  1/2007 - 12/2009  (4/2010 El Mayor-Cucapah EQ!)
python Proj2_make_avg_ref_disp_and_strain_v_1_0_1.py


### 4. total - avg  = nontectonic 
sh process_calculating_diff.sh


### 5. smoothing & plotting 

sh process_smoothing_and_plot.sh
