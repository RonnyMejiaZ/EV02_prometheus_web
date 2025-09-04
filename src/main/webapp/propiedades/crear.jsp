<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="com.prometheus.web.model.Property" %>
<%
  String ctx = request.getContextPath();
  Property item = (Property) request.getAttribute("item"); // null => crear
  boolean editing = (item != null);
%>
<c:set var="title" value="Propiedades"/>
<c:set var="active" value="propiedades"/>
<%@ include file="/WEB-INF/jspf/layout-crear-start.jspf" %>

<form id="f" method="post" action="<%=ctx%>/propiedades/guardar">
          <input type="hidden" name="id" value="<%= editing ? item.getId() : 0 %>">
          <% if (!editing) { %><input type="hidden" id="again" name="again" value=""><% } %>

          <div style="display:grid;grid-template-columns:1fr 1fr;gap:var(--spacing-lg);margin-bottom:var(--spacing-lg);">
            <div class="form-group">
              <label class="form-label" for="nombre">Nombre</label>
              <input type="text" id="nombre" name="nombre" class="form-control"
                     value="<%= editing && item.getNombre()!=null ? item.getNombre() : "" %>" required>
            </div>

            <div class="form-group">
              <label class="form-label" for="direccion">Dirección</label>
              <input type="text" id="direccion" name="direccion" class="form-control"
                     value="<%= editing && item.getDireccion()!=null ? item.getDireccion() : "" %>" required>
            </div>
          </div>

          <div class="form-group">
            <label class="form-label" for="descripcion">Descripción</label>
            <textarea id="descripcion" name="descripcion" class="form-control" rows="4"
              placeholder="Descripción detallada de la propiedad..."><%= editing && item.getDescripcion()!=null ? item.getDescripcion() : "" %></textarea>
          </div>

          <div class="form-group">
            <label class="form-label" for="rentado">¿Está rentado?</label>
            <select id="rentado" name="rentado" class="form-control">
              <option value="">Seleccionar...</option>
              <option value="si" <%= editing && item.isRentado() ? "selected" : "" %>>Sí</option>
              <option value="no" <%= editing && !item.isRentado() ? "selected" : "" %>>No</option>
            </select>
          </div>
          
<%@ include file="/WEB-INF/jspf/layout-crear-end.jspf" %>
