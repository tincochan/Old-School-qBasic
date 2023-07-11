 DEFINT A-Z
 DECLARE SUB Colores ()
 DECLARE SUB Caracters ()
 DECLARE SUB Imprimir ()
 DECLARE SUB Salir (sal)
 DECLARE SUB Texto ()
 DECLARE SUB Marcar.Bloque (Res)
 DECLARE SUB Mapa ()
 DECLARE SUB Menus ()
 DECLARE SUB Abrir ()
 DECLARE SUB Imagen ()
 DECLARE SUB Cuadrados ()

 DECLARE SUB Pantalla ()
 DECLARE SUB Inicio ()
 DECLARE SUB Limites ()
 DECLARE SUB Poner.Marca (Modo)
 DECLARE SUB Video ()
 DECLARE SUB Marca (letra$)
 DECLARE SUB P.Color ()
 DECLARE SUB LineaBlanca ()
 DECLARE SUB Marcos (a, b, c, d)
 DECLARE SUB Sombras (a, b, c, d)
 DECLARE SUB Pausa ()
 DECLARE SUB Limpia ()
 DECLARE SUB Config ()
 DECLARE SUB Mens.Ayudas ()
 DECLARE SUB Introduce (ty, tx1, tx2, t$, v)
 DECLARE SUB Mal ()

 CONST Si = 0, No = NOT Si

 COMMON SHARED Col, z, y, Carac, Sonido, Segmento, Nombre$, Estado

 DIM SHARED Opcion$(2, 8, 5)
   
 DEF SEG = 0
 Estado = PEEK(1047)

 ' ON ERROR GOTO Errores

 Mens.Ayudas
 Video
   
 SCREEN 0, 0, 0, 0
 VIEW PRINT
 COLOR 7, 0
 CLS
 WIDTH 80, 25
   
 Inicio

 Nombre$ = "SIN-NOMBRE"
 Col = 0
 Carac = 1
 Direccion = 1
 Sonido = Si
 y = 40
 z = 25
    
 DEF SEG = 0
 WIDTH 80, 50
 SCREEN 0, 0, 1, 0
   
 Limpia
 Pantalla
 VIEW PRINT 3 TO 48
 PCOPY 1, 0

Segu:
   
    SCREEN 0, 0, 0, 0
    Config
    LineaBlanca
   
    LOCATE 48, 4, 0
    COLOR , 7
    COLOR 15
    PRINT "MAY.IZQ :";
    COLOR 0: PRINT "DIBUJAR     ";
    COLOR 15: PRINT "MAY.DER :";
    COLOR 0: PRINT "BORRAR   ";
    COLOR 15: PRINT "ESC:";
    COLOR 0: PRINT "SALIR    ";
    COLOR 15: PRINT "ALT:";
    COLOR 0: PRINT "MENU";
   
    P.Color
    Poner.Marca 1
    LOCATE z, y, 1
    Marca "Mover"
    LOCATE z, y, 1, 1, 8
DO
    a = PEEK(1047)
    IF a >= 32 THEN POKE 1047, 0
    IF a <> va THEN
      IF Sonido = 1 THEN SOUND 1200, .5
      IF a = 0 THEN Marca "Mover"
      IF a = 2 THEN Marca "Dibujar"
      IF a = 1 THEN Marca "Borrar"
      IF va = 1 AND a <> 1 THEN COLOR 0, 7: LOCATE z, y, 0: PRINT " ";
      IF a = 8 THEN
        CALL Menus
        GOTO Segu
      END IF
    END IF
   
    va = a
    LOCATE z, y, 1', 1, 8
    IF a = 1 THEN COLOR 0, 7: LOCATE z, y, 0: PRINT "█";
   
    SELECT CASE INKEY$
      
      CASE CHR$(0) + "A"                     'F7
     
      CASE CHR$(0) + "@"                     'F6: STOP
         PCOPY 0, 1
         SCREEN 0, 0, 0, 0
         VIEW PRINT
         COLOR 7, 0
         CLS
         PRINT "Escriba EXIT tras el símbolo del sistema para volver...";
         LOCATE , , 1, 12, 13
         SHELL
         SCREEN , , 1, 1
         PCOPY 1, 0
         SCREEN 0, 0, 0, 0
         VIEW PRINT 3 TO 48
     
      CASE CHR$(0) + "?"                     'F5: SONIDO
         Sonido = NOT Sonido
         GOTO Segu
      
      CASE CHR$(0) + ">"                     'F4: HORA
        'LOCATE z, y, 1, 1, 8
        COLOR 0, 7
        Vtime$ = TIME$
        DO
         LOCATE 3, 48, 0: PRINT TIME$; "   ";
        LOOP UNTIL VAL(RIGHT$(TIME$, 2)) - VAL(RIGHT$(Vtime$, 2)) > 2
        LOCATE 3, 48, 0
        PRINT DATE$;
     
      CASE CHR$(0) + "="                     'F3: IMAGEN
        Imagen
        Pausa
        Pantalla
        GOTO Segu
       
      CASE CHR$(0) + "<"                     'F2: MAPA
        CALL Mapa
     
      CASE CHR$(0) + ";"
         'CALL Ayuda(1)
       
      CASE CHR$(0) + "H": NDireccion = 3: GOSUB Dibujar
      CASE CHR$(0) + "K": NDireccion = 2: GOSUB Dibujar
      CASE CHR$(0) + "M": NDireccion = 1: GOSUB Dibujar
      CASE CHR$(0) + "P": NDireccion = 4: GOSUB Dibujar
      CASE CHR$(0) + "G"
       Poner.Marca 0
       y = 3
       Poner.Marca 1
      CASE CHR$(0) + "I"
       Poner.Marca 0
       z = 6
       Poner.Marca 1
      CASE CHR$(0) + "O"
       Poner.Marca 0
       y = 77
       Poner.Marca 1
      CASE CHR$(0) + "Q"
       Poner.Marca 0
       z = 44
       Poner.Marca 1
      CASE CHR$(27): CALL Salir(1): GOTO Segu
   
    END SELECT

LOOP

Dibujar:
   
    Poner.Marca 0
   
    LOCATE z, y, 0
    
    IF NDireccion = 1 AND Direccion = 1 THEN y = y + 1: IF Carac = 2 THEN Caracter = 205 ELSE Caracter = 196
    IF NDireccion = 2 AND Direccion = 2 THEN y = y - 1: IF Carac = 2 THEN Caracter = 205 ELSE Caracter = 196
    IF NDireccion = 3 AND Direccion = 3 THEN z = z - 1: IF Carac = 2 THEN Caracter = 186 ELSE Caracter = 179
    IF NDireccion = 4 AND Direccion = 4 THEN z = z + 1: IF Carac = 2 THEN Caracter = 186 ELSE Caracter = 179
    IF NDireccion = 3 AND Direccion = 1 THEN z = z - 1: IF Carac = 2 THEN Caracter = 188 ELSE Caracter = 217
    IF NDireccion = 3 AND Direccion = 2 THEN z = z - 1: IF Carac = 2 THEN Caracter = 200 ELSE Caracter = 192
    IF NDireccion = 1 AND Direccion = 3 THEN y = y + 1: IF Carac = 2 THEN Caracter = 201 ELSE Caracter = 218
    IF NDireccion = 2 AND Direccion = 3 THEN y = y - 1: IF Carac = 2 THEN Caracter = 187 ELSE Caracter = 191
    IF NDireccion = 4 AND Direccion = 2 THEN z = z + 1: IF Carac = 2 THEN Caracter = 201 ELSE Caracter = 218
    IF NDireccion = 1 AND Direccion = 4 THEN y = y + 1: IF Carac = 2 THEN Caracter = 200 ELSE Caracter = 192
    IF NDireccion = 4 AND Direccion = 1 THEN z = z + 1: IF Carac = 2 THEN Caracter = 187 ELSE Caracter = 191
    IF NDireccion = 2 AND Direccion = 4 THEN y = y - 1: IF Carac = 2 THEN Caracter = 188 ELSE Caracter = 217
    
    Direccion = NDireccion
    Limites
   
    COLOR Col, 7
    IF a = 2 THEN PRINT CHR$(Caracter);
    IF a = 1 THEN COLOR 0, 7: PRINT " ";
   
    Poner.Marca 1
    RETURN
    

