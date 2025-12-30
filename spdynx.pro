pro SPDYNX,pj,i, image, time0, time1, th, ymin,ymax,yh, grid,power,palette,title
  tl=-0.01
  if grid eq 1 then tl=1.0
   image1=image-min(image)
  if power gt 0 then image1=image1^power else $
  if power gt 500 then image1=alog(image1+1)
  t0=double(time0[0]*3600000L+time0[1]*60000L+time0[2]*1000L+time0[3])
  t1=double(time1[0]*3600000L+time1[1]*60000L+time1[2]*1000L+time1[3])
  
  if t1 lt t0 or abs(t1-t0) le 1000 then t1=t1+24L*3600000L

  xn=n_elements(image[*,0])
  time=dblarr(xn)
  tth=(t1-t0)/double(xn-1)

  for iii=0,xn-1 do time[iii]=t0+tth*iii

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
 
  for ii=0,nticks-1 do begin
    atickv[ii]=ceil(t0+ii*long(th*1000L))
    hour=atickv[ii]/3600000L

    minute=(atickv[ii]-3600000L*hour)/60000L
    sec=(atickv[ii] mod 60000)/1000
    hsec=(atickv[ii] mod 1000)
    if hour ge 24 then hour=hour-24

    
    if hsec gt 0 then atickname(ii)=string(hour,minute,sec,hsec/100,format="(i2.2,':',i2.2,':',i2.2,',',i1.1)") $
                      else atickname(ii)=string(hour,minute,sec,format="(i2.2,':',i2.2,':',i2.2)")
   if palette gt 50 then read,dummy
  endfor
 
  device,decomposed=0
  
   if th le 0.01 then plot, [xmin-t0,xmax-t0], [ymin,ymax], /nodata, title='Perijove'+pj[i],yra=[ymin, ymax],ystyle=1, $
      ytitle='Frequency, MHz',xtitle='Time, UT',xcharsize=2, ycharsize=2,$
      ticklen=tl, xticks=nticks-1, xtickname=atickname, $
      xtickv=double(atickv)-t0,xra=[xmin-t0,xmax-t0], xstyle=1, $
     /device, position=[100,90,100+n_elements(image(*,0))+1,90+n_elements(image(0,*))+1] $
  else plot, [xmin,xmax], [ymin,ymax], /nodata, title='Perijove'+pj[i],yra=[ymin, ymax],ystyle=1, $
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
