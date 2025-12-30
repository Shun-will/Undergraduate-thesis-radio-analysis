pro choose_day,pj,data_file,time_c0,hr,intdiv3,strdiv2,strdiv6,orbit,a1,b1,freq_ini,c1,freq1,time1,sp1,time_c1,m,i
;print,'choose_day'
;print,data_file
;print,hr 
;print,intdiv3
;print,''

B=strpos(TIME_C0,strdiv6);perijove2
b1=where(b ne -1)
;print,strdiv6  
print,b1
if b1 eq -1 then begin
  print,'b1 is -1'
  goto,skip_iteration
endif
;NEED TO IMPROVE 
if hr[i] ge 12 and hr[i] lt 24 then begin ; if perijove time is between 12 to 24 read data after the day
  m=0
  hr[i]-=12
  intdiv3+=1
  restrdiv3=string(intdiv3)
  if intdiv3 lt 100 then restrdiv3='0'+restrdiv3
  ;file_search('F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\',count=f)
  if pj[i] le 24 then file1='WAV_'+strdiv2+restrdiv3+'T000000_E_V02.csv'
  if pj[i] gt 24 then file1='WAV_'+strdiv2+restrdiv3+'T000000_E_V01.csv'
  filecom=strcompress(file1,/remove_all)
  secondpic='F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\'+orbit+'\'+filecom
  
  strdiv7=strsplit(strdiv6,'T',count=tb,/extract)
  ;print,strdiv7
  strdiv8=strsplit(strdiv7[1],':',count=s8,/extract)
  ;print,strdiv8
  hfromdiv8=fix(strdiv8[0]);0 hr,1 min,2 sec
  ;print,hfromdiv8
  hdiv8=strtrim(hfromdiv8,2); remove all space
  ;print,hdiv8
  inth1=hdiv8-12
  strh1=string(inth1)
  if inth1 lt 10 then strh1='0'+strh1
  strdiv9=strdiv7[0]+'T'+strh1+':'+strdiv8[1]+':'+strdiv8[2]
  div9com=strcompress(strdiv9,/remove_all)
  ;print,div9com
  A=strpos(TIME_C0,div9com);perijove-12h
  a1=where(a ne -1)   
  print,a1
  if a1 eq -1 then begin
    print,'a1 is -1'
    goto,skip_iteration
  endif
  
  filename=secondpic
  print,"Second picture"
  READ_JUNO,filename,freq,time,sp,time_c
  freq1=freq
  time1=time
  sp1=sp[*,freq_ini:*]
  time_c1=time_c
  
  ;calculate c1  
  inth2=hdiv8+12
  if inth2 ge 24 then inth2-=24
  strh2=string(inth2)
  if inth2 lt 10 then strh2='0'+strh2
  strdiv11=strsplit(strdiv7[0],'-',count=div11,/extract)
  intdiv11=fix(strdiv11[1])
  intdiv11+=1
  strdiv12=string(intdiv11)
  if intdiv11 gt 10 and intdiv11 lt 100 then strdiv12='0'+strdiv12
  if intdiv11 lt 10 then strdiv12='00'+strdiv12
  strdiv10=strdiv11[0]+'-'+strdiv12+'T'+strh2+':'+strdiv8[1]+':'+strdiv8[2]
  div10com=strcompress(strdiv10,/remove_all)
  ;print,div10com
  C=strpos(TIME_C1,div10com);perijove+12h
  c1=where(c ne -1) 
  print,c1
  if c1 eq -1 then begin
    print,'c1 is -1'
    goto,skip_iteration
  endif

endif else if hr[i] ge 0 and hr[i] lt 12 then begin 
  m=1
  hr[i]+=12
  intdiv3-=1
  restrdiv3=string(intdiv3)
  if intdiv3 lt 100 then restrdiv3='0'+restrdiv3
  if pj[i] le 24 then file1='WAV_'+strdiv2+restrdiv3+'T000000_E_V02.csv'
  if pj[i] gt 24 then file1='WAV_'+strdiv2+restrdiv3+'T000000_E_V01.csv'
  filecom=strcompress(file1,/remove_all)
  secondpic='F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\'+orbit+'\'+filecom
  
  strdiv7=strsplit(strdiv6,'T',count=tb,/extract)
  ;print,strdiv7
  strdiv8=strsplit(strdiv7[1],':',count=s8,/extract)
  ;print,strdiv8
  hfromdiv8=fix(strdiv8[0]);0 hr,1 min,2 sec
  ;print,hfromdiv8
  hdiv8=strtrim(hfromdiv8,2); remove all space
  ;print,hdiv8
  inth1=hdiv8+12
  strh1=string(inth1)
  if inth1 lt 10 then strh1='0'+strh1
  strdiv9=strdiv7[0]+'T'+strh1+':'+strdiv8[1]+':'+strdiv8[2]
  div9com=strcompress(strdiv9,/remove_all)
  ;print,div9com
  c=strpos(TIME_C0,div9com);perijove-12h
  c1=where(c ne -1)   
  print,c1
  if c1 eq -1 then begin
    print,'c1 is -1'
    goto,skip_iteration
  endif
  
  filename=secondpic  
  print,"Second picture"
  print,filename
  READ_JUNO,filename,freq,time,sp,time_c

  freq1=freq
  time1=time
  sp1=sp[*,freq_ini:*]
  time_c1=time_c
  ;calculate c1  
  inth2=hdiv8-12
  if inth2 lt 0 then inth2+=24
  strh2=string(inth2)
  if inth2 lt 10 then strh2='0'+strh2
  strdiv11=strsplit(strdiv7[0],'-',count=div11,/extract)
  intdiv11=fix(strdiv11[1])
  intdiv11-=1
  strdiv12=string(intdiv11)
  if intdiv11 gt 10 and intdiv11 lt 100 then strdiv12='0'+strdiv12
  if intdiv11 lt 10 then strdiv12='00'+strdiv12
  strdiv10=strdiv11[0]+'-'+strdiv12+'T'+strh2+':'+strdiv8[1]+':'+strdiv8[2]
  div10com=strcompress(strdiv10,/remove_all)
  ;print,div10com
  a=strpos(TIME_C1,div10com);perijove+12h
  a1=where(a ne -1) 
  print,a1
  ;print,'----------------------------------------------'
endif

skip_iteration:
;stop
end