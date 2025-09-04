<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="com.prometheus.web.model.Alquiler" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="com.prometheus.web.model.Inquilino" %>
<%@ page import="com.prometheus.web.model.Property" %>
<%
  String ctx = request.getContextPath();
  Alquiler item = (Alquiler) request.getAttribute("item"); // null => crear
  boolean editing = (item != null);
%>
<%
    List<Inquilino> inquilinos = (List<Inquilino>) request.getAttribute("inquilinos");
    if (inquilinos == null) inquilinos = Collections.emptyList();
    long selInquilinoId = 0L;
    if (request.getAttribute("item") != null) {
        selInquilinoId = ((com.prometheus.web.model.Alquiler)request.getAttribute("item")).getInquilinoId();
    }
%>
<%
    List<Property> propiedades = (List<Property>) request.getAttribute("propiedades");
    if (propiedades == null) propiedades = Collections.emptyList();
    long selPropiedadId = 0L;
    if (request.getAttribute("item") != null) {
        selPropiedadId = ((com.prometheus.web.model.Alquiler)request.getAttribute("item")).getPropiedadId();
    }
%>

<c:set var="title" value="Alquileres"/>
<c:set var="active" value="alquileres"/>
<%@ include file="/WEB-INF/jspf/layout-crear-start.jspf" %>

<form id="f" method="post" action="<%=ctx%>/alquileres/guardar">
          <input type="hidden" name="id" value="<%= editing ? item.getId() : 0 %>">
          <% if (!editing) { %><input type="hidden" id="again" name="again" value=""><% } %>

          <div style="display:grid;grid-template-columns:1fr 1fr;gap:var(--spacing-lg);margin-bottom:var(--spacing-lg);">
            <!-- Fila 1: Fecha inicio / Cantidad de meses -->
            <div class="form-group">
              <label class="form-label" for="fechaInicio">Fecha inicio</label>
              <input type="date" id="fechaInicio" name="fechaInicio" class="form-control"
                     value="<%= editing && item.getFechaInicio()!=null ? item.getFechaInicio().toString() : "" %>" required>
            </div>
          
            <div class="form-group">
              <label class="form-label" for="meses">Cantidad de meses</label>
              <input type="number" id="meses" name="meses" class="form-control" min="1" step="1"
                     value="<%= editing ? item.getMeses() : "" %>" required>
            </div>
          
            <!-- Fila 2: Fecha fin / Monto mensual -->
            <div class="form-group">
              <label class="form-label" for="fechaFin">Fecha fin</label>
              <input type="date" id="fechaFin" name="fechaFin" class="form-control"
                     value="<%= editing && item.getFechaFin()!=null ? item.getFechaFin().toString() : "" %>">
            </div>
          
            <div class="form-group">
              <label class="form-label" for="montoMensual">Monto mensual</label>
              <input type="number" id="montoMensual" name="montoMensual" class="form-control" min="0" step="0.01"
                     value="<%= editing ? item.getMontoMensual() : "" %>" required>
            </div>
          
            <!-- Fila 3: Número de personas / Inquilinos -->
            <div class="form-group">
              <label class="form-label" for="personas">Número de personas</label>
              <input type="number" id="personas" name="personas" class="form-control" min="1" step="1"
                     value="<%= editing ? item.getPersonas() : "" %>">
            </div>
          
            <div class="form-group">
              <label class="form-label" for="inquilinoId">Inquilinos</label>
              <select id="inquilinoId" name="inquilinoId" class="form-control" required>
                <option value="">Seleccionar…</option>
                <% for (Inquilino inq : inquilinos) { %>
                  <option value="<%= inq.getId() %>"
                          <%= (selInquilinoId == inq.getId()) ? "selected" : "" %>>
                    <%= inq.getNombre() %> (<%= inq.getDocumento() %>)
                  </option>
                <% } %>
              </select>
            </div>
          
            <!-- Fila 4: ¿Está activo? / Contrato -->
            <div class="form-group">
              <label class="form-label" for="activo">¿Está activo?</label>
              <select id="activo" name="activo" class="form-control">
                <option value="">Seleccionar…</option>
                <option value="si" <%= editing && item.isActivo() ? "selected" : "" %>>Sí</option>
                <option value="no" <%= editing && !item.isActivo() ? "selected" : "" %>>No</option>
              </select>
            </div>
          
            <div class="form-group">
              <label class="form-label" for="contrato">Contrato</label>
              <input type="text" id="contrato" name="contrato" class="form-control"
                     value="<%= editing && item.getContrato()!=null ? item.getContrato() : "" %>">
            </div>
          
            <!-- Fila 5: Propiedad (ancho completo) -->
            <div class="form-group" style="grid-column: 1 / -1;">
              <label class="form-label" for="propiedadId">Propiedad</label>
              <select id="propiedadId" name="propiedadId" class="form-control" required>
                <option value="">Seleccionar…</option>
                <% for (Property p : propiedades) { %>
                  <option value="<%= p.getId() %>"
                    <%= (selPropiedadId == p.getId()) ? "selected" : "" %>>
                    <%= p.getNombre() %> — <%= p.getDireccion() %>
                  </option>
                <% } %>
              </select>
            </div>
          
<%@ include file="/WEB-INF/jspf/layout-crear-end.jspf" %>
