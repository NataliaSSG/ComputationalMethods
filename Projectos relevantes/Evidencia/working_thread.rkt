#lang racket

(require "evidencia1racket.rkt")
(require racket/place)
(provide process-files)

(define (process-files ch)
  (define base-folder (place-channel-get ch))
  (define output-folder (place-channel-get ch))

  ; se itera para leer los 100 archivos fuente, y los 100 archivos con regex
  ; en cada iteracion se crea el archivo html correspondiente
  (for ([i (in-range 1 101)])
    (define current-file-name (string-append base-folder "/archivofuente" (number->string i) ".txt"))
    (define regex-file (string-append base-folder "/archivoexpresiones" (number->string i) ".txt"))
    (define output-file (string-append output-folder "/archivohtml" (number->string i) ".html"))

    ; llamada a la funcion resaltador
    (resaltador regex-file current-file-name output-file)))


