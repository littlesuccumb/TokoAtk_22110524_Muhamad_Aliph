<%
  session.invalidate();
  response.sendRedirect("index.jsp?pesan=logout");
%>
