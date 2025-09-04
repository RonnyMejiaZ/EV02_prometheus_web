<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="java.util.*,java.time.format.DateTimeFormatter,com.prometheus.web.model.Alquiler" %>
<%
  String ctx = request.getContextPath();
  List<Alquiler> items = (List<Alquiler>) request.getAttribute("items");
  String q     = (String) request.getAttribute("q");
  Integer currentPage  = (Integer) request.getAttribute("page");
  Integer totalPages = (Integer) request.getAttribute("pages");
  DateTimeFormatter df = DateTimeFormatter.ofPattern("d/MM/yy");
  if (items == null) items = Collections.emptyList();
  String msg = (String) session.getAttribute("msg");
  if (msg != null) { session.removeAttribute("msg"); }
%>
<c:set var="title" value="Alquileres"/>
<c:set var="active" value="alquileres"/>
<%@ include file="/WEB-INF/jspf/layout-start.jspf" %>
          <tr>
            <th>ID</th><th>Fecha Inicio</th><th>Fecha Fin</th><th>Monto</th><th>Creado</th><th>Actualizado</th><th>Acciones</th>
          </tr>
        </thead>
        <tbody>
        <% if (items.isEmpty()) { %>
            <tr><td colspan="7">No hay <c:out value="${active}"/>.</td></tr>
        <% } else {
              for (Alquiler p : items) { %>
                  <tr>
                      <td><%= p.getId() %></td>
                      <td><%= p.getFechaInicio() %></td>
                      <td><%= p.getFechaFin() %></td>
                      <td><%= p.getMontoMensual() %></td>
                      <td><%= p.getInquilinoId() %></td>

<%@ include file="/WEB-INF/jspf/layout-end.jspf" %>                
