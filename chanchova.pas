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