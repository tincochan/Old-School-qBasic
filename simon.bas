DECLARE SUB Pantalla ()
DECLARE SUB Pone.Vidas ()
DECLARE SUB Pone.Sonido ()
DECLARE SUB Pausa ()
DECLARE SUB Cambio (in$)
DECLARE SUB Pone.Todo ()
DECLARE SUB Espera (Cu)
DECLARE SUB Ilumina (c, d)
DECLARE SUB Inicio (Azul$, Amarillo$, Rojo$, Verde$)
DECLARE SUB Quita.Teclas ()
DECLARE SUB Sube.Nivel ()
DECLARE SUB Sonidos (so)

COMMON SHARED NVidas, Sonido, Total, Toques
COMMON SHARED Nivel, Tiempo, MasL(), MasLarga, Ult()

DIM SHARED Simon(200)
DIM SHARED Vidas(100)
DIM SHARED Vida(100)
DIM SHARED Sonido(100)
DIM SHARED S(40)
DIM SHARED N(40)
DIM SHARED Nivel(140)
DIM SHARED Toques(140)
DIM SHARED Total(140)
DIM a(32)
DIM MasL(32)
DIM Ult(32)

 KEY 15, CHR$(12) + CHR$(83)     ' No Ctrl + Alt + Del
 KEY 16, CHR$(132) + CHR$(70)    ' No Ctrl + Brak
 ON KEY(15) GOSUB NCR
 ON KEY(16) GOSUB NCR
 ON ERROR GOTO Errores           ' Errores ...
 KEY(15) ON
 KEY(16) ON

RANDOMIZE TIMER
DEF SEG = 0
SCREEN 0, 1, 0, 0

Inicio Azul$, Amarillo$, Rojo$, Verde$

SCREEN 9, 1, 0, 0
CLS
COLOR 7, 0
LOCATE 10, 35: PRINT "S I M O N"
LOCATE 25, 1: PRINT "Por I¤igo Qu¡lez";

Otra:

 Pantalla
 Espera 4

 PCOPY 1, 0
 SCREEN , , 0, 0

 NVidas = 3
 Sonido = 1
 Nivel = 1
 Toques = 1
 MasLarga = 1
 Total = 0
 SemiTotal = 0
 Tiempo = 5000
 QT = 150

 Pone.Todo
 Pausa

'-----------------------------------------------------------------------------
DO
J:

SCREEN , , 0, 0

Sube.Nivel
Pone.Todo

Espera 2

Tiempo = Tiempo - QT

a(Toques) = 1 + INT(RND * 4)
FOR g = 1 TO Toques
 c = a(g)
 Ilumina c, 0
NEXT g

in$ = INKEY$
Cambio in$
Quita.Teclas

FOR g = 1 TO Toques
 ti = 0
 
DO

 ti = ti + 1
 IF ti > Tiempo * 1.2 THEN
   IF Sonido = 1 THEN Sonidos 2
   NVidas = NVidas - 1
   IF NVidas < 1 THEN GOTO Fin
   GOTO J
 END IF
ss:
 a$ = INKEY$

 B = 0
 IF a$ = Azul$ THEN B = 1
 IF a$ = Amarillo$ THEN B = 2
 IF a$ = Rojo$ THEN B = 3
 IF a$ = Verde$ THEN B = 4
 Cambio a$
 IF a$ <> "" THEN EXIT DO
 
LOOP

 Quita.Teclas
 IF B = 0 THEN GOTO ss
 Ilumina B, 1

 IF B <> a(g) THEN
   NVidas = NVidas - 1
   IF Sonido = 1 THEN Sonidos 2
   IF NVidas < 1 THEN GOTO Fin
   GOTO J
 END IF
NEXT g

FOR g = 1 TO Toques
 Ult(g) = a(g)
NEXT g

IF Toques > MasLarga THEN
 MasLarga = Toques
 FOR h = 1 TO Toques
  MasL(h) = a(h)
 NEXT h
END IF

Toques = Toques + 1
Total = Total + 1
LOOP

'---------------------------------------

Fin:
IF Sonido = 1 THEN Sonidos 4
Pone.Todo
TuTotal = Total
TuSemiTotal = Toques - 1
TuNivel = Nivel

OPEN "SIMON.DAT" FOR RANDOM AS #1 LEN = 25
FIELD #1, 15 AS Nombre$, 4 AS Total$, 2 AS Nivel$, 4 AS TuSemiTotal$
m = 0

FOR g = 1 TO 10
 GET #1, g
 IF TuTotal > VAL(Total$) THEN m = 1
NEXT g

