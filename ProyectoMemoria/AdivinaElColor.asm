; Proyecto: Simón Dice - Modo Números, Colores y Emojis con Mouse e Intentos
; Autor: Adaptado según indicaciones del usuario

.MODEL SMALL
.STACK 100H
.DATA
    buffer_j1 db 10, ?, 10 dup('$'),'$'
    buffer_j2 db 10, ?, 10 dup('$'),'$'
    puntos1 db '0','$'
    puntos2 db '0','$'
    turno db '1','$'
    cantidad_jugadores db ?,'$'
    dificultad db ?,'$'
    tipo_partida db ?,'$'
    saltolinea db 10,13,'$'
    secuencia db 20 dup(?),'$'

    longitud db ?,'$'
    intentos db ?,'$'
    intentos2 db ?,'$'
    response_idx db 0,'$'
    x_mouse db ?,'$'
    y_mouse db ?,'$'
    modo_juego db ?,'$'
    seleccionados db 10 dup(?),'$'

    contadorC db 0,'$'
    index db 0,'$'
    color db 0,'$'
    x_index db 0,'$'
    y_index db 0,'$' 
    tiempoU db 5,'$'
    tiempoD db 1 n,'$'
    num_pos_x db  31, 38, 45, 50, 50, 45, 38, 31, 26, 26,'$'
    num_pos_y db  5,  4,  5,  9, 16, 20, 21, 20, 16,  9,'$'

    num_impri db 0,1,2,3,4,5,6,7,8,9,'$'
    color_impr db 1,2,3,4,5,6,7,8,9,0Ah,'$'
    emoji_impr db 1,2,3,4,5,6,0Bh,0Ch,0Eh,0Fh,'$'

    msg_inicio     db 'SIMON DICE - Jugadores (1 o 2): $'
    msg_j1         db 0Dh,0Ah,'Nombre Jugador 1 (max 10): $'
    msg_j2         db 0Dh,0Ah,'Nombre Jugador 2 (max 10): $'
    msg_dif        db 0Dh,0Ah,'Dificultad (1-Facil,2-Medio,3-Dificil): $'
    msg_tipo       db 0Dh,0Ah,'Tipo (1-Tiempo,2-Intentos): $'
    msg_modo       db 0Dh,0Ah,'Modo (1-Numeros,2-Colores,3-Emojis): $'
    msg_ingreso    db 0Ah,0Dh,'Simon dice: $'
    msg_perdio     db 0Ah,0Dh,'Perdiste!$'
    msg_completado db 0Ah,0Dh,'Completado!$'
    msg_pts        db 0Ah,0Dh,'PUNTAJE: $'
    msg_vidas      db 0Ah,0Dh,'VIDAS: $'
    msg_tiempo      db 0Ah,0Dh,'TIEMPO: $'  
    msg_winner      db 0Ah,0Dh,'------WINNER------$'
    msg_losser      db 0Ah,0Dh,'------LOSSER------$' 
    msg_empate      db 0Ah,0Dh,'------EMPATE------$'
.CODE
start:
    mov ax, @data
    mov ds, ax
    call limpiar
    call config
main_loop:
    call limpiar
    call generar_secuencia
    call mostrar_secuencia   
    call imprimir_elementos
    call imprimir_numeros_fijos
    call esperar_clicks
    jmp main_loop  
    
;------NUMEROS ALEATORIOS------------------------------------------------------------------        
    random macro
        mov ah,2Ch  
        int 21h                                                                                                          
    endm 
           
;-----IMPRIMIR CORD COLOR------------------------------------------------------------------     
imprimirColor macro z,x,y,c             ;x = columna, y=fila, z =caracter, c=color    
        xor ax,ax                       ;xor para limpiar los registros
        xor dx,dx  
        xor bl,bl
        mov ah,2h                       ;codigo de interrupcion
        mov dh,y                        ;posicion de filas
        mov dl,x                        ;posicion de columnas
        int 10h                         ;posicion del caracter en la matriz
        xor ax,ax
        mov ah,09h                      ;codigo de la interrupcion
        mov al,z                        ;al guarda el simbolo a imprimir
        mov bl, c                       ;bl guarda el color a utilizar
        mov cx,1                        ;numero de veces que se repite el caracter
        int 10h                         ;impresion del caracter en la pisicion definida
endm              
; -------------------- SUBRUTINAS ---------------------

limpiar PROC
    mov ax, 0600h
    mov bh, 07h
    mov cx, 0
    mov dx, 184Fh
    int 10h
    ret
