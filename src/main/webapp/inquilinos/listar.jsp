<%@ taglib prefix="c"   uri="jakarta.tags.core" %>
<%@ page import="java.util.*,java.time.format.DateTimeFormatter,com.prometheus.web.model.Inquilino" %>
<%
  String ctx = request.getContextPath();
  List<Inquilino> items = (List<Inquilino>) request.getAttribute("items");
  String q     = (String) request.getAttribute("q");
  Integer currentPage  = (Integer) request.getAttribute("page");
  Integer totalPages = (Integer) request.getAttribute("pages");
  DateTimeFormatter df = DateTimeFormatter.ofPattern("d/MM/yy");
  if (items == null) items = Collections.emptyList();
  String msg = (String) session.getAttribute("msg");
  if (msg != null) { session.removeAttribute("msg"); }
%>
<c:set var="title" value="Inquilinos"/>
<c:set var="active" value="inquilinos"/>
<%@ include file="/WEB-INF/jspf/layout-start.jspf" %>
          <tr>
            <th>ID</th><th>Nombre</th><th>Documento</th><th>Teléfono</th><th>Creado</th><th>Actualizado</th><th>Acciones</th>
          </tr>
        </thead>
        <tbody>
        <% if (items.isEmpty()) { %>
            <tr><td colspan="7">No hay <c:out value="${active}"/>.</td></tr>
        <% } else {
              for (Inquilino p : items) { %>
                  <tr>
                      <td><%= p.getId() %></td>
                      <td><%= p.getNombre() %></td>
                      <td><%= p.getDocumento() %></td>
                      <td><%= p.getTelefono() %></td>
<%@ include file="/WEB-INF/jspf/layout-end.jspf" %>
