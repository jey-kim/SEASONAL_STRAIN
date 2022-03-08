		program make_anisotropic_spline_fit
		implicit real*8 (a-h,o-z)
	
		dimension exx1(15000),eyy1(15000),exy1(15000)
		dimension x(15000),y(15000)
		dimension sem_xx(15000),sem_yy(15000),sem_xy(15000)
		dimension cc1(15000),cc2(15000),cc3(15000)

                
		open(12,file='average_strain_ref.out')
		open(13,file='spline_fit_ref_scaled.dat')
                open(14,file='se_facs.dat')
                open(15,file='spline_fit_makeraw.dat')
		open(16,file='spline_fit_null.dat')	
	
        read(16,*)
        read(16,*)
        read(16,*)
        read(16,*) 


	read(12,*)
	read(12,*)

        read(15,*)i,j,k
        read(15,*)l
        read(15,*)m,r1,r2,r3
        read(15,*)i1
                 close(15)
        
	write(6,*)'enter time factor and factor for standard errors'
	read(5,*)t_fac,se_fac	
	write(13,*)i,j,k
	write(13,*)l
	write(13,*)m,r1,r2,r3
	write(13,*)i1

c        write(6,*)i,j,k
c	write(6,*)l
c        write(6,*)m,r1,r2,r3 
c        write(6,*)i1

		
	    do i = 1, i1
	
            read(12,*)ii2,rla,rlo,obs1,obs2,obs3,exx1(i),eyy1(i),exy1(i)
	    read(12,*)
            read(12,*)
	

            read(16,*)
            read(16,*)ii,jj,kk
            read(16,*)
            read(16,*)sem_xx(i),sem_yy(i),sem_xy(i),cc1(i),cc2(i),cc3(i)
	
            avg_xx = t_fac*exx1(i)
	    avg_yy = t_fac*eyy1(i)
	    avg_xy = t_fac*exy1(i)

	    sem_xx(i) = se_fac*sem_xx(i)
            sem_yy(i) = se_fac*sem_yy(i)
            sem_xy(i) = se_fac*sem_xy(i)

c	    write(6,*)exx1(i),eyy1(i),exy1(i),avg_xx,avg_yy,avg_xy

	    write(13,*)ii,jj,kk
            write(13,23)avg_xx,avg_yy,avg_xy

23	    format(3e15.5)
	    write(13,24)sem_xx(i),sem_yy(i),sem_xy(i),cc1(i),cc2(i),cc3(i)
            write(14,24)sem_xx(i),sem_yy(i),sem_xy(i)
24	    format(6e15.5)
	
	    end do


	stop
	end
