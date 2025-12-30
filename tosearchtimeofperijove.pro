pro tosearchTimeofperijove,i,data_file,hr,mins,sec,nameoffile,ns1,orbit,strdiv2,intdiv3,strdiv6
;print,'tosearchTimeofperijove'
;print,data_file

nameoffile=strsplit(data_file,'\.',count=ns1,/extract)
;print,'1, '+nameoffile[ns1-2]
;F: JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2 0 DATA WAVES_SURVEY 2016213_ORBIT_01 WAV_2016240T000000_E_V02 csv
orbit=nameoffile[ns1-3]
;print,'2, '+orbit
;2016213_ORBIT_01
strdiv=strsplit(nameoffile[6],'_',count=ns2,/extract)
;print,strdiv
;WAV 2016240T000000 E V02
strdiv0=strsplit(strdiv[1],'T',count=st,/extract,/regex)
;print,'strdiv0[0], '+strdiv0[0]
;2016240 000000

;strdiv1=strsplit(strdiv[1],'00',count=ns3,/extract,/regex)
;print,'strdiv1, '+strdiv1
;;2016240T

strdiv2=strmid(strdiv0[0],0,4)
;print,'strdiv2, '+strdiv2
;2016
strdiv3=strmid(strdiv0[0],4,3)
;print,'strdiv3, '+strdiv3
;240
intdiv3=fix(strdiv3)
;print,'intdiv3, '+intdiv3

;strdiv4=strmid(strdiv1,7,1)
;print,'strdiv4, '+strdiv4
;;T

strdiv5=strdiv2+'-'+strdiv3+'T'
;print,'strdiv5, '+strdiv5
;2016-240T


strhr=string(hr[i])
strmins=string(mins[i])
strsec=string(sec[i])

if hr[i] lt 10 then strhr='0'+strhr  
if mins[i] lt 10 then strmins='0'+strmins
if sec[i] lt 10 then strsec='0'+strsec
strhr1=strcompress(strhr,/remove_all);removed all space 
strmins1=strcompress(strmins,/remove_all)
strsec1=strcompress(strsec,/remove_all)
  
strdiv6=strdiv5+strhr1+':'+strmins1+':'+strsec1
;print,strdiv6

;strhr1=strtrim(strhr,2);removed all space
;strmins1=strtrim(strmins,2)
;strsec1=strtrim(strsec,2)
;strdiv6=strdiv5+strhr1+':'+strmins1+':'+strsec1
;print,strdiv6
;2016-240T12:50:44
end