pro search_jove,yearjove,date_files,constr,_doyarr
;print,'search_jove'
constr=strarr(77)
_doystr=strarr(77)
for j=0, 52 do begin
  files='F:\JNO-E_J_SS-WAV-3-CDR-SRVFULL-V2.0\DATA\WAVES_SURVEY\'
  cd,files
  ;print,'PERIJOVE No. '+strtrim(string(j+1),2)
  fnm=file_search(count=nz);read nz folder names present in the files folder.
  fnm=fnm[where(strpos(fnm,'ORBIT') gt 0)]; restrict the list to those with "ORBIT"
  data_files=files+fnm[j+1]
  cd,data_files;go to perijove "J" folder
  ;print,data_files
;  print,pj_date[*,j]
  if j ge 24 then version='1' else version='2'
  _doystr[j]=string(_doyarr[j])
  if _doyarr[j] lt 100 and _doyarr[j] gt 10 then _doystr[j]=strcompress('0'+_doystr[j],/remove_all)
  if _doyarr[j] lt 10 then _doystr[j]='00'+_doystr[j]
  constr[j]=data_files+'\WAV_'+strtrim(string(yearjove[j]),2)+strtrim(_doystr[j],2)+'T000000_E_V0'+version+'.csv'
  ;print,constr[j]
endfor 

end
