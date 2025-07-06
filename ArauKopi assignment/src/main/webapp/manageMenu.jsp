<%@page import="java.sql.Connection"%>
<%@page import="java.util.List"%>
<%@page import="ak.assignment.MenuItemDAO"%>
<%@page import="ak.assignment.MenuItem"%>
<%@page import="ak.assignment.DatabaseConnection"%>
<%
DatabaseConnection dbConnection = new DatabaseConnection();
dbConnection.initJDBC();
Connection connection = dbConnection.getConnection();
MenuItemDAO menuItemDAO = new MenuItemDAO(connection);
List<MenuItem> menuItems = menuItemDAO.getAllMenuItems();
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Manage Menu</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      background: #f7f7f7;
    }
    header {
      background-color: #5D4037;
      color: white;
      text-align: center;
      padding: 30px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }
    section {
      max-width: 800px;
      margin: 40px auto;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
      padding: 30px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th {
      background-color: #5D4037;
      color: white;
      padding: 12px;
      text-align: center;
    }
    td {
      border: 1px solid #ddd;
      padding: 12px;
      vertical-align: middle;
      text-align: center;
    }
    tr:nth-child(even) { background-color: #f9f9f9; }
    tr:hover { background-color: #f1f1f1; }
    .btn {
      background: #5D4037;
      color: white;
      padding: 10px 18px;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      margin: 4px;
      transition: background 0.3s, transform 0.2s, box-shadow 0.2s;
      text-decoration: none;
      display: inline-block;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    /* match Order & Feedback scaling hover */
    .btn:hover {
      background: #3E2723;
      transform: scale(1.03);
      box-shadow: 0 6px 12px rgba(0,0,0,0.2);
    }
    .update-btn {
      background: #8D6E63;
    }
    .update-btn:hover {
      background: #6D4C41;
    }
    input[type="text"], input[type="number"] {
      width: 90%;
      padding: 8px;
      margin: 5px 0;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    h2 {
      color: #5D4037;
      margin-bottom: 15px;
      text-align: center;
    }
    h3 {
      margin-top: 40px;
      color: #5D4037;
    }
    .back-btn {
      margin-bottom: 20px;
      background: #8D6E63;
    }
    .back-btn:hover {
      background: #6D4C41;
      transform: scale(1.03);
      box-shadow: 0 6px 12px rgba(0,0,0,0.2);
    }
    .add-form {
      text-align: center;
      margin-top: 20px;
    }
    .add-form input {
      width: 30%;
      margin: 0 5px;
    }
  </style>
</head>
<body>
  <header>Manage Menu</header>
  <section>
    <a href="managerDashboard.jsp" class="btn back-btn">Back to Dashboard</a>
    <h2>Menu Items</h2>
    <table>
      <tr>
        <th>Item</th>
        <th>Price (RM)</th>
        <th>Actions</th>
      </tr>
      <% for(MenuItem item : menuItems) { %>
      <tr>
        <form action="UpdateMenuItemServlet" method="post">
          <td>
            <input type="hidden" name="menuItemId" value="<%= item.getMenuItemID() %>">
            <input type="text" name="name" value="<%= item.getName() %>" required>
          </td>
          <td>
            <input type="number" name="price" step="0.01" value="<%= item.getPrice() %>" required>
          </td>
          <td>
            <div style="display: flex; justify-content: center; gap: 8px;">
              <button type="submit" class="btn update-btn">Update</button>
        </form>
              <form action="DeleteMenuItemServlet" method="post">
                <input type="hidden" name="menuItemId" value="<%= item.getMenuItemID() %>">
                <button type="submit" class="btn">Delete</button>
              </form>
            </div>
          </td>
      </tr>
      <% } %>
    </table>

    <h3>Add New Item</h3>
    <form action="AddMenuItemServlet" method="post" class="add-form">
      <input type="text" name="name" placeholder="Menu name" required>
      <input type="number" name="price" step="0.01" placeholder="Price" required>
      <button type="submit" class="btn">Add</button>
    </form>
  </section>
</body>
</html>
