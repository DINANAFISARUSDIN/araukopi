package ak.assignment;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ManagerLoginServlet")
public class ManagerLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException {
        String user = req.getParameter("username");
        String pass = req.getParameter("password");
        if("manager".equals(user) && "1234".equals(pass)){
            HttpSession session = req.getSession();
            session.setAttribute("role", "manager");
            resp.sendRedirect("managerDashboard.jsp");
        } else {
            resp.getWriter().println("Invalid!");
        }
    }
}
