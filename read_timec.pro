pro read_timec,time0,time0_out,time1_out
;print,'read_timec'
istart=0;start second
nt=n_elements(time0) 
ifin=nt/1011*1011-1;end second

time=time0;[time0[3032:*],time1[0:3047]]
str1=strsplit(time0[0],'-',/extract)
str2=strsplit(str1[1],':',/extract)
a1=strmid(str2[0],4,2)
a2=str2[1]
a3=strsplit(str2[2],'.',/extract)
;stop
;t0=time[istart]-time[0]
;t0=time[0]
;t1=time[ifin-1]-time[0]
hr0=fix(a1)
mn0=fix(a2)
sc0=fix(a3[0])
thsec0=long(a3[1])
time0_out=[hr0,mn0,sc0,thsec0];start time
str1=strsplit(time0[n_elements(time0)-1],'-',/extract)
str2=strsplit(str1[1],':',/extract)
a1=strmid(str2[0],4,2)
a2=str2[1]
a3=strsplit(str2[2],'.',/extract)
;read,dummy
hr1=fix(a1)
mn1=fix(a2)
sc1=fix(a3[0])
thsec1=long(a3[1])
time1_out=[hr1,mn1,sc1,thsec1];end time
;print,'time0_out'
;print,time0_out
;print,'time1_out'
;print,time1_out
;stop
;print,''
;print,''
 end