limpiar ENDP

leer_tecla PROC
    mov ah, 01h
    int 21h
    ret
leer_tecla ENDP

config PROC
    lea dx, msg_inicio
    mov ah, 09h
    int 21h
    call leer_tecla
    mov cantidad_jugadores, al

    lea dx, msg_j1
    mov ah, 09h
    int 21h
    lea dx, buffer_j1
    mov ah, 0Ah
    int 21h

    cmp cantidad_jugadores, '2'
    jne skip_j2
    lea dx, msg_j2
    mov ah, 09h
    int 21h
    lea dx, buffer_j2
    mov ah, 0Ah
    int 21h
skip_j2:

    lea dx, msg_dif
    mov ah, 09h
    int 21h
    call leer_tecla
    mov dificultad, al

    lea dx, msg_tipo
    mov ah, 09h
    int 21h
    call leer_tecla
    mov tipo_partida, al

    lea dx, msg_modo
    mov ah, 09h
    int 21h
    call leer_tecla
    mov modo_juego, al

    ; longitud e intentos
    cmp dificultad, '1'
    je dif_facil
    cmp dificultad, '2'
    je dif_medio
    mov longitud, 9
    mov intentos, '1' 
    mov intentos2, '1'
    ret

dif_facil:
    mov longitud, 5
    mov intentos, '3'
    mov intentos2, '3'
    ret

dif_medio:
    mov longitud, 7
    mov intentos, '2'
    mov intentos2, '2'
    ret
config ENDP

generar_secuencia PROC  
    xor bx,bx
    xor di, di
    lea di, secuencia 
    mov bh, longitud  
    mov bl, modo_juego
    cmp bl,'2'
    je nextColor
    cmp bl, '3'
    je nextEmoji
next:          
    random    
    cmp dl,'0'
    jb next
    cmp dl, '9'
    jg next
    mov [di], dl
    inc di
    cmp bh,0
    jbe endret
    dec bh
    jmp next  
    
nextColor:
    random    
    cmp dl,0
    jbe nextColor
    cmp dl,0Ah 
    jg nextColor
    mov [di], dl
    inc di
    cmp bh,0
    jbe endret
    dec bh
    jmp nextColor
nextEmoji:
    random    
    cmp dl,0      ;1,2,3,4,5,6,11,12,14,15,'$'
    jbe nextEmoji
    cmp dl, 6
    jg itsEleven
    jmp continue
    itsEleven:
    cmp dl,0Bh
    jb nextEmoji
    cmp dl,10h
    jg nextEmoji
    cmp dl, 0Dh
    je nextEmoji
    continue:
    
    mov [di], dl 
    inc di
    cmp bh,0
    jbe endret
    dec bh
    jmp nextEmoji

endret:
    ret
generar_secuencia ENDP


mostrar_secuencia PROC
    lea dx, msg_ingreso
    mov ah, 09h
    int 21h

    mov cl, longitud
    mov di, 0
    mov dl,0
siguiente_elemento:  
    mov contadorC,cl
    mov al, [secuencia + di]
    mov bl, modo_juego

    cmp bl, '1'
    je imprimir_num

    cmp bl, '2'
    je imprimir_color

    cmp bl, '3'
    je imprimir_emoji

    jmp continuar

; ------------ MODO 1: NUMEROS ------------
imprimir_num:
    mov ah, 02h
    mov dl, al      ; ya es el carácter ASCII (ej. '0' a '9')
    int 21h
    mov dl, ' '
    int 21h
    jmp continuar

; ------------ MODO 2: COLORES ------------
imprimir_color:
    ; AL podría venir como ASCII ('0'-'9') o directamente 0-9  
    mov color,al
    imprimirColor 219, index,3 , color 
    inc index 
    inc index
    mov cl, contadorC
    jmp continuar

; ------------ MODO 3: EMOJIS ------------
imprimir_emoji:
    mov ah, 02h
    mov dl, al      ; ya es el carácter ASCII (ej. '0' a '9')
    int 21h
    mov dl, ' '
    int 21h
    jmp continuar

continuar:
    inc di
    dec cl
    cmp cl, 0
    jne siguiente_elemento
    mov cx,0 
    retener:
    inc cx
    cmp cx,500
    jbe retener
    call limpiar
    ret
mostrar_secuencia ENDP



imprimir_numeros_fijos PROC
    mov di, 0