'-----------------------------------------------------------------------------
Errores:

    IF ERR = 7 THEN a$ = "Memoria agotada ..."
    IF ERR = 11 THEN a$ = "División entre cero ..."
    IF ERR = 12 THEN a$ = "No válido en modo directo ..."
    IF ERR = 14 THEN a$ = "Espacio insuficiente para cadenas ..."
    IF ERR = 25 THEN a$ = "Fallo en dispositivo (no tiene la impresora encedida) ..."
    IF ERR = 27 THEN a$ = "Falta papel o la impresora no está encendida..."
    IF ERR = 51 THEN a$ = "Error interno ..."
    IF ERR = 52 THEN a$ = "Nombre o número de archivo incorrecto ..."
    IF ERR = 53 THEN a$ = "Archivo no se encontró ..."
    IF ERR = 54 THEN a$ = "Modo de archivo incorrecto ..."
    IF ERR = 55 THEN a$ = "Archivo ya está abierto ..."
    IF ERR = 57 THEN a$ = "Error en dispositivo E/S ..."
    IF ERR = 58 THEN a$ = "Archivo ya existe ..."
    IF ERR = 59 THEN a$ = "Longitud de registro incorrecto ..."
    IF ERR = 61 THEN a$ = "Disco lleno ..."
    IF ERR = 62 THEN a$ = "Información excedió fin de archivo ..."
    IF ERR = 63 THEN a$ = "Número de registro incorrecto ..."
    IF ERR = 64 THEN a$ = "Nombre de archivo incorrecto ..."
    IF ERR = 67 THEN a$ = "Demasiados archivos ..."
    IF ERR = 68 THEN a$ = "Dispositivo no disponible ..."
    IF ERR = 69 THEN a$ = "Desborde de búfer de comunicaciones ..."
    IF ERR = 70 THEN a$ = "Permiso denegado ..."
    IF ERR = 71 THEN a$ = "El disco no está listo ..."
    IF ERR = 72 THEN a$ = "Error de disco/almacenamiento ..."
    IF ERR = 73 THEN a$ = "Característica no disponible ..."
    IF ERR = 74 THEN a$ = "Cambiar nombre entre discos ..."
    IF ERR = 75 THEN a$ = "Error de acceso en ruta/archivo ..."
    IF ERR = 76 THEN a$ = "Ruta de acceso no se encontró ..."

   
    es = INT((80 - LEN(a$)) / 2)
   
    Marcos es, 13, 83 - es, 15
    Sombras es, 13, 83 - es, 15
   
    COLOR 0, 3
    LOCATE 14, es + 2, 0
    PRINT a$;
    Pausa
    STOP

Impresora:
   DATA 205, 5, 203

SUB Abrir
   
    SHELL "CD > Dir.DAT"
    OPEN "Dir.DAT" FOR INPUT AS #1
    INPUT #1, CD$
    CLOSE #1
   
    PCOPY 0, 1
    SCREEN , , 1, 1
    LOCATE , , 0

    Marcos 8, 11, 73, 40
 
    LOCATE 11, 8
    COLOR 15, 1
    PRINT STRING$(30, " "); "ABRIR"; STRING$(30, " ");
 
    Sombras 8, 11, 73, 40
    COLOR 0, 3
    COLOR 15, 3
    LOCATE 14, 10: PRINT "A";
    COLOR 0, 3: PRINT "rchivo :"

    LOCATE 17, 10: PRINT CD$

    Marcos 20, 13, 71, 15
    COLOR 15, 3
    LOCATE 19, 25: PRINT "L";
    COLOR 0, 3: PRINT "ista "; ""
    Marcos 10, 20, 56, 36

    COLOR 15, 3
    LOCATE 19, 62: PRINT "R";
    COLOR 0, 3: PRINT "uta "; ""
    Marcos 58, 20, 71, 36

    COLOR 0, 4
    LOCATE 38, 25: PRINT "  Aceptar  ";
    COLOR 2, 3
    PRINT "▄";
    LOCATE 39, 26: PRINT "▀▀▀▀▀▀▀▀▀▀▀"
    COLOR 0, 4
    LOCATE 38, 44: PRINT "  Cancelar  ";
    COLOR 2, 3
    PRINT "▄";
    LOCATE 39, 45: PRINT "▀▀▀▀▀▀▀▀▀▀▀▀"

    a$ = "DIR " + CD$ + "\*.* /b >Arch.dat"
    'a$ = "DIR C:\DOS\*.* /b >Arch.dat"
    SHELL a$
    SHELL "SORT <Arch.dat >Arch.dat"

    DIM Ar$(150)
    a = 0
    OPEN "Arch.DAT" FOR INPUT AS #1
    DO
     a = a + 1
     INPUT #1, a$
     Ar$(a) = a$
    LOOP UNTIL (EOF(1))
    CLOSE #1
  
    COLOR 0, 3
  
    x = 12
    FOR g = 1 TO 45
      i = i + 1
      IF i > 15 THEN i = 1: x = x + 15
      LOCATE 20 + i, x, 0
      PRINT Ar$(g)
    NEXT g
   
LOCATE 14, 21, 0
t$ = ""

WHILE INKEY$ <> "": WEND
t$ = ""
text:
 
 Introduce 14, 21, 69, t$, v
 IF v = 1 THEN GOTO yae
 IF v = 2 THEN
   COLOR Col, 0
   SCREEN , , 0, 0
   Nombre$ = ""
   EXIT SUB
 END IF
 IF v = 3 THEN GOTO el

yae:

 IF Sonido = 1 THEN SOUND 800, .3: SOUND 1200, .3: SOUND 1600, 1
 SCREEN , , 0, 0

 IF INSTR(t$, ".") = 0 THEN t$ = t$ + ".DIB"

 Nombre$ = t$
 Nombre$ = UCASE$(Nombre$)
 DEF SEG = Segmento
 BLOAD CD$ + "\" + Nombre$, 0
 DEF SEG = 0
 Pantalla
 EXIT SUB

el:
 
  cx = 1
  cy = 1
  ncx = 1
  ncy = 1
 
  LOCATE 14, 21, 0: PRINT Ar$(1);

  co = 1
  GOSUB Mar

  DO
