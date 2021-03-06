PRO sfsetup

; read in all the templates for fitting program

; directory containing ascii files for templates
gdir = 'gal/'

readcol,  'savefiles/gal.list', galfiles,  format='A'

tgal = {gal, day:0,  file:' ', w:fltarr(10000),  f:fltarr(10000),  npoint:0}
gal = replicate(tgal, N_ELEMENTS(galfiles))

FOR i = 0, N_elements(galfiles)-1 DO BEGIN

    readcol,  gdir+GALFILES(I), Wt, Ft, format='D,D'
    gal(i).file = galfiles(i)
    gal(i).w  =  wt 
    gal(i).f =  ft
    gal(i).npoint = n_elements(wt)

ENDFOR

; save them in an IDL save file
; print out what's there

wfile = where(gal.file ne ' ')

FOR i=0, n_elements(wfile)-1 DO BEGIN

print, i, gal(i).file,  format='(i4, 3x, a)'

ENDFOR

save,gal,filename='savefiles/galtemp.idlsave'


;;;;;;;;;;; filters ;;;;;;;;;;;;;;;;;;
; directory containing ascii files for templates
fdir = 'filters/'

readcol,  'savefiles/filters.list', filtfiles,  format='A'

tfilt = {filt, day:0,  file:' ', w:fltarr(10000),  f:fltarr(10000),  npoint:0}
filt = replicate(tfilt, N_ELEMENTS(filtfiles))

FOR i = 0, N_elements(filtfiles)-1 DO BEGIN

    readcol,  fdir+FILTFILES(I), Wt, Ft, format='d,d'
    filt(i).file = filtfiles(i)
    filt(i).w  =  wt 
    filt(i).f =  ft
    filt(i).npoint = n_elements(wt)

ENDFOR

; save them in an IDL save file
; print out what's there

wfile = where(filt.file ne ' ')

FOR i=0, n_elements(wfile)-1 DO BEGIN

print, i, filt(i).file,  format='(i4, 3x, a)'

ENDFOR

save,filt,filename='savefiles/filters.idlsave'


; read in all the templates for fitting program

;; requires a file  named 'savefiles/tempset.list' which lists the
;; root name for each set of templates

; list of template sets
tempsetlist = 'savefiles/tempset.list'
; directory containing ascii files for templates
readcol, tempsetlist, temprootname, format='A'

FOR J = 0,N_ELEMENTS(temprootname)-1 DO BEGIN
    readcol, temprootname[J]+'.list', sntfiles,  format='A'
    tsnt = {snt, day:0,  file:' ', w:fltarr(20000),  f:fltarr(20000),  npoint:0}
    snt = replicate(tsnt, N_ELEMENTS(sntfiles))
    
    FOR i = 0, N_elements(sntfiles)-1 DO BEGIN
        
        readcol,  SNTFILES(I), Wt, Ft, format='d,d'
        print , sntfiles(i)
        snt(i).file = sntfiles(i)
        snt(i).w  =  wt 
        snt(i).f =  ft
        snt(i).npoint = n_elements(wt)
        
    ENDFOR
    
; save them in an IDL save file
; print out what's there
    
    wfile = where(snt.file ne ' ')
    
    FOR i=0, n_elements(wfile)-1 DO BEGIN
        
        print, i, snt(i).file,  format='(i4, 3x, a)'
        
    ENDFOR    
    save,snt,filename=temprootname[J]+'.idlsave'
    
ENDFOR

END
