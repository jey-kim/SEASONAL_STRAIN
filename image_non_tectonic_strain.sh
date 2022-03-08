#!/bin/bash
S="-Se0.1/0.95/0"
M="strain_non_tectonic.ps"
R="-R-123/-115.0/32.0/38.75"
J="-Jm1.9"
B="-Ba2f1 -BNseW"
dil="dilatation.out"
T="-T-15/15/5"
CPT="dilatation.cpt"


gmt set MAP_FRAME_TYPE plain
gmt psbasemap $R  $J  $B -V -Y2.0i -P -K > $M


gmt blockmean $dil $R -I6m -V > sigma_r.dat
gmt surface sigma_r.dat  -Ggm0.grd -I6m  -R -T0.2
gmt makecpt -Cvik $T -Z > $CPT
gmt grdimage gm0.grd -C$CPT -E $R $J -V -O -K >> $M

gmt psxy fault.dat $R $J -W1,black -V -O -K >> $M
gmt psxy san_andras_fault.dat $R $J -W1,black -V -O -K >> $M
gmt pscoast $J $R $B -Df -Slightblue -Na -W1.0 -V -O -K>> $M

#gmt psxy stations.dat $R $J -St0.3 -Gwhite -W1,black -V -O -K >> $M

gmt psvelo principal_con_less.out $J $R -Sx0.05 -W1.5p,black -A0.1p+a30,30 -K -O -V >> $M
gmt psvelo principal_ext_less.out $J $R -Sx0.05 -W1.5p,white -A0.1p+a30,30 -K -O -V >> $M


gmt pstext time_label.dat $R $J -V -O -K >> $M

gmt psxy $R $J -G255 -L -Wthicker -V -O -K >>$M <<END
-122.5 32.6
-121.48 32.6
-121.48 32.25
-122.5 32.25
END

gmt psvelo $R $J -W1.5p,black -Sx0.025 -L -A0.1p+a30,30 -O -K <<EOT>> $M
-122 32.368  20  0 0
EOT
#Twice smaller than the real strain

#psmeca meca_ridgecrest.dat -Wthin -Sd0.5c -J -C -G0/0/0 -R -O -K>> $M

gmt pstext $R $J -S1 -P -V -O -K  <<EOT>> $M
-122 32.48  9 0.0 0 6 1*10@+-8@+ 
EOT


gmt psscale -C$CPT -Dx6.4i/0i+w5.9i/0.2i -By+l"x10@+-9@+" -L -E -O >>$M

gmt psconvert  $M -Tg -A

rm $M 
