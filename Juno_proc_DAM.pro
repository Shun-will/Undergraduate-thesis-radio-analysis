pro SPDYNX, image, time0, time1, th, ymin,ymax,yh, grid,power,palette
  tl=-0.01
  if grid eq 1 then tl=1.0
  image1=image-min(image)
  if power gt 0 then image1=image1^power else $
  if power gt 500 then image1=alog(image1+1)
  t0=double(time0[0]*3600000L+time0[1]*60000L+time0[2]*1000L+time0[3])
  t1=double(time1[0]*3600000L+time1[1]*60000L+time1[2]*1000L+time1[3])
  
  if t1 lt t0 then t1=t1+24L*3600000L

  xn=n_elements(image[*,0])
  time=dblarr(xn)
  tth=(t1-t0)/double(xn-1)

  for i=0,xn-1 do time[i]=t0+tth*i

  xmin=time(0)
  xmax=time(xn-1)

  nticks=long(xmax-xmin)/(th*1000L)+1
 
  atickv=lonarr(nticks)
  atickname=strarr(nticks)
  
  if th ge 0.1 and th lt 1 then t0=t0+th*1000-(t0 mod (th*1000))
  if th ge 1 and th lt 2 then t0=t0+1000-(t0 mod 1000)
  if th ge 2 and th lt 5 then t0=t0+2000-(t0 mod 2000)
  if th ge 5 and th lt 10 then t0=t0+5000-(t0 mod 5000)
  if th ge 10 and th lt 20 then t0=t0+10000-(t0 mod 10000)
  if th ge 20 and th lt 30 then t0=t0+20000l-(t0 mod 20000l)
  if th ge 30 and th lt 60 then t0=t0+30000l-(t0 mod 30000l)
  if th ge 60 and th lt 600 then t0=t0+60000l-(t0 mod 60000l)
  if th ge 600 and th lt 1800 then t0=t0+600000l-(t0 mod 600000l)
  if th ge 1800 then t0=t0+1800000l-(t0 mod 1800000l)
 
  for i=0,nticks-1 do begin
    atickv[i]=ceil(t0+i*long(th*1000L))
    hour=atickv[i]/3600000L

    minute=(atickv[i]-3600000L*hour)/60000L
    sec=(atickv[i] mod 60000)/1000
    hsec=(atickv[i] mod 1000)
    if hour ge 24 then hour=hour-24

    
    if hsec gt 0 then atickname(i)=string(hour,minute,sec,hsec/100,format="(i2.2,':',i2.2,':',i2.2,',',i1.1)") $
                      else atickname(i)=string(hour,minute,sec,format="(i2.2,':',i2.2,':',i2.2)")
   
  endfor
 
  device,decomposed=0
  
   if th le 0.01 then plot, [xmin-t0,xmax-t0], [ymin,ymax], /nodata, title='!5  ',yra=[ymin, ymax],ystyle=1, $
      ytitle='Frequency, MHz',xtitle='Time, UT',xcharsize=2, ycharsize=2,$
      ticklen=tl, xticks=nticks-1, xtickname=atickname, $
      xtickv=double(atickv)-t0,xra=[xmin-t0,xmax-t0], xstyle=1, $
     /device, position=[100,90,100+n_elements(image(*,0))+1,90+n_elements(image(0,*))+1] $
  else plot, [xmin,xmax], [ymin,ymax], /nodata, title='!5  ',yra=[ymin, ymax],ystyle=1, $
      ytitle='Frequency, MHz',xtitle='Time, UT',xcharsize=2, ycharsize=2,$
      ticklen=tl, xticks=nticks-1, xtickname=atickname, $
      xtickv=double(atickv),xra=[xmin,xmax], xstyle=1, $
     /device, position=[110,100,110+n_elements(image(*,0))+1,100+n_elements(image(0,*))+1],$
     background='FFFFFF'x,color='000000'x
  
  loadct,palette
  tvscl, image1, 111, 101, /device;,true=3
  loadct,0
   
  return
end

pro SPDYNPS, image, time0, time1, th, ymin,ymax,yh, grid,power,palette,file_out
  tl=-0.01
  if grid eq 1 then tl=1.0
  image1=image-min(image)
  if power gt 0 then image1=image1^power else $
  if power gt 500 then image1=alog(image1+1)
  
  t0=double(time0[0]*3600000L+time0[1]*60000L+time0[2]*1000L+time0[3])
  t1=double(time1[0]*3600000L+time1[1]*60000L+time1[2]*1000L+time1[3])
  
  if t1 lt t0 then t1=t1+24L*3600000L
