# Evidencia EV02 — Construcción de módulo web (Servlets + JSP)
**Autor:** (tu nombre)  
**Grupo:** GA7-220501096  
**Fecha:** 2025-08-25

## Objetivo
Demostrar un módulo web con Servlets (GET/POST), vistas JSP y sesión.

## Entorno y ejecución
- JDK 17, Maven 3.8+, Tomcat 10.1
- Compilación: mvn clean package
- Despliegue: copiar .war a TOMCAT/webapps/

## Casos de prueba
| ID | Nombre             | Pasos                                       | Datos              | Resultado esperado                         | Evidencia                |
|----|--------------------|---------------------------------------------|--------------------|--------------------------------------------|--------------------------|
| TC-01 | GET /register   | Abrir /register                           | -                  | Se muestra egistro.jsp                   | 01_register_get.png      |
| TC-02 | POST /register  | Completar formulario y enviar               | nombre,email,pass  | Mensaje “registro exitoso”, vuelve a login  | 02_register_post_ok.png  |
| TC-03 | GET /login      | Abrir /login                              | -                  | Se muestra login.jsp                      | 03_login_get.png         |
| TC-04 | POST /login     | Ingresar credenciales y enviar              | email,pass         | Redirige a dashboard.jsp con sesión       | 04_login_post_ok.png     |
| TC-05 | Dashboard       | Entrar a dashboard.jsp con sesión activa  | -                  | Muestra dashboard                           | 05_dashboard.png         |
| TC-06 | Logout          | Ir a /logout                              | -                  | Sesión cerrada, vuelve a login              | 06_logout.png            |

## Estándares
Se aplican los estándares definidos en EV01 (adjuntar PDF en docs/).

## Conclusión
El módulo cumple el flujo básico y la rúbrica de EV02.