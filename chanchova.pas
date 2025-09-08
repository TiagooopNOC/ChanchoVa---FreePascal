program ChanchoVa;

// 4 cartas mismo numero para ganar 1,2,3,4
type
Palos = (Espada, Oro, Copa, Basto);  // Los 4 palos.
TCont = array[1..4] of integer;

TCarta = record
numero:integer;
palo:palos; 
end;

TMano = array[1..4] of TCarta;
TMazo = array [1..16] of TCarta;

var
cont:TCont; //Contador para saber cuantos 1 tiene, cuantos 2 tiene ... ( Ej: Espacio 1 para saber cuantos 1 tiene)
i,p,ronda,ganador:integer;
CartasP1,CartasP2,CartasP3,CartasP4: TMano;
MazoJuego:TMazo;

const NombrePalos: array[palos] of string = ('Espada', 'Oro', 'Copa', 'Basto');
{Toco usar string para nombrar los palos porque un viaje con char.}
//------------------------------------------------------------------------------------------------------

procedure LlenarMazo(var Mazo:Tmazo); 
//Inicializar el Mazo con sus cartas para 4 jugadores. (1 de espada, 1 de copa .. 2 de espada ... , 3 de espada, ... 4 de espada, ...)
var i,n:integer;
p:palos;
begin
  i:=1;
    for p:=Espada to Basto do
    begin
      for n:=1 to 4 do
      begin
        Mazo[i].numero:=n;
        Mazo[i].palo:=p;
        i:=i+1;
      end; 
    end;
end;

procedure Barajar(var Mazo:TMazo);
{Implementado lógica de shuffle (barajado) de Fisher-Yates}
var
i,j:integer;
temp:TCarta;
begin
  for i:= 16 downto 2 do
  begin
    j:= random (i) + 1;
    temp:=Mazo[i];
    Mazo[i] := Mazo[j];
    Mazo[j] := temp;
  end;
end;

procedure Repartir(var Mazo:TMazo; var p1,p2,p3,p4:TMano);
{Aplicado Lógica de Repartir ( Simulando de arriba a abajo )}
var i,indice:integer;
begin
  indice:=1;
  for i:=1 to 4 do
    begin
      p1[i]:=Mazo[indice];
      indice:=indice+1;
      p2[i]:=Mazo[indice];
      indice:=indice+1;
      p3[i]:=Mazo[indice];
      indice:=indice+1;
      p4[i]:=Mazo[indice];
      indice:=indice+1;
    end;
end;

procedure ContarNumeros(var mano:TMano; var cnt:TCont);
var
i:integer;
begin
  for i:=1 to 4 do  
  {Inicializamos todo en 0}
  cnt[i]:=0;
  for i:=1 to 4 do
  {A cada vez que aparezca un numero i en el cont[i] sumamos 1, asi sabemos cuanto le falta para tener los 4 num iguales:}
  cnt[mano[i].numero]:=cnt[mano[i].numero]+1;
end;

function HayCuatroIguales(mano:TMano):boolean;
var 
cnt:Tcont;
i:integer;
hay:boolean;

begin
  hay:=false;
  ContarNumeros(mano,cnt);
  for i:= 1 to 4 do
  if cnt[i] = 4 then
    hay:=true;

  HayCuatroIguales:=hay;
end;

function ElegirCartaADar (mano:TMano):integer;
{Quiero buscar el indice de la mejor carta para dar (es decir la menos util asi la doy al rival.)}
var
cnt:Tcont;
i,mejorindice,mejorfrecuencia:integer;

begin
  ContarNumeros(mano,cnt);
  mejorindice:=1; {Arrancamos suponiendo que la carta 1 es la peor}
  mejorfrecuencia:=cnt[mano[1].numero]; {Frecuencia de esa carta}

  for i:=2 to 4 do {For para comparar las demas cartas con la primera.}
  begin
    if cnt[mano[i].numero] < mejorfrecuencia then {Si las veces que tenemos esa carta es menor a mejorfrecuencia}
    begin
    // Entonces nuestra mejorfrecuencia y mejorindice para dar la carta es esa nueva aparicion
      mejorfrecuencia:=cnt[mano[i].numero];  
      mejorindice:=i;
    end;
  end;
  ElegirCartaADar:=mejorindice;
end;


procedure MostrarMano(titulo:string; mano:TMano);
const
NombrePalos: array [Palos] of string = ('Espada','Oro','Copa','Basto');
var
i:integer;