;  print,t0,t1

  xn=n_elements(image[*,0])
  time=dblarr(xn)
  tth=(t1-t0)/double(xn-1)

  for i=0,xn-1 do time[i]=t0+tth*i

  xmin=time(0)
  xmax=time(xn-1)

  nticks=long(xmax-xmin)/(th*1000L)+1
 
  atickv=lonarr(nticks)
  atickname=strarr(nticks)
  
  if th ge 0.1 and th lt 1 then t0=t0+th*1000-(t0 mod (th*1000))
  if th ge 1 and th lt 2 then t0=t0+1000-(t0 mod 1000)
  if th ge 2 and th lt 5 then t0=t0+2000-(t0 mod 2000)
  if th ge 5 and th lt 10 then t0=t0+5000-(t0 mod 5000)
  if th ge 10 and th lt 20 then t0=t0+10000-(t0 mod 10000)
  if th ge 20 and th lt 30 then t0=t0+20000l-(t0 mod 20000l)
  if th ge 30 and th lt 60 then t0=t0+30000l-(t0 mod 30000l)
  if th ge 60 and th lt 600 then t0=t0+60000l-(t0 mod 60000l)
  if th ge 600 and th lt 1800 then t0=t0+600000l-(t0 mod 600000l)
  if th ge 1800 then t0=t0+1800000l-(t0 mod 1800000l)
 
  for i=0,nticks-1 do begin
    atickv[i]=ceil(t0+i*long(th*1000L))
    hour=atickv[i]/3600000L

    minute=(atickv[i]-3600000L*hour)/60000L
    sec=(atickv[i] mod 60000)/1000
    hsec=(atickv[i] mod 1000)
    if hour ge 24 then hour=hour-24

   
    if hsec gt 0 then atickname(i)=string(hour,minute,sec,hsec/100,format="(i2.2,':',i2.2,':',i2.2,',',i1.1)") $
                      else atickname(i)=string(hour,minute,sec,format="(i2.2,':',i2.2,':',i2.2)")
    
  endfor
 
  ;device,decomposed=0
   
  set_plot,'ps'
  device,filename=file_out,/color,xsize=18.0,ysize=9.0,xoffset=1,yoffset=20,bits_per_pixel=8

plot, [xmin,xmax], [ymin,ymax], /nodata, /device,title='!5  ',yra=[ymin, ymax], $
     position=[1600,1600,1620+n_elements(image(*,0))*8L,1620+n_elements(image(0,*))*16L],$
      ytitle='Frequency, MHz',xtitle='Time, UT',xcharsize=1, ycharsize=1,$
      ticklen=-0.02, xticks=nticks-1, xtickname=atickname, $
      xtickv=double(atickv),xra=[xmin,xmax], /xsty, /ysty

  loadct,palette
  WW=bytscl(image1)
  ww[where(ww eq 0)]=!D.TABLE_SIZE-1
  
  tv,ww,1610,1610,/device,xsize=n_elements(image1(*,0))*8L,ysize=n_elements(image1(0,*))*16L
  loadct,0
  device,/close 
  set_plot,'win'
 
  return
end
;print

;MAIN PROGRAM**************************************************************************************************************
restore,'E:\Shun\JUNO\perijove1\WAV_2016240T000000_E_V02.sav',/verb
t_center=[12,50,44]
A=strpos(TIME_C,'2016-240T12:50:44')
a1=where(a ne -1)
help,a1
print,a1


t_rEdge=[00,50,44]
B=strpos(TIME_C,'2016-240T00:50:44')
b1=where(b ne -1)
help,b1
print,b1
sp0=sp
time0=time

restore,'E:\Shun\JUNO\perijove1\WAV_2016241T000000_E_V02.sav',/verb
t_lEdge=[00,50,43]
C=strpos(TIME_C,'2016-241T00:50:44')
c1=where(c ne -1)
help,c1
print,c1

sp=[sp0[3032:*,*],sp[0:3047,*]]
time=[time0[3032:*],time[0:3047]]

;stop
;file_out='e:\My_documents\proj_learn\2020\programs\WAV_2016240T000000_E_V01_DAM.ps'
;file_out='e:\My_documents\proj_learn\2020\programs\WAV_2017070T000000_E_V01.ps'
;file_out='e:\shun\WAV_2017086T000000_E_V02\'+strtrim(string(ct),2)+'.ps'
file_out='E:\Shun\JUNO\perijove1\WAV_2016240T000000_E_V02.ps'
freq_ini=88; First frequency channel to be used

;
istart=0;start second 
ifin=84L*1011-1;end second
tstep=3600L*8;time step on the picture [s]


sp1=sp[*,freq_ini:*]
nt=n_elements(sp1[*,0])
nf=n_elements(sp1[0,*])

sp_av=fltarr(nf)```
for k=0,nf-1 do sp_av[k]=median(sp1[*,k])

sp2=sp1;
;for k=0,nf-1 do sp2[*,k]/=sp_av[k]

window,10,xsize=1150,ysize=450

;origin
t0=time[istart]-time[0]
t1=time[ifin-1]-time[0]
hr0=fix(t0/3600)
mn0=fix((t0-hr0*3600l)/60)
sc0=fix(t0-hr0*3600L-mn0*60)
thsec0=long((t0-hr0*3600L-mn0*60-sc0)*1000L)
time0=[hr0,mn0,sc0,thsec0];start time
;read,dummy
hr1=fix(t1/3600)
mn1=fix((t1-hr1*3600l)/60)
sc1=fix(t1-hr1*3600L-mn1*60)
thsec1=long((t1-hr1*3600L-mn1*60-sc1)*1000L)
time1=[hr1,mn1,sc1,thsec1];end time


for m=0,40 do begin
  SPDYNX, alog(rebin(sp2[istart:ifin,*],1011,38*8)),time0,time1,tstep,$
  freq[freq_ini]/1e6,freq[freq_ini+nf-1]/1e6,10,0,0,m

  ;write_jpeg,'e:\shun\WAV_2017086T000000_E_V02\'+strtrim(string(m),2)+'.jpg',tvrd(TRUE=1),TRUE=1
  write_jpeg,'E:\Shun\JUNO\perijove1\'+strtrim(string(m),2)+'.jpg',tvrd(TRUE=1),TRUE=1
  
endfor
;for n=0,40 do begin
;  SPDYNPS, alog(rebin(sp2[istart:ifin,*],1011*2,38*8)), time0, time1, tstep, $
;  freq[freq_ini]/1e6,freq[freq_ini+nf-1]/1e6,10, 0,0,n,$
;  file_out='e:\shun\WAV_2017086T000000_E_V02\'+strtrim(string(n),2)+'.ps'
;endfor  
set_plot,'win'
end