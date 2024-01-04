#lang racket

(require racket/place)
(provide resaltador-paralelo)

(define (resaltador-paralelo folder1 folder2 output1 output2) ; dos carpetas de entrada, y dos carpetas de salida (cada una con los 100 archivos html por generarse)

    ; se crean los dos places
    (define p1 (dynamic-place "working_thread.rkt" 'process-files))
    (define p2 (dynamic-place "working_thread.rkt" 'process-files))

    ; se envian los paths de los folders
    (place-channel-put p1 folder1)
    (place-channel-put p1 output1)
  
    (place-channel-put p2 folder2)
    (place-channel-put p2 output2)
  
    (place-wait p1)
    (place-wait p2))

(define start-time (current-inexact-monotonic-milliseconds))

; se llama el resaltador paralelo
; primeros dos parametros son las carpetas con los 200 archivos cada una
; segundos dos parametros son las carpetas vacias donde se crearan los archivos html

(resaltador-paralelo "carpeta1" "carpeta2" "carpeta_output1" "carpeta_output2") 

(define end-time (current-inexact-monotonic-milliseconds))
(define elapsed-time (- end-time start-time))
(displayln (format "Tiempo de ejecucion: ~a milliseconds" elapsed-time))
