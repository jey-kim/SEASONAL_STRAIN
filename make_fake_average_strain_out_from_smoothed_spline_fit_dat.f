      program make_fake_average_strain_out_from_smoothed_spline_fit_dat

      integer a1,b1,a2,a3,a4,a5,a9,c1,c2,c3

      character c4
      open (unit=10, file="average_strain.out")
      open (unit=11, file="spline_fit.dat")
      open (unit=12, file="average_strain1.out")


      read (11,*)a1,a2,a3
      read (11,*)a4
      read (11,*)a5,a6,a7,a8
      read (11,*)a9

      read (10,*)
      read (10,*)
      write (12,*)
      write (12,*)

       do i=1,7185
       read (10,*)b1,b2,b3,b4,b5,b6,b7,b8,b9
       read (10,*)
       read (10,*)
      
       
       read (11,*)
       read (11,*)
       read (11,*)c6,c7,c8
       read (11,*)c9,c10,c11,c12,c13,c14


       write (12,*)b1,b2,b3,0,0,0,c6,c7,c8
       write (12,*)0,0,0,0,0,0
       write (12,*)0,0,0,0,0,0

       enddo
       close(10)
       close(11)
      stop
      end