s:
   te = 1
   SELECT CASE INKEY$
     
     CASE CHR$(0) + "H": ncy = cy - 1
     CASE CHR$(0) + "K": ncx = cx - 1
     CASE CHR$(0) + "M": ncx = cx + 1
     CASE CHR$(0) + "P": ncy = cy + 1
    
     CASE CHR$(0) + CHR$(30)
      a = ((cx - 1) * 15) + cy
      t$ = Ar$(a)
      co = 0
      GOSUB Mar
      GOTO text
    
     CASE CHR$(27)
      COLOR Col, 0
      SCREEN , , 0, 0
      Nombre$ = ""
      EXIT SUB
    
     CASE CHR$(13)
      a = ((cx - 1) * 15) + cy
      t$ = Ar$(a)
      GOTO yae
    
     CASE ELSE
      te = 0
   END SELECT
 
  IF te = 1 THEN
  
   co = 0
   GOSUB Mar
  
   cy = ncy
   cx = ncx
  
   IF cx < 1 THEN cx = 1
   IF cx > 3 THEN cx = 3
   IF cy > 15 THEN cy = 15
   IF cy < 1 THEN cy = 1
  
   LOCATE 14, 21, 0: PRINT STRING$(LEN(Ar$(a)), " ");
   a = ((cx - 1) * 15) + cy
   LOCATE 14, 21: PRINT Ar$(a);

   co = 1
   GOSUB Mar
 
  END IF

  LOOP
 
Mar:
  
   FOR g = (cx * 15) - 4 TO (cx * 15) + 9
    LOCATE 20 + cy, g, 0
    IF co = 1 THEN COLOR 3, 0 ELSE COLOR 0, 3
    PRINT CHR$(SCREEN(20 + cy, g));
   NEXT g
   RETURN
  
END SUB

SUB Caracters
      
    Marca "Caracteres"
      
    PCOPY 0, 1
    SCREEN , , 1, 1
      
    Marcos 18, 18, 57, 26
    Sombras 18, 18, 57, 26
      
    v = 18
    w = 20
    COLOR 0, 3
    FOR ca = 176 TO 223
      v = v + 2
      IF v > 55 THEN v = 20: w = w + 2
      LOCATE w, v, 0
      PRINT CHR$(ca); " ";
    NEXT ca
    LOCATE 24, 44
    PRINT " "; CHR$(16); " "; CHR$(8); " "; CHR$(4); "     ";
      
    FOR g = 19 TO 55
      LOCATE 19, g, 0
      PRINT " ";
      LOCATE 21, g, 0
      PRINT " ";
      LOCATE 23, g
      PRINT " ";
      LOCATE 25, g, 0
      PRINT " ";
    NEXT g
     
    LineaBlanca

    LOCATE 48, 4, 0
    COLOR , 7
    COLOR 0: PRINT "USE ";
    COLOR 15: PRINT CHR$(26);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(27);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(25);
    COLOR 0: PRINT " y ";
    COLOR 15: PRINT CHR$(24);
    COLOR 0: PRINT " PARA ELEGIR EL CARACTER Y PULSE";
    COLOR 15: PRINT " ENTER";
    COLOR 0: PRINT ".";
      
    v = 20
    w = 20
DO
    sc = SCREEN(w, v)
    LOCATE w, v, 0
    COLOR 28, 3: PRINT CHR$(sc);
    COLOR 3, 0
    SELECT CASE INKEY$
       
      CASE CHR$(0) + "K": GOSUB prb: v = v - 2: IF v < 20 THEN v = 20
      CASE CHR$(0) + "M": GOSUB prb: v = v + 2: IF v > 55 THEN v = 54
      CASE CHR$(0) + "P": GOSUB prb: w = w + 2: IF w > 25 THEN w = 24
      CASE CHR$(0) + "H": GOSUB prb: w = w - 2: IF w < 20 THEN w = 20
      CASE CHR$(27)
        SCREEN , , 0, 0
        EXIT SUB
      CASE CHR$(13)
        SCREEN , , 0, 0
        GOTO elegido
      
    END SELECT
LOOP

prb:
    LOCATE w, v, 0
    COLOR 0, 3
    PRINT CHR$(SCREEN(w, v));
    RETURN
     
elegido:
      
    LineaBlanca
     
    LOCATE 48, 4
    COLOR 0: PRINT "Elija la posicion del caracter con ";
    COLOR 15: PRINT CHR$(24);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(25);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(26);
    COLOR 0: PRINT " y ";
    COLOR 15: PRINT CHR$(27);
    COLOR 0: PRINT ", y pulse ";
    COLOR 15: PRINT "ENTER";
    COLOR 0: PRINT "...";
     
    Poner.Marca 0
    PCOPY 0, 1
    SCREEN , , 1, 1
      
    Poner.Marca 1
    COLOR Col, 7
    LOCATE z, y, 0
    PRINT CHR$(sc);

DO
    SELECT CASE INKEY$
      CASE CHR$(0) + "K": GOSUB yi: y = y - 1: Limites: GOSUB iy
      CASE CHR$(0) + "M": GOSUB yi: y = y + 1: Limites: GOSUB iy
      CASE CHR$(0) + "P": GOSUB yi: z = z + 1: Limites: GOSUB iy
      CASE CHR$(0) + "H": GOSUB yi: z = z - 1: Limites: GOSUB iy
      CASE CHR$(13): PCOPY 1, 0: EXIT SUB
      CASE CHR$(27): GOSUB yi: EXIT SUB
    END SELECT
LOOP
     
yi:
    Poner.Marca 0
    PCOPY 0, 1
    RETURN
iy:
    Poner.Marca 1
    LOCATE z, y, 0
    COLOR Col, 7
    PRINT CHR$(sc);
    RETURN

END SUB

SUB Colores
    
    PCOPY 0, 1
    SCREEN , , 1, 1
    Marca "Colores"
    LineaBlanca
   
    LOCATE 48, 4, 0
    COLOR 0: PRINT "USE ";
    COLOR 15: PRINT CHR$(26);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(27);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(25);
    COLOR 0: PRINT " y ";
    COLOR 15: PRINT CHR$(24);
    COLOR 0: PRINT " PARA ELEGIR EL COLOR Y PULSE";
    COLOR 15: PRINT " ENTER";
    COLOR 0: PRINT ".";

    Marcos 7, 18, 74, 26
    Sombras 7, 18, 74, 26
   
    yy = 20
    x = 5
    FOR co = 0 TO 31
     IF co = 16 THEN yy = 23: x = 5
     x = x + 4
     COLOR co, 3
     LOCATE yy, x, 0
     PRINT "██";
     LOCATE yy + 1, x, 0
     PRINT "██";
     IF co > 15 THEN COLOR 17, 3 ELSE COLOR 1, 3
     LOCATE yy, x + 2: PRINT "▄"
     LOCATE yy + 1, x + 2: PRINT "█"
     LOCATE yy + 2, x: PRINT " ▀▀"
   
    NEXT co
   
    PCOPY 0, 2
    SCREEN , , 2, 2
   
    cy = 20
    cx = 0
   
    GOSUB Gen
