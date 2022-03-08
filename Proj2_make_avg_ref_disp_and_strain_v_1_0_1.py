#!/usr/bin/env python
# coding: utf-8

#<img src="Figs/GEOS_Logo.pdf" width="500" />


import pandas as pd
import numpy as np


how_many_months = 36


vel_frame = np.zeros((9801,2))
vel_error_frame = np.zeros((9801,2))
df_vel_save = pd.DataFrame(vel_frame,columns=['ve','vn'])
df_vel_error_save = pd.DataFrame(vel_error_frame,columns=['se','sn'])


name=['lon','lat','ve','vn','se','sn','corr']
for i in range(how_many_months):
    filename = "vel_4_mo_knotpoints_"+str(i+1)+".gmt"
    df_load=pd.read_csv(filename,header = None,sep=r'(?:,|\s+)',comment='#', engine='python')
    df_load.columns = name
    df_vel_save = df_vel_save + df_load.loc[:,['ve','vn']]
    df_vel_error_save = df_vel_error_save + df_load.loc[:,['se','sn']]**2
    
    
lon = df_load.loc[:,['lon']]
lat = df_load.loc[:,['lat']]
df_vel_save = df_vel_save/how_many_months
df_vel_error_save = np.sqrt(df_vel_error_save)/how_many_months
corr = df_load.loc[:,['corr']]
concatFrame =[lon, lat, df_vel_save, df_vel_error_save, corr]
df_save=pd.concat(concatFrame,axis=1)


savefile = "vel_4_mo_knotpoints_average.gmt"
df_save.to_csv(savefile ,header=None, index=None ,float_format='%.6f', sep=' ')


strain_frame = np.zeros((7185,3))
strain_error_frame = np.zeros((7185,3))
df_strain_save = pd.DataFrame(strain_frame,columns=['exx','eyy','exy'])
df_strain_error_save = pd.DataFrame(strain_error_frame,columns=['sxx','syy','sxy'])


name=['num','lat','lon','exx','eyy','exy','sxx','syy','sxy']
for i in range(how_many_months):
    filename = "average_strain_4_mo_RECTANGULAR_"+str(i+1)+".out"
    df_load=pd.read_csv(filename,header = None,sep=r'(?:,|\s+)',comment='#', engine='python')
    df_load.columns = name
    df_strain_save = df_strain_save + df_load.loc[:,['exx','eyy','exy']]
    df_strain_error_save = df_strain_error_save + df_load.loc[:,['sxx','syy','sxy']]**2

num = df_load.loc[:,['num']]
lat = df_load.loc[:,['lat']]   
lon = df_load.loc[:,['lon']]

df_strain_save = df_strain_save/how_many_months
df_strain_error_save = np.sqrt(df_strain_error_save)/how_many_months

concatFrame =[num,lat,lon,  df_strain_save, df_strain_error_save]
df_save=pd.concat(concatFrame,axis=1)


savefile = "average_strain_4_mo_RECTANGULAR_average.out"
df_save.to_csv(savefile ,header=None, index=None ,float_format='%.6f', sep=' ')

