import os

for directory_name in ["carpeta1", "carpeta2"]:
    os.makedirs(directory_name, exist_ok=True)
    
    for i in range(1, 101):
        # Create the archivofuente file
        file_name = f"{directory_name}/archivofuente{i}.txt"
        with open(file_name, 'w') as file:
            file.write("// este es mi programa\n\n")
            file.write("x = 13*(3.14*18-5)+23/10\n")
            file.write("y = 144.10^2+x\n")
            file.write("resultado = x*y // respuesta\n")
            file.write("num = :12*14\n")
        
        # Create additional files with specified text
        additional_file_name = f"{directory_name}/archivoexpresiones{i}.txt"
        with open(additional_file_name, 'w') as file:
            file.write("^[A-Za-z](?>[A-Za-z]|[0-9]|_)*,identificador,#FF67E2\n")
            file.write("^-?(?>[0-9]*\.[0-9]+)(?>e[+-]?[0-9]+)?,real,#A671F4\n")
            file.write("^[0-9]+[0-9]*,entero,#FFAFF7\n")
            file.write("^//.*,comentario,#A3D87E\n")
            file.write("^\*,multiplicacion,#7FA7EB\n")
            file.write("^=,asignacion,#74DEFF\n")
            file.write("^\+,suma,#5D9F29\n")
            file.write("^-,resta,#253AFF\n")
            file.write("^/,division,#03B2A7\n")
            file.write("^\(,paren_abre,#F6AE7B\n")
            file.write("^\),paren_cierra,#019FA4\n")
            file.write("^\^,exponente,#FD8282\n")
            file.write("^ +,espacio,#FFFFFF\n")
