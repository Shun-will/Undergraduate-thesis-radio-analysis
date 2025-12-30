;skipit=1
freq_ini=88; First frequency channel to be used
;if skipit eq 0 then begin
  READ_JUNO,'F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\2017059_ORBIT_05\WAV_2017086T000000_E_V02.csv',freq,time,sp,time_c
  freq0=freq
  time0=time
  sp0=sp[*,freq_ini:*]
  nf=n_elements(sp0[0,*])
  time_c0=time_c
  READ_JUNO,'F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\2017059_ORBIT_05\WAV_2017087T000000_E_V02.csv',freq,time,sp,time_c
  freq1=freq
  time1=time
  sp1=sp[*,freq_ini:*]
  time_c1=time_c
;endif  
palette=39

istart=0;start second 
ifin=84L*1011-1;end second
tstep=3600L*8;time step on the picture [s]

Read_time,time0,time0_out,time1_out
image=alog(rebin(sp0[istart:ifin,*],1011,38*8))
window,0,xsize=1150,ysize=450
SPDYNX, image, time0_out, time1_out, tstep, freq0[freq_ini]/1e6,freq0[freq_ini+nf-1]/1e6,10, 0,0,palette
;SPDYNPS, image, time0, time1, th, ymin,ymax,yh, 0,0,palette,file_out

Read_time,time1,time0_out,time1_out
image1=alog(rebin(sp1[istart:ifin,*],1011,38*8))
window,1,xsize=1150,ysize=450
SPDYNX, image1, time0_out, time1_out, tstep, freq1[freq_ini]/1e6,freq1[freq_ini+nf-1]/1e6,10, 0,0,palette

window,2,xsize=1150,ysize=450

;plot,image,time0_out, time1_out, tstep, freq0[freq_ini]/1e6,freq0[freq_ini+nf-1]/1e6,10, 0,0,palette
;oplot,image1,time0_out, time1_out, tstep, freq0[freq_ini]/1e6,freq0[freq_ini+nf-1]/1e6,10, 0,0,palette

end
