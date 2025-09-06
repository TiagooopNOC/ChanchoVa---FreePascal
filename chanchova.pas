program ChanchoVa;

// 4 cartas mismo numero para ganar 1,2,3,4
type
Palos = (Espada, Oro, Copa, Basto);  // Los 4 palos.

TCarta = record
numero:integer;
palo:palos; 
end;

TMano = array[1..4] of TCarta;

TMazo = array [1..16] of TCarta;

var
cont: array [1..4] of integer; //Contador para saber cuantos 1 tiene, cuantos 2 tiene ... ( Ej: Espacio 1 para saber cuantos 1 tiene)

i:integer;
p:integer;

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
  randomize;
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

procedure ContarNumeros(var mano:TMano; cnt:cont);
i:integer;
begin
  for i:=1 to 4 do  
  {Inicializamos todo en 0}
  cnt[i]:=0;
  for i:=1 to 4 do
  {A cada vez que aparezca un numero i en el cont[i] sumamos 1, asi sabemos cuanto le falta para tener los 4 num iguales:}
  cnt[mano[i].numero]:=cnt[mano[i].numero]+1;
end;

function HayCuatroiIguales(mano:TMano):boolean;
var cnt:cont;
i:integer;
hay:boolean;

begin
  hay:=false;
  ContarNumeros(mano,cnt);
  for i:= 1 to 4 do
  if cnt[i] = 4 then
    hay:=true;

  HayCuatroiIguales:=hay;
end;

function ElegirCartaADar (mano:TMano):integer;
{Quiero buscar el indice de la mejor carta para dar (es decir la menos util asi la doy al rival.)}
var
cnt:cont;
i,mejorindice,mejorfrecuencia:integer;

begin
  ContarNumeros(mano,cont);
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

begin
    LlenarMazo(MazoJuego);
    Barajar(MazoJuego);

    for i:= 1 to 16 do
    writeln(MazoJuego[i].numero, ' De ', NombrePalos[MazoJuego[i].palo]);
    writeln;
    writeln('----------------------------------------------------------------');
    writeln;

    Repartir(MazoJuego,CartasP1,CartasP2,CartasP3,CartasP4);
    for i:=1 to 4 do
    {Escribimos que carta le toca a cada jugador}
    begin
      writeln('Cartas ',i  ,' P1');
      writeln(CartasP1[i].numero, ' De ', NombrePalos[CartasP1[i].palo]);
      writeln('Cartas ',i  ,' P2');
      writeln(CartasP2[i].numero, ' De ', NombrePalos[CartasP2[i].palo]);
      writeln('Cartas ',i  ,' P3');
      writeln(CartasP3[i].numero, ' De ', NombrePalos[CartasP3[i].palo]);
      writeln('Cartas ',i  ,' P4');
      writeln(CartasP4[i].numero, ' De ', NombrePalos[CartasP4[i].palo]);
    end;

  {Falta aplicar movimiento de juego del chancho va e interactividad con whiles y centinelas.}
end.