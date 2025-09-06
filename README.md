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
