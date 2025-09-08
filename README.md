
# 🐷 ChanchoVa — Free Pascal

Un proyecto en **Free Pascal** que implementa el clásico juego **“Chancho Va”**, versión simplificada:  
- 4 jugadores (1 humano + 3 IAs ).  
- Objetivo: ser el primero en juntar **4 cartas del mismo número**.  
- Cada ronda, cada jugador entrega **una carta al de la derecha**.  
- Se detecta automáticamente el ganador y se muestra la mano final.  

---

## 🎮 Características
- Mazo de **16 cartas** (1 a 4 de cada palo: Espada, Oro, Copa, Basto).  
- **Barajado justo** usando el algoritmo de Fisher–Yates.  
- **Reparto inicial** de 4 cartas por jugador.  
- Lógica de IAs que deciden qué carta descartar.  
- Posibilidad de partidas muy largas (pero con detección de ciclos / desempates aleatorios para evitarlo).  
- Salida por consola con manos y resultado final.  

---

## 🛠️ Tecnologías
- Lenguaje: **Free Pascal (FPC)**.  
- Estilo estructurado (uso de `record`, `array`, `procedure`, `function`).  
- Probado en:  
  - Windows con **fpc 3.2.x**  
  - (Debería compilar también en Linux y macOS con FPC).  

---

## 🗂️ Estructura del proyecto
Chanchova---Freepascal/
-chanchova.pas #Programa principal.
-Readme.MD #Este archivo.
-.gitignore #Ignora binarios(*.exe, *.o, etc).

## 📦 Instalación y ejecución
1. Cloná el repositorio:
   ```bash
   git clone https://github.com/TiagooopNOC/ChanchoVa---FreePascal.git
   cd ChanchoVa---FreePascal
   fpc chanchova.pas
   ./chanchova    # en Linux/Mac
   chanchova.exe  # en Windows


## ▶️ Uso
Al ejecutar:
 - Se baraja el mazo
 - Se reparten 4 cartas a cada jugador.
 - Se iteran rondas: Cada jugador entrega 1  carta a la derecha.
 - Tras cada ronda se chequea si algun jugador  ganó. (Acumulando 4 cartas del mismo numero)
 -  Se imprimen manos por ronda y el resultado   final.

## 🖨️ Ejemplo de Salida
```bash
--- Mano Jugador 1 ---
  2 de Espada
  3 de Copa
  1 de Oro
  4 de Basto
--- Mano Jugador 2 ---
  1 de Espada
  2 de Basto
  4 de Copa
  3 de Oro
...

Ganador: Jugador 3 en la ronda 27!
```
## 🗺️ Roadmap
- Interactividad: 1 humano + 3 IAs (pedir índice 1..4 con readln y validar).
- IA con desempate aleatorio y/o heurísticas alternativas.
 - Detector de ciclos y regla de anti-estancamiento.
 - Versión gráfica con Lazarus/GUI.
 - Tests simples de barajado y reparto.

## 🤝 Contribuir
- Hacé un fork y creá una rama: git checkout -b feature/mi-mejora
- Commit chico y claro: git commit -m "Explico qué cambié" (Con seguir mis commits esta bien)
- Push y PR.

- Convenciones:  Mantener nombres en español (coherentes con el curso).                Procedimientos/funciones cortas, bien comentadas. Evitar globales innecesarias (usar const y var en parámetros).

## 📄 Licencia MIT. 
Hacé lo que quieras, con cariño y dando crédito.

## 👨‍💻 Autor
-Proyecto de práctica para Programación 1 (Ingeniería en Computación).
- Tiago Nocella — @TiagooopNOC

