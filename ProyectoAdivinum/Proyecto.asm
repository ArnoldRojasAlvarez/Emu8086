.model small
.data 
 Apertura db '  ',0ah,0dh              ;muestra en pantalla el siguiente mensaje                                                                         
    dw ' ',0ah,0dh                     ;espacios en blanco para centrar el recuadro
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw ' ',0ah,0dh
    dw '           =============================================================',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh                                        
    dw '         ||             #   Juego de adivinar el numero   #             ||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||-------------------------------------------------------------||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh        
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||          _    _    _    _    _    _    _    _    _          ||',0ah,0dh
    dw '         ||         / \  / \  / \  / \  / \  / \  / \  / \  / \         ||',0ah,0dh
    dw '         ||        ( A )( D )( I )( V )( I )( N )( U )( M )( ! )        ||',0ah,0dh
    dw '         ||         \_/  \_/  \_/  \_/  \_/  \_/  \_/  \_/  \_/         ||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||                ENTER PARA INICIAR LA PARTIDA                ||',0ah,0dh 
    dw '         ||                                                             ||',0ah,0dh
    dw '         ||                                                             ||',0ah,0dh
    dw '           =============================================================',0ah,0dh
    dw '$',0ah,0dh,13,10 
 Cuadro db '  ',0ah,0dh              ;muestra en pantalla el marco que contiene los numeros                                                                         
    dw '           =======================================',0ah,0dh
    dw '         ||                                       ||',0ah,0dh                                        
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh        
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh 
    dw '         ||                                       ||',0ah,0dh
    dw '         ||                                       ||',0ah,0dh
    dw '           =======================================','$','$'
 ;----------MODOS DE JUEGO----------------------------------------------------------------------------                                                                                                     
    msjSeleccionMode db 10,13, 'Seleccione el modo de juego digitando el numero: ', '$';txt seleccion de modo 
    msjJVJ db 10,13, '1) Jugador vs Jugador', '$'         ;opcion 1
    msjJVM db 10,13, '2) Jugador vs Maquina', '$'         ;opcion 2  
    msjFastGame db 10,13, '3) Juego Rapido',10,13, '$'    ;opcion 3   
    msjModeGame db 10,13, 'Indique la modalidad de la partida digitando el numero: ','$';txt seleccion de modalidad por tiempo o vida
    msjPorTiempo   db 10,13, '1) Jugar por cantidad tiempo','$';Modo por intento
    msjPorIntentos db 10,13, '2) Jugar por intentos',10,13,'$'        ;Modo por intento  
    opcionMode db ?,'$'                    ;Variable para seleccionar un modo jvj,jvm,fg 
    opcionModeGame db ?,'$'                ;Variable para seleccionar modalidad tiempo o vida
    txtJVJ db 'MODO JUGADOR VS JUGADOR','$'        
    txtJVM db 'MODO JUGADOR VS MAQUINA','$'     ;txt que se imprimen en el recuadro de juego
    txtFG db 'MODO JUEGO RAPIDO','$'
    msjdificultadJVM db 'Modos de dificultad: 1)Facil 2)Medio 3)Dificil: ','$' ;msj seleccion dificultad para jvm 
    dificultadJVM db ?,'$'    ;variable almacena la dificultad a jugar                               
;----------INFO JUGADOR----------------------------------------------------------------------------                                                                                                                                                                                                        
    msjjugador1 db 10,13, 'Nombre del jugador 1 (max 10 caracteres se tomaran en cuenta): ', '$';txt nickname del jugador 1  
    msjjugador2 db 10,13, 'Nombre del jugador 2 (max 10 caracteres se tomaran en cuenta): ', '$';txt nickname del jugador 2  
    msjcantidadJugadores db 10,13, 'Cuantos jugadores van a participar (maximo 2 para JVJ,1 para los demas modos): '  ;msj de jugadores participes, 2 jvj, 1 fg y jvm
    cantidadJugadores db ?,'$'     ;almacena cantidad de jugadores
    jugador1 db 9 dup (?),10,13,'$'                ;buffer que contiene el nombre del jugador 1
    jugador2 db 9 dup (?),10,13,'$'                ;buffer que contiene el nombre del jugador 2               
    msjturnoJugador db 'Es el turno del jugador ','$' ;Indica que jugador va, para que el otro seleccione el rango numerico y el cuadro correcto 
    turnoJugador db 31h,'$'  ;almacena y cambia entre 1 y 2 para identificar cual jugador debe establecer el rango y lo demas                        
    txtlimite db 10,13, 'Por favor ingrese numeros como limite entre 1-99','$'
    txtlimitemin db 10,13, 'Por favor ingrese un numero minimo: ','$'
    txtlimitemax db 10,13, 'Ingrese con un minimo de 3 y un maximo de 10, la diferencia del limite maximo ',0ah,0dh
    dw 10,13,'para 10 digite 1: ','$'         
    txtnumElegidoJugador db 'digite cuadro correcto (0-9):','$'
    numElegidoJugador db ?,'$'   ;almacena el numero de cuadro correcto
    limmax db ?,'$'              ;almacena el rango mas alto que se puede establecer desde el minimo 34, 3, 34,35,36 
    limmin db 1 dup (?),10,13,'$';almacena como buffer un limite minimo
    msjGanoJ1 db 'A ganado ','$' 
    msjGanoJ2 db 'A ganado ','$'
    msjPerdioJ1 db 'Game Over: el numero generado era: ','$'
