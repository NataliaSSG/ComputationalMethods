#lang racket
(require racklog)

(define %padre
  (%rel ()
        [('Pablo 'Margarita)]
        [('Silvia 'Valeria)]
        [('Mateo 'Valeria)]
        [('Pablo 'Hugo)]
        [('Lucas 'Daniel)]
        [('Emma 'Manuel)]
        [('Juan 'Alejandro)]
        [('Alejandro 'Antonio)]
        [('Paula 'Emma)]
        [('Lucas 'Julia)]
        [('Pedro 'Lucas)]
        [('Leonardo 'Emma)]
        [('Manuel 'Carmen)]
        [('Pablo 'Luisa)]
        [('Margarita 'Carmen)]
        [('Hugo 'Ramiro)]
        [('Carlos 'Pablo)]
        [('Carlos 'Beatriz)]
        ))

(define %genero ; BD para declarar el genero de las personas
  (%rel ()
    [('Pablo 'hombre)]
    [('Silvia 'mujer)]
    [('Mateo 'hombre)]
    [('Hugo 'hombre)]
    [('Lucas 'hombre)]
    [('Emma 'mujer)]
    [('Juan 'hombre)]
    [('Alejandro 'hombre)]
    [('Paula 'mujer)]
    [('Julia 'mujer)]
    [('Pedro 'hombre)]
    [('Leonardo 'hombre)]
    [('Manuel 'hombre)]
    [('Luisa 'mujer)]
    [('Margarita 'mujer)]
    [('Ramiro 'hombre)]
    [('Carlos 'hombre)]
    [('Beatriz 'mujer)]
    [('Valeria 'mujer)]
    [('Carmen 'mujer)]
    [('Antonio 'hombre)]
    [('Daniel 'hombre)]
    ))


;; PROBLEMA 1
(define %mujer
  (%rel (person)
    [(person)
     (%genero person 'mujer)]))

(define %hombre
  (%rel (person)
    [(person)
     (%genero person 'hombre)]))

(newline)
(displayln "Problema 1: Genero")
(display "Mujeres: ")
(%find-all (p) (%mujer p))
(display "Hombres: ")
(%find-all (p) (%hombre p))
(newline) (newline)


;; PROBLEMA 2
(define %abuela-mujer
  (%rel (a h n)
        [(a n)
         (%mujer a) (%padre a h) (%padre h n)]))

(displayln "Problema 2: Abuelas mujeres con sus nietos/as")
(%find-all (a n) (%abuela-mujer a n))
(newline) (newline)


;; PROBLEMA 3
(define %hermano
  (%rel (p h he)
        [(h he)
         (%padre p h) (%padre p he)
         (%/== h he)]))

(define %tio-hombre
  (%rel (t h s)
        [(t s)
         (%hombre t) (%padre h s) (%hermano t h)]))

(displayln "Problema 3: Tios hombres con sus sobrinos/as")
(%find-all (t s) (%tio-hombre t s))
(newline) (newline)


;; PROBLEMA 4
(define %nieta-mujer
  (%rel (a h n)
        [(a n)
         (%padre a h) (%padre h n) (%mujer n)]))

(displayln "Problema 4: Abuelos/as con nietas mujeres")
(%find-all (a n) (%nieta-mujer a n))
(newline) (newline)


;; PROBLEMA 5
(define %sobrino-hombre
  (%rel (t h s)
        [(t s)
         (%hombre s) (%padre h s) (%hermano t h)]))

(displayln "Problema 5: Tios/as con sobrinos hombres")
(%find-all (t s) (%sobrino-hombre t s))
(newline) (newline)


;; PROBLEMA 6
(define %abuelo
  (%rel (a p n)
        [(a n)
         (%padre a p) (%padre p n)]))

(define %sobrina-nieta-mujer
  (%rel (ta a sn)
        [(ta sn)
         (%mujer sn) (%hermano ta a) (%abuelo a sn)]))

(displayln "Problema 6: Tios/as abuelos/as con sobrinas nietas mujeres")
(%find-all (ta sn) (%sobrina-nieta-mujer ta sn))
(newline) (newline)
