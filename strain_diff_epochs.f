	program diff_vel_and_stack

        integer a

        open(19,file = '1.out')
        open(20,file = '2.out')
        open(21,file = 'strain_diff_between_epochs.out')
	open(22,file = 'average_strain_with_error.out')
        
	write(21,*)
        write(21,*)
        write(21,*)

	write(22,*)
	write(22,*)

        do i = 1, 7185

         read(19,*)a,rlat,rlong,ex,ey,exy,sigx,sigy,sigxy
         read(20,*)a,rlat,rlong,ex2,ey2,exy2,sigx2,sigy2,sigxy2
         
         ex_diff = ex2 - ex 
         ey_diff = ey2 - ey
         exy_diff = exy2 - exy
	 
	 sigx_diff = sqrt(sigx2*sigx2+sigx*sigx)
	 sigy_diff = sqrt(sigy2*sigy2+sigy*sigy)
	 sigxy_diff = sqrt(sigxy2*sigxy2+sigxy*sigxy)
	 
	 write(21,*)a,rlat,rlong,ex_diff,ey_diff,exy_diff

	 write(22,*)a,rlat,rlong,0,0,0,ex_diff,ey_diff,exy_diff
	 write(22,*)0,0,0,sigx_diff,sigy_diff,sigxy_diff
	 write(22,*)0,0,0,-0.25,0,0	

	end do


        close (19)
        close (20)
        close (21)


	stop

	end