IF m = 1 THEN

 PCOPY 0, 1
 SCREEN , , 1, 0
 LINE (180, 140)-(410, 170), 8, BF
 LINE (170, 130)-(400, 160), 7, BF
 LINE (170, 130)-(400, 160), 15, B
 COLOR 8, 7
 SCREEN , , 1, 1
 IF Sonido = 1 THEN PLAY "MBo2g15a16b15>d7<b15>d2"
 LOCATE 11, 24: INPUT "Tu Nombre:", TuNombre$
 SCREEN , , 0, 0

 LSET Nombre$ = TuNombre$
 LSET Total$ = STR$(TuTotal)
 LSET Nivel$ = STR$(TuNivel)
 LSET TuSemiTotal$ = STR$(TuSemiTotal)
 PUT #1, 10

 DIM t(10)
 DIM No$(10)
 DIM Ni$(10)
 DIM Se$(10)

 FOR g = 1 TO 10
  GET #1, g
  t(g) = VAL(Total$)
  No$(g) = Nombre$
  Ni$(g) = Nivel$
  Se$(g) = SemiTotal$
 NEXT g

 FOR gg = 1 TO 10
  o = o + 1
  FOR hh = o TO 10
   IF t(hh) > t(gg) THEN
    SWAP t(hh), t(gg)
    SWAP No$(hh), No$(gg)
    SWAP Ni$(hh), Ni$(gg)
    SWAP Se$(hh), Se$(gg)
   END IF
  NEXT hh
 NEXT gg

 FOR g = 1 TO 10
  LSET Nombre$ = No$(g)
  LSET Total$ = STR$(t(g))
  LSET Nivel$ = Ni$(g)
  LSET SemiTotal$ = Se$
  PUT #1, g
 NEXT g
END IF
CLOSE

BEEP

LINE (155, 82)-(540, 312), 8, BF
LINE (145, 72)-(530, 302), 7, BF
LINE (145, 72)-(530, 302), 15, B
LOCATE 7, 40: PRINT "RECORDS";
COLOR 8, 7
LOCATE 21, 40: PRINT "TOTAL:"; TuTotal;

OPEN "SIMON.DAT" FOR RANDOM AS #1 LEN = 25
FIELD #1, 15 AS Nombre$, 4 AS Total$, 2 AS Nivel$, 4 AS SemiTotal$

LOCATE 9, 22: PRINT "Nombre               Total           Nivel"
LOCATE 10, 22: PRINT "------               -----           ------"
PRINT
FOR g = 1 TO 10
 GET #1, g
 LOCATE g + 10, 22
 PRINT Nombre$, Total$, Nivel$; " ("; SemiTotal$; ")";
NEXT g
CLOSE

GOTO Otra

NCR:
 RETURN

Errores:
 SCREEN 0
 CLS
 COLOR 7, 0
 LOCATE 1, 1
 PRINT "Error"; ERR; "...";
 SYSTEM

SUB Cambio (in$)
 SELECT CASE in$
   CASE CHR$(0) + ";":
     BEEP
     COLOR 8, 7
     LOCATE 1, 34: PRINT "  ULTIMA ";
     FOR g = 1 TO Toques
      Ilumina Ult(g), 0
     NEXT g
     COLOR 8, 7
     LOCATE 1, 34: PRINT "  JUEGO  ";
     Pausa
     Espera 2
  
   CASE CHR$(0) + "<"
     BEEP
     COLOR 8, 7
     LOCATE 1, 34: PRINT "MAS LARGA";
     FOR g = 1 TO MasLarga
      Ilumina MasL(g), 0
     NEXT g
     COLOR 8, 7
     LOCATE 1, 34: PRINT "  JUEGO  ";
     Pausa
     Espera 2
  
   CASE CHR$(0) + "=": Sonido = NOT Sonido: Pone.Sonido
   CASE CHR$(0) + ">": PCOPY 0, 1: COLOR 7, 0: CLS : SHELL: SCREEN 9: PCOPY 1, 0: COLOR 8, 7
   CASE CHR$(0) + "?": SCREEN 0, 0, 0, 0: COLOR 7, 0: BEEP: CLS : SYSTEM
 END SELECT
END SUB

SUB Espera (Cu)

 VTimer = TIMER
 DO
  in$ = INKEY$
  Cambio in$
  IF in$ <> "" THEN EXIT DO
 LOOP UNTIL INT(TIMER) > INT(VTimer) + Cu
 Quita.Teclas
END SUB