;----------CONTADOR DE PUNTAJES------------------------------------------------------------------                                           
    msjPuntaje db 'Puntos: ','$'
    puntaje1unidad db 48,'$'                           ;Muestra el puntaje del jugador1
    puntaje1decena db 48,'$'
    puntaje2unidad db 48,'$'                            ;Muestra el puntaje del jugador2
    puntaje2decena db 48,'$'                                                               
;----------CONTADOR DE TIEMPO O INTENTOS------------------------------------------------------------------                                            
    contadortiempodecena db ?
    contadortiempounidad db ?
    txttiempo db 'Tiempo: ','$'
    txtvidad  db 'Vidas: ','$'
    tiempo db 2 dup (?),10,13,'$'
    vidaJ1 db 39h,'$'
    VidaJ2 db 39h,'$'  
    ayudaTiempo dw 0,'$' 
;----------NUMEROS A PRESENTAR EN PANTALLA------------------------------------------------------------------                                           
    UNO db 2 dup (?),'$'  
    DOS db 2 dup (?),'$'
    TRES db 2 dup (?),'$'
    CUATRO db 2 dup (?),'$'
    CINCO db 2 dup (?),'$' 
    SEIS db 2 dup (?),'$'    ;estas variables seran usadas para mostrar los numeros en pantalla
    SIETE db 2 dup (?),'$'
    OCHO  db 2 dup (?),'$'
    NUEVE db 2 dup (?),'$'  
    DIEZ db 2 dup (?),'$'
    InserccionUnidad db ?,'$' 
    InserccionDecena db ?,'$' 
    ContadorVariableNum db 0h,'$'
    numCorrecto db ?,'$' 
;----------COMPLEMENTARIOS-----------------------------------------------------------------                                           
    inserccion db ?,'$'  ;ayuda a insertar una variable en una posicion del buffer
    contadorCaracteres db 0h,'$'    ;delimita que no se escriba mas de la cuenta al insertar en un buffer
    espacio db 08h,'$'    ;variable para retroceder un espacio en pantalla
    nulo    db 00h,'$'    ;variable para eliminar informacion en un espacio de pantalla
    saltolinea db 10,13,'$' 
    rondasJugadas db 30h,'$' ;Con esta variable se verifica si gana o no el jugador en fg, jvm
;----------BOTONES-------------------------------------------------------------------------
   rendirse db 219,10,13,'$' 
   salir db 219,10,13,'$'
   reiniciar db 219,10,13,'$'
   posNum db 219,10,13,'$' 
;----------MOUSE---------------------------------------------------------------------------    
    posicionx db ?           ;Variables para detectar posiciones del mouse
    posiciony db ?
    posicionCorrectay db 16 
    posicionCorrectax db 0 

.code  
mov ax, @data
mov ds, ax
;------------------------------MACROS------------------------------------------------------   
limpiarPantalla macro                     ;Macro para limpiar la pantalla.
    mov ah, 0fh
    int 10h
    mov ah, 0
    int 10h
endm    
imprimirPantalla macro txt                ;Macro para imprimir en pantalla. 
   mov ah,09h                             
   lea dx, txt                            ;Recibe la informacion que se desea imprimir.
   int 21h
endm     
imprimirConCords macro texto,y,x          ;Macro para imprimir los textos en una coordenada dada. 
    mov ah, 02h                           
    mov bh, 00d
    mov dh, y                             ;coordenada y.
    mov dl, x                             ;coordenada x.
    int 10h    
    mov ah, 9
    lea dx, texto                         ;impresion      
    int 21h
endm              
Input macro variable                      ;macro que solicita la entrada de algun dato,  
    xor ax,ax                             ;lo lee y almacena en una variable.
    mov variable,al                       ;xor ax,ax limpia la memoria.      
    mov ah, 01h                           
    int 21h                               ;Ejecuta otra int 21   
    mov variable, al     
endm 
InsertUnitario macro variable        ;macro para insertar un digito en una variable
    cmp al,39h
    jg converDecena              ;en caso de que deje de ser un numero unitario salta a 
    inc ContadorVariableNum      ;la insercion de decenas
    mov variable,al             
    inc al
    dec limmax
    cmp limmax,30h
    je JuegoProceso              ;De aqui debe saltar a juego
endm 
InsertDecenas macro variable     ;macro para insertar 2 digitos en una variable
    cmp al,39h
    jg converDecena
    mov di,0
    mov variable[di],al
    mov di,1
    mov variable[di],bl
    inc bl     
    inc ContadorVariableNum 
    dec limmax
    cmp limmax,30h               ;De aqui debe saltar a juego
    je JuegoProceso              
    jmp cicloDecenas
