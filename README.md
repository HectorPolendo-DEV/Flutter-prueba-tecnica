# Prueba Tecnica Flutter
### Este proyecto fue desarrollado como parte de una prueba técnica.

### Módulo de Búsqueda (Unsplash API)
- Permite buscar imágenes desde la API de [Unsplash](https://unsplash.com/developers).
- Implementación del consumo de API usando **Dio**.
- Manejo de excepciones personalizadas
- Paginación automática (scroll infinito).

### Módulo de Lista de Tareas (To-Do)
- Agregar, eliminar y marcar tareas como completadas.
- Persistencia local utilizando **Hive**.
- Sincronización entre UI y base de datos en tiempo real.

### Módulo de Propinas (Tips)
- Calcula el monto de propina según porcentaje o cantidad personalizada.
- Animaciones fluidas con **AnimatedSwitcher**.
- Cálculo dinámico en tiempo real.

## Arquitectura del proyecto
- Clean Architecture + MVVM
- Gestión de estado: Provider  
- Cliente HTTP: Dio
- Persistencia local: Hive

## ⚙️ Configuración del entorno (.env)

El proyecto usa el paquete [`flutter_dotenv`](https://pub.dev/packages/flutter_dotenv)  
para manejar las claves de API de forma segura.

### 🧩 Paso 1: Crear el archivo `.env` en la raíz del proyecto
Ejemplo: UNSPLASH_KEY=tu_access_key_aquí

### 🧩 Paso 2: Cargar las variables

En `main.dart` ya está configurado:

```dart
void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
