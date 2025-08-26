<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ page contentType="text/html; charset=UTF-8" %>


    <!DOCTYPE html>
    <html lang="es">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Registro - Prometheus</title>

      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/reset.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/variables.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/components.css">
      <link rel="stylesheet" href="<%=request.getContextPath()%>/css/responsive.css">

      <style>
        .register-container {
          min-height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
          padding: var(--spacing-lg, 24px);
        }

        .register-card {
          width: 100%;
          max-width: 400px;
          text-align: center;
        }

        form {
          text-align: left;
        }

        .form-group {
          margin-bottom: var(--spacing-md, 16px);
        }

        label {
          display: block;
          font-weight: 500;
          margin-bottom: .5rem;
        }

        .form-control {
          width: 100%;
          padding: .5rem;
          font-size: 1rem;
          border: 1px solid #ccc;
          border-radius: var(--border-radius-sm, 10px);
        }

        .btn {
          width: 100%;
          padding: .75rem;
          background: var(--primary-color, #4b6bfb);
          color: #fff;
          border: 0;
          border-radius: var(--border-radius-sm, 10px);
          font-size: 1rem;
          font-weight: 600;
          cursor: pointer;
          margin-top: var(--spacing-lg, 24px);
        }

        .btn:hover {
          background: var(--primary-color-dark, #004080);
        }

        p {
          text-align: center;
          margin-top: var(--spacing-lg, 24px);
        }

        p a {
          color: orange;
          text-decoration: none;
          font-weight: 600;
        }

        p a:hover {
          text-decoration: underline;
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
      <div class="register-container">
        <div class="register-card">
          <h1>Crear cuenta</h1>

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

                      <form action="<%=request.getContextPath()%>/register" method="post">
                        <div class="form-group">
                          <label for="name">Nombre completo</label>
                          <input type="text" id="name" name="name" class="form-control" required />
                        </div>

                        <div class="form-group">
                          <label for="email">Correo electrónico</label>
                          <input type="email" id="email" name="email" class="form-control" required />
                        </div>

                        <div class="form-group">
                          <label for="password">Contraseña</label>
                          <input type="password" id="password" name="password" class="form-control" required />
                        </div>

                        <button type="submit" class="btn">Registrarse</button>
                      </form>

                      <p>¿Ya tienes cuenta? <a href="<%=request.getContextPath()%>/login">Inicia sesión</a></p>
        </div>
      </div>
    </body>

    </html>