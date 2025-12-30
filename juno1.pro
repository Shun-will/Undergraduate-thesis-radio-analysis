file='E:\Shun\perijove\Perijoves1.csv'  
skipit=1
freq_ini=88
data_filearr=strarr(77)
Read_excel,file,pj,hr,mins,sec,ymd,yearjove,_doyarr; First frequency channel to be used  
search_jove,yearjove,date_files,constr,_doyarr
for i=0,52 do begin 
;if skipit eq 0 then begin
  data_file=constr[i]
;data_file[0]='F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\2017165_ORBIT_07\WAV_2017192T000000_E_V02.csv'
;F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\2018223_ORBIT_15\WAV_2018249T000000_E_V02.csv
;F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\2017165_ORBIT_07\WAV_2017192T000000_E_V02.csv
  READ_JUNO,data_file,freq,time,sp,time_c
  freq0=freq
  time0=time
  sp0=sp[*,freq_ini:*]
  nf=n_elements(sp0[0,*])
  time_c0=time_c
  tosearchtimeofperijove,i,data_file,hr,mins,sec,nameoffile,ns1,orbit,strdiv2,intdiv3,strdiv6
  choose_day,pj,data_file,time_c0,hr,intdiv3,strdiv2,strdiv6,orbit,a1,b1,freq_ini,c1,freq1,time1,sp1,time_c1,m,i
  if a1 eq -1 or b1 eq -1 or c1 eq -1 then begin 
    ;print,'PERIJOVE'+pj[i]+' does NOT have sufficient data.'
    goto,skip_iteration
  endif
  palette=39
  istart=0;start second 
  ifin=84L*1011-1;end second
  tstep=3600L*8;time step on the picture [s]

  Read_time,time0,time0_out,time1_out
  ;if alog(sp0[istart:ifin,*]) gt 0 then begin 
  image=alog(rebin(sp0[istart:ifin,*],1011,38*8))
  ;endif 
  window,0,xsize=1150,ysize=450
  SPDYNX,pj,i, image, time0_out, time1_out, tstep, freq0[freq_ini]/1e6,freq0[freq_ini+nf-1]/1e6,10,0,0,palette;,title
;SPDYNPS, image, time0, time1, th, ymin,ymax,yh, 0,0,palette,file_out

  Read_time,time1,time0_out,time1_out
  istart=0;start second 
  ifin=78L*1011-1;end second
  image1=alog(rebin(sp1[istart:ifin,*],1011,38*8))
  window,1,xsize=1150,ysize=450
  SPDYNX,pj,i,image,time0_out,time1_out,tstep,freq1[freq_ini]/1e6,freq1[freq_ini+nf-1]/1e6,10,0,0,palette;,title

  if m eq 0 then begin
    time_array=[time0[a1:*],time1[0:c1]]
    Read_time,time_array,time0_out,time1_out
    image=sp0[a1:*,*]
    image1=sp1[0:c1,*]
    image_array=[image,image1]
;    sony=n_elements(time0)-a1+c1
;    print,sony
    image_array=alog(rebin(image_array[0:85934,*],1011,38*8))
    window,2,xsize=1150,ysize=450
    SPDYNX,pj,i,image_array,time0_out,time1_out,tstep,freq1[freq_ini]/1e6,freq1[freq_ini+nf-1]/1e6,10,0,0,palette;,title
    time_array_c=[time_c0[a1:*,*],time_c1[0:c1,*]]
    read_timec,time_array_c,time0_out,time1_out
    window,3,xsize=1150,ysize=450
    SPDYNX,pj,i,image_array,time0_out,time1_out,tstep,freq1[freq_ini]/1e6,freq1[freq_ini+nf-1]/1e6,10,0,0,palette;,title
    write_jpeg,'E:\Shun\perijove\'+nameoffile[ns1-2]+'.jpg',true=1,tvrd(true=1)
    
  endif else if m eq 1 then begin 
;    time2=time0
;    time0=time1
;    time1=time0
;    
;    sp2=sp0
;    sp0=sp1
;    sp1=sp0
;    
;    time2_out=time0_out
;    time0_out=time1_out
;    time1_out=time0_out

    time_array=[time1[a1:*],time0[0:c1]]
    Read_time,time_array,time0_out,time1_out
    
    image=sp0[0:c1,*]
    image1=sp1[a1:*,*]
;    sony=n_elements(time)-a1+c1
;    print,sony
    image_array=[image1,image]
    image_array=alog(rebin(image_array[0:85934,*],1011,38*8))
    window,2,xsize=1150,ysize=450
    SPDYNX,pj,i,image_array,time0_out,time1_out,tstep,freq1[freq_ini]/1e6,freq1[freq_ini+nf-1]/1e6,10,0,0,palette;,title
    time_array_c=[time_c1[a1:*,*],time_c0[0:c1,*]]
    read_timec,time_array_c,time0_out,time1_out
    window,3,xsize=1150,ysize=450
    SPDYNX,pj,i,image_array,time0_out,time1_out,tstep,freq1[freq_ini]/1e6,freq1[freq_ini+nf-1]/1e6,10,0,0,palette;,title
    write_jpeg,'E:\Shun\perijove\'+nameoffile[ns1-2]+'.jpg',true=1,tvrd(true=1)
  endif
  skip_iteration:
endfor
end