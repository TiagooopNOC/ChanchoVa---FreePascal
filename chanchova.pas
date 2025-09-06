program ChanchoVa;

// 4 cartas mismo numero para ganar 1,2,3,4
type
Palos = (Espada, Oro, Copa, Basto);  // Los 4 palos.

TCarta = record
numero:integer;
palo:palos; 
end;

TMazo = array [1..16] of TCarta;

var
i:integer;
p:integer;
MazoJuego:TMazo;

CartasP1: array [1..4] of TCarta;

CartasP2: array [1..4] of TCarta;

CartasP3: array [1..4] of TCarta;

CartasP4: array [1..4] of TCarta;


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

procedure Barajar(Mazo:TMazo);
var
i,j:integer;
temp:TCarta;
begin
  randomize;
  for i:= 1 to 16 do
  begin
    Mazo[i]
  end;
end;

{function CartaEnUso(CartasP:TCarta):boolean;
var i:integer;
}

{procedure RepartirCartas(var CartasP:TCarta; var Mazo);
var i,j:integer;
begin
  for i:=1 to  4 do
    begin
      randomize;
      CartasP[i].numero:= (random(4) + 1);

    end;
end;}

begin
    randomize;
    LlenarMazo(MazoJuego);
    for i:= 1 to 4 do
        for p:= 1 to 4 do
        begin
        writeln(MazoJuego[i].numero,' ', MazoJuego[p].palo);
        end;
end.