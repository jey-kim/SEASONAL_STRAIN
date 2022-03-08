#!/bin/bash
S="-Se0.1/0.95/0"
M="displacement_monthly.ps"
R="-R-123/-115.0/32.0/38.75"
J="-Jm1.9"
B="-Ba2f1 -BNseW"

gmt set MAP_FRAME_TYPE plain
gmt psbasemap $R  $J  $B -V -Y2.0i -P -K > $M
gmt psxy fault.dat $R $J -W1,black -V -O -K >> $M
gmt psxy san_andras_fault.dat $R $J -W1,black -V -O -K >> $M
gmt pscoast $J $R $B -Df -Slightblue -Na -W1.0 -V -O -K>> $M



gmt psvelo vel_less_dense.gmt $R -W0.1,gray -Ggray $S  -L $J -A0.03/0.1/0.07 -O -K  >>$M
awk '{print $1,$2}' vel_obs_4_mo.gmt > stations.dat
gmt psxy stations.dat $R $J -St0.3 -Gwhite -W1,black -V -O -K >> $M
gmt psvelo vel_obs_4_mo.gmt $R -W0.3,black -Gred $S  -L $J -A0.05/0.08/0.07 -O -K  >>$M
gmt psvelo vel_mod_4_mo.gmt $R -W0.3,black -Ggreen $S  -L $J -A0.05/0.08/0.07 -O -K  >>$M



gmt pstext time_label.dat $R $J -V -O -K >> $M

gmt psxy $R $J -G255 -L -Wthicker -V -O -K >>$M <<END
-122.5 32.6
-121.48 32.6
-121.48 32.25
-122.5 32.25
END

gmt psvelo $R -W0.5 -Gwhite $S  -L -Jm -A0.05/0.08/0.07 -O -K <<EOT>> $M
-122.24 32.35 10 0 0 0 0 0
EOT

gmt pstext  $R $J -P -O -V <<EOT>> $M
-122 32.5 12 0.0 0 6 10 mm
EOT

gmt psconvert  $M -Tg -A

rm $M stations.dat
