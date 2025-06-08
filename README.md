# flutter_application_1

🛴 Flutter Self-Balancing Cart App
Esta aplicación Flutter permite controlar un carrito de dos llantas autoestabilizado mediante conexión Bluetooth BLE. El carro cuenta con controladores de posición y velocidad, lo que permite un manejo estable y responsivo desde el celular.

🧩 Características principales
👋 Pantalla de bienvenida simple e intuitiva.

📡 Pantalla de conexión Bluetooth BLE para emparejar con el carrito.

🎮 Pantalla de control por pulsos para manejar la velocidad y dirección del carrito en tiempo real.

⚙️ Compatible con el protocolo Bluetooth transparente.

🔁 Comunicación bidireccional para recibir estado del carro o enviar comandos.

🖼️ Vistas de la aplicación
Pantalla de Bienvenida
Muestra el logo o nombre del proyecto e invita a comenzar la conexión.

Pantalla de Conexión
Escanea dispositivos Bluetooth BLE cercanos y permite emparejarse con el carrito.

Pantalla de Pulsos (Controlador)
Permite al usuario enviar comandos de movimiento y controlar el carrito con precisión gracias al sistema de control de velocidad y posición.

🤖 Sobre el carro
Dos ruedas con diseño autoestabilizado.

Controlador de posición para mantener equilibrio.

Controlador de velocidad para controlar el avance o retroceso.

Compatible con microcontroladores como Arduino o ESP32.

Comunicaciones vía Bluetooth BLE con protocolo transparente.

🛠️ Tecnologías utilizadas
Flutter

Bluetooth Low Energy (BLE)

Librerías Flutter BLE compatibles (flutter_blue, flutter_reactive_ble)

Controladores PID en el microcontrolador para mantener la estabilidad del carro.

🚀 Cómo usar
1. Clona este repositorio.

2. Instala dependencias:

flutter pub get

3. Ejecuta en un dispositivo real (Bluetooth no funciona en simuladores):

flutter run

4. Asegúrate de que el carrito esté encendido y en modo visible para emparejar.

5. Controla el carrito desde la pantalla de pulsos.

📸 Capturas de pantalla



📝 Notas
Se recomienda usar dispositivos Android con BLE habilitado.

Asegúrate de tener permisos de ubicación y Bluetooth activos.
