<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="java.util.List, java.util.Collections" %>
<%@ page import="com.prometheus.web.model.Pago" %>
<%@ page import="com.prometheus.web.model.Alquiler" %>
<%@ page import="com.prometheus.web.model.Property" %>

<%
  String ctx = request.getContextPath();
  Pago item = (Pago) request.getAttribute("item"); // null => crear
  boolean editing = (item != null);
%>
<%
    List<Alquiler> alquileres = (List<Alquiler>) request.getAttribute("alquileres");
    if (alquileres == null) alquileres = Collections.emptyList();
    long selAlquilerId = 0L;
    if (request.getAttribute("item") != null) {
        selAlquilerId = ((com.prometheus.web.model.Pago)request.getAttribute("item")).getAlquilerId();
    }
%>

<c:set var="title" value="Pagos"/>
<c:set var="active" value="pagos"/>
<%@ include file="/WEB-INF/jspf/layout-crear-start.jspf" %>

<form id="f" method="post" action="<%=ctx%>/pagos/guardar">

          <input type="hidden" name="id" value="<%= editing ? item.getId() : 0 %>">
          <% if (!editing) { %><input type="hidden" id="again" name="again" value=""><% } %>

          <div style="display:grid;grid-template-columns:1fr 1fr;gap:var(--spacing-lg);margin-bottom:var(--spacing-lg);">

            <div class="form-group">
              <label class="form-label" for="fechaPago">Fecha de pago</label>
              <input type="date" id="fechaPago" name="fechaPago" class="form-control"
                     value="<%= editing && item.getFechaPago()!=null ? item.getFechaPago().toString() : "" %>" required>
            </div>
        
            <div class="form-group">
              <label class="form-label" for="montoMensual">Monto mensual</label>
              <input type="number" id="montoMensual" name="montoMensual" class="form-control" min="0" step="0.01"
                     value="<%= editing ? item.getMontoMensual() : "" %>" required>
            </div>
          
            <div class="form-group">
              <label class="form-label" for="alquilerPago">¿Alquiler pago?</label>
              <select id="alquilerPago" name="alquilerPago" class="form-control">
                <option value="">Seleccionar…</option>
                <option value="si" <%= editing && item.isAlquilerPago() ? "selected" : "" %>>Sí</option>
                <option value="no" <%= editing && !item.isAlquilerPago() ? "selected" : "" %>>No</option>
              </select>
            </div>
          
            <div class="form-group">
              <label class="form-label" for="compAlquiler">Comprobante alquiler</label>
              <input type="text" id="compAlquiler" name="compAlquiler" class="form-control"
                     value="<%= editing && item.getCompAlquiler()!=null ? item.getCompAlquiler() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="reciboAgua">Recibo del agua pago</label>
              <input type="text" id="reciboAgua" name="reciboAgua" class="form-control"
                     value="<%= editing && item.getReciboAgua()!=null ? item.getReciboAgua() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="compAgua">Comprobante recibo agua pago</label>
              <input type="text" id="compAgua" name="compAgua" class="form-control"
                     value="<%= editing && item.getCompAgua()!=null ? item.getCompAgua() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="reciboEnergia">Recibo energía pago</label>
              <input type="text" id="reciboEnergia" name="reciboEnergia" class="form-control"
                     value="<%= editing && item.getReciboEnergia()!=null ? item.getReciboEnergia() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="compEnergia">Comprobante recibo energía pago</label>
              <input type="text" id="compEnergia" name="compEnergia" class="form-control"
                     value="<%= editing && item.getCompEnergia()!=null ? item.getCompEnergia() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="compGas">Recibo gas pago</label>
              <input type="text" id="compGas" name="compGas" class="form-control"
                     value="<%= editing && item.getCompGas()!=null ? item.getCompGas() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="compGas">Comprobante recibo gas pago</label>
              <input type="text" id="compGas" name="compGas" class="form-control"
                     value="<%= editing && item.getCompGas()!=null ? item.getCompGas() : "" %>">
            </div>

            <div class="form-group">
              <label class="form-label" for="alquilerId">Alquiler</label>
              <select id="alquilerId" name="alquilerId" class="form-control" required>
                <option value="">Seleccionar…</option>
                <% for (Alquiler a : alquileres) { %>
                  <option value="<%= a.getId() %>"
                          <%= (selAlquilerId == a.getId()) ? "selected" : "" %>>
                    <%= a.getId() %> (<%= a.getMontoMensual() %>)
                  </option>
                <% } %>
              </select>
            </div>


<%@ include file="/WEB-INF/jspf/layout-crear-end.jspf" %>
