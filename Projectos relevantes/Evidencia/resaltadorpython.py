import re
import time

# Lista de variables globales
line_list = [] 
token_list = [] 
regex_patterns = [] 

# Diccionario de expresiones regulares, con nombre y color 
regex_patterns = [
    {"pattern": "^[A-Za-z](?>[A-Za-z]|[0-9]|_)*", "name": "identificador", "color": "#FF67E2"},  # rosa
    {"pattern": "^-?(?>[0-9]*\\.[0-9]+)(?>e[+-]?[0-9]+)?", "name": "real", "color": "#A671F4"},  # morado
    {"pattern": "^[0-9]+[0-9]*", "name": "entero", "color": "#FFAFF7"},  # rosa claro
    {"pattern": "^//.*", "name": "comentario", "color": "#A3D87E"},  # verde claro
    {"pattern": "^\\*", "name": "multiplicacion", "color": "#7FA7EB"},  # azul cielo
    {"pattern": "^=", "name": "asignacion", "color": "#74DEFF"},  # celeste
    {"pattern": "^\\+", "name": "suma", "color": "#5D9F29"},  # verde oscuro
    {"pattern": "^-", "name": "resta", "color": "#253AFF"},  # azul oscuro
    {"pattern": "^/", "name": "division", "color": "#03B2A7"},  # aqua
    {"pattern": "^\\(", "name": "paren_abre", "color": "#F6AE7B"},  # naranjita
    {"pattern": "^\\)", "name": "paren_cierra", "color": "#019FA4"},  # aqua oscuro
    {"pattern": "^\\^", "name": "exponente", "color": "#FD8282"},  # coral
    {"pattern": "^ +", "name": "espacio", "color": "#FFFFFF"}  # blanco
]

def tokenize_line(line, patterns):
    for pattern in patterns:
        regex, name, color = pattern["pattern"], pattern["name"], pattern["color"]
        match = re.match(regex, line)
        if match:
            token = match.group()
            token_list.append({"token": token, "name": name, "color": color})
            return tokenize_line(line[len(token):], patterns)
    if line.strip(): # quitar el resto de los espacios vacios
        token_list.append({"token": f"{line} error, caracter no reconocido", "name": "error", "color": "#E40000"})


def read_pseudocode(file_path, patterns):
    with open(file_path, 'r') as file:
        for line in file:
            tokenize_line(line.strip(), patterns)
            line_list.append(list(token_list))
            token_list.clear()


def create_html_file(file_path):
    with open(file_path, 'w') as file:
        file.write("<!DOCTYPE html>\n")
        file.write("<html>\n")
        file.write("<head>\n")
        file.write("<title>Resaltador</title>\n")
        file.write("<link href=\"https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600&display=swap\" rel=\"stylesheet\">\n")
        file.write("<style>\n")
        file.write("body { font-family: 'Poppins', sans-serif; }\n")
        file.write("</style>\n")
        file.write("</head>\n")
        file.write("<body>\n")
        file.write("<h1 style=\"text-align: center; padding-bottom: 0px; padding-top: 20px; margin: 0px;\">Implementacion de Metodos Computacionales</h1>\n")
        file.write("<h1 style=\"text-align: center; padding: 0px; margin: 0px;\">Evidencia 1: Resaltador de Sintaxis</h1>\n")
        file.write("<p style=\"font-size: 22px; text-align: center;\">Natalia Sofia Salgado Garcia A01571008</p>\n")
        file.write("<br><br>\n")
        for line_info in line_list:
            file.write("<p style=\"font-size: 30px; margin: 10px;\">")
            for token_info in line_info:
                file.write(f"<span style=\"color:{token_info['color']};\">{token_info['token']}</span> ")
            file.write("</p>\n")
        file.write("</body>\n")
        file.write("</html>\n")


def highlight_syntax(exp_reg_file, cod_fue_file, html_css_file):
    start_time = time.time() 
    global line_list, token_list
    line_list, token_list = [], []
    read_pseudocode(cod_fue_file, regex_patterns)
    create_html_file(html_css_file)
    end_time = time.time() 
    elapsed_time = (end_time - start_time) * 1000  
    print(f"Su archivo se ha creado! Tiempo de ejecución: {elapsed_time:.4f} segundos")

# Ejemplo de usp
highlight_syntax("regex.txt", "pseudocode.txt", "example.html")
