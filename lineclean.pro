FUNCTION lineclean,wav,flux,numsig,grow,niter,sigma
; function that takes an input spectrum and cleans points 
; that deviate by numsig sigma 
; if you have an error spectrum you can pass it as sigma
; if not, the program calculates a running standard deviation

fixedflux=flux

;do iterations
FOR j=1,niter DO BEGIN
   ;create running median of the spectrum
   md=median(fixedflux,20)
   ;If sigma spectrum is provided, use it.  Otherwise
   ;calculate a running standard deviation
   IF (N_ELEMENTS(sigma) EQ 0) THEN BEGIN
      standarddev=dblarr(N_ELEMENTS(wav))
      FOR i=10l,N_ELEMENTS(wav)-11 DO $
            standarddev(i)=STDDEV(fixedflux[i-10:i+10],/DOUBLE)
      standarddev[0:9]=standarddev[10]
      standarddev[N_ELEMENTS(wav)-10:N_ELEMENTS(wav)-1]=standarddev[N_ELEMENTS(wav)-11]
   ENDIF ELSE standarddev=sigma

   ;replace values gt numsig standard deviations away with running median
   w=where((fixedflux GT md+numsig*standarddev) OR (fixedflux LT md-numsig*standarddev),count)

   ;if there is a grow radius set,
   ;replace values on 'grow' number of pixels on either side of the bad pixel
   FOR i=0,grow DO BEGIN
      IF (count NE 0) THEN BEGIN
         fixedflux[w+i]=md[w+i]
         fixedflux[w-i]=md[w-i]
      ENDIF
   ENDFOR ; grow
ENDFOR  ; niter

RETURN,fixedflux
END
