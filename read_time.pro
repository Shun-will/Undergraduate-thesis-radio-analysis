pro read_time,time0,time0_out,time1_out
;print,'read_time'
istart=0;start second
nt=n_elements(time0) 
ifin=nt/1011*1011-1;end second


time=time0;[time0[3032:*],time1[0:3047]]
print,time0[0]

t0=time[istart]-time[0]
;t0=time[0]
t1=time[ifin-1]-time[0]
hr0=fix(t0/3600)
mn0=fix((t0-hr0*3600l)/60)
sc0=fix(t0-hr0*3600L-mn0*60)
thsec0=long((t0-hr0*3600L-mn0*60-sc0)*1000L)
time0_out=[hr0,mn0,sc0,thsec0];start time
;read,dummy
hr1=fix(t1/3600)
mn1=fix((t1-hr1*3600l)/60)
sc1=fix(t1-hr1*3600L-mn1*60)
thsec1=long((t1-hr1*3600L-mn1*60-sc1)*1000L)
time1_out=[hr1,mn1,sc1,thsec1];end time
;stop
;print,''
;print,''
;print,time0_out,time1_out

 end