endm 
imprimirColor macro z,x,y,c             ;x = columna, y=fila, z =caracter, c=color    
        xor ax,ax                       ;xor para limpiar los registros
        xor dx,dx  
        xor bl,bl
        mov ah,2h                       ;codigo de interrupcion
        mov dh,y                        ;posicion de columnas
        mov dl,x                        ;posicion de columnas
        int 10h                         ;posicion del caracter en la matriz
        xor ax,ax
        mov ah,09h                      ;codigo de la interrupcion
        mov al,z                        ;al guarda el simbolo a imprimir
        mov bl, c                       ;bl guarda el color a utilizar
        mov cx,1                        ;numero de veces que se repite el caracter
        int 10h                         ;impresion del caracter en la pisicion definida
endm  
verificarPosCorrecta macro xCorrecta,yCorrecta,xMouse,yMouse
    mov di,0
    mov al,xCorrecta
    mov bl,xMouse
    cmp al,bl
    jne marcarEquivocado
    mov dl,yCorrecta
    mov cl,yMouse
    cmp dl,cl
    jne marcarEquivocado
    jmp marcarCorrecto   
endm 
ImprimirNumPantalla macro 
imprimirConCords UNO,15,12            ;se imprime con formato texto,y,x     
imprimirConCords posNum,16,12
imprimirConCords DOS,15,16
imprimirConCords posNum,16,16
imprimirConCords TRES,15,20
imprimirConCords posNum,16,20 
cmp ContadorVariableNum,3h
je dejarDeImprimir
imprimirConCords CUATRO,15,24
imprimirConCords posNum,16,24
cmp ContadorVariableNum,4h
je dejarDeImprimir 
imprimirConCords CINCO,15,28 
imprimirConCords posNum,16,28  
cmp ContadorVariableNum,5h
je dejarDeImprimir
imprimirConCords SEIS,15,32 
imprimirConCords posNum,16,32
cmp ContadorVariableNum,6h
je dejarDeImprimir
imprimirConCords SIETE,15,36 
imprimirConCords posNum,16,36 
cmp ContadorVariableNum,7h
je dejarDeImprimir
imprimirConCords OCHO,15,40  
imprimirConCords posNum,16,40 
cmp ContadorVariableNum,8h
je dejarDeImprimir
imprimirConCords NUEVE,15,44 
imprimirConCords posNum,16,44
cmp ContadorVariableNum,9h
je dejarDeImprimir 
imprimirConCords DIEZ,15,48 
imprimirConCords posNum,16,48
endm 
insertarNumCorrecto macro var
    mov al,var 
    cmp al,0h
    je insertarenUno  
    cmp al,1h
    je insertarenDos  
    cmp al,2h
    je insertarenTres
    cmp al,3h
    je insertarenCuatro
    cmp al,4h
    je insertarenCinco
    cmp al,5h
    je insertarenSeis
    cmp al,6h
    je insertarenSiete
    cmp al,7h
    je insertarenOcho
    cmp al,8h
    je insertarenNueve
    cmp al,9h
    je insertarenDiez 
endm      
limpiarPosiciones macro 
    mov ContadorVariableNum,0h
    mov UNO[0],10 
    mov UNO[1],10
    mov DOS[0],10
    mov DOS[1],10
    mov TRES[0],10
    mov TRES[1],10              
    mov CUATRO[0],10
    mov CUATRO[1],10
    mov CINCO[0],10
    mov CINCO[1],10
    mov SEIS[0],10
    mov SEIS[1],10
    mov SIETE[0],10
    mov SIETE[1],10
    mov OCHO[0],10
    mov OCHO[1],10
    mov NUEVE[0],10
    mov NUEVE[1],10
    mov DIEZ[0],10
    mov DIEZ[1],10
endm  
;------NUMEROS ALEATORIOS------------------------------------------------------------------        
random macro
    mov ah,2Ch           ;Elige numeros aleatorios entre 0 y 100 en dl
    int 21h                                                                                                           