print_num:
    mov ah, 02h
    mov bh, 0
    mov dl, [num_pos_x + di]
    mov dh, [num_pos_y + di]
    int 10h

    mov ah, 09h
    mov bl, modo_juego

    cmp bl, '1'
    je imprimir_numPrint

    cmp bl, '2'
    je imprimir_colorPrint

    cmp bl, '3'
    je imprimir_emojiPrint
    
    imprimir_numPrint:
    mov al, [num_impri + di] 
    add al, '0'   
    mov bl, 0Fh
    mov cx, 1
    int 10h               
    jmp continuePrint 
    
    imprimir_colorPrint: 
    mov al, [color_impr + di]  
    mov color,al
    mov x_index,dl
    mov y_index,dh  
    imprimirColor 219, x_index,y_index , color
    jmp continuePrint 
    
    imprimir_emojiPrint:
    mov al, [emoji_impr + di] 
    mov bl, 0Fh
    mov cx, 1
    int 10h 
    jmp continuePrint 
    
    continuePrint: 
    inc di
    cmp di, 10
    jne print_num 
    ret   
imprimir_numeros_fijos ENDP
                         
                         
                         
                         
                         
                         
                         
esperar_clicks PROC
    cmp turno, '1'
    je continuar_turno
    mov al, intentos2
    mov intentos, al
continuar_turno:
    mov si, 0
    mov index, 0
esperar:
    call leer_click
    mov di, 0 
     
    xor ax,ax                                      ;1
buscar:                               
    cmp bx,1
    jne esperar
    
    mov al, [num_pos_x + di]        ;num_pos_x db  31, 38, 45, 50, 50, 45, 38, 31, 26, 26,'$'
    mov ah,x_mouse
    cmp al, ah
    jne sig
    mov dl, [num_pos_y + di]        ;num_pos_y db   5,  4,  5,  9, 16, 20,  21, 20, 16, 9,'$'
    mov dh, y_mouse
    cmp dl, dh                 ;dl a su vez devuelve index del valor correcto
    jne sig
    mov al, secuencia[si]           ;[2,3,1,1,0]
    
    mov bl, modo_juego

    cmp bl, '1'
    je ScanNum

    cmp bl, '2'
    je ScanColor

    cmp bl, '3'
    je ScanEmoji  
    
    ScanNum:
    mov bl,[num_impri + di] 
    add bl,30h
    cmp bl, al 
    jne fallo   
    inc si
    inc index  
    mov al, longitud 
    cmp index,al
    je incpuntaje
    mov bx,0
    jmp buscar    
       
    ScanColor:
    mov bl,[color_impr + di]
    cmp bl, al
    jne fallo   
    inc si 
    inc index  
    mov al, longitud 
    cmp index,al
    je incpuntaje 
    mov bx,0
    jmp buscar   
       
    ScanEmoji:
    mov bl,[emoji_impr + di]
    cmp bl, al
    jne fallo   
    inc si  
    inc index  
    mov al, longitud 
    cmp index,al
    je incpuntaje
    mov bx,0
    jmp buscar    
    
    incpuntaje:
    cmp turno, '1'
    je sumar_p1
    inc puntos2
    jmp mostrar_msg
sumar_p1:
    inc puntos1
mostrar_msg:
    lea dx, msg_completado
    mov ah, 09h
    int 21h
    call delay
    
    jmp main_loop
    ret
sig:  
     
    inc di
    cmp di, 10
    jne buscar
    jmp fallo
fallo:
    cmp turno, '1'
    je dec_j1
    dec intentos2
    mov al, intentos2
    mov intentos, al
    jmp check_fallo

dec_j1:
    dec intentos
check_fallo:
    cmp intentos, '0'
    je game_over
    jmp main_loop
    ret
game_over:
    lea dx, msg_perdio
    mov ah, 09h
    int 21h
    call delay
    cmp cantidad_jugadores, '2'
    jne terminar_juego
    cmp turno, '1'
    je turno_a_2
    jmp terminar_juego
turno_a_2:
    mov turno, '2'
    mov al, intentos2
    mov intentos, al
    jmp main_loop
terminar_juego:
    call limpiar
    call resultados
    mov ah, 4Ch
    int 21h
esperar_clicks ENDP
                             
                
leer_click PROC  
    mov ax,0
    int 33h
    mov ax, 1
    int 33h                   ; mostrar mouse
    mov ax, 3
    int 33h
    mov ax, cx
    mov cl, 8
    div cl     
    mov cx,ax
    mov x_mouse, cl
    mov ax,3
    int 33h 
    mov ax, dx
    mov dl, 8
    div dl 
    mov dx,ax
    mov y_mouse, dl
    ret
