PRO READ_JUNO,data_file,freq,time,sp,time_c
;print,'read_juno'
;dir='e:\My_documents\proj_learn\2020\programs\'
;dir='e:\programs\Idl40\2020\JUNO\
;file='y:\JUNO_DATA\data\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V1.0\DATA\WAVES_SURVEY\2016213_ORBIT_01\WAV_2016240T000000_E_V01.CSV'
;file='y:\JUNO_DATA\data\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V1.0\DATA\WAVES_SURVEY\2018329_ORBIT_17\WAV_2018355T000000_E_V01.CSV'
;file='y:\JUNO_DATA\data\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V1.0\DATA\WAVES_SURVEY\2017059_ORBIT_05\WAV_2017070T000000_E_V01.CSV'
;file='F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\2017059_ORBIT_05\WAV_2017086T000000_E_V02.csv'
file=data_file
print,file
fn=strsplit(file,'\',count=nf,/extract)
fn1=strsplit(fn[nf-1],'.',/extract)
;file_out=dir+fn1[0]+'.bin'
PJ=strsplit(fn[nf-2],'_',/EXTRACT)
PJ=fix(PJ[2])
;stop
;read,dummy
openr,1,file
c=''
n=100000;estimate from above on the number of data points (strings in Excel file)

i0=28;start of frequency recordings

time=dblarr(n)
time_c=strarr(n)
N_empty=intarr(n)
for k=0,3 do readf,1,c;skip first 4 lines. 4th line contains frequencies [Hz]
bb=byte(c)
c=string(bb[where(bb ne 34)]);34 is '"'
reslt=strsplit(c,',',count=ncf,/EXTRACT,/PRESERVE_NULL)
freq=[double(reslt[i0:*])]
;read,dummy
readf,1,c;one more line skip. contains channel noise bandwidths in Hertz
bb=byte(c)
c=string(bb[where(bb ne 34)])
band=double(reslt[i0:*])
reslt=strsplit(c,',',count=nc,/EXTRACT,/PRESERVE_NULL)
sp=dblarr(n,nc-i0)-1;dynamic spectrum
k=0L
WHILE NOT EOF(1) DO BEGIN 
  readf,1,c
  bb=byte(c)
  c=string(bb[where(bb ne 34)])
  reslt=strsplit(c,',',count=nc,/EXTRACT,/PRESERVE_NULL)
  res_emp=where(reslt eq '',nc_empty)
  if nc_empty gt 0 then n_empty[k]=nc_empty
  if nc ne ncf then read,dummy
  time_c[k]=reslt[1]
  time[k]=reslt[0]
  sp[k,*]=double(reslt[i0:*])
  k++
  ;read,dummy
ENDWHILE  
n=k
sp=sp[0:n-1,*]
time=time[0:n-1]
time_c=time_c[0:n-1]
n_empty=n_empty[0:n-1]
;help,freq,time,sp,time_c 

;openw,2,file_out  

;writeu,2,freq,time,sp,time_c
;close,2;close output file
close,1;close input file

end