SUB Ilumina (c, d)

 PCOPY 0, 1
 SCREEN , , 1, 0

 IF c = 1 THEN PAINT (200, 100), 9, 15
 IF c = 2 THEN PAINT (400, 100), 15, 15
 IF c = 3 THEN PAINT (200, 200), 12, 15
 IF c = 4 THEN PAINT (400, 200), 10, 15

 SCREEN , , 1, 1
 IF Sonido = 1 THEN SOUND c * 250, 2
 IF d <> 1 THEN FOR t = 1 TO Tiempo: NEXT t ELSE FOR t = 1 TO 900: NEXT t
 SCREEN , , 0, 0
END SUB

SUB Inicio (Azul$, Amarillo$, Rojo$, Verde$)
CLS
COLOR 15, 1
LOCATE 7, 23
PRINT "É"; STRING$(8, CHR$(205)); " Elija las teclas "; STRING$(8, CHR$(205)); "»";
LOCATE 17, 23
PRINT "È"; STRING$(34, CHR$(205)); "¼"
FOR g = 8 TO 16
 LOCATE g, 23: PRINT "º"; STRING$(34, " "); "º";
NEXT g

LOCATE 10, 30: PRINT "Azul:       Amarillo:"
LOCATE 14, 30: PRINT "Rojo:       Verde:"
LOCATE 24, 1
PRINT "º F1= Ultima    F2= M s Larga    F3= Sonido Si/No    F4= Ejecutar    F5= Salir º";
LOCATE 23, 1
PRINT "É"; STRING$(78, CHR$(205)); "»";
LOCATE 25, 1
PRINT "È"; STRING$(78, CHR$(205)); "¼";

DO
a$ = INKEY$
IF te = 0 THEN LOCATE 10, 36, 1
IF te = 1 THEN LOCATE 10, 52, 1
IF te = 2 THEN LOCATE 14, 36, 1
IF te = 3 THEN LOCATE 14, 49, 1
IF a$ <> "" THEN
 Sonidos 3
 te = te + 1
 IF te = 1 THEN Azul$ = a$: LOCATE 10, 36: PRINT a$
 IF te = 2 THEN Amarillo$ = a$: LOCATE 10, 52: PRINT a$
 IF te = 3 THEN Rojo$ = a$: LOCATE 14, 36: PRINT a$
 IF te = 4 THEN Verde$ = a$: LOCATE 14, 49, 0: PRINT a$: SLEEP 1: EXIT DO
END IF

LOOP

END SUB

SUB Pantalla

Pi = 4 * ATN(1)

SCREEN , , 1, 0
CLS
COLOR 9
LOCATE 6, 10: PRINT "S I M O N"
GET (70, 70)-(160, 82), Simon
COLOR 6
LOCATE 8, 10: PRINT "VIDAS"
GET (70, 99)-(112, 110), Vidas
PSET (100, 120), 4
DRAW "r2f2re2r2f2d2g6 l h6u2e2"
PAINT (101, 125), 4
GET (98, 120)-(111, 130), Vida
LOCATE 13, 10: PRINT "SONIDO"
GET (70, 168)-(122, 180), Sonido
LOCATE 14, 10: PRINT "S"
GET (70, 183)-(80, 194), S
LOCATE 15, 10: PRINT "N"
GET (70, 196)-(80, 208), N
LOCATE 17, 10: PRINT "NIVEL"
GET (70, 225)-(112, 236), Nivel
LOCATE 19, 10: PRINT "TOQUES"
GET (70, 253)-(120, 264), Toques
LOCATE 21, 10: PRINT "TOTAL"
GET (70, 280)-(120, 291), Total

SCREEN , 1, 1, 0
CLS
PAINT (10, 10), 7, 15
CIRCLE (300, 180), 225, 15
CIRCLE (300, 180), 200, 15, .1, Pi / 2 - .1
CIRCLE (300, 180), 200, 15, Pi / 2 + .1, Pi - .1
CIRCLE (300, 180), 200, 15, Pi + .1, 3 / 2 * Pi - .1
CIRCLE (300, 180), 200, 15, 3 / 2 * Pi + .1, 2 * Pi - .1

CIRCLE (300, 180), 100, 15, .1, Pi / 2 - .1
CIRCLE (300, 180), 100, 15, Pi / 2 + .1, Pi - .1
CIRCLE (300, 180), 100, 15, Pi + .1, 3 / 2 * Pi - .1
CIRCLE (300, 180), 100, 15, 3 / 2 * Pi + .1, 2 * Pi - .1

LINE (101, 165)-(200, 173)
LINE (101, 195)-(201, 187)

LINE (499, 165)-(400, 173)
LINE (500, 195)-(400, 187)

LINE (290, 107)-(280, 35)
LINE (310, 107)-(320, 35)

