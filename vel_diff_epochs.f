	program diff_vel_and_stack

        open(19,file = '1.gmt')
        open(20,file = '2.gmt')
        open(21,file = 'vel_diff_between_epochs.gmt')

        do i = 1, 9801
         read(19,*)rlong,rlat,vx,vy,se_vx,se_vy,cc
         read(20,*)rlong,rlat,vx2,vy2,se_vx2,se_vy2,cc2
         
         ve_diff = vx2 - vx 
         vn_diff = vy2 - vy
	 
         sig_x =sqrt(se_vx2*se_vx2 + se_vx*se_vx)
         sig_y =sqrt(se_vy2*se_vy2 + se_vy*se_vy)

	 write(21,*)rlong,rlat,ve_diff,vn_diff,sig_x,sig_y,0

	end do

        close (19)
        close (20)
        close (21)
 

	stop

	end
