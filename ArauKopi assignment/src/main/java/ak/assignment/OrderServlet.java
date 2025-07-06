package ak.assignment;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;

public class OrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            DatabaseConnection dbConnection = new DatabaseConnection();
            dbConnection.initJDBC();
            Connection connection = dbConnection.getConnection();

            OrderDAO orderDAO = new OrderDAO(connection);
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String status = "New"; // Default status
            orderDAO.createOrder(customerId, status);

            response.sendRedirect("customer.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
