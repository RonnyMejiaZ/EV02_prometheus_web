<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="com.prometheus.web.model.Inquilino" %>
<%
  String ctx = request.getContextPath();
  Inquilino item = (Inquilino) request.getAttribute("item"); // null => crear
  boolean editing = (item != null);
%>
<c:set var="title" value="Inquilinos"/>
<c:set var="active" value="inquilinos"/>
<%@ include file="/WEB-INF/jspf/layout-crear-start.jspf" %>

<form id="f" method="post" action="<%=ctx%>/inquilinos/guardar">
          <input type="hidden" name="id" value="<%= editing ? item.getId() : 0 %>">
          <% if (!editing) { %><input type="hidden" id="again" name="again" value=""><% } %>

          <div style="display:grid;grid-template-columns:1fr 1fr;gap:var(--spacing-lg);margin-bottom:var(--spacing-lg);">
            <div class="form-group">
              <label class="form-label" for="nombre">Nombre</label>
              <input type="text" id="nombre" name="nombre" class="form-control"
                     value="<%= editing && item.getNombre()!=null ? item.getNombre() : "" %>" required>
            </div>

            <div class="form-group">
              <label class="form-label" for="documento">Documento</label>
              <input type="text" id="documento" name="documento" class="form-control"
                     value="<%= editing && item.getDocumento()!=null ? item.getDocumento() : "" %>" required>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="telefono">Teléfono</label>
            <input type="text" id="telefono" name="telefono" class="form-control"
                   value="<%= editing && item.getTelefono()!=null ? item.getTelefono() : "" %>" required>
          </div>
          
<%@ include file="/WEB-INF/jspf/layout-crear-end.jspf" %>
