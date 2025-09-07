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

procedure PasarCartaALaDerecha (var p1,p2,p3,p4:TMano);
var
indice1,indice2,indice3,indice4:integer;
carta1,carta2,carta3,carta4:TCarta;

begin
  indice1:=ElegirCartaADar(p1);
  indice2:=ElegirCartaADar(p2);
  indice3:=ElegirCartaADar(p3);
  indice4:=ElegirCartaADar(p4);

  carta1:=p1[indice1];
  carta2:=p2[indice2];
  carta3:=p3[indice3];
  carta4:=p4[indice4];

  p2[indice2]:=carta1; {Jugador 2 recibe la carta de jugador 1}
  p3[indice3]:=carta2; {Jugador 3 recibe la carta de jugador 2}
  p4[indice4]:=carta3; {Jugador 4 recibe la carta de jugador 3}
  p1[indice1]:=carta4; {Jugador 1 recibe la carta de jugador 4}
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

begin
    randomize;
    LlenarMazo(MazoJuego);
    Barajar(MazoJuego);
    Repartir(MazoJuego,CartasP1,CartasP2,CartasP3,CartasP4);

    ronda:=0;
    ganador:=0;

    repeat
      inc(ronda); {Para incrementar +1}

      {Chequear victoria antes de pasar cartas por si alguno empezó ganando.}
      if HayCuatroIguales(CartasP1) then 
      ganador:=1
      else if HayCuatroIguales(CartasP2) then
      ganador:=2
      else if HayCuatroIguales(CartasP3) then
      ganador:=3
      else if HayCuatroIguales(CartasP4) then
      ganador:=4;

      if ganador = 0 then
      begin  
        PasarCartaALaDerecha(CartasP1,CartasP2,CartasP3,Cartasp4);
        {Chequeo de victoria nuevamente}
        if HayCuatroIguales(CartasP1) then 
        ganador:=1
        else if HayCuatroIguales(CartasP2) then
        ganador:=2
        else if HayCuatroIguales(CartasP3) then
        ganador:=3
        else if HayCuatroIguales(CartasP4) then
        ganador:=4;
        writeln('    --- RONDA ',ronda,'---');
        writeln;
        MostrarMano('Mano Jugador 1', CartasP1);
        writeln;
        MostrarMano('Mano Jugador 2', CartasP2);
        writeln;
        MostrarMano('Mano Jugador 3', CartasP3);
        writeln;
        MostrarMano('Mano Jugador 4', CartasP4);
        writeln;
      end;
    until ganador <> 0;
    writeln;
    writeln('Ganador: Jugador ',ganador,' en la ronda ', ronda,'!');

  {Falta aplicar movimiento de juego del chancho va e interactividad con whiles y centinelas.}
end.