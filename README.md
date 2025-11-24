### Informe Completo del Prototipo de la Aplicación "Uniprimera Respuesta"

#### 1. Presentación de la Aplicación, su Objetivo y su Utilidad

La aplicación "Uniprimer Respuesta" es un prototipo desarrollado en Flutter (framework cross-platform de Google) diseñado para facilitar la respuesta rápida a emergencias en entornos institucionales, como universidades o empresas. Su objetivo principal es permitir a los usuarios reportar incidentes de emergencia de manera sencilla y eficiente, enviando información crítica a los servicios de respuesta (por ejemplo, a través de un correo electrónico con datos estructurados en JSON) y activando una llamada automática a un número de extensión interna (88888).

Esta aplicación es particularmente útil en contextos donde la rapidez y la precisión son esenciales, como en campus universitarios (inspirado en la Universidad Nacional de Colombia). Permite a los usuarios anónimos o identificados alertar sobre emergencias como accidentes eléctricos, químicos, quemaduras o otros, incluyendo detalles vitales como la localización GPS y el estado de la víctima. Su utilidad radica en:
- **Reducción del tiempo de respuesta**: Automatiza el envío de datos y la llamada, evitando demoras en comunicación manual.
- **Privacidad y seguridad**: Utiliza datos sensibles (como localización) solo para emergencias, con persistencia local de información personal para reutilización.
- **Accesibilidad**: Interfaz simple y en español, compatible con Android (y potencialmente iOS).
- **Escalabilidad**: Fácil integración con servidores backend para notificaciones push o bases de datos.

En resumen, "Uniprimer Respuesta" empodera a los usuarios para actuar como primeros respondedores, potenciando la seguridad colectiva en entornos educativos o laborales.

#### 2. Explicación de las Funcionalidades Presentes

El prototipo actual incluye las siguientes funcionalidades clave, implementadas para un flujo completo de reporte de emergencias. A continuación, se describe cada una, dejando espacio para insertar capturas de pantalla o fotos del prototipo en acción.

- **Pantalla de Inicio (Ingreso de Datos Personales)**: Al abrir la app, el usuario ingresa su primer nombre, apellido y número de documento de identidad. Estos datos se guardan localmente (usando `shared_preferences`) para autocompletar en usos futuros, evitando repetir información. Obliga a aceptar condiciones de uso y permisos de localización GPS la primera vez.  
  [Espacio para foto: Captura de la pantalla de inicio con campos de texto y botón "Continuar"].

- **Botón de Emergencia Principal**: Una interfaz simple con un botón rojo grande (imagen asset `buton.png`) que, al tocarse, lleva directamente a la selección de tipo de emergencia. No hay cuenta regresiva para simplicidad y rapidez.  
  [Espacio para foto: Captura del botón de emergencia con logo y notificaciones].

- **Selección de Tipo de Emergencia**: El usuario elige entre "Electricidad", "Químico", "Quemadura" o "Otro". Para "Otro", se abre una subpantalla con opciones adicionales (Caídas, Afección Cardíaca, Psicológicas, Pérdida de conciencia, Intoxicación por sustancias).  
  [Espacio para foto: Captura de la lista de tipos de emergencia con iconos].

- **Cuestionario Rápido**: Después de seleccionar el tipo, un cuestionario interactivo:  
  - Primera pregunta: "¿Soy yo la persona que tiene una emergencia?".  
  - Si "Sí": Directo a descripción (campo de texto limitado a 100 palabras).  
  - Si "No": Preguntas vitales secuenciales ("¿Respira?", "¿Está inconsciente?", "¿Responde de manera coherente?"). Si "Sí" a cualquiera, salta al resto y va a descripción.  
  - Obliga acceso a localización GPS (si denegado, bloquea envío).  
  [Espacio para foto: Captura del cuestionario con botones Sí/No y campo de descripción].

- **Envío del Reporte y Llamada Automática**: Construye un JSON con datos (ponente, identidad, tipo, respuestas, descripción, localización). Envía vía POST HTTP al servidor (ej.: Localtunnel o IP). Si éxito (status 200), llama automáticamente al número "6013165000,88888" (vía `url_launcher`).  
  [Espacio para foto: Captura de la confirmación de envío].

