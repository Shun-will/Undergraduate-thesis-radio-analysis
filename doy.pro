pro DOY,ymd,_doy
;print,'DOY'
ymddiv=strsplit(ymd,' ',count=ng,/extract)
year=ymddiv[0]
monthwithapos=ymddiv[1]
date=ymddiv[2]
month=ymddiv[1]

monofy=[31,28,31,30,31,30,31,31,30,31,30,31]

months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]

index = where(months eq month, count)
_doy=intarr(77)
if year mod 4 eq 0 then  monofy[1]++
if numbers[index]-1 gt 0 then begin
  _doy=total(monofy[0:numbers[index]-2])
endif else begin 
  _doy=0
endelse 
  _doy=_doy+date
end