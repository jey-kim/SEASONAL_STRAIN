#!/usr/bin/env python
# coding: utf-8

#<img src="Figs/GEOS_Logo.pdf" width="500" />


import numpy as np
#import pandas as pd


input_file="average_strain_RECTANGULAR.out"
output_file1="principal_ext.out"
output_file2="principal_con.out"
output_file3="dilatation.out"
output_file4="second_inv.out"
output_file5="pure_shear.out"

data=np.loadtxt(input_file)
lat = data[:,1]
lon = data[:,2]
exx = data[:,3]
eyy = data[:,4]
exy = data[:,5]

num_strain = len(exx)


BASIS_for_extensional = np.zeros((num_strain,5))
BASIS_for_contractional = np.zeros((num_strain,5))

for i in range(num_strain):
    tau = np.array([[exx[i],exy[i]],[exy[i],eyy[i]]])
    Lam, N = np.linalg.eig(tau) #Lam = eigenvalues; N = eigenvectors (columns)
    taur = N.transpose() @ tau @ N  #Principal axes    
    
    # Set the larger principal axis is e11
    t1=taur[0,0]
    t2=taur[1,1]
    N1=N[:,0]
    N2=N[:,1]
    if t2 > t1:
        taur[0,0] = t2
        taur[1,1] = t1
        N = np.array([N2,N1])
        
    # Take the two components of the contractional eigenvector
    x = N[0,1]  
    y = N[1,1]
    
    # Angle from the north
    if x > 0 and y > 0:
        angle = np.arcsin(x)*180/np.pi
    elif x > 0 and y < 0:
        angle = 180 - np.arcsin(x)*180/np.pi
    elif x == 0 and y > 0:
        angle = 0
    elif x == 0 and y < 0:
        angle = 180
    elif x < 0 and y < 0:
        angle = 180 + np.arcsin(np.abs(x))*180/np.pi
    elif x < 0 and y > 0:
        angle = 360 - np.arcsin(np.abs(x))*180/np.pi
    elif x > 0 and y == 0:
        angle = 90
    elif x < 0 and y == 0:
        angle = 270
    else:
        print("ERROR! Stop this algorithm.")
        break
        
        
    BASIS_for_extensional[i,0] = lon[i]
    BASIS_for_extensional[i,1] = lat[i]
    BASIS_for_extensional[i,4] = angle
    
    
    BASIS_for_contractional[i,0] = lon[i]
    BASIS_for_contractional[i,1] = lat[i]
    BASIS_for_contractional[i,4] = angle
    
    
    if taur[0,0] >= 0 and taur[1,1] >= 0: #e11 and e22 are both extentional (+ve)
        BASIS_for_extensional[i,2] = taur[0,0]
        BASIS_for_extensional[i,3] = taur[1,1]
        
    elif taur[0,0] >= 0 and taur[1,1] < 0: #e11 +ve ; e22 -ve
        BASIS_for_extensional[i,2] = taur[0,0]
        BASIS_for_contractional[i,3] = taur[1,1]
    
    elif taur[0,0] < 0 and taur[1,1] < 0: #e11 and e22 are both contractional (-ve)
        BASIS_for_contractional[i,2] = taur[0,0]
        BASIS_for_contractional[i,3] = taur[1,1]
    else:
        print("ERROR! Stop this algorithm.")
        break
        


dil = exx + eyy
BASIS_for_dil=np.column_stack((lon,lat,dil))


second_inv = 2*exx**2 + 2*eyy**2 + 2*exy**2 + 2*exx*eyy
second_inv = np.sqrt(second_inv)
BASIS_for_second_inv=np.column_stack((lon,lat,second_inv))


y2s=1.0
sigma = 0.5*(exx+eyy)/y2s
gama1 = 0.5*(exx-eyy)/y2s
exy1 = exy/y2s

gama = np.sqrt(gama1**2+exy1**2)
gama_tmp = sigma**2 - gama**2

gama_ss = np.zeros(len(gama_tmp))

# logic 1
#if gama_tmp > 0, then gama_ss = 0

# logic not 1 & logic 2
#if gama_tmp <=0 & np.abs(sigma+gama) > np.abs(sigma-gama), 
# then gama_ss = sigma-gama

# logic not 1 & logic 3
#if gama_tmp <=0 & np.abs(sigma+gama) <= np.abs(sigma-gama), 
# then gama_ss = sigma+gama

idx1=(gama_tmp<=0)  # logic not 1
idx2=(np.abs(sigma+gama) > np.abs(sigma-gama)) # logic 2
idx3=np.logical_not(idx2) # logic 3
            
gama_ss[idx1*idx2]=np.abs(sigma[idx1*idx2]-gama[idx1*idx2]) # logic not 1 & logic 2
gama_ss[idx1*idx3]=np.abs(sigma[idx1*idx3]+gama[idx1*idx3]) # logic not 1 & logic 3


BASIS_for_pure_shear=np.column_stack((lon,lat,gama_ss))


np.savetxt(output_file1, BASIS_for_extensional, fmt='%g', delimiter=' ')
np.savetxt(output_file2, BASIS_for_contractional, fmt='%g', delimiter=' ')
np.savetxt(output_file3, BASIS_for_dil, fmt='%g', delimiter=' ')
np.savetxt(output_file4, BASIS_for_second_inv, fmt='%g', delimiter=' ')
np.savetxt(output_file5, BASIS_for_pure_shear, fmt='%g', delimiter=' ')




