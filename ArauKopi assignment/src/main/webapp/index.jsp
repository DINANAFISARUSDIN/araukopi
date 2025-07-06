<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>Arau Kopi Order System</title>
  <style>
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
      font-family: "Segoe UI", Arial, sans-serif;
      color: #333;
      display: flex;
      justify-content: center;
      align-items: center;
     background: url('https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEhq7zEPizfzGfvFJMKKmtf6bhjWrUL0jPLqceloMK1KvZVLEwisyXROoXzSiWAu061PQqarCq5uqyT4DWCRzk0vH4Y73OtblKGE5usmrKzJhwQsdjC6qivx7YvsAoKEwtGFjmZy9eqyusTM01ExONWpjGJpVJTojtFOEfgQZr2DHDvtkKVEu9Pc9qxEDQQ/s2560/1000062458.jpg') no-repeat center center fixed;
      background-size: cover;
    }
    .container {
      max-width: 600px;
      background: rgba(255, 255, 255, 0.9); /* translucent white for readability */
      padding: 30px;
      border-radius: 12px;
      box-shadow: 0 4px 20px rgba(0,0,0,0.3);
      text-align: center;
    }
    header {
      background-color: #4E342E;
      color: white;
      padding: 20px;
      border-radius: 12px 12px 0 0;
      margin: -30px -30px 20px -30px;
    }
    .role {
      margin-top: 20px;
      background: #f9f7f6;
      padding: 20px;
      border-left: 5px solid #4E342E;
      border-radius: 8px;
      text-align: left;
    }
    .hidden {
      display: none;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 20px;
    }
    table, th, td {
      border: 1px solid #ddd;
    }
    th, td {
      padding: 12px;
      text-align: left;
    }
    table tr:nth-child(even) {
      background: #fafafa;
    }
    table tr:hover {
      background: #f1f1f1;
    }
    form input, form textarea, form select {
      padding: 12px;
      width: 100%;
      margin-bottom: 15px;
      border: 1px solid #ccc;
      border-radius: 6px;
    }
    .btn {
      padding: 12px 24px;
      background: #4E342E;
      color: white;
      border: none;
      border-radius: 6px;
      cursor: pointer;
      transition: background 0.3s;
      text-decoration: none;
      margin: 5px 0;
      display: inline-block;
      width: 80%;
    }
    .btn:hover {
      background: #3E2723;
    }
    .back-btn {
      background-color: #795548;
      margin-top: 10px;
      float: left;
      width: auto;
    }
    .back-btn:hover {
      background-color: #5D4037;
    }
    .actions {
      display: flex;
      justify-content: space-between;
      align-items: center;
      gap: 10px;
      flex-wrap: wrap;
    }
    .checkbox-label {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 5px;
    }
    #cart-section {
      display: none;
      margin-top: 20px;
      background: #f9f7f6;
      border-radius: 8px;
      padding: 20px;
    }
  </style>
</head>
<body>
  <section class="container">
    <header>
      <h1>Arau Kopi Order Management</h1>
    </header>
    <div id="role-selection">
      <h2>Select Your Role</h2>
      <button class="btn" onclick="selectRole('customer')">Customer</button><br>
      <button class="btn" onclick="selectRole('manager')">Manager</button><br>
      <button class="btn" onclick="selectRole('chef')">Chef</button><br>
      <button class="btn" onclick="selectRole('cashier')">Cashier</button>
    </div>

    <!-- Customer Interface -->
    <div id="customer" class="role hidden section-content">
      <h2>Menu</h2>
      <table>
        <tr><th>Item</th><th>Price</th><th>Availability</th><th>Action</th></tr>
        <tr><td>Kopi Ais</td><td>RM2.50</td><td>Available</td><td><button class="btn" onclick="addToCart('Kopi Ais')">Add to Cart</button></td></tr>
        <tr><td>Teh Tarik</td><td>RM2.00</td><td>Available</td><td><button class="btn" onclick="addToCart('Teh Tarik')">Add to Cart</button></td></tr>
        <tr><td>Nasi Lemak</td><td>RM5.00</td><td>Out of Stock</td><td><button class="btn" disabled>Add to Cart</button></td></tr>
      </table>

      <div id="cart-section">
        <h3>Order Cart</h3>
        <ul id="cart-list"></ul>

        <h3>Payment</h3>
        <form action="PaymentServlet" method="post">
          <select name="method">
            <option value="cash">Cash</option>
            <option value="ewallet">E-Wallet</option>
          </select>
          <button class="btn" type="submit">Pay Now</button>
        </form>
      </div>
      <button class="btn back-btn" onclick="backToRoleSelection()">Back</button>
    </div>

    <!-- Manager Login -->
    <div id="manager-login" class="role hidden">
      <form action="ManagerDashboard.jsp" method="post">
 		 <input type="text" placeholder="Username" name="username" required>
  			<input type="password" placeholder="Password" name="password" required>
  			<div class="actions">
   			 <button class="btn back-btn" type="button" onclick="backToRoleSelection()">Back</button>
    		<button class="btn" type="submit">Login</button>
 			 </div>