DO
    SELECT CASE INKEY$
     
      CASE CHR$(0) + "M"
        cx = cx + 1
        IF cx > 15 THEN cx = 15
        GOSUB Gen
        
      CASE CHR$(0) + "K"
        cx = cx - 1
        IF cx < 0 THEN cx = 0
        GOSUB Gen
     
      CASE CHR$(0) + "P"
       cy = 23
       GOSUB Gen
     
      CASE CHR$(0) + "H"
       cy = 20
       GOSUB Gen
     
      CASE CHR$(13)
       Col = ele
       SCREEN , , 0, 0
       EXIT SUB
     
      'CASE CHR$(0) + ";": GOSUB ayuda3
      CASE CHR$(27): EXIT SUB
    END SELECT

LOOP
    
Gen:
    ele = cx + ((cy - 20) * 16 / 3)
    COLOR 7, 0
    PCOPY 1, 2
    IF ele < 15 THEN COLOR 15, ele
    IF ele > 15 THEN COLOR 15, ele - 16
    IF ele = 15 OR ele = 31 THEN COLOR 0, 15
    LOCATE cy, 5 + (cx + 1) * 4
    PRINT "■■";
    LOCATE cy + 1, 5 + (cx + 1) * 4
    PRINT "■■";
    RETURN

END SUB

SUB Config
   
    COLOR 0, 7

    LOCATE 3, 33 + ((12 - LEN(Nombre$)) / 2)
    
    PRINT Nombre$;

    LOCATE 3, 48, 0
    PRINT DATE$; " ";
        
    LOCATE 3, 9, 0
    IF Sonido = Si THEN PRINT "SONIDO ON " ELSE PRINT "SONIDO OFF "

    LOCATE 3, 23, 0
    IF Carac = 1 THEN PRINT "SIMPLE";  ELSE PRINT "DOBLE ";

END SUB

SUB Cuadrados
    
    Marca "Cuadrados"
   
    LineaBlanca
    LOCATE 48, 4, 0
    COLOR 0
    PRINT "PULSE";
    COLOR 15: PRINT " ENTER ";
    COLOR 0: PRINT "PARA DEJARLO O ";
    COLOR 15: PRINT "ESC";
    COLOR 0: PRINT " PARA BORRARLO  ";

    PCOPY 0, 1
    SCREEN , , 1, 1

    COLOR Col, 7
    Ar = z
    Ab = z + 1
    iz = y - 1
    De = y + 1
 
    GOSUB jaj

DO
    SELECT CASE INKEY$
      CASE CHR$(0) + "H"
        PCOPY 0, 1
        SCREEN , , 1, 1
        Ab = Ab - 1
        GOSUB jaj
      CASE CHR$(0) + "P"
        PCOPY 0, 1
        SCREEN , , 1, 1
        Ab = Ab + 1
        GOSUB jaj
      CASE CHR$(0) + "M"
        PCOPY 0, 1
        SCREEN , , 1, 1
        De = De + 1
        GOSUB jaj
      CASE CHR$(0) + "K"
        PCOPY 0, 1
        SCREEN , , 1, 1
        De = De - 1
        GOSUB jaj
      CASE CHR$(13)
        PCOPY 1, 0
        SCREEN , , 0, 0
        EXIT SUB
      CASE CHR$(27)
        SCREEN , , 0, 0
        EXIT SUB
      'CASE CHR$(0) + ";"
    END SELECT
LOOP

jaj:
   
    IF Ar = Ab THEN Ab = Ab + 1
    IF De = iz + 1 THEN De = De + 1
    IF Ab > 44 THEN Ab = 44
    IF Ar < 6 THEN Ar = 6
    IF iz < 3 THEN iz = 3
    IF De > 78 THEN De = 78
   
    LOCATE Ar, iz, 0
    IF Carac = 1 THEN
      PRINT "┌"; STRING$(De - iz - 2, "─"); "┐";
      LOCATE Ab, iz, 0
      PRINT "└"; STRING$(De - iz - 2, "─"); "┘";
    ELSE
      PRINT "╔"; STRING$(De - iz - 2, "═"); "╗";
      LOCATE Ab, iz, 0
      PRINT "╚"; STRING$(De - iz - 2, "═"); "╝";
    END IF

    FOR g = Ar + 1 TO Ab - 1
      LOCATE g, iz, 0
      IF Carac = 1 THEN PRINT "│";  ELSE PRINT "║";
      LOCATE g, De - 1, 0
      IF Carac = 1 THEN PRINT "│";  ELSE PRINT "║";
    NEXT g
    
    RETURN

END SUB

SUB Imagen
   
    COLOR 0, 7
    FOR g = 1 TO 5
      LOCATE g, 1, 0
      PRINT STRING$(80, " ");
    NEXT g

    FOR g = 45 TO 50
      LOCATE g, 1, 0
      PRINT STRING$(80, " ");
    NEXT g

    FOR g = 1 TO 50
      LOCATE g, 1, 0: PRINT "  ";
      LOCATE g, 78, 0: PRINT "   ";
    NEXT g
    
    LOCATE 50, 1, 0
    PRINT "PULSE CUALQUIER TECLA PARA VOLVER ...";

END SUB

SUB Imprimir
   
    Marca "Imprimir"
   
    OPEN "LPT1:" FOR OUTPUT AS #1
     PRINT #1, ""
    CLOSE #1
   
    LineaBlanca
    LOCATE 48, 4, 0
    COLOR 31
    PRINT "PULSE CUALQUIER TECLA PARA EMPEZAR A IMPRIMIR ...";
    Pausa
    Imagen
   
    COLOR 0
    LOCATE 50, 1, 0
    PRINT STRING$(80, " ");
   
    DIM a(2)
    DEF SEG = VARSEG(a(0))
    RESTORE Impresora
    FOR i = 0 TO 2
       READ d
       POKE VARPTR(a(0)) + i, d
    NEXT i
   
    CALL ABSOLUTE(VARPTR(a(0)))

    DEF SEG = 0
    
    Pantalla

END SUB

SUB Inicio
  
    COLOR 7, 0
    CLS
    LOCATE , , 0
    COLOR 15, 1
    LOCATE 11, 30: PRINT "┌───────────────────┐"
    LOCATE 12, 30: PRINT "│                   │"
    LOCATE 13, 30: PRINT "│   D I B U J O S   │"
    LOCATE 14, 30: PRINT "│                   │"
    LOCATE 15, 30: PRINT "│       V 2.1       │"
    LOCATE 16, 30: PRINT "└───────────────────┘"

    COLOR 15, 0
    LOCATE 25, 1, 0
    PRINT "Por Iñigo Quílez (1995)";
    Pausa
    
    CLS
    LOCATE 8, 1, 0
    COLOR 7, 0
    PRINT "         Este programa sirve para dibujar simples dibujos mediante"
    PRINT "       los caracteres ASCII del PC. Con este programa se pueden  "
    PRINT "       hacer dibujos bastante divertidos y se demuestra lo valiosos"
    PRINT "       que pueden llegar a ser estos caracteres."
    PRINT
    PRINT "         Este programa está escrito en QBASIC por Iñigo Quílez"
    PRINT "       durante el año 1994 y 1995."

    LOCATE 23, 26, 0
    COLOR 15
    PRINT " Pulse una tecla para continuar";
    COLOR 31
    PRINT "...";
  
    Pausa
 
    COLOR 7, 0
    CLS
    LOCATE 5, 1, 0
    COLOR 7, 0
    PRINT "       Para mover el cursor use:           En los menús use:"
    PRINT
    PRINT "       -Las flechas                        -Las flechas"
    PRINT "                                           -ENTER"
    PRINT "                                           -ESC"
    PRINT "                                           -La letra "; : COLOR 15, 0: PRINT "RESALTADA": COLOR 7, 0
    PRINT
    PRINT " ─────────────────────────────────────────────────────────────────────────────"
    PRINT
    PRINT "       -F1 = Ayuda                         -May.Izq = Dibujar"
    PRINT "       -F2 = Mapa                          -May.Der = Borrar"
    PRINT "       -F3 = No Márgenes                   -ALT = Menú"
    PRINT "       -F4 = Hora                          -ESC = Salir"
    PRINT "       -F5 = Sonido On/Off"
    PRINT "       -F6 = Stop"
    LOCATE 23, 26, 0
    COLOR 15
    PRINT " Pulse una tecla para continuar";
    COLOR 31
    PRINT "... ";
    COLOR 7, 0
    Pausa
  
    CLS
