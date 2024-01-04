#lang racket

;; Natalia Salgado
;; Sebastian Rosas

(define cabeza 0) ; permanece igual
(struct accion (escribir mover siguiente)) ; permanece igual
(define estado 0) ; permanece igual


;; ***************************** EJERCICIO 1: PALINDROMOS *****************************

#|

(define encabezados (list 'a 'b 'V))

; (define cinta (vector 'a 'b 'a 'a 'b 'b 'a 'b 'V 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 1
; (define cinta (vector 'b 'a 'a 'b 'b 'a 'a 'b 'V 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 2


(define tabla-estados
  (vector
   (vector (accion 'V 'D 1) (accion 'V 'D 4)  (accion 'V 'T 6)) ; estado 0 (ESTADO FINAL PALINDROMO PAR)
   (vector (accion 'a 'D 1) (accion 'b 'D 1)  (accion 'V 'I 2)) ; estado 1
   (vector (accion 'V 'I 3) (accion 0 #f 0)  (accion 'V 'T 6)) ; estado 2 (A IMPAR)
   (vector (accion 'a 'I 3) (accion 'b 'I 3)  (accion 'V 'D 0)) ; estado 3
   (vector (accion 'a 'D 4) (accion 'b 'D 4)  (accion 'V 'I 5)) ; estado 4
   (vector (accion 0 #f 0) (accion 'V 'I 3)  (accion 'V 'T 6)) ; estado 5 (B IMPAR)
   (vector (accion 0 #f 0) (accion 0 #f 0)  (accion 0 #f 0)) ; estado 6
   ))

|#


;;  ***************************** EJERCICIO 2: L = {(test)+} *****************************

#|

(define encabezados (list 't 'e 's 'V))

; (define cinta (vector 't 'e 's 't 't 'e 's 't 't 'V 'V 'V 'V 'V)) ; EJEMPLO 1
; (define cinta (vector 't 'e 's 't 't 'e 's 't 't 'e 's 't 't 'e 's 't 'V 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 2


(define tabla-estados
  (vector
   (vector (accion 't 'D 1) (accion 0 #f 0)  (accion 0 #f 0) (accion 0 #f 0)) ; estado 0
   (vector (accion 0 #f 0) (accion 'e 'D 2)  (accion 0 #f 0) (accion 0 #f 0)) ; estado 1
   (vector (accion 0 #f 0) (accion 0 #f 0)  (accion 's 'D 3) (accion 0 #f 0)) ; estado 2
   (vector (accion 't 'D 4) (accion 0 #f 0)  (accion 0 #f 0) (accion 0 #f 0)) ; estado 3
   (vector (accion 't 'D 1) (accion 0 #f 0)  (accion 0 #f 0) (accion 'V 'T 5)) ; estado 4
   (vector (accion 0 #f 0) (accion 0 #f 0)  (accion 0 #f 0) (accion 0 #f 0)) ; estado 5
   ))

|#


;;  ***************************** EJERCICIO 3: DIFERENCIA ENTRE DOS NUMEROS *****************************

#|

(define encabezados (list 1 '- 'V))

; (define cinta (vector 1 1 1 1 1 '- 1 1 1 'V 'V 'V 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 1
; (define cinta (vector 1 1 1 1 '- 1 1 1 1 1 1 1 1 1 'V 'V 'V 'V 'V 'V 'V 'V 'V 'V)) ; EJEMPLO 2


(define tabla-estados
  (vector
   (vector (accion 'V 'D 1) (accion 'V 'D 4)  (accion 0 #f 0)) ; estado 0
   (vector (accion 1 'D 1) (accion '- 'D 1)  (accion 'V 'I 2)) ; estado 1
   (vector (accion 'V 'I 3) (accion 1 'D 6)  (accion 0 #f 0)) ; estado 2 (RESTA POSITIVA)
   (vector (accion 1 'I 3) (accion '- 'I 3)  (accion 'V 'D 0)) ; estado 3
   (vector (accion 1 'I 5) (accion 0 #f 0)  (accion 'V 'T 7)) ; estado 4 (RESULTADO 0)
   (vector (accion 0 #f 0) (accion 0 #f 0)  (accion '- 'D 6)) ; estado 5 (RESTA NEGATIVA)
   (vector (accion 1 'T 7) (accion '- 'T 7)  (accion 'V 'T 7)) ; estado 6 (GUARDAR CAMBIOS)
   (vector (accion 0 #f 0) (accion 0 #f 0)  (accion 0 #f 0)) ; estado 7
   ))

|#


;;  ***************************************** EJECUCION *****************************************


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


