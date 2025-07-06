<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Feedback Report</title>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f7f7f7;
      margin: 0;
    }
    header {
      background-color: #5D4037;
      color: white;
      text-align: center;
      padding: 25px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }
    .notification {
      position: absolute;
      top: 5px;
      right: 10px;
      background: #4CAF50;
      color: white;
      padding: 8px 12px;
      border-radius: 4px;
      display: none;
    }
    section {
      max-width: 1100px;
      margin: 30px auto;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
      padding: 30px;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    th, td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: center;
      vertical-align: top;
    }
    th {
      background-color: #5D4037;
      color: white;
    }
    tr:nth-child(even) { background-color: #f2f2f2; }
    tr:hover { background-color: #eee; }
    .btn {
      display: inline-block;
      background: #5D4037;
      color: white;
      padding: 10px 20px;
      border-radius: 6px;
      text-decoration: none;
      margin-top: 15px;
      transition: background 0.3s, transform 0.2s, box-shadow 0.2s;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .btn:hover {
      background: #3E2723;
      transform: scale(1.03);
      box-shadow: 0 6px 12px rgba(0,0,0,0.2);
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
    h3 {
      color: #5D4037;
      text-align: center;
      margin-top: 40px;
    }
  </style>
  <script>
    function printReport() {
      window.print();
    }
    function showNotification(msg) {
      const note = document.getElementById("notification");
      note.textContent = msg;
      note.style.display = "block";
      setTimeout(() => note.style.display = "none", 3000);
    }
    window.onload = function() {
      showNotification("Feedback report generated successfully.");
    }
  </script>
</head>
<body>
  <header>
    <h1>Feedback Report</h1>
    <div id="notification" class="notification"></div>
  </header>
  <section>
    <form class="filter-form" method="get">
      <label for="rating">Rating:</label>
      <select name="rating" id="rating">
        <option value="">All</option>
        <% for(int i=1;i<=5;i++){ %>
          <option value="<%=i%>" <%= String.valueOf(i).equals(request.getParameter("rating")) ? "selected" : "" %>><%=i%></option>
        <% } %>
      </select>
      <label for="orderID">Order ID:</label>
      <input type="text" name="orderID" id="orderID" value="<%= request.getParameter("orderID") != null ? request.getParameter("orderID") : "" %>">
      <button type="submit" class="btn">Apply Filter</button>
    </form>

    <table>
      <tr>
        <th>Feedback ID</th>
        <th>Order ID</th>
        <th>Message</th>
        <th>Rating</th>
      </tr>
      <%
        String ratingParam = request.getParameter("rating");
        String orderIDParam = request.getParameter("orderID");
        int[] ratingCounts = new int[5]; // for chart
        try {
          Class.forName("com.mysql.jdbc.Driver");
          Connection con = DriverManager.getConnection("jdbc:mysql://localhost/araukopi", "root", "");

          String sql = "SELECT * FROM Feedback WHERE 1=1";
          if (ratingParam != null && !ratingParam.isEmpty()) {
            sql += " AND Rating = " + ratingParam;
          }
          if (orderIDParam != null && !orderIDParam.isEmpty()) {
            sql += " AND OrderID = " + orderIDParam;
          }

          Statement stmt = con.createStatement();
          ResultSet rs = stmt.executeQuery(sql);
          while(rs.next()) {
            int r = rs.getInt("Rating");
            if(r>=1 && r<=5) ratingCounts[r-1]++;
      %>
      <tr>
        <td><%= rs.getInt("FeedbackID") %></td>
        <td><%= rs.getInt("OrderID") %></td>
        <td><%= rs.getString("Message") %></td>
        <td><%= r %></td>
      </tr>
      <%
          }
          rs.close();
          stmt.close();
          con.close();
        } catch(Exception e) {
          out.println("<tr><td colspan='4'>Error: " + e.getMessage() + "</td></tr>");
        }
      %>
    </table>

    <div style="text-align:center;">
      <button class="btn" onclick="printReport()">Print Report</button>
      <a href="viewReport.jsp" class="btn">Back</a>
    </div>

    <div id="chart-container">
      <h3>Feedback Ratings Distribution</h3>
      <canvas id="feedbackChart"></canvas>
    </div>

    <script>
      const ratingData = <%= java.util.Arrays.toString(ratingCounts) %>;
      const ctx = document.getElementById('feedbackChart').getContext('2d');
      new Chart(ctx, {
        type: 'bar',
        data: {
          labels: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'],
          datasets: [{
            label: 'Number of Feedbacks',
            data: ratingData,
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
