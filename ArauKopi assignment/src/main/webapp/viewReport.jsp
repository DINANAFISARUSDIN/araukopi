<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Manager Reports</title>
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
      max-width: 600px;
      margin: 40px auto;
      background: white;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.15);
      padding: 30px;
      text-align: center;
    }
    section h2 {
      color: #5D4037;
      margin-bottom: 20px;
    }
    ul {
      list-style: none;
      padding: 0;
      margin: 0;
    }
    li {
      margin: 15px 0;
    }
    a.btn, a {
      display: block;
      background: #5D4037;
      color: white;
      text-decoration: none;
      padding: 12px 20px;
      border-radius: 8px;
      transition: background 0.3s, transform 0.2s;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    a.btn:hover, a:hover {
      background: #3E2723;
      transform: scale(1.02);
    }
    .back-btn {
      margin-top: 30px;
      background: #8D6E63;
    }
    .back-btn:hover {
      background: #6D4C41;
    }
  </style>
</head>
<body>
  <header>
    <h1>Order & Feedback Reports</h1>
  </header>
  <section>
    <h2>Select Report</h2>
    <ul>
      <li><a href="orderReportManager.jsp">Order Report</a></li>
      <li><a href="feedbackReportManager.jsp">Feedback Summary</a></li>
    </ul>
    <a href="managerDashboard.jsp" class="btn">Back to Dashboard</a>
    
  </section>
</body>
</html>