endm 
;-----------------------FIN APARTADO MACRO------------------------------------------------------------        
;---->inicia programa  
inicioReinicio:
limpiarPantalla
imprimirPantalla Apertura
entrada:
mov ah,01h     ; Solicita enter para iniciar
int 21h
cmp al,13
je inicio  
imprimirPantalla espacio  
imprimirPantalla nulo   
imprimirPantalla espacio
loop entrada  
inicio:
limpiarPantalla  
imprimirPantalla msjcantidadJugadores 
input cantidadJugadores
cmp cantidadJugadores,31h
je usuarios
cmp cantidadJugadores,32h
je usuarios 
loop inicio         
usuarios:        ;--> Se solicitan los datos principales del usuario 1                                                             
mov ah, 09       ;Valor en registro necesario para la ejecucion de la interrupcion
lea dx, msjjugador1   
int 21h          ;Ejecuta la interrupcion 21 que espera un input                           
mov di, 0                           
leer:  
inc contadorCaracteres                    ;Ciclo para obtener el nombre del jugador 1
mov ah, 1              ;input
int 21h      
cmp al, 13       ;presiono enter
je  segundojug 
cmp al,8         ;presiono backspace
je deluno
cmp contadorCaracteres,10h           
je tope          ;analiza si llego al lim maximo del nombre
cmp al,32        ;presiono espacio
je leer  
mov jugador1[di], al        
inc di
loop leer
deluno:  
cmp di,0
je  leer                 
imprimirPantalla nulo            
imprimirPantalla espacio                               ;Signo del jugador 1 
sub contadorCaracteres,2         
sub di,1 
jmp leer 
tope:
imprimirPantalla espacio  
imprimirPantalla nulo 
imprimirPantalla espacio   
sub contadorCaracteres,2
jmp leer
segundojug:          ;--> Se solicitan los datos principales del usuario 1
cmp cantidadJugadores,32h
jb  solicitud
mov al,0                          
mov contadorCaracteres,al
mov di, 0
mov ah, 09                          
lea dx, msjjugador2             
int 21h                             
leer1:
inc contadorCaracteres
mov ah, 1
int 21h
cmp al, 13                          ;guarda el nombre del jugador 2
je  solicitud 
cmp al,8 
je deldos
cmp contadorCaracteres,10h   
jg tope2
cmp al,32
je leer1 
mov jugador2[di], al             
inc di
loop leer1  
deldos:  
cmp di,0
je  leer1
imprimirPantalla nulo 
imprimirPantalla espacio  
sub contadorCaracteres,2 
sub di,1                            ;retrocede un espacio y descuenta 1 en di
jmp leer1 
tope2:
imprimirPantalla espacio  
imprimirPantalla nulo
imprimirPantalla espacio    
sub contadorCaracteres,2
jmp leer1 
solicitud: 
limpiarPantalla   
imprimirPantalla msjSeleccionMode  
imprimirPantalla msjJVJ                    ;Impresiones de opciones de  juego
imprimirPantalla msjJVM  
imprimirPantalla msjFastGame  
Input opcionMode   
cmp  opcionMode,31h
je JVJ
cmp  opcionMode,32h
je JVM
cmp opcionMode,33h
je FG     
loop inicio         
;-----------------------JUGADOR VS JUGADOR------------------------------------------------------------        
  
