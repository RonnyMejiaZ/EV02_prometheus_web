<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="java.util.*,java.time.format.DateTimeFormatter,com.prometheus.web.model.Property" %>
<%
  String ctx = request.getContextPath();
  List<Property> items = (List<Property>) request.getAttribute("items");
  String q     = (String) request.getAttribute("q");
  Integer currentPage  = (Integer) request.getAttribute("page");
  Integer totalPages = (Integer) request.getAttribute("pages");
  DateTimeFormatter df = DateTimeFormatter.ofPattern("d/MM/yy");
  if (items == null) items = Collections.emptyList();
  String msg = (String) session.getAttribute("msg");
  if (msg != null) { session.removeAttribute("msg"); }
%>
<c:set var="title" value="Propiedades"/>
<c:set var="active" value="propiedades"/>
<%@ include file="/WEB-INF/jspf/layout-start.jspf" %>
          <tr>
            <th>ID</th><th>Nombre</th><th>Dirección</th><th>Rentado</th><th>Creado</th><th>Actualizado</th><th>Acciones</th>
          </tr>
        </thead>
        <tbody>
        <% if (items.isEmpty()) { %>
            <tr><td colspan="7">No hay <c:out value="${active}"/>.</td></tr>
        <% } else {
              for (Property p : items) { %>
                  <tr>
                      <td><%= p.getId() %></td>
                      <td><%= p.getNombre() %></td>
                      <td><%= p.getDireccion() %></td>
                      <td><span class="badge <%= p.isRentado()? "badge-success":"badge-danger" %>"><%= p.isRentado()? "Sí":"No" %></span></td>
<%@ include file="/WEB-INF/jspf/layout-end.jspf" %>

