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

plot, [xmin,xmax], [ymin,ymax], /nodata, /device,title='!5 ',yra=[ymin, ymax], $
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