package ak.assignment;

import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AddMenuItemServlet")
public class AddMenuItemServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DatabaseConnection dbConnection = new DatabaseConnection();
            dbConnection.initJDBC();
            Connection connection = dbConnection.getConnection();
            MenuItemDAO dao = new MenuItemDAO(connection);

            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));

            dao.addMenuItem(name, price);

            response.sendRedirect("manageMenu.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