begin
  writeln('--- ',titulo,' ---');
  for i:=1 to 4 do
  writeln(' ', mano[i].numero, ' de ',NombrePalos[mano[i].palo]);
end;


function ElegirCartaIA(var mano: TMano): integer;
var
  cnt: TCont;
  i, minFreq, candCount, k: integer;
  cands: array[1..4] of integer;
begin
  ContarNumeros(mano, cnt);

  minFreq := cnt[ mano[1].numero ];
  for i := 2 to 4 do
    if cnt[ mano[i].numero ] < minFreq then
      minFreq := cnt[ mano[i].numero ];

  candCount := 0;
  for i := 1 to 4 do
    if cnt[ mano[i].numero ] = minFreq then
    begin
      inc(candCount);
      cands[candCount] := i;
    end;

  k := random(candCount) + 1;        { 1..candCount }
  ElegirCartaIA := cands[k];
end;

function ElegirCartaHumano(const mano: TMano): integer;
var
  idx: integer; ok: boolean;
begin
  writeln;
  MostrarMano('Tu mano', mano);
  repeat
    write('Elija el indice (1..4) de la carta que quiere pasar: ');
    readln(idx);
    ok := (idx >= 1) and (idx <= 4);
    if not ok then writeln('indice invalido, proba de nuevo.');
  until ok;
  ElegirCartaHumano := idx;
end;

procedure PasarCartaALaDerecha(var p1, p2, p3, p4: TMano);
var
  i1, i2, i3, i4: integer;
  c1, c2, c3, c4: TCarta;
begin
  { Humano }
  i1 := ElegirCartaHumano(p1);
  { IAs }
  i2 := ElegirCartaIA(p2);
  i3 := ElegirCartaIA(p3);
  i4 := ElegirCartaIA(p4);

  c1 := p1[i1];  c2 := p2[i2];  c3 := p3[i3];  c4 := p4[i4];

  p2[i2] := c1;  p3[i3] := c2;  p4[i4] := c3;  p1[i1] := c4;

end;

begin
  randomize;
  LlenarMazo(MazoJuego);
  Barajar(MazoJuego);
  Repartir(MazoJuego, CartasP1, CartasP2, CartasP3, CartasP4);

  ronda := 0; ganador := 0;

  repeat
    inc(ronda);

    if      HayCuatroIguales(CartasP1) then ganador := 1
    else if HayCuatroIguales(CartasP2) then ganador := 2
    else if HayCuatroIguales(CartasP3) then ganador := 3
    else if HayCuatroIguales(CartasP4) then ganador := 4;

    if ganador = 0 then
    begin
      writeln; writeln('=== RONDA ', ronda, ' ===');
      PasarCartaALaDerecha(CartasP1, CartasP2, CartasP3, CartasP4);

      if      HayCuatroIguales(CartasP1) then 
      ganador := 1
      else if HayCuatroIguales(CartasP2) then 
      ganador := 2
      else if HayCuatroIguales(CartasP3) then 
      ganador := 3
      else if HayCuatroIguales(CartasP4) then 
      ganador := 4;

      writeln;
      MostrarMano('Tu mano (después de pasar/recibir)', CartasP1);
      { si alguien desea ver las manos de las ias descomente lo siguiente: }
      { MostrarMano('Mano Jugador 2', CartasP2);
        MostrarMano('Mano Jugador 3', CartasP3);
        MostrarMano('Mano Jugador 4', CartasP4); }
    end;
  until ganador <> 0;

  writeln;
  if ganador = 1 then
    writeln('CHANCHO! Ganaste en la ronda ', ronda, ' ')
  else if ganador = 2 then
    begin
    writeln('El Jugador ', ganador, ' grito Chancho, es el ganador en la ronda ', ronda, '.');
    MostrarMano('Mano Jugador 2', CartasP2);
    end
  else if ganador = 3 then
    begin
    writeln('El Jugador ', ganador, ' grito Chancho, es el ganador en la ronda ', ronda, '.');
    MostrarMano('Mano Jugador 3', CartasP3);
    end
  else if ganador = 4 then
    begin
    writeln('El Jugador ', ganador, ' grito Chancho, es el ganador en la ronda ', ronda, '.');
    MostrarMano('Mano Jugador 4', CartasP4);
    end;    
end.