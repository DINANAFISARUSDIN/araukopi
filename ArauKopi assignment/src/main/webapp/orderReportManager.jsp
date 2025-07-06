<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Order Report</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
      padding: 25px; 
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }
    section { 
      max-width: 1100px; 
      margin: 30px auto; 
      padding: 30px; 
      background: white; 
      box-shadow: 0 8px 20px rgba(0,0,0,0.2); 
      border-radius: 12px;
    }
    table { 
      width: 100%; 
      border-collapse: collapse; 
      margin-top: 20px;
    }
    th, td { 
      border: 1px solid #ddd; 
      padding: 12px; 
      vertical-align: top; 
      text-align: center;
    }
    th { 
      background-color: #5D4037; 
      color: white;
    }
    tr:nth-child(even) { 
      background-color: #f2f2f2;
    }
    tr:hover {
      background-color: #eee;
    }
    .btn { 
      display: inline-block; 
      background: #5D4037; 
      color: white; 
      padding: 10px 20px; 
      text-decoration: none; 
      border-radius: 6px; 
      transition: background 0.3s; 
      margin-top: 15px;
    }
    .btn:hover { 
      background: #3E2723;
    }
    .filter-form { 
      margin-bottom: 20px; 
      text-align: center;
    }
    .filter-form label { 
      margin-right: 10px; 
      font-weight: bold; 
      color: #5D4037;
    }
    .filter-form input, .filter-form select { 
      padding: 8px; 
      margin-right: 10px; 
      border-radius: 6px; 
      border: 1px solid #ccc;
    }
    #chart-container { 
      margin-top: 40px; 
    }
    .items-box {
      border: 1px solid #ddd;
      padding: 8px;
      margin: 5px 0;
      border-radius: 6px;
      background: #fafafa;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      text-align: left;
    }
    .items-box strong {
      display:inline-block; 
      width:150px; 
      color:#5D4037;
    }
    h3 {
      color: #5D4037;
      text-align: center;
      margin-top: 40px;
    }
  </style>
  <script>
    function printReport() { window.print(); }
  </script>
</head>
<body>
  <header>
    <h1>Order Report</h1>
  </header>
  <section>
    <form class="filter-form" method="get">
      <label for="status">Status:</label>
      <select name="status" id="status">
        <option value="">All</option>
        <%
          String statusParam = request.getParameter("status");
          String[] statuses = {"New", "Cooking", "Ready", "Served"};
          for(String s : statuses) {
        %>
        <option value="<%=s%>" <%= s.equals(statusParam) ? "selected" : "" %>><%=s%></option>
        <% } %>
      </select>

      <label for="fromDate">From:</label>
      <input type="date" name="fromDate" value="<%=request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "" %>">

      <label for="toDate">To:</label>
      <input type="date" name="toDate" value="<%=request.getParameter("toDate") != null ? request.getParameter("toDate") : "" %>">

      <button type="submit" class="btn">Apply Filter</button>
    </form>

    <table>
      <tr>
        <th>Order ID</th>
        <th>Customer</th>
        <th>Order Date</th>
        <th>Status</th>
        <th>Total Amount (RM)</th>
        <th>Items</th>
      </tr>
      <%
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        
        int[] statusCounts = new int[4]; // New, Cooking, Ready, Served

        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost/araukopi", "root", "");

          String sql = "SELECT o.OrderID, c.Name as CustomerName, o.OrderDate, o.Status, p.Amount " +
                       "FROM `Order` o " +
                       "JOIN Customer c ON o.CustomerID = c.CustomerID " +
                       "LEFT JOIN Payment p ON o.OrderID = p.OrderID WHERE 1=1";

          if (statusParam != null && !statusParam.isEmpty()) {
            sql += " AND o.Status='" + statusParam + "'";
          }
          if (fromDate != null && !fromDate.isEmpty()) {
            sql += " AND o.OrderDate >= '" + fromDate + " 00:00:00'";
          }
          if (toDate != null && !toDate.isEmpty()) {
            sql += " AND o.OrderDate <= '" + toDate + " 23:59:59'";
          }

          sql += " ORDER BY o.OrderDate DESC";

          Statement stmt = con.createStatement();
          ResultSet rs = stmt.executeQuery(sql);

          while(rs.next()) {
            int orderId = rs.getInt("OrderID");
            String stat = rs.getString("Status");
            switch(stat) {
              case "New": statusCounts[0]++; break;
              case "Cooking": statusCounts[1]++; break;
              case "Ready": statusCounts[2]++; break;
              case "Served": statusCounts[3]++; break;
            }

            // collect items for this order
            String itemsHtml = "";
            String detailSql = "SELECT m.Name, oi.Quantity FROM OrderItem oi JOIN MenuItem m ON oi.MenuItemID = m.MenuItemID WHERE oi.OrderID=" + orderId;
            Statement detailStmt = con.createStatement();
            ResultSet detailRs = detailStmt.executeQuery(detailSql);
            while(detailRs.next()) {
              itemsHtml += "<div class='items-box'><strong>" + detailRs.getString("Name") + "</strong> x " + detailRs.getInt("Quantity") + "</div>";
            }
            detailRs.close();
            detailStmt.close();
      %>
      <tr>
        <td><%= orderId %></td>
        <td><%= rs.getString("CustomerName") %></td>
        <td><%= rs.getTimestamp("OrderDate") %></td>
        <td><%= stat %></td>
        <td><%= rs.getBigDecimal("Amount") != null ? rs.getBigDecimal("Amount") : "0.00" %></td>
        <td><%= itemsHtml %></td>
      </tr>
      <%
          }
          rs.close();
          stmt.close();
          con.close();
        } catch(Exception e) {
          out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
        }
      %>
    </table>

    <div style="text-align:center;">
      <button class="btn" onclick="printReport()">Print Report</button>
      <a href="viewReport.jsp" class="btn">Back</a>
    </div>

    <div id="chart-container">
      <h3>Order Status Distribution</h3>
      <canvas id="orderChart"></canvas>
    </div>

    <script>
      const statusData = <%= java.util.Arrays.toString(statusCounts) %>;
      const ctx = document.getElementById('orderChart').getContext('2d');
      const chart = new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['New', 'Cooking', 'Ready', 'Served'],
          datasets: [{
            label: 'Number of Orders',
            data: statusData,
            backgroundColor: '#5D4037'
          }]
        },
        options: {
          scales: {
            y: {
              beginAtZero: true,
              precision: 0,
              stepSize: 1
            }
          }
        }
      });
    </script>
  </section>
</body>
</html>
