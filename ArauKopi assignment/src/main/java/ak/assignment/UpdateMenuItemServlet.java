package ak.assignment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UpdateMenuItemServlet")
public class UpdateMenuItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
        try {
            DatabaseConnection dbConnection = new DatabaseConnection();
            dbConnection.initJDBC();
            connection = dbConnection.getConnection();
            MenuItemDAO dao = new MenuItemDAO(connection);

            int menuItemId = Integer.parseInt(request.getParameter("menuItemId"));
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));

            dao.updateMenuItem(menuItemId, name, price);
            response.sendRedirect("manageMenu.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Optionally redirect to an error page or show an error message
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
