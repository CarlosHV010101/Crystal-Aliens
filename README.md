¡Hola! Aquí te proporciono una plantilla básica para crear un archivo README:

# Crystal Aliens 🚀

Este repositorio contiene un videojuego tipo Arcade, tomando como base los famosos Galaga y Space Invaders.

## Comenzando

"Crystal Aliens" es un emocionante juego para móvil en el que el jugador asume el papel de un explorador espacial que debe luchar contra una invasión alienígena para salvar la galaxia. El juego está desarrollado con la tecnología Sprite Kit de Apple, lo que permite una experiencia de juego fluida y envolvente.

### Prerrequisitos

- Un dispositivo con sistema operativo iOS 9.0 o superior.
- Xcode 9 o superior instalado en la máquina.
- Una cuenta de desarrollador de Apple para poder crear un perfil de aprovisionamiento y firmar la aplicación.
- Conocimientos básicos de programación en Swift y Sprite Kit.
- El código fuente del juego, disponible en un repositorio en línea como GitHub.
- La capacidad de descargar y compilar el código fuente del juego utilizando Xcode.
- Una conexión a Internet para descargar las dependencias necesarias.
- Un entorno de prueba de iOS, como un simulador o un dispositivo físico, para ejecutar el juego y realizar pruebas.

### Instalación

Pasos a seguir para instalar el software.

1. Clona el repositorio del juego desde GitHub o descarga el código fuente en formato ZIP.
2. Abre Xcode en tu máquina y selecciona "Abrir proyecto".
3. Navega hasta la carpeta donde has descargado el código fuente del juego y selecciona el archivo de proyecto con extensión .xcodeproj.
4. En el menú desplegable de Xcode, selecciona el esquema de compilación para el juego y elige el entorno de ejecución (por ejemplo, un simulador de iOS o un dispositivo físico conectado).
5. Haz clic en el botón "Ejecutar" o presiona Cmd + R para compilar el proyecto y ejecutar el juego.
6. Si todo va bien, el juego se ejecutará en el entorno de prueba que has elegido y podrás comenzar a jugar.

## Construido con

* [Sprite Kit] - (https://developer.apple.com/spritekit/)
* [Swift 5.7] - (https://www.swift.org/documentation/)

## Autor

Carlos Hernández Vázquez -  Desarrollador  

## Sprites 

Los Sprites fueron construidos a base imágenes para mostrar la nave del jugador, las naves enemigas, las balas, y las explosiones por colisión.

## Gameplay 

El juego consiste en una nave que va navegando por el espacio mientras pelea con naves enemigas las cuales comienzan a aparecer de forma repentina aumentando el tiempo en el que aparecen y la velocidad con la que se dirigen. El jugador solo cuenta con 3 vidas en caso de ser colisionado por una nave enemiga. En caso de que una nave pase de largo por la pantalla y el jugador no logre impactarla el juego será terminado. 

https://youtube.com/shorts/rl3PjtcP348?feature=share

## Interfaz 

Inicio: permite al jugador iniciar una nueva partida o ver los puntajes más altos 

![IMG_3171](https://user-images.githubusercontent.com/100322385/234654762-034a45b2-6feb-4352-9c35-a62f321e062f.PNG)

Gameplay: 

![IMG_3172](https://user-images.githubusercontent.com/100322385/234654978-7cf4f8fc-a75f-4e05-a32a-e6c21029b6f4.PNG)


Fin del juego: muestra el score del jugador, el score más alto y permite volver a comenzar 

![IMG_3175](https://user-images.githubusercontent.com/100322385/234655196-500db49c-153b-4013-aa96-460696666565.PNG)

High Score: cuando el jugador establece un nuevo record se le solicita un nombre con 5 letras 

![IMG_3174](https://user-images.githubusercontent.com/100322385/234655381-008e0b31-7046-41b9-801d-dff9191a5334.PNG)

High Score: al entrar a la pantalla de los High Scores aparece el nombre guardado 

![IMG_3175](https://user-images.githubusercontent.com/100322385/234655702-910e1d77-0026-47bb-b844-0c304b8424bb.PNG)


