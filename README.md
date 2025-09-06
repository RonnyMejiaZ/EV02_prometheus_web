# EV02 - Módulo Web (Servlets + JSP)
## Requisitos: JDK 17, Maven 3.8+, Tomcat 10.1
### Ejecutar
mvn clean package
# Copia target/prometheus-web.war a TOMCAT/webapps/
# Abre http://localhost:8080/prometheus-web-1.0.0/
### Flujo probado
- GET /register -> mostrar formulario
- POST /register -> registro OK, vuelve a login con mensaje
- GET /login -> formulario
- POST /login -> dashboard con sesión
- GET /logout -> cierre de sesión
- GET /inquilinos/listar -> ver listado
- GET /inquilinos/crear -> mostrar formulario
- POST /inquilinos/guardar -> crear OK, 302 → /inquilinos/listar
- POST /inquilinos/guardar (con id) -> actualizar OK, 302 → /inquilinos/listar
- POST /inquilinos/eliminar -> eliminar OK, 302 → /inquilinos/listar
- GET /propiedades/listar -> ver listado
- GET /propiedades/crear -> mostrar formulario
- POST /propiedades/guardar -> crear OK, 302 → /propiedades/listar
- POST /propiedades/guardar (con id) -> actualizar OK, 302 → /propiedades/listar
- POST /propiedades/eliminar -> eliminar OK, 302 → /propiedades/listar
- GET /alquileres/listar -> ver listado
- GET /alquileres/crear -> mostrar formulario
- POST /alquileres/guardar -> crear OK (requiere inquilinoId y propiedadId), 302 → /alquileres/listar
- POST /alquileres/guardar (con id) -> actualizar OK, 302 → /alquileres/listar
- POST /alquileres/eliminar -> eliminar OK, 302 → /alquileres/listar
- GET /pagos/listar -> ver listado
- GET /pagos/crear -> mostrar formulario
- POST /pagos/guardar -> crear OK, 302 → /pagos/listar
- POST /pagos/guardar (con id) -> actualizar OK, 302 → /pagos/listar
- POST /pagos/eliminar -> eliminar OK, 302 → /pagos/listar
- GET /perfil/listar -> ver datos del perfil
- GET /perfil/crear -> mostrar formulario
- POST /perfil/guardar -> crear/actualizar OK, 302 → /perfil/listar
- POST /perfil/eliminar -> eliminar OK, 302 → /perfil/listar
- GET /dashboard -> métricas con sesión
- GET /dashboard?activo=1 -> métricas solo con alquileres activos
- GET /dashboard?activo=0 -> métricas solo con alquileres inactivos
- GET /dashboard?fi=yyyy-MM-dd -> filtrar por fecha de inicio exacta
- GET /dashboard?ff=yyyy-MM-dd -> filtrar por fecha de fin exacta
- GET /dashboard?activo=1&fi=yyyy-MM-dd&ff=yyyy-MM-dd -> filtros combinados
