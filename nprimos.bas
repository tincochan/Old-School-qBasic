DEFINT A-Z

ON ERROR GOTO Errores
DO
CLS
WIDTH 80, 25
COLOR 0, 7
LOCATE 2, 28: PRINT "┌"; STRING$(20, "─"); "┐";
LOCATE 3, 28: PRINT "│ Los Números Primos │"
LOCATE 4, 28: PRINT "└"; STRING$(20, "─"); "┘"

COLOR 7, 0
LOCATE 25, 1: PRINT "Por I.Q (1994)";

LOCATE 6, 20: PRINT "Elija la resolución de la pantalla:"
LOCATE 8, 20, 0
COLOR 15, 0
PRINT "a"; : COLOR 7, 0: PRINT ") 50 x 80               ";
COLOR 15, 0: PRINT "b"; : COLOR 7, 0: PRINT ") 25 x 80";

a:
DO
SELECT CASE INKEY$
 CASE "a", "A": WIDTH 80, 50: lim = 48: ff = 20: EXIT DO
 CASE "b", "B": WIDTH 80, 25: lim = 23: ff = 10: EXIT DO
END SELECT
LOOP

SCREEN 0, 1, 0, 0
COLOR 3, 3
CLS

COLOR 0, 7
LOCATE 2, 28: PRINT "┌"; STRING$(20, "─"); "┐";
LOCATE 3, 28: PRINT "│ Los Números Primos │"; : COLOR 3, 9: PRINT "  "; : COLOR 0, 7
LOCATE 4, 28: PRINT "└"; STRING$(20, "─"); "┘"; : COLOR 3, 9: PRINT "  ";
LOCATE 5, 30: PRINT STRING$(22, " ");
COLOR 15, 7
LOCATE lim + 1, 2: PRINT " F1 PAUSA ";
LOCATE lim + 1, 16: PRINT " F2 NUEVO ";
LOCATE lim + 1, 31: PRINT " F3 SALIR ";
COLOR 3, 9
LOCATE lim + 2, 3: PRINT "▄▄▄▄▄▄▄▄▄▄";
LOCATE lim + 2, 17: PRINT "▄▄▄▄▄▄▄▄▄▄";
LOCATE lim + 2, 32: PRINT "▄▄▄▄▄▄▄▄▄▄";
LOCATE lim + 1, 12: PRINT "▀";
LOCATE lim + 1, 26: PRINT "▀";
LOCATE lim + 1, 41: PRINT "▀";

COLOR 0, 3
c:
LOCATE 6, 2, 1: INPUT "Desde el número (ENTER=1):", np
LOCATE 7, 2, 1: INPUT "Hasta el número (ENTER=Infinito):", nf
IF np = 0 THEN np = 1
IF nf = 0 THEN nf = 30000
IF np > nf THEN BEEP: GOTO c
LOCATE 6, 2: PRINT STRING$(79, " ");
LOCATE 7, 2: PRINT STRING$(79, " ");

COLOR 15, 3
LOCATE 5, 1, 0
VIEW PRINT 7 TO lim - 1
IF np = 1 THEN PRINT " 1  2 ";
IF np = 2 THEN PRINT " 2 ";
DIM Nu(30000)

Nu(1) = 2

t = 1
c = 1

d:
 a$ = INKEY$
 IF a$ = CHR$(0) + ";" THEN BEEP: GOSUB Pausa
 IF a$ = CHR$(0) + "<" THEN BEEP: RUN
 IF a$ = CHR$(0) + "=" THEN BEEP: CLS : SYSTEM
 t = t + 1
 FOR g = 1 TO c
  IF t MOD Nu(g) = 0 THEN GOTO d
 NEXT g
 IF t > np THEN PRINT t;
 c = c + 1
 Nu(c) = t
 IF t >= nf THEN GOSUB Pausa: RUN
GOTO d

LOOP

Pausa:
   x = POS(0)
   y = CSRLIN
  
   PCOPY 0, 1
   SCREEN , , 1, 1
   COLOR 0, 7
   LOCATE ff, 19: PRINT "┌"; STRING$(35, "─"); "┐";
   LOCATE ff + 1, 19: PRINT "│                                   │"; : COLOR 7, 9: PRINT CHR$(SCREEN(ff + 1, 56)); CHR$(SCREEN(ff + 1, 57)); : COLOR 0, 7
   LOCATE ff + 2, 19: PRINT "└"; STRING$(35, "─"); "┘"; : COLOR 7, 9: PRINT CHR$(SCREEN(ff + 2, 56)); CHR$(SCREEN(ff + 2, 57));
   FOR g = 21 TO 57
    LOCATE ff + 3, g: PRINT CHR$(SCREEN(ff + 3, g));
   NEXT g
   COLOR 0, 7
   LOCATE ff + 1, 21: PRINT "PULSE UNA TECLA PARA CONTIMUAR...";
   WHILE INKEY$ = "": WEND
   SCREEN , , 0, 0
   COLOR 15, 3
   VIEW PRINT 7 TO lim - 1
   LOCATE y, x
RETURN

Errores:
 SOUND 800, 1
 COLOR 7, 0
 CLS
 PRINT "Error "; ERR; "..."
 SYSTEM