LINE (290, 253)-(280, 325)
LINE (310, 253)-(320, 325)

PAINT (200, 100), 1, 15
PAINT (400, 100), 14, 15
PAINT (200, 200), 4, 15
PAINT (400, 200), 2, 15

CIRCLE (298, 180), 50, 8, 0, .8, .5
CIRCLE (298, 180), 50, 15, .8, 3.6, .5
CIRCLE (298, 180), 50, 8, 3.6, 6.28, .5

PUT (260, 175), Simon
PUT (548, 20), Simon, XOR
PSET (544, 35), 15
DRAW "u18r83c8d18l83"

CIRCLE (300, 180), 225, 8, 0, .8
CIRCLE (300, 180), 225, 15, .8, 3.6
CIRCLE (300, 180), 225, 8, 3.6, 6.28

PUT (564, 80), Vidas
PSET (554, 115)
DRAW "c15u40r65c8d40l65"

PUT (562, 140), Sonido
PSET (554, 175)
DRAW "c15u40r65c8d40l65"

PUT (568, 158), S
PUT (592, 157), N

PUT (564, 195), Nivel
PSET (554, 225)
DRAW "c15u35r65c8d35l65"

PUT (560, 250), Toques
PSET (554, 280)
DRAW "c15u35r65c8d35l65"

PUT (564, 308), Total
PSET (554, 338)
DRAW "c15u35r65c8d35l65"

END SUB

SUB Pausa

 PCOPY 0, 1
 SCREEN , , 1, 0
 LINE (180, 140)-(480, 170), 8, BF
 LINE (170, 130)-(470, 160), 7, BF
 LINE (170, 130)-(470, 160), 15, B

 COLOR 8, 7
 LOCATE 11, 26: PRINT "Pulse una tecla para seguir..."
 SCREEN , , 1, 1
 WHILE INKEY$ = "": WEND
 Quita.Teclas
 SCREEN , , 0, 0

END SUB

SUB Pone.Sonido
PSET (565, 170)
IF Sonido = 1 THEN
 DRAW "c8 u13r16 c15 d13l16"
 PSET (589, 170)
 DRAW "c15 u13r16 c8 d13l16"
ELSE
 DRAW "c15 u13r16 c8 d13l16"
 PSET (589, 170)
 DRAW "c8u 13r16 c15 d13l16"
END IF


END SUB

SUB Pone.Todo

 Pone.Vidas
 Pone.Sonido
 COLOR 8, 7
 LOCATE 16, 73: PRINT Nivel;
 LOCATE 20, 73: PRINT Toques;
 LOCATE 24, 73: PRINT Total;
 COLOR 8, 7
 LOCATE 1, 34: PRINT "  JUEGO  ";
 
END SUB

SUB Pone.Vidas

 COLOR 8, 7
 LOCATE 8, 71: PRINT "       ";
 FOR g = 1 TO NVidas
  PUT (540 + (g * 20), 100), Vida
 NEXT g

END SUB

SUB Quita.Teclas
 POKE 1050, PEEK(1052)
END SUB

SUB Sonidos (so)
IF so = 1 THEN
 FOR g = 1 TO 100 STEP 10
    SOUND 37 + (SQR(g ^ 1) * 50), .1
    SOUND 37 + (SQR(g ^ 3) * 5), .1
    SOUND 3000, .1
 NEXT g
 FOR g = 100 TO 1 STEP -4
    SOUND 37 + SQR(g ^ 1) * 50, .1
    SOUND 37 + SQR(g ^ 3) * 5, .1
    SOUND 3000, .1
 NEXT g
END IF

IF so = 2 THEN
 
 FOR u = 1 TO 10
 FOR g = 200 TO 1200 STEP 100
   SOUND 37 + ATN(g / 1000) * 200, .1
 NEXT g
 NEXT u
END IF

IF so = 3 THEN SOUND 1200, .1

IF so = 4 THEN
 FOR g = 100 TO 1 STEP -1
  SOUND 37 + g * 20, .1
 NEXT g
END IF
END SUB

SUB Sube.Nivel
 IF Nivel = 1 AND Toques = 17 THEN Toques = 1: Nivel = 2: Tiempo = 4000: QT = 175: Sonidos 1
 IF Nivel = 2 AND Toques = 23 THEN Toques = 1: Nivel = 3: Tiempo = 2500: QT = 200: Sonidos 1
 IF Nivel = 3 AND Toques = 31 THEN Toques = 1: Nivel = 4: Tiempo = 1000: QT = 250: Sonidos 1
 Pone.Todo
END SUB