JVJ: 
cmp cantidadJugadores,32h
jne inicio  
mov vidaJ1,39h 
mov vidaJ2,39h 
limpiarPantalla 
imprimirPantalla msjModeGame
imprimirPantalla msjPorTiempo           ;Impresion para solicitar como se jugara la partida
imprimirPantalla msjPorIntentos           
Input opcionModeGame 
cmp  opcionModeGame,31h
je salirJVJ
cmp  opcionModeGame,32h
je salirJVJ     
loop JVJ
salirJVJ:
mov di,0
mov tiempo[di],31h   
mov di,1
mov tiempo[di],30h  
mov al,0
mov contadorCaracteres,al      
mov di,0       
mov limmin[0],10
mov limmin[1],10  
limpiarPantalla  
imprimirPantalla msjturnoJugador    
imprimirPantalla turnoJugador
imprimirPantalla txtlimite 
imprimirPantalla txtlimitemin
ciclolimmenor:  
inc contadorCaracteres                    ;Ciclo para obtener el limite menor
mov ah, 1           ;input
int 21h      
cmp al, 13   
je  tomalimmayor
cmp al,8 
je  backlimmenor
cmp contadorCaracteres,3h        
je topemin            
cmp al,32
je espaci  
mov limmin[di], al  
inc di
loop ciclolimmenor
espaci: 
imprimirPantalla espacio
dec contadorCaracteres 
jmp ciclolimmenor 
topemin:
imprimirPantalla espacio  
imprimirPantalla nulo  
imprimirPantalla espacio        ;delimita que no pueda escribir mas de lo permitido en el buffer
sub contadorCaracteres,1      
jmp ciclolimmenor 
backlimmenor: 
cmp di,0
je  ciclolimmenor
imprimirPantalla nulo
imprimirPantalla espacio 
sub di,1   
mov limmin[di], 10
sub contadorCaracteres,2                   ;retrocede un espacio y descuenta 1 en di
jmp ciclolimmenor 
tomalimmayor: 
limpiarPantalla
cmp di,0
je salirJVJ      ;si el jugador no digito nada se devuelve hasta que digite un numero
imprimirPantalla txtlimitemax   ;Solicita un limite mayor entre 3 a 10 de diferencia con el menor
Input limmax
limpiarPosiciones       ;Se limpian todos los buffes de posiciones que se presentan en pantalla
cmp limmax,31h
je esdiez   
cmp limmax,33h
jb tomalimmayor
cmp limmax,39h
jg tomalimmayor          ;Espacio para trabajar el guardado de los numeros
jmp prosiga
;-----------------------JUGADOR VS MAQUINA------------------------------------------------------------        
JVM: 
cmp cantidadJugadores,32h
je inicio
MalaSeleccionDificultad:
limpiarPantalla
imprimirPantalla msjdificultadJVM
Input dificultadJVM
cmp dificultadJVM,31h
jb MalaSeleccionDificultad
cmp dificultadJVM,33h
jg MalaSeleccionDificultad
cmp dificultadJVM,32h
je AsignarValoresNormal
cmp dificultadJVM,33h
je AsignarValoresDificil
mov di,0
mov tiempo[di],31h
mov di,1
mov tiempo[di],30h
mov vidaJ1,39h 
jmp salirModoDificultad
AsignarValoresNormal: 
mov di,0
mov tiempo[di],30h
mov di,1
mov tiempo[di],38h
mov vidaJ1,36h  
jmp salirModoDificultad
AsignarValoresDificil: 
mov di,0
mov tiempo[di],30h
mov di,1
mov tiempo[di],36h
mov vidaJ1,35h 
salirModoDificultad:
limpiarPantalla 
imprimirPantalla msjModeGame
imprimirPantalla msjPorTiempo 
imprimirPantalla msjPorIntentos   
Input opcionModeGame 
cmp  opcionModeGame,31h
je salirJVM
cmp  opcionModeGame,32h
je salirJVM     
loop JVM 
salirJVM:  
mov al,0
mov contadorCaracteres,al   ;limpia
mov di,0       
mov limmin[0],10
mov limmin[1],10       ;limpia
cmp rondasJugadas,34h
je GanoJ1  
;Implementar toma datos random 
limpiarPosiciones ;Se limpian todos los buffes de posiciones que se presentan en pantalla
TomaRandomJvMDecenas:
random
cmp dl,30h
jb TomaRandomJvMDecenas
cmp dl,39h
jg TomaRandomJvMDecenas          ;Seccion para guardar numero random en lim minimo
mov limmin[0],dl
TomaRandomJvMUnidades:
random
cmp dl,30h
jb TomaRandomJvMUnidades
cmp dl,39h
jg TomaRandomJvMUnidades
mov limmin[1],dl    
TomaRandomLimMaxJVM:
random
cmp dl,31h
je esdiez
cmp dl,33h
jb TomaRandomLimMaxJVM
cmp dl,39h
jg TomaRandomLimMaxJVM
mov limmax,dl
jmp prosiga
;-----------------------PARTIDA RAPIDA------------------------------------------------------------        
FG:  
mov di,0
mov tiempo[di],30h
mov di,1
mov tiempo[di],37h
mov vidaJ1,39h 
limpiarPantalla 
cmp cantidadJugadores,32h
je inicio
imprimirPantalla msjModeGame
imprimirPantalla msjPorTiempo 
imprimirPantalla msjPorIntentos   
Input opcionModeGame 
cmp  opcionModeGame,31h
je salirFG
cmp  opcionModeGame,32h
je salirFG     
loop FG
salirFG:
mov al,0
mov contadorCaracteres,al     ;limpia
mov di,0       
mov limmin[0],10
mov limmin[1],10              ;limpia
cmp rondasJugadas,32h
je GanoJ1   
;Implementar toma datos random 
limpiarPosiciones       ;Se limpian todos los buffes de posiciones que se presentan en pantalla
TomaRandomFGDecenas:
random
cmp dl,30h
jb TomaRandomFGDecenas
cmp dl,39h
jg TomaRandomFGDecenas          ;Seccion para guardar numero random en lim minimo
mov limmin[0],dl
TomaRandomFGUnidades:
random
cmp dl,30h
jb TomaRandomFGUnidades
cmp dl,39h
jg TomaRandomFGUnidades
mov limmin[1],dl    
TomaRandomLimMaxFG:
jmp esdiez
;---------------ESPACIO DONDE SE REALIZA EL PROCESO DE INSERTAR LOS NUMEROS EN LAS VARIABLES A MOSTRAR EN PANTALLA---------------------
esdiez: 
mov limmax,58
prosiga:
mov di,1
mov al,limmin[di] 
cmp al,10
jne decenas
unitario:
mov di,0
mov al,limmin[di]       
InsertUnitario UNO
InsertUnitario DOS
InsertUnitario TRES
InsertUnitario CUATRO       ;Almacena la informacion de forma unitaria en las variables
InsertUnitario CINCO 
InsertUnitario SEIS
InsertUnitario SIETE
InsertUnitario OCHO
InsertUnitario NUEVE 
InsertUnitario DIEZ
converDecena:
mov di,0                    
mov al,31h
mov limmin[di],al           ;En caso de pasar de unidad a decenas por primera vez
mov di,1        
mov bl,30h
mov limmin[di],bl 
decenas: 
mov di,0
mov al,limmin[di]       
mov di,1
mov bl,limmin[di]        
cicloDecenas:  
cmp ContadorVariableNum,1h       
je insertart2
cmp ContadorVariableNum,2h       
je insertart3
cmp ContadorVariableNum,3h       
je insertart4
cmp ContadorVariableNum,4h      ;almacena la informacion en buffers (2 caracteres)
je insertart5
cmp ContadorVariableNum,5h
je insertart6
cmp ContadorVariableNum,6h
je insertart7 
cmp ContadorVariableNum,7h
je insertart8
cmp ContadorVariableNum,8h
je insertart9 
cmp ContadorVariableNum,9h
je insertart10
cmp bl,39h
jg conversiondecimal 
InsertDecenas UNO
insertart10: 
cmp bl,39h
jg conversiondecimal 
InsertDecenas DIEZ
insertart9: 
cmp bl,39h
jg conversiondecimal 
InsertDecenas NUEVE
insertart8: 
cmp bl,39h
jg conversiondecimal
InsertDecenas OCHO
insertart7: 
cmp bl,39h
jg conversiondecimal 
InsertDecenas SIETE
insertart6:  
cmp bl,39h               ;etiquetas donde se llama la macro para guardar la informacion 
jg conversiondecimal     ;en las variables
InsertDecenas SEIS
insertart5: 
cmp bl,39h
jg conversiondecimal 
InsertDecenas CINCO
insertart4:  
cmp bl,39h
jg conversiondecimal
InsertDecenas CUATRO
insertart3:  
cmp bl,39h
jg conversiondecimal
InsertDecenas TRES
insertart2:  
cmp bl,39h
jg conversiondecimal
InsertDecenas DOS
conversiondecimal:
mov bl,30h               
inc al
jmp cicloDecenas
;-----------------------PRESENTACION DE INFORMACION EN PANTALLA Y DESARROLLO DEL JUEGO------------------------------------------------------------        
JuegoProceso: 
limpiarPantalla  
cmp opcionMode,32h
je ModoJvM
cmp opcionMode,33h
je ModoFG 
limpiarPantalla
mov di,7   
ImprimirNumPantalla
errNum:
imprimirConCords txtnumElegidoJugador,7,8       
Input numElegidoJugador 
mov al,numElegidoJugador
sub al,30h
cmp  al,0h
jb errNum 
cmp  al,ContadorVariableNum   ;Verifica que el num digitado no sobrepase a la cantidad de cuadros que hay en pantalla
jg errNum
mov numCorrecto,al 
limpiarPantalla 
imprimirPantalla Cuadro
imprimirConCords txtJVJ,7,20               
mov di,8
insertarNumCorrecto numCorrecto
ModoJvM: 
random    
cmp  dl,0h
jb ModoJvM 
cmp  dl,ContadorVariableNum
jg ModoJvM                     ;toma el num correcto automaticamente
mov numCorrecto,dl
imprimirPantalla Cuadro
imprimirConCords txtJVM,7,20
mov di,8
insertarNumCorrecto numCorrecto ;Logica para posicion random correcta                             
VuelvaModoJVM: 
ImprimirNumPantalla 
jmp ContinuarProcesoJuego 
ModoFG:
random    
cmp dl,0h
jb ModoFG 
cmp  dl,ContadorVariableNum
jg ModoFG
mov numCorrecto,dl 
imprimirPantalla Cuadro
imprimirConCords txtFG,7,20
mov di,8
insertarNumCorrecto numCorrecto ;Logica para posicion random correcta
VuelvaModoFG:
ImprimirNumPantalla 
dejarDeImprimir: 
cmp di,7
je errNum             
ContinuarProcesoJuego:
imprimirConCords UNO,15,12            ;se imprime con formato texto,y,x     
imprimirConCords posNum,16,12
imprimirConCords DOS,15,16
imprimirConCords posNum,16,16
imprimirConCords TRES,15,20
imprimirConCords posNum,16,20 
cmp ContadorVariableNum,3h
je dejarDeImprimir2
imprimirConCords CUATRO,15,24
imprimirConCords posNum,16,24
cmp ContadorVariableNum,4h
je dejarDeImprimir2 
imprimirConCords CINCO,15,28 
imprimirConCords posNum,16,28  
cmp ContadorVariableNum,5h
je dejarDeImprimir2
imprimirConCords SEIS,15,32          ;impresones
imprimirConCords posNum,16,32
cmp ContadorVariableNum,6h
je dejarDeImprimir2
imprimirConCords SIETE,15,36 
imprimirConCords posNum,16,36 
cmp ContadorVariableNum,7h
je dejarDeImprimir2
imprimirConCords OCHO,15,40  
imprimirConCords posNum,16,40 
cmp ContadorVariableNum,8h
je dejarDeImprimir2
imprimirConCords NUEVE,15,44 
imprimirConCords posNum,16,44
cmp ContadorVariableNum,9h
je dejarDeImprimir2 
imprimirConCords DIEZ,15,48 
imprimirConCords posNum,16,48
dejarDeImprimir2:
imprimirConCords jugador1,8,57 
imprimirConCords msjPuntaje,9,57 
imprimirConCords puntaje1decena,9,64
imprimirConCords puntaje1unidad,9,65
cmp cantidadJugadores,32h
jne ignoreJ2  
imprimirConCords jugador2,12,57
imprimirConCords msjPuntaje,13,57 
imprimirConCords puntaje1decena,13,64
imprimirConCords puntaje1unidad,13,65
ignoreJ2:
imprimirColor reiniciar,65,16,4
imprimirColor salir,65,18,5 
imprimirColor rendirse,65,14,6
imprimirColor "R",55,14,6 
imprimirColor "e",56,14,6
imprimirColor "n",57,14,6
imprimirColor "d",58,14,6
imprimirColor "i",59,14,6
imprimirColor "r",60,14,6
imprimirColor "s",61,14,6
imprimirColor "e",62,14,6
imprimirColor ":",63,14,6 
imprimirColor "R",55,16,4 
imprimirColor "e",56,16,4
imprimirColor "i",57,16,4
imprimirColor "n",58,16,4
imprimirColor "i",59,16,4          ;impresiones
imprimirColor "c",60,16,4
imprimirColor "i",61,16,4
imprimirColor "a",62,16,4
imprimirColor "r",63,16,4   
imprimirColor ":",64,16,4 
imprimirColor "S",55,18,5
imprimirColor "a",56,18,5 
imprimirColor "l",57,18,5
imprimirColor "i",58,18,5
imprimirColor "r",59,18,5
imprimirColor ":",60,18,5 
cmp opcionModeGame,32h
je vidascaso      
imprimirConCords txttiempo,6,55
imprimirConCords tiempo,6,63 
jmp Temp                          ;comparativas para modalidad a jugar
vidascaso:    
imprimirConCords txtvidad,6,55
cmp turnoJugador,32h
je imprimirVidaJ2  
imprimirConCords vidaJ1,6,63 
jmp cicloJugando
imprimirVidaJ2:
imprimirConCords vidaJ2,6,63 
jmp cicloJugando 
Temp: 
mov di,0
mov al,tiempo[di]
mov di,1
mov bl,tiempo[di]          
mov contadortiempodecena,al
mov contadortiempounidad,bl
cmp ayudaTiempo,3         
je  restatiempo             
inc ayudaTiempo 
cicloJugando:
;aqui se agrega la logica de deteccion de mouse
mov ax,0
int 33h
mov ax, 1
int 33h                                               ;estado del mouse
mov ax,3
int 33h  
mov ax,cx
mov cl,8
div cl
mov cx,ax
mov posicionx,cl
mov ax,3
int 33h                                   ;Guardar posiciones del mouse
mov ax,dx
mov dl,8
div dl
mov dx,ax
mov posiciony,dl 
;Espacio para realizar las comparativas del cursor y el click 
mov dl,posiciony
mov cl,posicionx    
cmp cl,65
je opcionesy                 ;analiza si esta en la misma direccion en x que las opciones
verificarPosCorrecta posicionCorrectax,posicionCorrectay,posicionx,posiciony
cmp opcionModeGame,32h
je cicloJugando              ;analiza si se toca posicion correcta en un cuadro
jmp temp
opcionesy: 
mov dl,posiciony               
cmp dl,18
je salirclick                ;analiza si esta en y correcta de alguna opcion
cmp dl,16
je reiniciarclick
cmp dl,14                      
je rendirseclick
cmp opcionModeGame,32h
je cicloJugando
jmp temp
CompruebeDireccion:
cmp opcionModeGame,32h
je cicloJugando
jmp temp  
marcarEquivocado:
mov ax,3
int 33h           ;Se comprueba si se esta clickeando izquierdo
cmp bx,1
jne CompruebeDireccion
mov ah,02h
mov dx,7
int 21h           ;suena 2 veces para decir que dio error
mov ah,02h
mov dx,7
int 21h           ;Da el sonido 'beep' 
cmp opcionModeGame,32h 
jne NoesModoVida            ;analiza el modo de juego
cmp turnoJugador,32h
je resteVidaJ2              ;compara turno de jugador en jvj
dec vidaJ1                  ;resta vida a j1
cmp vidaJ1,30h              ;se quedo sin vida? salte a perdioj1
je PerdioJ1    
imprimirConCords vidaJ1,6,63  ;si no perdio imprima nueva vida
jmp NoesModoVida 
resteVidaJ2:
dec vidaJ2                  ;resta vida al j2
cmp vidaJ2,30h
je PerdioJ2                 ;se quedo sin vida? salte a perdioj2
imprimirConCords vidaJ2,6,63   
NoesModoVida:               ;caso para decir hacia donde esta el num correcto
mov al,posicionCorrectax
cmp posicionx,al
jb  MensajeDerecha
jmp MensajeIzquierda   ;IMPLEMENTAR AQUI LA LOGICA PARA SEGUIR JUGANDO CON NUEVO NUMERO SOLICITADO
MensajeDerecha:
imprimirColor ">",15,17,4
cmp opcionModeGame,32h
je cicloJugando
jmp temp                      ;imprime hacia a donde deberia probar suerte
MensajeIzquierda:
imprimirColor "<",15,17,4
cmp opcionModeGame,32h
je cicloJugando
jmp temp
marcarCorrecto: 
mov ax,3
int 33h           ;Compara si clickeo o si debe volver al ciclo
cmp bx,1                               ;emite solo un sonido para indicar que marco bien
jne CompruebeDireccion 
inc rondasJugadas ;cantidad de rondas para jvm o fg
mov ah,02h        ;Da el sonido 'beep'
mov dx,7
int 21h                           
cmp cantidadJugadores,31h
je AumentarAUnJugador
cmp turnoJugador,32h
je AumentarAjugador2
cmp puntaje1unidad,39h
je incDecJ1
inc puntaje1unidad 
mov turnoJugador,32h
jmp salirJVJ 
incDecJ1:
inc puntaje1decena
mov puntaje1unidad,30h 
mov turnoJugador,32h
jmp salirJVJ
AumentarAjugador2:
cmp puntaje2unidad,39h    ;COMPARATIVAS PARA VER A CUAL DEBE DE INCREMENTAR
je incDecJ2
inc puntaje2unidad 
mov turnoJugador,31h
jmp salirJVJ 
incDecJ2: 
inc puntaje2decena
mov puntaje2unidad,30h
mov turnoJugador,31h
jmp salirJVJ 
AumentarAUnJugador:
cmp puntaje1unidad,39h
je incDecJSolit
inc puntaje1unidad 
cmp opcionMode,32h
je salirJVM
cmp opcionMode,33h 
je salirFG 
incDecJSolit:
inc puntaje1decena
mov puntaje1unidad,30h
cmp opcionMode,32h
je salirJVM
cmp opcionMode,33h 
je salirFG
salirclick: 
cmp bx,1
je fin
reiniciarclick:         ;Consultar si se estan clickeando las opciones
cmp bx,1
je inicioReinicio
rendirseclick: 
cmp bx,1
je rendirsejuego
cmp opcionModeGame,32h
je cicloJugando
jmp temp  
;------------PROCESO PARA RESTAR SEGUNDOS------------------------------------------------
restatiempo:
mov ayudaTiempo,0 
cmp bl,30h         ;unidades es 0?  
je cambiotiempo
dec bl  
mov di,1                           
mov tiempo[di],bl
imprimirConCords tiempo,6,63
jmp Temp
cambiotiempo:
cmp al,30h              ;decenas es 0?  
je cambiotiempounidad   
continue:
sub al,1
mov bl,39h              
mov di,0
mov tiempo[di],al
mov di,1
mov tiempo[di],bl
imprimirConCords tiempo,6,63
jmp Temp 
cambiotiempounidad:
cmp bl,30h               ;reitera la consulda de que sea 0 decenas
je Jugadorsintiempo      
jmp continue
;-------------SECCION DE MENSAJES DE DERROTA----------------------------------------------
Jugadorsintiempo:
cmp cantidadJugadores,31h
je PerdioJ1Solitario
cmp turnoJugador,31h
je PerdioJ1
PerdioJ2:
limpiarPantalla
imprimirConCords msjGanoJ1,10,20
imprimirConCords jugador1,10,30
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38 
imprimirConCords jugador2,14,30
imprimirConCords msjPuntaje,15,30 
imprimirConCords puntaje2decena,15,37
imprimirConCords puntaje2unidad,15,38  
jmp fin
PerdioJ1:
cmp cantidadJugadores,31h
je PerdioJ1Solitario
limpiarPantalla
imprimirConCords msjGanoJ2,10,20
imprimirConCords jugador2,10,30
imprimirConCords jugador2,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje2decena,12,37
imprimirConCords puntaje2unidad,12,38 
imprimirConCords jugador1,14,30
imprimirConCords msjPuntaje,15,30 
imprimirConCords puntaje1decena,15,37
imprimirConCords puntaje1unidad,15,38 
jmp fin
GanoJ1: 
limpiarPantalla 
imprimirConCords msjGanoJ1,10,20
imprimirConCords jugador1,10,30 
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38 
jmp fin 
PerdioJ1Solitario: 
limpiarPantalla
imprimirConCords msjPerdioJ1,10,20 
mov al,posicionCorrectax 
cmp al,0h
je CorrectoUno  
cmp al,1h
je CorrectoDos  
cmp al,2h
je CorrectoTres
cmp al,3h
je CorrectoCuatro
cmp al,4h
je CorrectoCinco
cmp al,5h
je CorrectoSeis
cmp al,6h
je CorrectoSiete
cmp al,7h
je CorrectoOcho
cmp al,8h
je CorrectoNueve
cmp al,9h
je CorrectoDiez
CorrectoUno:                ;SECCION PARA DETERMINAR CUAL ERA EL NUM CORRECTO PARA
imprimirConCords UNO,10,55
imprimirConCords jugador1,11,30     ;MOSTRARLE AL JUGADOR EN PANTALLA
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin  
CorrectoDos:
imprimirConCords DOS,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin   
CorrectoTres:
imprimirConCords TRES,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoCuatro:
imprimirConCords CUATRO,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoCinco:
imprimirConCords CINCO,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoSeis:
imprimirConCords SEIS,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoSiete:
imprimirConCords SIETE,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoOcho:
imprimirConCords OCHO,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoNueve:
imprimirConCords NUEVE,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin 
CorrectoDiez:
imprimirConCords DIEZ,10,55
imprimirConCords jugador1,11,30
imprimirConCords msjPuntaje,12,30 
imprimirConCords puntaje1decena,12,37
imprimirConCords puntaje1unidad,12,38
jmp fin  
;------------Proceso de insertar numero correcto en posx,posy-----------------------------
insertarenUno: 
mov posicionCorrectax,12   ;MOVIMIETO CORRECTO A X, SALTO A LA RESPECTIVA ETIQUETA DEL
cmp opcionMode,32h         ;DEL INICIO DEL PROCESO DEL JUEGO
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenDos:
mov posicionCorrectax,16  
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenTres: 
mov posicionCorrectax,20 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenCuatro: 
mov posicionCorrectax,24 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenCinco:
mov posicionCorrectax,28
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG 
jmp ContinuarProcesoJuego
insertarenSeis: 
mov posicionCorrectax,32 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenSiete:
mov posicionCorrectax,36 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenOcho: 
mov posicionCorrectax,40 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenNueve:
mov posicionCorrectax,44 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
insertarenDiez: 
mov posicionCorrectax,48 
cmp opcionMode,32h
je VuelvaModoJVM
cmp opcionMode,33h
je VuelvaModoFG
jmp ContinuarProcesoJuego
rendirsejuego:   
cmp turnoJugador,31h
je PerdioJ1  
cmp turnoJugador,32h
je PerdioJ2
fin:
