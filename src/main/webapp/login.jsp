<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page contentType="text/html; charset=UTF-8" %>


    <!DOCTYPE html>
    <html lang="es">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Login - Prometheus</title>

      <!-- Tus hojas reales; déjalas o cambia nombres según tu proyecto -->
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/variables.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/components.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/layout.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/responsive.css">

      <!-- (Opcional) estilos de la pantalla: muévelos a components.css si prefieres -->
      <style>
        .login-container {
          min-height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
          padding: var(--spacing-lg, 24px);
        }

        .login-card {
          width: 100%;
          max-width: 400px;
          text-align: center;
        }

        .login-header {
          margin-bottom: var(--spacing-2xl, 48px);
        }

        .login-logo {
          width: 60px;
          height: 60px;
          background: var(--primary-color, #4b6bfb);
          border-radius: var(--border-radius-lg, 16px);
          display: flex;
          align-items: center;
          justify-content: center;
          font-size: var(--font-size-xl, 24px);
          font-weight: 700;
          color: #fff;
          margin: 0 auto var(--spacing-md, 12px);
        }

        .login-title {
          font-size: var(--font-size-2xl, 28px);
          font-weight: 600;
          margin-bottom: var(--spacing-sm, 8px);
        }

        .login-subtitle {
          color: var(--text-secondary, #6b7280);
        }

        .login-form {
          text-align: left;
        }

        .form-group {
          margin-bottom: 12px;
        }

        .form-label {
          display: block;
          font-size: 14px;
          margin-bottom: 6px;
          color: #374151;
        }

        .form-control {
          width: 100%;
          padding: 12px 14px;
          border: 1px solid #ddd;
          border-radius: 12px;
        }

        .login-footer {
          margin-top: var(--spacing-lg, 24px);
          text-align: center;
          color: var(--text-secondary, #6b7280);
        }

        .login-footer a {
          color: var(--primary-color, #4b6bfb);
        }

        .login-btn {
          width: 100%;
          margin-top: var(--spacing-lg, 24px);
          background: var(--primary-color, #4b6bfb);
          color: #fff;
          padding: .75rem;
          border: 0;
          border-radius: var(--border-radius-lg, 16px);
          font-size: var(--font-size-md, 16px);
          font-weight: 700;
          cursor: pointer;
          transition: background-color .3s ease;
        }

        .login-btn:hover {
          background: var(--primary-color-dark, #004080);
        }

        .error {
          color: #b91c1c;
          margin-bottom: 8px;
        }

        .ok {
          color: #166534;
          margin-bottom: 8px;
        }
      </style>
    </head>

    <body>
      <div class="login-container">
        <div class="login-card">

          <div class="login-header">
            <div class="login-logo">P</div>
            <h1 class="login-title">PROMETHEUS</h1>
            <p class="login-subtitle">Sistema de Gestión de Alquileres</p>
          </div>

          <% if (request.getAttribute("error") !=null) { %>
            <p class="error">
              <%= request.getAttribute("error") %>
            </p>
            <% session.removeAttribute("error"); %>
              <% } %>
                <% if (request.getAttribute("msg") !=null) { %>
                  <p class="ok">
                    <%= request.getAttribute("msg") %>
                  </p>
                  <% session.removeAttribute("msg"); %>
                    <% } %>

                      <!-- AHORA el formulario va al Servlet /login (POST) -->
                      <form class="login-form" action="<%=request.getContextPath()%>/login" method="post">
                        <div class="form-group">
                          <label class="form-label" for="email">Correo electrónico</label>
                          <input type="email" id="email" name="email" class="form-control" required />
                        </div>

                        <div class="form-group">
                          <label class="form-label" for="password">Contraseña</label>
                          <input type="password" id="password" name="password" class="form-control" required />
                        </div>

                        <button type="submit" class="login-btn">Iniciar sesión</button>
                      </form>

                      <div class="login-footer">
                        <!-- Enlace correcto usando el contexto y el Servlet /register -->
                        <p>¿No tienes cuenta? <a href="<%=request.getContextPath()%>/register">Regístrate aquí</a></p>
                      </div>
        </div>
      </div>

      <script src="<%=request.getContextPath()%>/js/modals.js"></script>
      <script src="<%=request.getContextPath()%>/js/navigation.js"></script>
    </body>

    </html>