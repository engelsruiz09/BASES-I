import random
from re import search#Busca si la cadena era igual a true
############################################################################################LICENCIAS
lastnames = ['Mateo','Daniel','Pablo','Alvaro','Adrian','David','Diego','Javier','Mario','Sergio','Marcos','Manuel','Martin','Nicolas','Jorge','Ivan','Carlos','Miguel','Lucas','Antonio','Jose','William','George','Joseph','Frank','Thomas','Edward','Walter','Harold','Samuel','Santiago','Sebastian','Alejandro','Daniel','Paul','Gabriela','Andrea','Elizabeth','Maria','Lucia','Adriana','Veronica','Isabel','Daniela','Monica','Carolina','Pilar','Rosario','Sofia','Edgardo']


names = ['Garcia','Gonzales','Rodriguez','Fernandez','Lopez','Martinez','Sanchez','Perez','Gomez','Martin','Jimenez','Ruiz','Hernandez','Diaz','Moreno','Munoz','Alvarez','Romero','Alonso','Gutierrez','Navarro','Torres','Dominguez','Vazquez','Ramos','Gil','Ramirez','Serrano','Blanco','Molina','Morales','Suarez','Ortega','Delgado','Castro','Ortiz','Rubio','Marin','Sanz','Nunez','Iglesias','Medina','Garrido','Cortes','Castillo','Santos','Cruz','Guerrero','Cano','Mendez']

Lentes = ['SI','NO']

dpis = ['0101','0102','0103','0104','0105','0106','0107','0108','0109','0110','0111','0112','0113','0114','0115','0116','0117']
Espacio = '-'
Puntos = ':'
ConductoresFile = open('Conductores.csv', mode='w', encoding='utf-8')
print('writing Conductores file...\n')
a = 1
i = 0
while (i < 3000):
    id_licencia = f'{random.randint(1,4)}'

    dpiPostfix = random.choice(dpis)
    dpi = f'{random.randint(1000, 9999)} {random.randint(10000, 99999)} {dpiPostfix}'

    line = ','.join([random.choice(lastnames), random.choice(names),random.choice(Lentes),(str(random.randint(1980,2003))+Espacio+str(random.randint(1,12))+Espacio+str(random.randint(1,28))),str(a), dpi, id_licencia])

    print(line)
    ConductoresFile.write(line + "\n")

    i = i + 1
    a = a + 1
ConductoresFile.close()
print('\nfinished writing Conductores file...\n')

############################################################################################CONDUCTORES

print('\nwriting Automoviles file...\n')
AutomovilesFile = open('Automoviles.csv', mode='w', encoding='utf-8')

Tipo = ['A','M','B','C']
LetraA = "A"
LetraM = "M"
LetraB = "B"
LetraC = "C"
i = 0
m = 1
while (i < 5000):
    Ocupantes = 0
    Letra = random.choice(Tipo)
    placa = f'{Letra}{random.randint(000000,999999)}'

    if search(LetraA, Letra):
        Ocupantes = random.randint(15,30)
    if search(LetraM, Letra):
        Ocupantes = 2
    if search(LetraB, Letra):
        Ocupantes = random.randint(5,8)
    if search(LetraC, Letra):
        Ocupantes = 5

    line = ','.join([str(placa),str(random.randint(1,3000)),str(m),str(Ocupantes)])
    print(line)
    AutomovilesFile.write(line + "\n")

    i = i + 1
    m = m + 1
AutomovilesFile.close()
print('\nfinished writing Automoviles file...\n')

############################################################################################TABLA
TablasFile = open('tabla.csv', mode='w', encoding='utf-8')
print('writing tabla file...\n')
Lentes = ['SI','NO']
i = 0
a = 1 #ID_TABLA
x = 0
y = 1
z = 1
w = 1
Espacio = '-'
Puntos = ':'
while (i < 1):
    while (x < 3):
        while (y < 13):
            while (z < 29):
                while (w < 251):
                    id_control = f'{random.randint(1,50)}'
                    id_vehiculo = f'{random.randint(1,1250)}'
                    velocidad = f'{random.randint(25,100)}'
                    ocupantes = f'{random.randint(2,30)}'
                    line = ','.join([str(a),str(id_control),str(id_vehiculo),str(velocidad),'202'+str(x)+Espacio+str(y)+Espacio+str(z),(str(random.randint(0,23))+Puntos+str(random.randint(1,59))+Puntos+str(random.randint(1,59))+Puntos+'000'),str(ocupantes),random.choice(Lentes)])
                    print(line)
                    TablasFile.write(line + "\n")
                    a = a + 1
                    w = w + 1
                w = 1
                z = z + 1
            z = 1
            y = y + 1
        y = 1
        x = x + 1
i = i + 1
TablasFile.close()
print('\nfinished writing tabla file...\n')
