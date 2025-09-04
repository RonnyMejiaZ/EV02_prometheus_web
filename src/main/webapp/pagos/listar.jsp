<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="java.util.*,java.time.format.DateTimeFormatter,com.prometheus.web.model.Pago" %>

<%
  String ctx = request.getContextPath();
  List<Pago> items = (List<Pago>) request.getAttribute("items");
  String q     = (String) request.getAttribute("q");
  Integer currentPage  = (Integer) request.getAttribute("page");
  Integer totalPages = (Integer) request.getAttribute("pages");
  DateTimeFormatter df = DateTimeFormatter.ofPattern("d/MM/yy");
  if (items == null) items = Collections.emptyList();
  String msg = (String) session.getAttribute("msg");
  if (msg != null) { session.removeAttribute("msg"); }
%>

<c:set var="title" value="Pagos"/>
<c:set var="active" value="pagos"/>
<%@ include file="/WEB-INF/jspf/layout-start.jspf" %>
          <tr>
            <th>ID Alquiler</th><th>ID Pago</th><th>Fecha Pago</th><th>Monto</th><th>Creado</th><th>Actualizado</th><th>Acciones</th>
          </tr>
        </thead>
        <tbody>
        <% if (items.isEmpty()) { %>
            <tr><td colspan="7">No hay <c:out value="${active}"/>.</td></tr>
        <% } else {
              for (Pago p : items) { %>
                  <tr>
                      <td><%= p.getAlquilerId() %></td>
                      <td><%= p.getId() %></td>
                      <td><%= p.getFechaPago() %></td>
                      <td><%= p.getMontoMensual() %></td>
<%@ include file="/WEB-INF/jspf/layout-end.jspf" %>
