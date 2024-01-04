#lang racket

;; Natalia Salgado
;; Sebastian Rosas

;; ***************************** EJERCICIO 1: SUMA BINARIA *****************************

(define cabeza 0)
(define estado 0)
(struct accion (escribir mover siguiente))

; ENCABEZADOS
(define encabezados (list 0 1 '+ 'V))

; EJEMPLOS (LAS CINTAS DEBEN TENER SUFICIENTES CELDAS VACIAS A LA IZQUIERDA)
(define cinta (vector 'V 'V 'V 'V 'V 1 1 0 1 1 0 0 1 0 1 '+ 1 0 1 1 1 0 0 1 0 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 1
; (define cinta (vector 'V 'V 'V 'V 'V 'V 1 0 1 0 1 1 '+ 1 0 0 1 0 1 0 1 1 1 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 2

; TABLA DE ESTADOS
(define tabla-estados
  (vector
   (vector (accion 0 'D 0) (accion 1 'D 0)  (accion '+ 'D 1) (accion 'V 'D 0)) ; estado 0 ESTADO QUE RECORRE HASTA EL +
   (vector (accion 0 'D 1) (accion 1 'D 1)  (accion 0 #f 0) (accion 'V 'I 2)) ; estado 1 ESTADO QUE RECORRE HASTA CELDA VACIA
   (vector (accion 1 'I 2) (accion 0 'I 3)  (accion 'V 'D 6) (accion 0 #f 0)) ; estado 2 RESTA 1 AL NUM DER
   (vector (accion 0 'I 3) (accion 1 'I 3)  (accion '+ 'I 3) (accion 'V 'D 4)) ; estado 3 RECORRE HASTA EL V EN IZQ
   (vector (accion 0 'D 4) (accion 1 'D 4)  (accion '+ 'I 5) (accion  0 #f 0)) ; estado 4 RECORRE HASTA EL +
   (vector (accion 1 'D 0) (accion 0 'I 5)  (accion 0 #f 0) (accion 1 'D 0)) ; estado 5 SUMA 1 AL  NUM IZQ
   (vector (accion 0 #f 0) (accion 'V 'D 6)  (accion 0 #f 0) (accion 'V 'T 7)) ; estado 6 CONVIERTE CELDAS A VACIAS DEL NUM DER 
   (vector (accion 0 #f 0) (accion 0 #f 0)  (accion 0 #f 0) (accion 0 #f 0)) ; estado 7 TERMINA
   ))

(define (determina-ind-enc ent) (- (length encabezados) (length (member ent encabezados))))
(define (estado-ref est ent) (vector-ref (vector-ref tabla-estados est) (determina-ind-enc ent)))
(define (cabeza-val) (vector-ref cinta cabeza))
(define (cinta-set! v) (vector-set! cinta cabeza v))

(define (recorre-maq-tur)
  (let* ([simbolo (cabeza-val)] ; entrada actual
      [acciones (estado-ref estado simbolo)]
         [mover (accion-mover acciones)])
    (cond [(equal? #f mover)
           (printf "Rechazado. Falla en estado ~a, cabeza: ~a\n~a" estado cabeza cinta)]
       [(equal? 'T mover)
           (printf "Finalizado y aceptado!\n")]
          [else
        (let* ([escribir (accion-escribir acciones)]
               [cambiado (not (equal? simbolo escribir))])
             (cinta-set! escribir)
          (set! cabeza (if (equal? mover 'I) (sub1 cabeza) (add1 cabeza)))
          (when cambiado (printf "~a\n" cinta))
          (set! estado (accion-siguiente acciones))
             (recorre-maq-tur))])))

(recorre-maq-tur)

