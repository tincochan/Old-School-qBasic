DEFINT A-Z

DECLARE SUB Imagenes ()
DECLARE SUB Flecha (x, y)
DECLARE SUB Cuadro (x, y, a, B, m)
DECLARE SUB Escribe (x, y, p, f, t$)
DECLARE SUB Pantalla ()
DECLARE SUB Botones (m)
DECLARE SUB Enter ()
DECLARE SUB Barra (m, n, o, p)
DECLARE SUB QuitaCursor ()
DECLARE SUB PoneCursor ()
DECLARE SUB MRecorte ()
DECLARE SUB Ayudas ()
DECLARE SUB Salvapantallas (n, l, s)
DECLARE SUB Dibuja (Direccion)
DECLARE SUB MArchivo ()
DECLARE SUB MRecorte ()
DECLARE SUB MParam ()
DECLARE SUB MOpciones ()
DECLARE SUB Salir ()
DECLARE SUB Menus (Menu, Cual, Opcion)
DECLARE SUB Activa.SalvaPant (VTimer#, tiempo)
DECLARE SUB CnfSalvaPant ()
DECLARE SUB AceCance (Ax, Ay, Cx, Cy, p, s, t, B, ve, l)
DECLARE SUB Pausa (h#)


COMMON SHARED vx, vy, a, x, y, col, v, Estado$, vca, vcb, ti, Cursor

DIM SHARED Est$(2, 10)

DIM SHARED Menu1(2500)
DIM SHARED Menu2(3000)
DIM SHARED Menu3(2000)
DIM SHARED Menu4(3500)
DIM SHARED Salv(90)
DIM SHARED Salv1(3500)
DIM SHARED Salv2(13900)
DIM SHARED VSalir(7700)
DIM SHARED VCnfSPant(13900)
DIM SHARED Aceptar(500)
DIM SHARED Cancelar(500)

SCREEN 9, 0, 0, 0
WIDTH 80, 43
LOCATE 20, 21
PRINT "Espere un momento, por favor ..."
SCREEN , , 1, 0

OPEN "win_paint.dat" FOR INPUT AS #1
INPUT #1, tiempo
CLOSE #1

Imagenes
Ayudas

Pantalla
FOR g = 1 TO 19
 Botones g
NEXT g

v = 1
x = 210
y = 210
col = 0
Cursor = 1

Barra 1, 1, 1, 1

PCOPY 1, 0
SCREEN , , 1, 1

PoneCursor

DEF SEG = 0
Cy = 10
Cx = 10
vca = 1
vcb = 1
VTimer# = TIMER


DO
  
  a = PEEK(&H417)
  IF a >= 32 THEN POKE &H417, 0
  IF va = 2 AND a = 0 THEN GOSUB SeSuelta
  IF va = 0 AND a = 2 THEN GOSUB SePulsa
  va = a

  Tecla = 1
  Tecla$ = INKEY$
  IF Estado$ = " TEXTO " THEN Cursor = 3
  SELECT CASE Tecla$
     
      CASE CHR$(128) TO CHR$(254)
        SOUND 500, 2
        SOUND 400, 2

      CASE CHR$(32) TO CHR$(127)
      
       IF Estado$ = " TEXTO " THEN
        QuitaCursor
        Escribe x - 8, y - 8, col, 15, Tecla$
        x = x + 9
        IF x > 630 THEN x = 58: y = y + 8
        PoneCursor
       ELSE
        IF Tecla$ = "+" THEN
         v = v + 1
         IF v > 20 THEN v = 20
         Barra 0, 1, 0, 0
        END IF
        IF Tecla$ = "-" THEN
         v = v - 1
         IF v < 1 THEN v = 1
         Barra 0, 1, 0, 0
        END IF
       END IF
     
      CASE CHR$(8)
       IF Estado$ = " TEXTO " THEN
        QuitaCursor
        x = x - 9
        IF x < 58 THEN x = 58
        LINE (x, y - 8)-STEP(8, 8), 15, BF
        PoneCursor
       END IF

      CASE CHR$(0) + "H": Direccion = 3: Dibuja Direccion
      CASE CHR$(0) + "K": Direccion = 2: Dibuja Direccion
      CASE CHR$(0) + "M": Direccion = 1: Dibuja Direccion
      CASE CHR$(0) + "P": Direccion = 4: Dibuja Direccion
      CASE CHR$(0) + "I", "9": Direccion = 5: Dibuja Direccion
      CASE CHR$(0) + "G", "7": Direccion = 8: Dibuja Direccion
      CASE CHR$(0) + "O", "1": Direccion = 7: Dibuja Direccion
      CASE CHR$(0) + "Q", "3": Direccion = 6: Dibuja Direccion
     
      CASE CHR$(13)
      
       IF x < 15 AND y < 10 THEN         'Forma r pida de salir
          CALL Salir
       END IF
      
       IF Menu = 1 THEN                   'opci¢n del men£
       
        Opcion = 1 + ((y - 28) \ 12)
       
        IF Cual = 1 THEN
          IF Opcion = 5 THEN CALL Salir
          QuitaCursor
          PUT (6, 24), Salv1, PSET
          PoneCursor
        END IF
        IF Cual = 4 THEN
          IF Opcion = 4 THEN CALL CnfSalvaPant
          OPEN "win_paint.dat" FOR INPUT AS #1
          INPUT #1, tiempo
          CLOSE #1
          QuitaCursor
          PUT (322, 24), Salv1, PSET
          PoneCursor
        END IF
      
       END IF
      
       IF y < 23 AND y > 12 THEN
         GOSUB DespliegaMenu
       ELSE
         Cual = 0
         Menu = 0
       END IF
      
       IF x < 55 AND y > 25 AND Menu = 0 THEN GOSUB AprietaBoton
       IF Estado$ = " TEXTO " THEN GOSUB EnterTexto

       CASE ""
        Tecla = 0
    
     END SELECT

     IF Tecla = 1 AND Menu = 1 THEN CALL Menus(Menu, Cual, Opcion)
    
     IF Tecla = 1 THEN VTimer# = TIMER
     Activa.SalvaPant VTimer#, tiempo

LOOP

EnterTexto:
   QuitaCursor
   x = 58
   y = y + 10
   PoneCursor
   RETURN

AprietaBoton:
    Enter
    Barra 0, 0, 1, 0
    QuitaCursor
    PCOPY 1, 0
    PoneCursor
    RETURN

DespliegaMenu:
   
    IF Cual = 1 THEN I = 6
    IF Cual = 2 THEN I = 85
    IF Cual = 3 THEN I = 206
    IF Cual = 4 THEN I = 322
    IF Cual <> 0 THEN PUT (I, 24), Salv1, PSET
    
    IF Cual <> 0 THEN
      IF Cual = 1 THEN I = 6
      IF Cual = 2 THEN I = 85
      IF Cual = 3 THEN I = 206
      IF Cual = 4 THEN I = 322
      PUT (I, 24), Salv1, PSET
    END IF
    IF x < 63 AND x > 5 THEN
      Cual = 1
      MArchivo
      Menu = 1
    END IF
    IF x < 163 AND x > 105 THEN
      Cual = 2
      MRecorte
      Menu = 1
    END IF
    IF x < 287 AND x > 205 THEN
      Cual = 3
      MParam
      Menu = 1
    END IF
    IF x < 392 AND x > 324 THEN
       Cual = 4
       MOpciones
       Menu = 1
    END IF
    RETURN

SeSuelta:
   QuitaCursor
   IF Estado$ = " CIRCULO RELLENO " THEN
    PAINT ((vx + x) / 2, (y + vy) / 2), col, col
   END IF
   IF Estado$ = " CUADRADO RELLENO " THEN
    PAINT ((vx + x) / 2, (y + vy) / 2), col, col
   END IF
   IF Estado$ = " POLIGONO RELLENO " THEN
    PAINT ((vx + x) / 2, (y + vy) / 2), col, col
   END IF
  
   IF Estado$ = " RECORTE " THEN
     LINE (vx, vy)-(x, y), 15, B
   END IF
  
   PCOPY 1, 0
   PoneCursor
   RETURN

SePulsa:
   IF Estado$ = " DIBUJAR " THEN PSET (x, y), col
   IF Estado$ = " BORRAR " THEN
    QuitaCursor
    PoneCursor
   END IF
   vx = x
   vy = y
   IF Estado$ = " PICOS " THEN ti = ti + 1
   RETURN

SUB AceCance (Ax, Ay, Cx, Cy, p, s, t, B, ve, l)

 IF s = 1 THEN
  IF B = 1 THEN si$ = "SI" ELSE si$ = "NO"
  Escribe 355, 100, 7, 15, LTRIM$(STR$(t))
  Escribe 314, 120, 7, 15, si$
  Escribe 315, 140, 7, 15, LTRIM$(STR$(ve))
  Escribe 300, 160, 7, 15, LTRIM$(STR$(l))
 END IF

 DO
  SELECT CASE INKEY$
    
      CASE "+"
         v = v + 1
         IF v > 20 THEN v = 20
         Barra 0, 1, 0, 0
        
      CASE "-"
         v = v - 1
         IF v < 1 THEN v = 1
         Barra 0, 1, 0, 0
     
      CASE CHR$(0) + "H": Dir = 3: GOSUB Dib
      CASE CHR$(0) + "K": Dir = 2: GOSUB Dib
      CASE CHR$(0) + "M": Dir = 1: GOSUB Dib
      CASE CHR$(0) + "P": Dir = 4: GOSUB Dib
      CASE CHR$(0) + "I", "9": Dir = 5: GOSUB Dib
      CASE CHR$(0) + "G", "7": Dir = 8: GOSUB Dib
      CASE CHR$(0) + "O", "1": Dir = 7: GOSUB Dib
      CASE CHR$(0) + "Q", "3": Dir = 6: GOSUB Dib
      CASE CHR$(27)
        p = 2
        EXIT SUB
     
      CASE CHR$(13)
        IF x > Ax AND x < (Ax + 80) AND y > Ay AND y < (Ay + 20) THEN
          p = 1
          QuitaCursor
          PSET (Ax, Ay), 8
          DRAW "r80 c15 d20l80 c8 u20"
          PSET (Ax + 1, Ay + 1), 8
          DRAW "r78 c15 d18l78 c8 u19"
          PoneCursor
          SOUND 2000, 1
          Pausa .15
          QuitaCursor
          PUT (Ax, Ay), Aceptar, PSET
          PoneCursor
          SOUND 2000, 1
          Pausa .15
          EXIT SUB
        END IF
        IF x > Cx AND x < (Cx + 80) AND y > Cy AND y < (Cy + 20) THEN
          p = 2
          QuitaCursor
          PSET (Cx, Ay), 8
          DRAW "r80 c15 d20l80 c8 u20"
          PSET (Cx + 1, Ay + 1), 8
          DRAW "r78 c15 d18l78 c8 u19"
          PoneCursor
          SOUND 2000, 1
          Pausa .15
          QuitaCursor
          PUT (Cx, Cy), Cancelar, PSET
          PoneCursor
          SOUND 2000, 1
          Pausa .15
          EXIT SUB
        END IF
        IF s = 1 THEN GOSUB sa
  END SELECT
 LOOP

Dib:

  QuitaCursor
  IF Dir = 1 THEN x = x + v
  IF Dir = 2 THEN x = x - v
  IF Dir = 3 THEN y = y - v
  IF Dir = 4 THEN y = y + v
  IF Dir = 5 THEN x = x + v: y = y - v
  IF Dir = 6 THEN x = x + v: y = y + v
  IF Dir = 7 THEN x = x - v: y = y + v
  IF Dir = 8 THEN x = x - v: y = y - v

  IF x < 1 THEN x = 1
  IF y < 1 THEN y = 1
  IF x > 627 THEN x = 627
  IF y > 334 THEN y = 334

  PoneCursor
  Barra 0, 0, 0, 1
  RETURN

sa:
  IF x > 381 AND y > 98 AND x < 389 AND y < 106 THEN
   t = t - 1
   IF t < 10 THEN t = 10: RETURN
   Escribe 355, 100, 7, 15, "  "
   Escribe 355, 100, 7, 15, LTRIM$(STR$(t))
  END IF
  IF x > 393 AND y > 98 AND x < 401 AND y < 106 THEN
   t = t + 1
   IF t > 90 THEN t = 90: RETURN
   Escribe 355, 100, 7, 15, "  "
   Escribe 355, 100, 7, 15, LTRIM$(STR$(t))
  END IF
 
  IF x > 341 AND y > 138 AND x < 350 AND y < 147 THEN
   ve = ve - 1
   IF ve < 3 THEN ve = 3: RETURN
   Escribe 315, 140, 7, 15, "  "
   Escribe 315, 140, 7, 15, LTRIM$(STR$(ve))
  END IF
 
  IF x > 352 AND y > 138 AND x < 363 AND y < 147 THEN
   ve = ve + 1
   IF ve > 10 THEN ve = 10: RETURN
   Escribe 315, 140, 7, 15, "  "
   Escribe 315, 140, 7, 15, LTRIM$(STR$(ve))
  END IF
 
  IF x > 338 AND y > 118 AND x < 349 AND y < 126 THEN
   IF B = 1 THEN B = 0 ELSE B = 1
   IF B = 1 THEN si$ = "SI" ELSE si$ = "NO"
   Escribe 314, 120, 7, 15, "  "
   Escribe 314, 120, 7, 15, si$
  END IF
 
  IF x > 325 AND y > 158 AND x < 335 AND y < 167 THEN
   l = l - 1
   IF l < 1 THEN l = 1: RETURN
   Escribe 300, 160, 7, 15, "  "
   Escribe 300, 160, 7, 15, LTRIM$(STR$(l))
  END IF

  IF x > 337 AND y > 158 AND x < 348 AND y < 167 THEN
   l = l + 1
   IF l > 10 THEN l = 10: RETURN
   Escribe 300, 160, 7, 15, "  "
   Escribe 300, 160, 7, 15, LTRIM$(STR$(l))
  END IF
 
  RETURN
 
END SUB

SUB Activa.SalvaPant (VTimer#, tiempo)
    
     IF TIMER - VTimer# > tiempo THEN
       PCOPY 1, 0
       SCREEN , , 0, 0
       OPEN "win_paint.dat" FOR INPUT AS #1
       INPUT #1, tiempo
       INPUT #1, borra
       INPUT #1, vertices
       INPUT #1, lineas
       CLOSE #1
       Salvapantallas vertices, lineas, borra
       PCOPY 1, 0
       SCREEN , , 1, 1
       VTimer# = TIMER
     END IF

END SUB

SUB Ayudas

 Est$(1, 1) = " CIRCULO "
 Est$(2, 1) = " CIRCULO RELLENO "
 Est$(1, 2) = " CUADRADO "
 Est$(2, 2) = " CUADRADO RELLENO "
 Est$(1, 3) = " LINEA "
 Est$(2, 3) = " SPRAY "
 Est$(1, 4) = " DIBUJAR "
 Est$(2, 4) = " RELLENAR "
 Est$(1, 5) = " BORRAR "
 Est$(2, 5) = " TEXTO "
 Est$(1, 6) = " ESTRELLA "
 Est$(2, 6) = " ESTRELLA RELLENA "
 Est$(1, 7) = " POLIGONO "
 Est$(2, 7) = " POLIGONO RELLENO "
 Est$(1, 8) = " PICOS "
 Est$(2, 8) = " RECORTE "

END SUB

SUB Barra (m, n, o, p)

 IF m = 1 THEN
  LINE (6, 333)-STEP(50, 12), col, BF
 END IF

 COLOR 15
 IF n = 1 THEN
  LOCATE 43, 10: PRINT v;
  IF LEN(STR$(v)) = 2 THEN PRINT " ";
 END IF
 IF o = 1 THEN
  LOCATE 43, 17
  PRINT Estado$; STRING$(18 - LEN(Estado$), " ");
 END IF
 IF p = 1 THEN
  LOCATE 43, 38
  PRINT "("; x;
  LOCATE 43, 44: PRINT ","; y;
  LOCATE 43, 50: PRINT ")";
 END IF

END SUB

SUB Botones (m)

ON m GOSUB ba, bb, bc, bd, be, BF, bg, bh, bi, bj, bk, bl, bm, bn, bo, bp
EXIT SUB

ba:
 CIRCLE (14, 35), 8, 0
 CIRCLE (14, 35), 7, 0
 RETURN

bb:
 CIRCLE (41, 35), 8, 0
 CIRCLE (41, 35), 7, 0
 PAINT (41, 35), 15, 0
 RETURN

bc:
 LINE (7, 52)-STEP(13, 10), 0, B
 LINE (6, 51)-STEP(15, 12), 0, B
 RETURN

bd:
 LINE (35, 52)-STEP(13, 10), 0, B
 LINE (34, 51)-STEP(15, 12), 0, B
 PAINT (37, 60), 15, 0
 RETURN

be:
 LINE (6, 74)-STEP(16, 8), 0
 LINE (6, 75)-STEP(16, 8), 0
 RETURN

BF:
 LINE (32, 73)-STEP(16, 12), 7, BF
 FOR g = 1 TO 22
  PSET (32 + RND * 16, 73 + RND * 12), 0
 NEXT g
 RETURN

bg:
 PSET (12, 94), 0
 DRAW "d12f2e2u12l4 d11 r3lu10d10 bd2c15ulr2"
 RETURN

bh:
 PSET (34, 106), 0
 DRAW "fr11el12ur11 d r3euhl7hu2eu5ld5lu5"
 RETURN

bi:
 PSET (16, 130), 0
 DRAW "ta180"
 DRAW "d12f2e2u12l4 d11 r3lu10d10 bd2d"
 PSET (15, 130), 15
 DRAW "ta0"
 DRAW "l2bubr2c0l2"
 RETURN

bj:
 PSET (33, 123), 0
 DRAW "u4e2f2d4u2l3"
 PSET (39, 123), 0
 DRAW "u4r2fdg f2dg2l2u3"
 PSET (49, 123), 0
 DRAW "l2g2d3f2r2"
 RETURN

bk:
 PSET (13, 140), 0
 DRAW "dfdfdfdfdfd"
 DRAW "h2lh2lh2lh2"
 DRAW "r12"
 PSET (13, 140), 0
 DRAW "dgdgdgdgdgd"
 DRAW "e2re2re2re2"
 PSET (13, 143), 7
 DRAW "dr2dldl3u2l"
 RETURN

bl:
 PSET (42, 140), 0
 DRAW "dfdfdfdfdfd"
 DRAW "h2lh2lh2lh2"
 DRAW "r12"
 PSET (42, 140), 0
 DRAW "dgdgdgdgdgd"
 DRAW "e2re2re2re2"
 PSET (42, 143), 7
 DRAW "dr2dldl3u2l"
 PAINT (42, 143), 15, 0
 PAINT (44, 147), 15, 0
 RETURN

bm:
 PSET (10, 162), 0
 DRAW "r7f4dg4l7h4ue4"
 PSET (10, 161), 0
 DRAW "r7f5dg5l7h5ue5"
 RETURN

bn:
 PSET (38, 162), 0
 DRAW "r7f4dg4l7h4ue4"
 PSET (38, 161), 0
 DRAW "r7f5dg5l7h5ue5"
 PAINT (40, 164), 15, 0
 RETURN

bo:
 PSET (6, 191), 0
 DRAW "e8f8"
 RETURN

bp:
 LINE (35, 184)-STEP(12, 10), 0, B, &HCCCC
 RETURN

END SUB

SUB CnfSalvaPant
   
    QuitaCursor
    GET (150, 60)-(450, 240), Salv2
    PUT (150, 60), VCnfSPant, PSET
    PoneCursor
    
    OPEN "win_paint.dat" FOR INPUT AS #1
    INPUT #1, t
    INPUT #1, B
    INPUT #1, ve
    INPUT #1, l
    CLOSE #1
 
    IF B = 1 THEN si$ = "SI" ELSE si$ = "NO"
    Escribe 355, 100, 7, 15, LTRIM$(STR$(t))
    Escribe 314, 120, 7, 15, si$
    Escribe 315, 140, 7, 15, LTRIM$(STR$(ve))
    Escribe 300, 160, 7, 15, LTRIM$(STR$(l))
    
    AceCance 180, 210, 330, 210, p, 1, t, B, ve, l

    QuitaCursor
    PUT (150, 60), Salv2, PSET
    PoneCursor

    IF p = 1 THEN
     OPEN "win_paint.dat" FOR OUTPUT AS #1
     PRINT #1, t
     PRINT #1, B
     PRINT #1, ve
     PRINT #1, l
     CLOSE #1
    END IF
   
END SUB

SUB Cuadro (x, y, a, B, m)

 IF m = 0 THEN
  LINE (x, y)-(x + a, y + B), 7, BF
  PSET (x, y), 15
  DRAW "r" + STR$(a) + "c8d" + STR$(B) + "l" + STR$(a) + "c15u" + STR$(B)
  PSET (x + 1, y + 1), 15
  DRAW "r" + STR$(a - 1) + "c8d" + STR$(B - 1) + "l" + STR$(a - 1) + "c15u" + STR$(B - 1)
  PSET (x + 1, y + 1), 15
  DRAW "r" + STR$(a - 2) + "c8d" + STR$(B - 2) + "l" + STR$(a - 1) + "drluc15u" + STR$(B - 1)
 ELSE
  LINE (x, y)-(x + a, y + B), 7, BF
  PSET (x, y), 8
  DRAW "r" + STR$(a) + "c15d" + STR$(B) + "l" + STR$(a) + "c8u" + STR$(B)
  'PSET (x, y), 8
  'DRAW "r" + STR$(a - 1) + "c15d" + STR$(B) + "l" + STR$(a - 1) + "c8u" + STR$(B)
 END IF

END SUB

SUB Dibuja (Direccion)
STATIC va1, vb1, va2, vb2

     IF x < 56 THEN a = 0
     IF y < 25 THEN a = 0
     IF y > 327 THEN a = 0
   
     QuitaCursor
   
     IF Direccion = 1 THEN x = x + v
     IF Direccion = 2 THEN x = x - v
     IF Direccion = 3 THEN y = y - v
     IF Direccion = 4 THEN y = y + v
     IF Direccion = 5 THEN x = x + v: y = y - v
     IF Direccion = 6 THEN x = x + v: y = y + v
     IF Direccion = 7 THEN x = x - v: y = y + v
     IF Direccion = 8 THEN x = x - v: y = y - v
   
     IF x < 1 THEN x = 1
     IF y < 1 THEN y = 1
     IF x > 627 THEN x = 627
     IF y > 334 THEN y = 334
  
    IF a <> 2 THEN GOTO no
  
     IF Estado$ = " DIBUJAR " THEN
      LINE -(x, y), col
     END IF
    
     IF Estado$ = " BORRAR " THEN
      LINE (x, y)-STEP(6, 6), 15, BF
      PCOPY 1, 0
     END IF
     

     IF Estado$ = " CIRCULO " OR Estado$ = " CIRCULO RELLENO " THEN
        PCOPY 0, 1
        aa# = (x + vx) / 2
        bb# = (y + vy) / 2
        ra# = ABS(aa# - vx)
        rb# = ABS(bb# - vy)
        IF ra# > rb# THEN r# = ra# ELSE r# = rb#
        IF ra# = 0 THEN
         c# = 100
        ELSE
         c# = rb# / ra#
        END IF
        CIRCLE (aa#, bb#), r#, col, , , c#
     END IF
   
     IF Estado$ = " LINEA " THEN
        PCOPY 0, 1
        LINE (vx, vy)-(x, y), col
     END IF

    IF Estado$ = " CUADRADO " OR Estado$ = " CUADRADO RELLENO " THEN
        PCOPY 0, 1
        LINE (vx, vy)-(x, y), col, B
    END IF
   
    IF Estado$ = " SPRAY " THEN
      FOR g = 1 TO 200
        sx = INT(RND * 25)
        sy = INT(RND * 25)
      
        IF RND > .5 THEN sx = x - sx ELSE sx = x + sx
        IF RND > .5 THEN sy = y - sy ELSE sy = y + sy
      
        IF SQR((x - sx) ^ 2 + (y - sy) ^ 2) < 26 THEN
          PSET (sx, sy), col
        END IF
      NEXT g
    END IF

    IF Estado$ = " ESTRELLA " OR Estado$ = " ESTRELLA RELLENA " OR Estado$ = " POLIGONO " OR Estado$ = " POLIGONO RELLENO " THEN
      IF LEFT$(Estado$, 2) = " E" THEN I = 2 ELSE I = 1
      PCOPY 0, 1
     
      pi# = 4 * ATN(1)
      aa# = (x + vx) / 2
      bb# = (y + vy) / 2
     
      n = 5
      
      ra# = ABS(aa# - vx)
      rb# = ABS(bb# - vy)

      d# = .94    '  (inclinaci¢n)
     
      co# = 2 * pi# / n

      FOR ca# = 0 TO (2 * pi#) STEP co#
        px# = COS(d# + ca# * I) * ra#
        py# = SIN(d# + ca# * I) * rb#
        IF ca# = 0 THEN vpx# = px#: vpy# = py#
        LINE (vpx# + aa#, vpy# + bb#)-(px# + aa#, py# + bb#), col
        vpy# = py#
        vpx# = px#
      NEXT ca#

    END IF

    IF Estado$ = " PICOS " THEN
    
     IF ti = 2 THEN
      PCOPY 0, 1
      LINE (va1, vb1)-(va2, vb2), 15
      PCOPY 1, 0
      ti = 0
     END IF
     IF ti = 1 THEN
      PCOPY 0, 1
      LINE (vx, vy)-(x, y), col
      va1 = vx
      vb1 = vy
      va2 = x
      vb2 = y
     ELSE
      PCOPY 0, 1
      LINE (va1, vb1)-(x, y), col
      LINE (va2, vb2)-(x, y), col
     END IF
    END IF

    IF Estado$ = " RECORTE " THEN
      PCOPY 0, 1
      LINE (vx, vy)-(x, y), col, B, &HF0F0
    END IF
no:
    PoneCursor
    Barra 0, 0, 0, 1

END SUB

SUB Enter
      
      SOUND 2000, 1
      QuitaCursor

      Cuadro 28 * vca - 27, (22 * vcb) + 3, 25, 20, 0
     
      IF vca = 1 THEN cc = 1 ELSE cc = 0
      Botones ((vcb * 2) - cc)
     
      ca = 1 + FIX(x / 27)
      cb = 1 + (y - 25) \ 22
      Estado$ = Est$(ca, cb)
      Cuadro 28 * ca - 27, (22 * cb) + 3, 25, 20, 1
      IF ca = 1 THEN cc = 1 ELSE cc = 0
      Botones ((cb * 2) - cc)
      vca = ca
      vcb = cb
      
      PoneCursor

END SUB

SUB Escribe (x, y, p, f, t$)

DEF SEG = &HF000

vx = x
vy = y

FOR g = 1 TO LEN(t$)
 ch = ASC(MID$(t$, g, 1))

 y = vy
 vx = vx + 8

 x = vx

 FOR sc = 0 TO 7
  bc = PEEK(&HFA6E + sc + ch * 8)
  FOR B = 1 TO 8
   IF bc < 128 THEN c = f ELSE c = p
   IF bc > 127 THEN bc = bc - 128
   bc = bc * 2
   PSET (x, y), c
   x = x + 1
  NEXT B
  x = vx
  y = y + 1
 NEXT sc

NEXT g

END SUB

SUB Flecha (x, y)

 Cy = y + 1
 Cx = x + 1

 PSET (Cx, Cy), 0
 DRAW "d10rer2 dfdf r2 uhuhur3 h8"
 PSET (Cx + 1, Cy + 1), 15
 DRAW "d8eu6fd5ru4fd2rufl2d3rd2r"

END SUB

SUB Imagenes
   
    Cuadro 180, 210, 80, 20, 0
    Cuadro 330, 210, 80, 20, 0
    Escribe 183, 217, 0, 7, "Aceptar"
    Escribe 330, 217, 0, 7, "Cancelar"
    GET (180, 210)-(260, 230), Aceptar
    GET (330, 210)-(410, 230), Cancelar
   
    LINE (6, 24)-STEP(112, 64), 15, BF
    LINE (6, 24)-STEP(112, 64), 0, B
    LINE (6, 75)-STEP(112, 0), 0
    Escribe 6, 30, 0, 15, "Nuevo"
    Escribe 6, 42, 0, 15, "Abrir"
    Escribe 6, 54, 0, 15, "Guardar"
    Escribe 6, 66, 0, 15, "Guardar como"
    Escribe 6, 78, 0, 15, "Salir"
    GET (6, 24)-(118, 88), Menu1
   
    LINE (85, 24)-STEP(155, 70), 15, BF
    LINE (85, 24)-STEP(155, 70), 0, B
    LINE (85, 63)-STEP(155, 0), 0
    Escribe 86, 30, 0, 15, "Mover"
    Escribe 86, 42, 0, 15, "Copiar"
    Escribe 86, 54, 0, 15, "Borrar"
    Escribe 86, 66, 0, 15, "Reflejo horizontal"
    Escribe 86, 78, 0, 15, "Reflejo vertical"
    GET (85, 24)-(240, 94), Menu2
 
    LINE (206, 24)-STEP(90, 40), 15, BF
    LINE (206, 24)-STEP(90, 40), 0, B
    Escribe 207, 30, 0, 15, "Estrella"
    Escribe 207, 42, 0, 15, "Poligono"
    Escribe 207, 54, 0, 15, "Spray"
    GET (206, 24)-(296, 64), Menu3

    LINE (322, 24)-STEP(150, 78), 15, BF
    LINE (322, 24)-STEP(150, 78), 0, B
    LINE (322, 63)-STEP(150, 12), 0, B
    Escribe 323, 30, 0, 15, "Guargar paleta"
    Escribe 323, 42, 0, 15, "Recuperar paleta"
    Escribe 323, 54, 0, 15, "Paleta predeterm."
    Escribe 323, 66, 0, 15, "Salvapantallas"
    Escribe 323, 78, 0, 15, "Ver imagen"
    Escribe 323, 90, 0, 15, "Ver barra"
    GET (322, 24)-(472, 102), Menu4
   
    LINE (150, 100)-STEP(300, 100), 15, BF
    LINE (150, 100)-STEP(300, 100), 0, B
    LINE (151, 101)-STEP(298, 98), 0, B
    LINE (150, 100)-STEP(300, 12), 1, BF
    Escribe 220, 102, 15, 1, "Salir al sistema"
    Escribe 170, 130, 0, 15, "Confirme la opcion de abandonar"
    Escribe 170, 139, 0, 15, "el programa y salir al sistema."
    PSET (311, 130), 0
    DRAW "e2gr"
    LINE (179, 169)-STEP(82, 22), 0, B
    LINE (329, 169)-STEP(82, 22), 0, B
    PUT (180, 170), Aceptar, PSET
    PUT (330, 170), Cancelar, PSET
    GET (150, 100)-(450, 200), VSalir

    LINE (150, 60)-STEP(300, 180), 15, BF
    LINE (150, 60)-STEP(300, 180), 0, B
    LINE (151, 61)-STEP(298, 178), 0, B
    LINE (150, 60)-STEP(300, 12), 1, BF
    Escribe 165, 62, 15, 1, "Configuracion del SalvaPantallas"
    Escribe 160, 100, 0, 15, "Velocidad de activacion:"
    Escribe 160, 120, 0, 15, "Borrar la pantalla:"
    Escribe 160, 140, 0, 15, "Numero de vertices:"
    Escribe 160, 160, 0, 15, "Numero de lineas:"
    PSET (341, 100), 0: DRAW "e2gr"
    PSET (259, 140), 0: DRAW "e2gr"
    PSET (258, 160), 0: DRAW "e2gr"
    PSET (179, 140), 0: DRAW "e2gr"
    PSET (179, 160), 0: DRAW "e2gr"
    PUT (180, 210), Aceptar, PSET
    PUT (330, 210), Cancelar, PSET
    LINE (179, 209)-STEP(82, 22), 0, B
    LINE (329, 209)-STEP(82, 22), 0, B
    Cuadro 382, 98, 10, 10, 0
    Cuadro 394, 98, 10, 10, 0
    PSET (385, 103), 0: DRAW "r4"
    PSET (397, 103), 0: DRAW "r4l2ud2"
    LINE (360, 98)-STEP(45, 10), 0, B
    LINE (360, 98)-STEP(21, 10), 0, B
    Cuadro 342, 138, 10, 10, 0
    Cuadro 354, 138, 10, 10, 0
    PSET (345, 143), 0: DRAW "r4"
    PSET (357, 143), 0: DRAW "r4l2ud2"
    LINE (320, 138)-STEP(45, 10), 0, B
    LINE (320, 138)-STEP(21, 10), 0, B
    Cuadro 327, 158, 10, 10, 0
    Cuadro 339, 158, 10, 10, 0
    PSET (330, 163), 0: DRAW "r4"
    PSET (342, 163), 0: DRAW "r4l2ud2"
    LINE (305, 158)-STEP(45, 10), 0, B
    LINE (305, 158)-STEP(21, 10), 0, B
    LINE (319, 118)-STEP(33, 10), 0, B
    LINE (339, 119)-STEP(0, 9), 0
    Cuadro 340, 119, 11, 9, 0
    PSET (344, 121), 0
    DRAW "f4h2e2g4"

    GET (150, 60)-(450, 240), VCnfSPant

END SUB

SUB MArchivo
   
    QuitaCursor
    GET (6, 24)-(118, 89), Salv1
    PUT (6, 24), Menu1, PSET
    PoneCursor

END SUB

SUB Menus (Menu, Cual, Opcion)
    
     IF Cual = 1 THEN
     
       IF y > 25 AND y < 88 AND x > 5 AND x < 115 THEN
        Opcion = 1 + ((y - 28) \ 12)
        IF Opcion <> VOpcion THEN
         QuitaCursor
         PUT (6, 24), Menu1, PSET
         LINE (10, (Opcion * 12) + 16)-STEP(102, 10), 7, B
         VOpcion = Opcion
         PoneCursor
        END IF
       END IF
     
       IF y > 88 OR x < 6 OR x > 114 OR y < 12 THEN
         QuitaCursor
         Menu = 0
         PUT (6, 24), Salv1, PSET
         PoneCursor
       END IF
     END IF

     IF Cual = 2 THEN
       IF y > 25 AND y < 88 AND x > 105 AND x < 163 THEN
        Opcion = 1 + ((y - 28) \ 12)
        IF Opcion <> VOpcion THEN
         QuitaCursor
         PUT (85, 24), Menu2, PSET
         LINE (90, (Opcion * 12) + 16)-STEP(147, 10), 7, B
         VOpcion = Opcion
         PoneCursor
        END IF
       END IF
    
       IF y > 92 OR x < 86 OR x > 238 OR y < 12 THEN
         QuitaCursor
         Menu = 0
         PUT (85, 24), Salv1, PSET
         PoneCursor
       END IF
     END IF
  
     IF Cual = 3 THEN
       IF y > 25 AND y < 64 AND x > 205 AND x < 287 THEN
        Opcion = 1 + ((y - 28) \ 12)
        IF Opcion <> VOpcion THEN
         QuitaCursor
         PUT (206, 24), Menu3, PSET
         LINE (209, (Opcion * 12) + 16)-STEP(80, 10), 7, B
         VOpcion = Opcion
         PoneCursor
        END IF
       END IF
   
       IF y > 63 OR x < 205 OR x > 287 OR y < 12 THEN
         QuitaCursor
         Menu = 0
         PUT (206, 24), Salv1, PSET
         PoneCursor
       END IF
     END IF
   
     IF Cual = 4 THEN
       IF y > 25 AND y < 99 AND x > 324 AND x < 473 THEN
        Opcion = 1 + ((y - 28) \ 12)
        IF Opcion <> VOpcion THEN
         QuitaCursor
         PUT (322, 24), Menu4, PSET
         LINE (326, (Opcion * 12) + 16)-STEP(140, 10), 7, B
         VOpcion = Opcion
         PoneCursor
        END IF
       END IF
  
       IF y > 99 OR x < 324 OR x > 472 OR y < 12 THEN
         QuitaCursor
         Menu = 0
         PUT (322, 24), Salv1, PSET
         PoneCursor
       END IF
     END IF

END SUB

SUB MOpciones

 QuitaCursor
 GET (322, 24)-(473, 103), Salv1
 PUT (322, 24), Menu4, PSET
 PoneCursor

END SUB

SUB MParam

 QuitaCursor
 GET (206, 24)-(297, 69), Salv1
 PUT (206, 24), Menu3, PSET
 PoneCursor

END SUB

SUB MRecorte

 QuitaCursor
 GET (85, 24)-(241, 95), Salv1
 PUT (85, 24), Menu2, PSET
 PoneCursor
 
END SUB

SUB Pantalla

VIEW (0, 0)-(639, 349), 15, 15
LINE (0, 0)-STEP(639, 12), 1, BF

Cuadro 1, 0, 16, 12, 0
PSET (5, 5), 0
DRAW "r7dl7"

LINE (0, 12)-STEP(639, 12), 7, BF
LINE (0, 12)-STEP(639, 12), 0, B

LINE (0, 24)-STEP(55, 263), 0, BF

FOR g = 25 TO 280 STEP 22
 Cuadro 1, g, 25, 20, 0
 Cuadro 29, g, 25, 20, 0
NEXT g

Escribe 240, 3, 15, 1, "Programa de Dibujo"
Escribe 0, 15, 15, 7, "A"
Escribe 9, 15, 0, 7, "rchivo"
Escribe 100, 15, 15, 7, "R"
Escribe 109, 15, 0, 7, "ecorte"
Escribe 200, 15, 15, 7, "P"
Escribe 209, 15, 0, 7, "arametros"

Escribe 320, 15, 15, 7, "O"
Escribe 329, 15, 0, 7, "pciones"


LINE (0, 328)-STEP(639, 24), 7, BF
LINE (0, 328)-STEP(639, 24), 0, B

Cuadro 5, 332, 52, 14, 1
Cuadro 71, 335, 33, 9, 1
Cuadro 127, 335, 145, 9, 1
Cuadro 295, 335, 105, 9, 1

END SUB

SUB Pausa (h#)

 vt# = TIMER
 DO
 LOOP UNTIL TIMER - vt# > h#

END SUB

SUB PoneCursor
    GET (x, y)-(x + 11, y + 15), Salv
    Flecha x, y
END SUB

SUB QuitaCursor
 PUT (x, y), Salv, PSET
END SUB

SUB Salir

 Ax = 180
 Ay = 170
 Cx = 330
 Cy = 170

 QuitaCursor
 GET (150, 100)-(450, 200), Salv2

 FOR g = 1 TO 50
  LINE (300 - (g * 3), 150 - g)-(300 + (g * 3), 150 + g), 15, BF
  LINE (300 - (g * 3), 150 - g)-(300 + (g * 3), 150 + g), 0, B
 NEXT g

 PUT (150, 100), VSalir, PSET
 PoneCursor

 AceCance Ax, Ay, Cx, Cy, p, 0, 0, 0, 0, 0

 IF p = 2 THEN
   QuitaCursor
   PUT (150, 100), Salv2, PSET
   PoneCursor
 END IF

 IF p = 1 THEN
   QuitaCursor
   PUT (150, 100), Salv2, PSET
   PoneCursor
   CLS
   BEEP
   SYSTEM
 END IF
END SUB

SUB Salvapantallas (n, l, s)

RANDOMIZE TIMER


    ' n =  V‚rtices
    ' l = L¡neas
    ' s = 1: borra pantalla, s = 0: no borra pantalla

IF s = 1 THEN CLS

l = l - 1

 DIM x(n)
 DIM y(n)
 DIM vx(n)
 DIM vy(n)
 DIM xi(n)
 DIM yi(n)

 FOR g = 1 TO n
  x(g) = INT(RND * 639)
  y(g) = INT(RND * 350)
 NEXT g

 FOR g = 1 TO n
  xi(g) = 1 + INT(RND * 3)
  IF INT(RND * 2) = 1 THEN xi(g) = -xi(g)
  yi(g) = 1 + INT(RND * 3)
  IF INT(RND * 2) = 1 THEN yi(g) = -yi(g)
 NEXT g

DO

 IF RND > .99 THEN col = 1 + INT(RND * 14)

 FOR c = 0 TO l
  FOR g = 1 TO n
   h = g + 1
   IF g = n THEN h = 1
   LINE (x(g), y(g) + (c * 4))-(x(h), y(h) + (c * 4)), col
  NEXT g
 NEXT c

 FOR g = 1 TO n
 
  vx(g) = x(g)
  vy(g) = y(g)

  x(g) = x(g) + xi(g)
  y(g) = y(g) + yi(g)

  IF x(g) > 639 THEN xi(g) = INT(RND * 6): xi(g) = -xi(g)
  IF x(g) < 1 THEN xi(g) = INT(RND * 6)
  IF y(g) > 349 THEN yi(g) = INT(RND * 6): yi(g) = -yi(g)
  IF y(g) < 1 THEN yi(g) = INT(RND * 6)

 NEXT g

 FOR c = 0 TO l
  FOR g = 1 TO n
   h = g + 1
   IF g = n THEN h = 1
   LINE (vx(g), vy(g) + (c * 4))-(vx(h), vy(h) + (c * 4)), 0
  NEXT g
 NEXT c

LOOP UNTIL INKEY$ <> ""

END SUB