END SUB

SUB Introduce (ty, tx1, tx2, t$, v)

v = 0
lo = tx2 - tx1

DO

 IF LEN(t$) > lo THEN
  t$ = LEFT$(t$, lo)
  BEEP
  WHILE INKEY$ <> "": WEND
 END IF

 LOCATE ty, tx1, 0
 PRINT t$; ; STRING$(lo - LEN(t$), " ");

 x = tx1 + LEN(t$)

 LOCATE ty, x, 1, 6, 7

 DO
  i$ = INKEY$
 LOOP UNTIL i$ <> ""
 
 SELECT CASE i$
 
  CASE CHR$(0) + "&": v = 3: EXIT SUB

  CASE CHR$(8)
   IF LEN(t$) > 0 THEN
    t$ = LEFT$(t$, LEN(t$) - 1)
   ELSE
    BEEP
   END IF

  CASE CHR$(13)
   v = 1
   EXIT SUB

  CASE CHR$(27)
   v = 2
   EXIT SUB

  CASE IS > CHR$(31)
    t$ = t$ + i$

  'CASE ELSE
  ' BEEP

  END SELECT

LOOP

END SUB

SUB Limites
   
    IF z < 6 THEN z = 6
    IF y < 3 THEN y = 3
    IF y > 77 THEN y = 77
    IF z > 44 THEN z = 44

END SUB

SUB Limpia

    COLOR 0, 7
    FOR g = 1 TO 50
      LOCATE g, 1, 0
      PRINT STRING$(80, " ");
    NEXT g

END SUB

DEFSNG A-Z
SUB LineaBlanca
   
    COLOR 0, 7
    LOCATE 48, 3, 0
    PRINT STRING$(75, " ");

END SUB

DEFINT A-Z
SUB Mal
 IF Sonido = Si THEN SOUND 800, 1: SOUND 400, 1
END SUB

SUB Mapa

    PCOPY 0, 1
    SCREEN , , 1, 0
   
    Marca "Mapa"
    LineaBlanca

    Marcos 9, 9, 52, 42
    Sombras 9, 9, 52, 42

    COLOR 0, 3

    LOCATE 11, 10: PRINT "               ┌─SALIR                  ";
    LOCATE 12, 10: PRINT "               │                         ";
    LOCATE 13, 10: PRINT "               ├─NUEVO                  ";
    LOCATE 14, 10: PRINT "               │                         ";
    LOCATE 15, 10: PRINT "               ├─ARCHIVO                ";
    LOCATE 16, 10: PRINT "               │                         ";
    LOCATE 17, 10: PRINT "               ├─IMPRIMIR               ";
    LOCATE 18, 10: PRINT "               │                         ";
    LOCATE 19, 10: PRINT "      ┌─MENU1─┼─DIBUJO                 ";
    LOCATE 20, 10: PRINT "      │        │                         ";
    LOCATE 21, 10: PRINT "      │        ├─COLOR                  ";
    LOCATE 22, 10: PRINT "      │        │                         ";
    LOCATE 23, 10: PRINT "      │        └─2ºMENU─┐               ";
    LOCATE 24, 10: PRINT "      │                  │    ┌─COPIAR  ";
    LOCATE 25, 10: PRINT " ALT──┘ ┌────────────────┘    │          ";
    LOCATE 26, 10: PRINT "      ^ │                     ├─MOVER   ";
    LOCATE 27, 10: PRINT "      │ │       ┌─BLOQUE─────┤          ";
    LOCATE 28, 10: PRINT "      │ │       │             ├─BORRAR  ";
    LOCATE 29, 10: PRINT "      │ │       ├─ESPECIALES │          ";
    LOCATE 30, 10: PRINT "      │ │       │             └─REPASAR ";
    LOCATE 31, 10: PRINT "      │ └MENU2─┼─CUADRADOS             ";
    LOCATE 32, 10: PRINT "      │         │                        ";
    LOCATE 33, 10: PRINT "      │         ├─TEXTO                 ";
    LOCATE 34, 10: PRINT "      │         │                        ";
    LOCATE 35, 10: PRINT "      │         ├─LINEAS                ";
    LOCATE 36, 10: PRINT "      │         │                        ";
    LOCATE 37, 10: PRINT "      │         ├─MAPA                  ";
    LOCATE 38, 10: PRINT "      │         │                        ";
    LOCATE 39, 10: PRINT "      │         └─1ºMENU┐               ";
    LOCATE 40, 10: PRINT "      └──────────────────┘               ";
   
    SCREEN , , 1, 1

    LOCATE 48, 4, 0
    COLOR 0, 7
    PRINT "PULSE UNA TECLA PARA VOLVER ...";
    Pausa
      
    SCREEN , , 0, 0

END SUB

SUB Marca (letra$)
   
    COLOR 0, 7
    LOCATE 3, 62
    PRINT STRING$(10, " ");
    COLOR 31, 7
    LOCATE 3, 62, 0
    PRINT letra$;

END SUB

SUB Marcar.Bloque (Res)
    
    LineaBlanca
    LOCATE 48, 4, 0
    COLOR 0: PRINT "USE ";
    COLOR 15: PRINT CHR$(26);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(27);
    COLOR 0: PRINT ",";
    COLOR 15: PRINT CHR$(25);
    COLOR 0: PRINT " y ";
    COLOR 15: PRINT CHR$(24);
    COLOR 0: PRINT " PARA MARCAR EL BLOQUE Y PULSE";
    COLOR 15: PRINT " ENTER";
    COLOR 0: PRINT ".";

    PCOPY 0, 1
    SCREEN , , 1, 1
    
    Ar = z
    Ab = z
    iz = y
    De = y
    
    GOSUB Jij

