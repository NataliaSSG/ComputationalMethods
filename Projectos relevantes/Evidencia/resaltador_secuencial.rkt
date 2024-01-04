#lang racket

(require "evidencia1racket.rkt")


(define (resaltador-secuencial base-folder output-folder)
  (for ([i (in-range 1 101)])
    (define current-file-name (string-append base-folder "/archivofuente" (number->string i) ".txt"))
    (define regex-file (string-append base-folder "/archivoexpresiones" (number->string i) ".txt"))
    (define output-file (string-append output-folder "/archivohtml" (number->string i) ".html"))

    ; llamada a la funcion resaltador
    (resaltador regex-file current-file-name output-file)))


(define start-time (current-inexact-monotonic-milliseconds))

; llamadas al resaltador secuencial
; primer parametro es la carpeta con los archivos a leer
; segundo parametro es la carpeta donde se generaran los archivos html

(resaltador-secuencial "carpeta1" "carpeta_output1") ; llamada con carpeta 1
(resaltador-secuencial "carpeta2" "carpeta_output2") ; llamada con carpeta 2

; se deben hacer dos llamadas, una para cada carpeta

(define end-time (current-inexact-monotonic-milliseconds))
(define elapsed-time (- end-time start-time))
(displayln (format "Tiempo de ejecucion: ~a milliseconds" elapsed-time))