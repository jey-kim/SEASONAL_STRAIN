       program time_label_JK

       real lo, la
       integer fontsize, a1, a2, a3, yr, mo

       open(unit=11, file = 'time_label_all.dat')

       lo = -121.0
       la = 32.44
       fontsize = 12
       a1 = 0
       a2 = 0
       a3 = 6
       yr = 2006
       mo = 12

       do i = 1,300
       
           mo = mo + 1
           if (mo.eq.13)then
               mo = 1
               if (mo.eq.1)then
                   yr = yr + 1
               endif
           endif

           write(11,99)lo,la,fontsize,a1,a2,a3,yr,mo

99     format(f7.2,1x,f7.2,1x,i4,i4,i4,i4,i6,i4)

       enddo
       end