DO
    SELECT CASE INKEY$
      CASE CHR$(0) + "H"
        PCOPY 0, 1
        SCREEN , , 1, 1
        Ab = Ab - 1
        GOSUB Jij
      
      CASE CHR$(0) + "P"
        PCOPY 0, 1
        SCREEN , , 1, 1
        Ab = Ab + 1
        GOSUB Jij
      
      CASE CHR$(0) + "M"
        PCOPY 0, 1
        SCREEN , , 1, 1
        De = De + 1
        GOSUB Jij
      
      CASE CHR$(0) + "K"
        PCOPY 0, 1
        SCREEN , , 1, 1
        De = De - 1
        GOSUB Jij
      
      CASE CHR$(13)
        PCOPY 0, 1
        SCREEN , , 1, 1
        
        DIM Ah(iz TO De, Ar TO Ab)
        DIM Ah2(iz TO De, Ar TO Ab)
        FOR g = iz TO De
          FOR t = Ar TO Ab
            Ah(g, t) = SCREEN(t, g)
            Ah2(g, t) = (SCREEN(t, g, 1)) - 112
          NEXT t
        NEXT g
        GOSUB Poner

        EXIT SUB
      CASE CHR$(27): SCREEN , , 0, 0: EXIT SUB
      'CASE CHR$(0) + ";": GOTO ayuda2:
    END SELECT
LOOP

Jij:
    
    IF Ab < Ar THEN Ab = Ab + 1
    IF De < iz THEN De = De + 1
    IF De > 77 THEN De = 77
    IF De < 2 THEN De = 2
    IF Ab > 44 THEN Ab = 44
    
    COLOR , 0
    FOR g = Ar TO Ab
      FOR i = iz TO De
        LOCATE g, i, 0
        c = (SCREEN(g, i, 1)) - 112
        IF c = 0 THEN c = 7
        COLOR c
        PRINT CHR$(SCREEN(g, i));
      NEXT i
    NEXT g

RETURN

Poner:

    LineaBlanca

    IF Res = 2 OR Res = 1 THEN
     LOCATE 48, 4, 0
     COLOR 0, 7: PRINT "ELIJA LA NUEVA POSICION CON ";
     COLOR 15, 7: PRINT CHR$(25); : COLOR 0, 7: PRINT ",";
     COLOR 15, 7: PRINT CHR$(24); : COLOR 0, 7: PRINT ",";
     COLOR 15, 7: PRINT CHR$(27); : COLOR 0, 7: PRINT " Y ";
     COLOR 15, 7: PRINT CHR$(26); : COLOR 0, 7: PRINT ", Y PULSE ";
     COLOR 15, 7: PRINT "ENTER "; : COLOR 0, 7: PRINT "...";
    END IF
   
    IF Res = 4 THEN LOCATE 48, 4: PRINT "ESPERE...";
    
    yi = -1

    IF Res = 1 THEN
      GOSUB NuevaPos
      GOSUB Pone
    END IF
    
    IF Res = 2 THEN
      GOSUB NuevaPos
      GOSUB Borra
      GOSUB Pone
    END IF

    IF Res = 3 THEN
      GOSUB Borra
    END IF
      
    IF Res = 4 THEN
      FOR g = iz TO De
        FOR h = Ar TO Ab
          LOCATE h, g, 0
          COLOR Col, 7
          PRINT CHR$(SCREEN(h, g));
        NEXT h
      NEXT g
    END IF
   
   
    PCOPY 1, 0
    SCREEN , , 0, 0
    EXIT SUB

NuevaPos:
   
    Poner.Marca 0
   
    LOCATE , , 1, 4, 8
   
    DO
   
    Limites
    Poner.Marca 1
    LOCATE z, y, 1, 4, 8
   
    SELECT CASE INKEY$
        CASE CHR$(0) + "H": Poner.Marca 0: z = z - 1
        CASE CHR$(0) + "P": Poner.Marca 0: z = z + 1
        CASE CHR$(0) + "M": Poner.Marca 0: y = y + 1
        CASE CHR$(0) + "K": Poner.Marca 0: y = y - 1
        CASE CHR$(13): RETURN
        CASE CHR$(27): EXIT SUB
    END SELECT
LOOP

Pone:
          
    yi = -1
    FOR g = iz TO De
      zi = -1
      yi = yi + 1
      FOR t = Ar TO Ab
        zi = zi + 1
        COLOR Ah2(g, t), 7
        LOCATE z + zi, y + yi, 0
        PRINT CHR$(Ah(g, t));
      NEXT t
    NEXT g
 RETURN

Borra:
   COLOR 0, 7
   FOR g = iz TO De
     FOR t = Ar TO Ab
       LOCATE t, g, 0: PRINT " ";
     NEXT t
   NEXT g
   RETURN

END SUB

SUB Marcos (a, b, c, d)

COLOR 0, 3
LOCATE b, a, 0
PRINT "┌"; STRING$(c - a - 2, "─"); "┐";
LOCATE d, a, 0
PRINT "└"; STRING$(c - a - 2, "─"); "┘";

FOR g = b + 1 TO d - 1
 LOCATE g, a, 0
 PRINT "│"; STRING$(c - a - 2, " "); "│"
NEXT g

COLOR 0, 7
END SUB

SUB Mens.Ayudas

 Opcion$(1, 1, 0) = "Salir"
 Opcion$(1, 2, 0) = "Nuevo"
 Opcion$(1, 3, 0) = "Archivo"
 Opcion$(1, 3, 1) = "Abrir"
 Opcion$(1, 3, 2) = "Salvar"
 Opcion$(1, 3, 3) = "Guardar como"
 Opcion$(1, 3, 4) = "Borrar"
 Opcion$(1, 3, 5) = "*"
 Opcion$(1, 4, 0) = "Imprimir"
 Opcion$(1, 5, 0) = "Dibujo"
 Opcion$(1, 6, 0) = "Color"
 Opcion$(1, 7, 0) = "2º Menú"
 Opcion$(1, 8, 0) = "*"

 Opcion$(2, 1, 0) = "Bloque"
 Opcion$(2, 1, 1) = "Copiar"
 Opcion$(2, 1, 2) = "Mover"
 Opcion$(2, 1, 3) = "Borrar"
 Opcion$(2, 1, 4) = "Repasar"
 Opcion$(2, 1, 5) = "*"
 Opcion$(2, 2, 0) = "Especiales"
 Opcion$(2, 3, 0) = "Cuadrado"
 Opcion$(2, 4, 0) = "Texto"
 Opcion$(2, 5, 0) = "Linea"
 Opcion$(2, 5, 1) = "Simple"
 Opcion$(2, 5, 2) = "Doble"
 Opcion$(2, 5, 3) = "*"
 Opcion$(2, 6, 0) = "Mapa"
 Opcion$(2, 7, 0) = "1º Menú "
 Opcion$(2, 8, 0) = "*"

END SUB

SUB Menus

     Marca "Menú"
     LOCATE z, y, 1
    
     x1 = 1
Menu:
     x2 = 1
     x3 = 0
     n = 2

     LineaBlanca
     GOSUB Elecc
    
     LOCATE z, y, 1
    
