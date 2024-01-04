#lang racket

(provide resaltador)

;; LISTA DE VARIABLES GLOBALES
(define line-list '()) ; lista de token-lists
(define token-list '()) ; lista de tokens y su info por linea
(define regex-patterns '()) ; lista de regex


;; FUNCION PARA CREAR LISTA DE REGEX
(define (crear-lista-regex file-path)
  (define file (open-input-file file-path))
  (let loop ((line (read-line file)))
    (cond
      [(eof-object? line) 
       (close-input-port file) ; cerrar archivo
       regex-patterns] 
      [else
       (let ((inner-list (string-split line ","))) ; se divide cada linea por comas (cada linea tiene regex, nombre del token, hexcode)
         (set! regex-patterns (append regex-patterns (list inner-list)))  ; ir agregando cada linea (inner list) leida a la lista
         (loop (read-line file)))]))) ; loop


;; COMO DEBERIA CREARSE LA LISTA DE REGEX (EN CUANTO A ESTRUCTURA)
#|
(define regex-patterns
    (list
     (list "^[A-Za-z](?>[A-Za-z]|[0-9]|_)*" "identificador" "#FF67E2") ; rosa 
     (list "^-?(?>[0-9]*\\.[0-9]+)(?>e[+-]?[0-9]+)?" "real" "#A671F4") ; morado
     (list "^[0-9]+[0-9]*" "entero" "#FFAFF7") ; rosa claro
     (list "^//.*" "comentario" "#A3D87E") ; verde claro
     (list "^\\*" "multiplicacion" "#7FA7EB") ; azul cielo 
     (list "^=" "asignacion" "#74DEFF") ; celeste
     (list "^\\+" "suma" "#5D9F29") ; verde oscuro
     (list "^-" "resta" "#253AFF") ; azul oscuro
     (list "^/" "division" "#03B2A7") ; aqua
     (list "^\\(" "paren_abre" "#F6AE7B") ; naranjita
     (list "^\\)" "paren_cierra" "#019FA4") ; aqua oscuro
     (list "^\\^" "exponente" "#FD8282") ; coral
     (list "^ +" "espacio" "#FFFFFF"))) ; blanco
|#


;; FUNCION PARA TOKENIZAR
(define (tokens-en-linea linea)
  (define (tokenizar patterns linea)
    (cond
      [(null? patterns) (set! token-list (append token-list (list (list (string-append linea " error, caracter no reconocido") "error" "#E40000"))))] ; si no hay match con alguna regex
      [(regexp-match (car (car patterns)) linea)
       (let ([match (car (regexp-match (car (car patterns)) linea))])
         (define name (cadr (car patterns)))  
         (define color (caddr (car patterns)))  
         (set! token-list (append token-list (list (list match name color)))) ; se agrega cada token con su info a la lista de tokens
         (tokens-en-linea (substring linea (string-length match)))
         )
       ]
      [else (tokenizar (cdr patterns) linea)]
      ))

  (if (not (string=? linea "")) ; si la linea no esta vacia
      (tokenizar regex-patterns linea)
      " "))


;; FUNCION PARA LEER PSEUDOCODIGO
(define (leer-pseudocodigo file-path)
  (let ((port (open-input-file file-path)))
    (let loop ((line (read-line port)))
      (cond
        [(eof-object? line) (close-input-port port)] ; se cierra el archivo
        [else
         (tokens-en-linea line) ; se llama la funcion de tokens en linea
           (set! line-list (append line-list (list token-list))) ; se agrega cada token-list a line-list
           (set! token-list '()) ; vaciar token-list
         (loop (read-line port)) ; loop
        ]))))


;; FUNCION PARA CREAR HTML
(define (crear-html-file file-path)
  (with-output-to-file file-path
    (lambda ()
      (display "<!DOCTYPE html>")
      (display "<html>")
      (display "<head>")
      (display "<title>Resaltador</title>")
      (display "<link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap\" rel=\"stylesheet\">") ; font de Google Fonts
      (display "<style>")
      (display "body { font-family: 'Poppins', sans-serif; }") ; aplicar font a todo el archivo
      (display "</style>")
      (display "</head>")
      (display "<body>")
      (display "<h1 style=\"text-align: center; padding-bottom: 0px; padding-top: 20px; margin: 0px;\">Implementacion de Metodos Computacionales</h1>") ; titulo
      (display "<h1 style=\"text-align: center; padding: 0px; margin: 0px;\">Evidencia 1: Resaltador de Sintaxis</h1>") ; titulo
      (display "<p style=\"font-size: 22px; text-align: center;\">Natalia Sofia Salgado Garcia A01571008</p>") ; mi informacion
      (display "<br><br>")
      (for-each (lambda (line-info) ; por cada lista de line-list
                  (display "<p style=\"font-size: 30px; margin: 10px;\">")
                  (for-each (lambda (token-info) ; por cada elemento de token-list
                              (define token (car token-info))
                              (define name (cadr token-info))
                              (define color (caddr token-info))
                              (display (format "<span style=\"color:~a;\">~a</span> " color token))) ; imprimir token dentro de un <span> tag y aplicar su color
                            line-info)
                  (display "</p>"))
                line-list)
      (display "</body>")
      (display "</html>"))))


;; FUNCION DE RESALTADOR DE SINTAXIS (PARA LLAMAR A TODAS LAS FUNCIONES)
(define (resaltador archivoExpReg archivoCodFue archivoHTMLCSS)
  (set! line-list '()) ; LINEA AGREGADA
  (crear-lista-regex archivoExpReg) ; crear regex especificando el color de cada una
  (leer-pseudocodigo archivoCodFue) ; leer pseudocodigo y tokenizar
  (crear-html-file archivoHTMLCSS) ; crear html para resaltar
  (displayln "Su archivo se ha creado!")) 


; Ejemplo de uso
; (define archivoExpReg "regex.txt")
; (define archivoCodFue "pseudocode.txt")
; (define archivoHTMLCSS "example.html")


; LLamada a la funcion
; (resaltador archivoExpReg archivoCodFue archivoHTMLCSS)