</form>
      
        </div>
      </form>
    </div>

    <!-- Chef Login -->
    <div id="chef-login" class="role hidden">
      <h2>Chef Login</h2>
      <form onsubmit="event.preventDefault(); showSection('chef');">
        <input type="text" placeholder="Username" required>
        <input type="password" placeholder="Password" required>
        <div class="actions">
          <button class="btn back-btn" type="button" onclick="backToRoleSelection()">Back</button>
          <button class="btn" type="submit">Login</button>
        </div>
      </form>
    </div>
    <div id="chef" class="role hidden section-content">
      <h3>View Orders</h3>
      <table>
        <tr><th>Order ID</th><th>Item</th><th>Status</th><th>Action</th></tr>
        <tr><td>101</td><td>Kopi Ais</td><td>Pending</td>
          <td>
            <form action="UpdateOrderServlet" method="post">
              <input type="hidden" name="orderId" value="101">
              <select name="status">
                <option value="In Progress">In Progress</option>
                <option value="Completed">Completed</option>
              </select>
              <button class="btn" type="submit">Update</button>
            </form>
          </td>
        </tr>
      </table>
      <button class="btn back-btn" onclick="backToRoleSelection()">Back</button>
    </div>

    <!-- Cashier Login -->
    <div id="cashier-login" class="role hidden">
      <h2>Cashier Login</h2>
      <form onsubmit="event.preventDefault(); showSection('cashier');">
        <input type="text" placeholder="Username" required>
        <input type="password" placeholder="Password" required>
        <div class="actions">
          <button class="btn back-btn" type="button" onclick="backToRoleSelection()">Back</button>
          <button class="btn" type="submit">Login</button>
        </div>
      </form>
    </div>
    <div id="cashier" class="role hidden section-content">
      <h3>Notifications</h3>
      <ul>
        <li>Order #101 received</li>
        <li>Payment #2001 completed</li>
      </ul>

      <h3>Print Receipt</h3>
      <form>
        <label class="checkbox-label"><input type="checkbox" name="receipt" value="2001"> Payment #2001</label><br>
        <label class="checkbox-label"><input type="checkbox" name="receipt" value="2002"> Payment #2002</label><br>
        <button class="btn" type="button" onclick="alert('Receipt(s) printed')">Print Selected Receipts</button>
      </form>

      <h3>Report & Feedback Summary</h3>
      <button class="btn" onclick="alert('Feedback summary generated')">Generate Summary</button>
      <button class="btn back-btn" onclick="backToRoleSelection()">Back</button>
    </div>
  </section>
  <script>
    function selectRole(roleId) {
      document.getElementById('role-selection').classList.add('hidden');
      document.getElementById(roleId + '-login').classList.remove('hidden');
    }

    function showSection(id) {
      document.querySelectorAll('.section-content').forEach(el => el.classList.add('hidden'));
      document.getElementById(id).classList.remove('hidden');
      const loginDiv = document.getElementById(id + '-login');
      if (loginDiv) loginDiv.classList.add('hidden');
    }

    function backToRoleSelection() {
      document.querySelectorAll('.role').forEach(div => div.classList.add('hidden'));
      document.getElementById('role-selection').classList.remove('hidden');
    }

    function addToCart(itemName) {
      const list = document.getElementById("cart-list");
      const entry = document.createElement("li");
      entry.innerText = itemName + " x 1";
      list.appendChild(entry);
      document.getElementById("cart-section").style.display = "block";
    }
  </script>
</body>
</html>
