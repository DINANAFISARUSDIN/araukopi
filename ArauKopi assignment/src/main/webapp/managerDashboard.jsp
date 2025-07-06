<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Manager Dashboard</title>
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      font-family: Arial, sans-serif;
      background: url('https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjzHG9ZUpHfXw7ObxUsWWhc3tZ5PSzeUYfAKk7Djzr7-egDCuDkORIkOn2wbNzLoLwX28o7cs_8aOGR6531O5t4Lor6CJ4RNM59-A7rPqvJS7ts4XEhtiDZFdWCvzuI6xH49s8fMTrGKYcIGAqGKrVsarTRfsTNxz27tg4Fq2egYPJHTH0eI_FETLHkuwQ/s2560/1000062462.jpg') no-repeat center center fixed;
      background-size: cover;
      display: flex;
      justify-content: center;
      align-items: center;
    }
    .container {
      background: rgba(255, 255, 255, 0.95);
      max-width: 500px;
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.2);
      text-align: center;
    }
    header {
      background-color: #5D4037;
      color: white;
      padding: 20px;
      border-radius: 12px 12px 0 0;
      margin: -30px -30px 20px -30px;
    }
    .btn {
      display: block;
      margin: 15px auto;
      padding: 15px;
      background: #5D4037;
      color: white;
      text-decoration: none;
      border-radius: 6px;
      transition: background 0.3s;
      width: 80%;
    }
    .btn:hover {
      background: #3E2723;
    }
    .logout-btn {
      background: #8D6E63;
    }
    .logout-btn:hover {
      background: #6D4C41;
    }
  </style>
</head>
<body>
  <section class="container">
    <header>
      <h1>Manager Dashboard</h1>
    </header>
    <h2>What would you like to do?</h2>
    <a href="manageMenu.jsp" class="btn">Manage Menu</a>
    <a href="viewReport.jsp" class="btn">View Reports</a>
    <a href="index.jsp" class="btn logout-btn">Log Out</a>
  </section>
</body>
</html> 