      program reducing_gps_sites

      integer a1,b1,a2,a3,a4,a5,a9,c1,c2,c3

      character c4
      open (unit=10, file="avg_strain.dat")
      open (unit=11, file="spline_fit.dat")
      open (unit=12, file="spline_fit1.dat")


      read (11,*)a1,a2,a3
      read (11,*)a4
      read (11,*)a5,a6,a7,a8
      read (11,*)a9

      read (10,*)
      read (10,*)


      write (12,*)a1,a2,a3
      write (12,*)a4
      write (12,*)a5,a6,a7,a8
      write (12,*)a9

c       write (12,*) "Observed  Calculated"
c       write (12,*) "no lat long Elong Elat Exy Elong Elat Exy"


       do i=1,7185
       read (10,*)b1,b2,b3,b4,b5,b6,b7,b8,b9
       read (10,*)
       read (10,*)
      
       
c       read (11,*)
       read (11,*)c1,c2,c3
       read (11,*)c6,c7,c8
       read (11,*)c9,c10,c11,c12,c13,c14


c       write (12,*)
       write (12,*)c1,c2,c3
       write (12,*)b7,b8,b9
       write (12,*)c9,c10,c11,c12,c13,c14

       enddo
       close(10)
       close(11)
      stop
      end