DO
      b$ = ""
      SELECT CASE INKEY$
      
       CASE CHR$(27)
         n = n - 1
         IF n = 1 THEN EXIT SUB
         LineaBlanca
         x3 = 0
         x2 = 1
         GOSUB Elecc

       CASE CHR$(0) + "K"
         IF n = 2 THEN x2 = x2 - 1
         IF n = 3 THEN x3 = x3 - 1
         GOSUB Elecc
       
       CASE CHR$(0) + "M"
         IF n = 2 THEN x2 = x2 + 1
         IF n = 3 THEN x3 = x3 + 1
         GOSUB Elecc
      
       CASE "1"
         IF x1 = 2 AND n = 2 THEN
          x1 = 1
          x2 = 1
          x3 = 0
          LineaBlanca
          GOSUB Elecc
         END IF
      
       CASE "2"
         IF x1 = 1 AND n = 2 THEN
          x1 = 2
          x2 = 1
          x3 = 0
          LineaBlanca
          GOSUB Elecc
         END IF
        
       CASE CHR$(13)
         IF n = 3 THEN GOTO ya
         IF n = 2 AND x3 = 0 THEN x3 = 1: n = 3
         IF Opcion$(x1, x2, x3) = "" THEN GOTO ya
         LineaBlanca
         GOSUB Elecc
      
       CASE "S", "s"
        IF x1 = 1 AND n = 2 THEN b$ = "111": GOTO ya
        IF x1 = 2 AND x2 = 5 THEN Carac = 1: EXIT SUB
       CASE "N", "n": IF x1 = 1 AND n = 2 THEN b$ = "121": GOTO ya
       CASE "A", "a"
        IF x1 = 1 AND x2 = 3 AND n = 3 THEN b$ = "131": GOTO ya
        IF x1 = 1 AND n = 2 THEN
         n = 3
         x2 = 3
         x3 = 1
         LineaBlanca
         GOSUB Elecc
        END IF
       CASE "I", "i": IF x1 = 1 AND n = 2 THEN b$ = "141": GOTO ya
       CASE "D", "d"
        IF x1 = 1 AND n = 2 THEN b$ = "151": GOTO ya
        IF x1 = 2 AND x2 = 5 THEN Carac = 2: EXIT SUB
       CASE "C", "c"
        IF x1 = 1 AND n = 2 THEN b$ = "161": GOTO ya
        IF x1 = 2 AND n = 2 THEN b$ = "231": GOTO ya
        IF x1 = 2 AND x2 = 1 AND n = 3 THEN b$ = "211": GOTO ya
       CASE "B", "b"
        IF x1 = 2 AND x2 = 1 AND n = 3 THEN b$ = "213": GOTO ya
        IF x1 = 2 THEN
         x2 = 1
         x3 = 1
         n = 3
         LineaBlanca
         GOSUB Elecc
        END IF
       CASE "R", "r": IF x1 = 2 AND x2 = 1 AND n = 3 THEN b$ = "214": GOTO ya
       CASE "M", "m"
        IF x1 = 2 AND x2 = 1 AND n = 3 THEN b$ = "212": GOTO ya
        IF x1 = 2 AND n = 2 THEN b$ = "261": GOTO ya
       CASE "E", "e": IF x1 = 2 AND n = 2 THEN b$ = "221": GOTO ya
       CASE "T", "t": IF x1 = 2 AND n = 2 THEN b$ = "241": GOTO ya
       CASE "L", "l"
        IF x1 = 2 THEN
         x2 = 5
         x3 = 1
         n = 3
         LineaBlanca
         GOSUB Elecc
        END IF
       CASE IS <> ""
        Mal
      END SELECT

LOOP
    
Elecc:
       
       LOCATE 48, 3, 0
        
       IF n = 2 THEN
        IF x2 < 1 THEN x2 = 7
        IF x2 > 7 THEN x2 = 1
        g = 0
        DO
         g = g + 1
         a$ = Opcion$(x1, g, 0)
         IF a$ = "*" THEN EXIT DO

         final = LEN(a$)

         IF x2 = g THEN COLOR 7, 0 ELSE COLOR 0, 7
         PRINT " ";
         IF x2 = g THEN COLOR 15, 0 ELSE COLOR 15, 7
         PRINT LEFT$(a$, 1);
         IF x2 = g THEN COLOR 7, 0 ELSE COLOR 0, 7
         PRINT RIGHT$(a$, final - 1); " ";
         COLOR 0, 7: PRINT "  ";
        LOOP
      
       END IF
      
       IF n = 3 THEN
       
        IF x2 = 3 THEN
          IF x3 < 1 THEN x3 = 4
          IF x3 > 4 THEN x3 = 1
        END IF
        IF x2 = 5 THEN
          IF x3 < 1 THEN x3 = 2
          IF x3 > 2 THEN x3 = 1
        END IF
        IF x2 = 1 THEN
          IF x3 < 1 THEN x3 = 4
          IF x3 > 4 THEN x3 = 1
        END IF

        g = 0
        DO
        
         g = g + 1
         a$ = Opcion$(x1, x2, g)
         IF a$ = "*" THEN EXIT DO
         final = LEN(a$)
       
         IF x3 = g THEN COLOR 7, 0 ELSE COLOR 0, 7
         PRINT " ";
         IF x3 = g THEN COLOR 15, 0 ELSE COLOR 15, 7
         PRINT LEFT$(a$, 1);
         IF x3 = g THEN COLOR 7, 0 ELSE COLOR 0, 7
         PRINT RIGHT$(a$, final - 1); " ";
         COLOR 0, 7: PRINT "  ";
       
        LOOP
       END IF

       RETURN


ya:
    a$ = LTRIM$(STR$(x1)) + LTRIM$(STR$(x2)) + LTRIM$(STR$(x3))
    IF b$ <> "" THEN a$ = b$
   
    IF a$ = "111" THEN CALL Salir(1)
    IF a$ = "121" THEN CALL Salir(2)
   
    IF a$ = "131" THEN CALL Abrir
    'IF a$ = "132" THEN CALL Salvar
    'IF a$ = "133" THEN CALL Guardarcomo
    'IF a$ = "134" THEN CALL Borrar
   
    IF a$ = "141" THEN CALL Imprimir
    IF a$ = "151" THEN CALL Imagen: Pausa: Pantalla
    IF a$ = "161" THEN CALL Colores
    IF a$ = "171" THEN x1 = 2: GOTO Menu
   
    IF a$ = "211" THEN CALL Marcar.Bloque(1)
    IF a$ = "212" THEN CALL Marcar.Bloque(2)
    IF a$ = "213" THEN CALL Marcar.Bloque(3)
    IF a$ = "214" THEN CALL Marcar.Bloque(4)

    IF a$ = "221" THEN CALL Caracters
    IF a$ = "231" THEN CALL Cuadrados
    IF a$ = "241" THEN CALL Texto
    IF a$ = "251" THEN Carac = 1
    IF a$ = "252" THEN Carac = 2
   
    IF a$ = "261" THEN CALL Mapa
    IF a$ = "271" THEN x1 = 1: GOTO Menu

END SUB

SUB P.Color

 LOCATE 3, 4, 0
 COLOR Col, 7
 PRINT "█";

END SUB

SUB Pantalla

FOR g = 1 TO 50
  
   LOCATE g, 1, 0
      
   COLOR 15, 7
   PRINT "│";
   COLOR 8, 7
   PRINT "│";

   LOCATE g, 78, 0
  
   COLOR 15, 7
   PRINT "│";
   COLOR 0, 7
   PRINT " ";
   COLOR 8, 7
   PRINT "│";
       
NEXT g
 
LOCATE 3, 1, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│";

LOCATE 3, 6, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│";
 
LOCATE 3, 20, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│";

LOCATE 3, 31, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│";

LOCATE 3, 45, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│ ";
 
