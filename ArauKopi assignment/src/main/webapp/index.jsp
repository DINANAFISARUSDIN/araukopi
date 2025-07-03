<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Arau Kopi Order System</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body { font-family: Arial; background: #f7f7f7; margin: 0; padding: 0; }
        header { background-color: #5D4037; color: white; padding: 20px; text-align: center; }
        section { padding: 30px; }
        .container { max-width: 1000px; margin: auto; background: white; padding: 20px; box-shadow: 0 0 10px #ccc; }
        .role { margin-top: 20px; background: #EEE; padding: 10px; border-left: 5px solid #5D4037; }
        .hidden { display: none; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #ccc; }
        th, td { padding: 10px; text-align: left; }
        form input, form textarea, form select { padding: 10px; width: 100%; margin-bottom: 10px; }
        .btn { padding: 10px 20px; background: #5D4037; color: white; border: none; cursor: pointer; }
        .back-btn { background-color: #8D6E63; margin-top: 10px; margin-right: 10px; float: left; }
        .actions { display: flex; justify-content: space-between; align-items: center; gap: 10px; flex-wrap: wrap; }
        .checkbox-label { display: inline-flex; align-items: center; gap: 5px; margin-bottom: 5px; }
        #cart-section { display: none; }
    </style>
</head>
<body>
<header>
    <h1>Arau Kopi Order Management</h1>
</header>
<section class="container">
    <div id="role-selection">
        <h2>Select Your Role</h2>
        <button class="btn" onclick="selectRole('customer')">Customer</button>
        <button class="btn" onclick="selectRole('manager')">Manager</button>
        <button class="btn" onclick="selectRole('chef')">Chef</button>
        <button class="btn" onclick="selectRole('cashier')">Cashier</button>
    </div>

    <!-- Customer Interface -->
    <div id="customer" class="role hidden section-content">
        <h2> Menu</h2>
        <table>
            <tr><th>Item</th><th>Price</th><th>Availability</th><th>Action</th></tr>
            <tr><td>Kopi Ais</td><td>RM2.50</td><td>Available</td><td><button onclick="addToCart('Kopi Ais')">Add to Cart</button></td></tr>
            <tr><td>Teh Tarik</td><td>RM2.00</td><td>Available</td><td><button onclick="addToCart('Teh Tarik')">Add to Cart</button></td></tr>
            <tr><td>Nasi Lemak</td><td>RM5.00</td><td>Out of Stock</td><td><button disabled>Add to Cart</button></td></tr>
        </table>

        <div id="cart-section">
            <h3> Order Cart</h3>
            <ul id="cart-list"></ul>

            <h3> Payment</h3>
            <form action="PaymentServlet" method="post">
                <select name="method">
                    <option value="cash">Cash</option>
                    <option value="ewallet">E-Wallet</option>
                </select>
                <button type="submit">Pay Now</button>
            </form>
        </div>

        <button class="btn back-btn" onclick="backToRoleSelection()">Back</button>
    </div>

    <!-- Manager Login and Interface -->
    <div id="manager-login" class="role hidden">
        <h2> Manager Login</h2>
        <form onsubmit="event.preventDefault(); showSection('manager');">
            <input type="text" placeholder="Username" required>
            <input type="password" placeholder="Password" required>
            <div class="actions">
                <button class="btn back-btn" type="button" onclick="backToRoleSelection()">Back</button>
                <button class="btn" type="submit">Login</button>
            </div>
        </form>
    </div>
    <div id="manager" class="role hidden section-content">
        <h3> Manage Menu</h3>
        <form action="MenuServlet" method="post">
            <input type="text" name="itemName" placeholder="Menu Item Name" required>
            <input type="number" name="price" placeholder="Price" required>
            <button class="btn" type="submit">Add Menu</button>
        </form>

        <h3> View Report</h3>
        <button class="btn" onclick="alert('Order & feedback report generated')">Generate Report</button>
        <button class="btn back-btn" onclick="backToRoleSelection()">Back</button>
    </div>

    <!-- Chef Login and Interface -->
    <div id="chef-login" class="role hidden">
        <h2> Chef Login</h2>
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
        <h3> View Orders</h3>
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
                </td></tr>
        </table>
        <button class="btn back-btn" onclick="backToRoleSelection()">Back</button>
    </div>

    <!-- Cashier Login and Interface -->
    <div id="cashier-login" class="role hidden">
        <h2> Cashier Login</h2>
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
        <h3> Notifications</h3>
        <ul>
            <li>Order #101 received</li>
            <li>Payment #2001 completed</li>
        </ul>

        <h3> Print Receipt</h3>
        <form>
            <label class="checkbox-label"><input type="checkbox" name="receipt" value="2001"> Payment #2001</label><br>
            <label class="checkbox-label"><input type="checkbox" name="receipt" value="2002"> Payment #2002</label><br>
            <button class="btn" type="button" onclick="alert('Receipt(s) printed')">Print Selected Receipts</button>
        </form>

        <h3> Report & Feedback Summary</h3>
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
