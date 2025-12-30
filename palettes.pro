a1=!x.STYLE
a2=!Y.STYLE
a3=!P.MULTI
a4=!X.MARGIN
a5=!Y.MARGIN
!X.STYLE=5
!Y.STYLE=5
!P.MULTI=[0,3,14]
!X.MARGIN=[10,0]
!Y.MARGIN=[1,0]
window,2,xsize=600,ysize=400
device ,decomposed=0 
for i =0, 40 do begin
  loadct, i, /silent
  contour , [[indgen(255)], [indgen(255)]], nlevels=256, /fill,background=255
  loadct,0
  xyouts , 0, 0.2, strcompress(strmid(i, 2),/remove_all),color=0,alignment=1,charsize=1.5
endfor
write_jpeg,'m:\programs\Idl40\2022\GALYA\palettes.jpg',$
    tvrd(TRUE=1),TRUE=1
!X.STYLE=a1
!Y.STYLE=a2
!P.MULTI=a3
!X.MARGIN=a4
!Y.MARGIN=a5
loadct,get_names=names
;for i=0,n_elements(names)-1 do print,i,names[i],format='(%"%d: %s")'


end