LOCATE 3, 59, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│ ";

LOCATE 3, 73, 0
COLOR 15, 7
PRINT "│";
COLOR 8, 7
PRINT "│";


 COLOR 15, 7
 LOCATE 1, 2, 0: PRINT STRING$(78, "─");
 LOCATE 4, 2, 0: PRINT STRING$(77, "─");
 LOCATE 45, 2, 0: PRINT STRING$(76, "─");
 LOCATE 49, 2, 0: PRINT STRING$(77, "─");

 COLOR 8, 7
 LOCATE 2, 2, 0: PRINT STRING$(77, "─");
 LOCATE 5, 2, 0: PRINT STRING$(77, "─");
 LOCATE 46, 2, 0: PRINT STRING$(77, " ");
 LOCATE 47, 2, 0: PRINT STRING$(76, "─");
 LOCATE 50, 2, 0: PRINT STRING$(78, "─");

COLOR 8, 7

LOCATE 1, 80, 0: PRINT "┐";
LOCATE 50, 80, 0: PRINT "┘";
LOCATE 2, 2, 0: PRINT "┌";
LOCATE 47, 78, 0: PRINT "┐";
LOCATE 47, 2, 0: PRINT "┌";
LOCATE 45, 2, 0: PRINT "└";
LOCATE 5, 2, 0: PRINT "┌";

LOCATE 4, 2, 0: PRINT "└";
LOCATE 4, 7, 0: PRINT "└";
LOCATE 4, 21, 0: PRINT "└";
LOCATE 4, 32, 0: PRINT "└";
LOCATE 4, 46, 0: PRINT "└";
LOCATE 4, 60, 0: PRINT "└";
LOCATE 4, 74, 0: PRINT "└";

LOCATE 2, 7, 0: PRINT "┌";
LOCATE 2, 21, 0: PRINT "┌";
LOCATE 2, 32, 0: PRINT "┌";
LOCATE 2, 46, 0: PRINT "┌";
LOCATE 2, 60, 0: PRINT "┌";
LOCATE 2, 74, 0: PRINT "┌";

COLOR 15, 7

LOCATE 49, 2, 0: PRINT "└";
LOCATE 49, 78, 0: PRINT "┘ ";
LOCATE 50, 1, 0: PRINT "└";
LOCATE 45, 78, 0: PRINT "┘";
LOCATE 4, 78, 0: PRINT "┘ ";
LOCATE 1, 1, 0: PRINT "┌";

LOCATE 4, 6, 0: PRINT "┘";
LOCATE 4, 20, 0: PRINT "┘";
LOCATE 4, 31, 0: PRINT "┘";
LOCATE 4, 45, 0: PRINT "┘";
LOCATE 4, 59, 0: PRINT "┘";
LOCATE 4, 73, 0: PRINT "┘";

LOCATE 2, 6, 0: PRINT "┐";
LOCATE 2, 20, 0: PRINT "┐";
LOCATE 2, 31, 0: PRINT "┐";
LOCATE 2, 45, 0: PRINT "┐";
LOCATE 2, 59, 0: PRINT "┐";
LOCATE 2, 73, 0: PRINT "┐";
LOCATE 2, 78, 0: PRINT "┐";
LOCATE 5, 78, 0: PRINT "┐";

END SUB

DEFSNG A-Z
SUB Pausa
 WHILE INKEY$ <> "": WEND
 WHILE INKEY$ = "": WEND
 WHILE INKEY$ <> "": WEND
END SUB

DEFINT A-Z
SUB Poner.Marca (Modo)
   
    IF Modo = 0 THEN
     LOCATE z, 79, 0
     COLOR 0, 7
     PRINT " ";
     LOCATE 46, y, 0
     PRINT " ";
    ELSE
     LOCATE z, 79, 0
     COLOR 0, 7
     PRINT CHR$(27)
     LOCATE 46, y, 0
     PRINT CHR$(24);
    END IF

END SUB

SUB Salir (sal)

     PCOPY 0, 1
     SCREEN , , 1, 1
   
     Marcos 23, 13, 52, 17
     Sombras 23, 13, 52, 17
    
     LOCATE 15, 27, 0
     COLOR , 3
     COLOR 0: PRINT "¿ ESTA SEGURO (";
     COLOR 15: PRINT "s";
     COLOR 0: PRINT "/";
     COLOR 15: PRINT "n";
     COLOR 0: PRINT ") ?  "


DO
     SELECT CASE INKEY$
      CASE "S", "s"
         IF sal = 1 THEN
           IF Sonido = 1 THEN SOUND 800, .3: SOUND 1200, .3: SOUND 1600, 1
           SCREEN 0, 0, 0, 0
           WIDTH 80, 25
           VIEW PRINT
           COLOR 7, 0
           CLS
           POKE 1047, Estado
           SYSTEM
         ELSE
           SCREEN , , 1, 0
           Limpia
           Pantalla
           PCOPY 1, 0
           SCREEN , , 0, 0
           EXIT SUB
         END IF
         
      CASE "N", "n", CHR$(27)
            SCREEN , , 0, 0
            EXIT SUB
      CASE IS <> ""
            Mal

     END SELECT
LOOP

END SUB

SUB Sombras (a, b, c, d)
    
     FOR g = a + 1 TO c
      LOCATE d + 1, g
      co = SCREEN(d + 1, g, 1) - 112
      ca = SCREEN(d + 1, g)
      IF co < 8 THEN co = 0
      IF co > 8 AND co < 16 THEN co = co - 8
      IF co > 31 THEN co = 0
      COLOR co, 8
      PRINT CHR$(ca);
     NEXT g
  
     FOR g = b + 1 TO d + 1
      LOCATE g, c
      co = SCREEN(d + 1, g, 1) - 112
      ca = SCREEN(d + 1, g)
      IF co > 8 AND co < 16 THEN co = co - 8
      IF co > 23 THEN co = co - 8
      IF co < 8 THEN co = 0
      COLOR co, 8
      PRINT CHR$(ca);
     NEXT g

END SUB

SUB Texto

Poner.Marca 0
PCOPY 0, 1
SCREEN , , 1, 1

Marca "Texto"

LineaBlanca

LOCATE 48, 4, 0
COLOR 0, 7: PRINT "PULSE "; : COLOR 15, 7: PRINT "ENTER";
COLOR 0, 7: PRINT " CUANDO ACABE DE ESCRIBIR O ";
COLOR 15, 7: PRINT "ESC"; : COLOR 0, 7: PRINT " PARA ABORTAR ...";

COLOR Col, 7
vy = y
vz = z
LOCATE z, y, 1, 6, 7
Poner.Marca 1

Introduce z, y, 80, Tex$, v
IF v = 1 THEN COLOR Col, 7: LOCATE vz, vy: PRINT Tex$; : PCOPY 1, 0
IF v = 2 THEN z = vz: y = vy: SCREEN , , 0, 0

END SUB

SUB Video
    DEF SEG = &H40
    a = PEEK(&H49)
    IF a = 7 THEN Segmento = &HB000
    IF a < 4 THEN Segmento = &HB800
    IF a = 0 THEN BEEP: CLS : LOCATE 1, 1, 0: PRINT "Modo de vídeo desconocido..."; : Pausa: CLS : SYSTEM
END SUB