- **Pantalla de Confirmación**: Muestra éxito con resumen (tipo, reportador, víctima), mensaje de gracias y botón "Volver al inicio".  
  [Espacio para foto: Captura de la pantalla de confirmación].

- **Otras**: Assets (logo, botón), persistencia datos, navegación fluida.

#### 3. Funcionalidades No Implementadas pero Deseadas para Futuras Iteraciones

Si el proyecto es seleccionado para avanzar, planeamos agregar las siguientes funcionalidades para hacer la app más robusta y completa. Estas están en fase de diseño y requieren recursos adicionales (desarrollo, testing, integración).

- **Integración con Servicios de Emergencia Reales**: Conexión con APIs de servicios de emergencia locales (ej.: bomberos, policía en Colombia) para el envío automático de alertas, incluyendo mapas interactivos (a través de Google Maps API).
- **Notificaciones Push**: Usando Firebase Cloud Messaging para notificar a administradores o usuarios cercanos de una emergencia en tiempo real.
- **Autenticación y Perfiles**: Login con correo UNAL o Google, perfiles con historial de reportes, para usuarios registrados (en vez de anónimos).
- **Multimedia en Reportes**: Adjuntar fotos/vídeos de la escena (usando camera plugin), y análisis básico de IA (por ejemplo: detectar gravedad usando ML Kit).
- **Soporte iOS y Multidispositivos**: Optimización para iOS (Apple Maps para localización), y versión web/escritorio.
- **Análisis de Datos**: Dashboard backend para estadísticas de emergencias (por ejemplo: mapas de calor de incidentes).
- **Multilengua y Accesibilidad**: Soporte de inglés/francés, voice-to-text para descripción, modo oscuro.
- **Seguridad Avanzada**: Encriptación de datos (HTTPS obligatorio), cumplimiento GDPR para datos sensibles.

Estas adiciones transformarían el prototipo en una solución completa, escalable para instituciones.

#### 4. Instrucciones para Instalar y Ejecutar el Prototipo desde GitHub

El repositorio está disponible en GitHub (asumiendo URL: https://github.com/TonUsername/Uniprimera_Repuesta). Sigue estos pasos para clonar, instalar y ejecutar. Requiere Flutter instalado (https://flutter.dev/install). Dos opciones: emulador (PC) o teléfono real (Android).

**Requisitos Comunes**:  
- Instala Flutter (versión ≥3.9.2).  
- Git para clonar.  
- Terminal para comandos.

**Etapa 1 : Clonar el Repositorio**  
```bash
git clone https://github.com/Paulito1546/Uniprimera_Repuesta.git
cd Uniprimera_Repuesta
flutter pub get  # Instala dependencias (http, geolocator, etc.)
```

**Opción 1 : Ejecutar en emulador (en PC)**  
Ideal para pruebas rápidas, sin teléfono.  
1. Lanza emulador: `flutter emulators --launch ton_emulador` (ej.: pixel_6_api_33).  
2. Ejecuta app: `flutter run`.  
3. Prueba: La app se abre en emulador. Para envío de correo, inicia tu servidor local (`node server.js`) y Localtunnel/Ngrok (como antes) para URL pública.  
[Espacio para foto: Captura del emulador con la app en ejecución].

**Opción 2 : Ejecutar en Teléfono Real (Android)**  
Para pruebas reales (localización GPS, llamada).  
1. Activa "Modo Desarrollador": Ajustes > Acerca de > Toca 7 veces "Número de compilación".  
2. Activa "Depuración USB" y conecta teléfono vía USB.  
3. Construye APK: `flutter build apk --release` (genera `build/app/outputs/flutter-apk/app-release.apk`).  
4. Transfiere APK al teléfono (por USB/email) e instala (activa "Fuentes desconocidas" si es necesario).  
5. Lanza app. Para envío, asegura servidor + Localtunnel iniciado en PC.  
[Espacio para foto: Captura del teléfono con la app instalada].

**Solución de problemas**: Si el envío falla, verifica la URL del servidor en código y que Localtunnel esté activo. Para iOS, añade configuración Xcode (no implementado por ahora).

