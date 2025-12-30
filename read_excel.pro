;Perijove1
pro Read_excel,file,pj,hr,mins,sec,ymd,yearjove,_doyarr
;print,'read_excel'
pj=intarr(77)
hr=pj
mins=pj
sec=pj
yearjove=pj
_doyarr=pj

;if skipit eq 0 then begin
openr,1,file
;endif
c=''

for i=0,76 do begin 
  readf,1,c
  jove=c
  fn1=strsplit(jove,';',count=nf,/extract)
  fn2=strsplit(fn1[2],':',count=nf,/extract);hour,min,sec
  ymd=fn1[1];year month day
  ymddiv=strsplit(ymd,' ',count=ng,/extract)
  yearjove[i]=ymddiv[0]
  pj[i]=fix(fn1[0])
  hr[i]=fix(fn2[0])
  mins[i]=fix(fn2[1])
  sec[i]=fix(fn2[2])
  doy,ymd,_doy
  _doyarr[i]=_doy
endfor
;print,yearjove
close,1

end