leer_click ENDP  




delay PROC
    mov cx, 100
espera:                      ;ajustar esto para el tiempo
    nop
    loop espera
    ret
delay ENDP
       
imprimir_elementos PROC
    mov di,0    
    mov ah, 02h
    mov bh, 0 
    cmp turno, '2'
    je darNom2
    lea di, buffer_j1
    jmp darNom1
    darNom2:
    lea di, buffer_j2
    darNom1:
    mov dh, 1  
    mov dl, 1  ;y
    int 10h   
    printname1:
    mov al, [di]
    cmp al,0
    je salirImpname1 
    inc di  
    cmp al,'$'
    je salirImpname1
    mov ah, 02h
    mov dl, al      ; ya es el caracter ASCII (ej. '0' a '9')
    int 21h    
    jmp printname1
    
    salirImpname1:  
    mov di,0    
    mov ah, 02h
    mov bh, 0
    lea di, msg_pts
    mov dh, 4 
    mov dl, 4  ;y
    int 10h        
    printPunt1:
    mov al,[di]
    cmp al,0
    je salirPunt1 
    inc di  
    cmp al,'$'
    je salirPunt1
    mov ah, 02h
    mov dl, al      ; ya es el carácter ASCII (ej. '0' a '9')
    int 21h    
    jmp printPunt1  
    salirPunt1:
    mov ah, 02h     
    cmp turno, '2'
    je darPunt2
    mov dl, puntos1
    jmp darPunt1
    darPunt2:
    mov dl, puntos2
    darPunt1:
    int 21h 
    
    mov di,0    
    mov ah, 02h
    mov bh, 0
    lea di, msg_vidas
    mov dh, 6 
    mov dl, 6  ;y
    int 10h 
    
    printVid1:
    mov al,[di]
    cmp al,0
    je salirVid1 
    inc di  
    cmp al,'$'
    je salirVid1
    mov ah, 02h
    mov dl, al      ; ya es el carácter ASCII (ej. '0' a '9')
    int 21h    
    jmp printVid1  
    salirVid1:
    mov ah, 02h 
    mov dl, intentos      ; ya es el carácter ASCII (ej. '0' a '9')
    int 21h 
    
    ret
imprimir_elementos ENDP
       
resultados PROC
    call limpiar
    mov al,cantidad_jugadores
    cmp al,'2'
    je DosJugando
    mov turno, '1'
    call imprimir_elementos
    ret
    DosJugando:
    mov al,puntos1
    cmp al,puntos2 
    je empate  
    cmp al,puntos2 
    jg gana1
    cmp al,puntos2 
    jb gana2 
    
    empate:  
    mov turno, '1'
    mov ah, 09h
    lea dx, msg_empate  
    int 21h    
    
    call imprimir_elementos
    call delay 
    call delay
    call delay
    call limpiar
    mov turno, '2'
    mov ah, 09h
    lea dx, msg_empate  
    int 21h
    call imprimir_elementos
    ret  
    
    gana1: 
    mov turno, '1'
    mov ah, 09h
    lea dx, msg_winner  
    int 21h    
    
    call imprimir_elementos
    call delay 
    call delay
    call delay
    call limpiar
    mov turno, '2'
    mov ah, 09h
    lea dx, msg_losser  
    int 21h
    call imprimir_elementos
    ret
    
    gana2:
    mov turno, '2'
    mov ah, 09h
    lea dx, msg_winner  
    int 21h    
    
    call imprimir_elementos
    call delay 
    call delay
    call delay
    call limpiar
    mov turno, '1'
    mov ah, 09h
    lea dx, msg_losser  
    int 21h
    call imprimir_elementos
    ret
    
resultados ENDP        
       
END start
     
     
;------TO DO-----
;--FUNCION PARA TIEMPO DE VISTA DE LOS SIMBOLOS--   CHECK
;--ELIMINAR LOS ELEMENTOS EN PANTALLA--             CHECK
;--COLOCAR NOMBRE, PUNTOS, VIDA O TIEMPO--          CHECK
;--FUNCIONALIDAD DE ACIERTO O FALLO--               CHECK
;--IMPRIMIR RESULTADO                               CHECK
;--JUEGO PARA 2--                                   CHECK
