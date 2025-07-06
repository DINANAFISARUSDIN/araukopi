// DatabaseConnection.java
package ak.assignment;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private Connection connection;

    public void initJDBC() throws ClassNotFoundException, SQLException {
        Class.forName("com.mysql.jdbc.Driver");
        System.out.println("Driver loaded");
        connection = DriverManager.getConnection("jdbc:mysql://localhost/araukopi", "root", "");
        System.out.println("Database connected");
    }

    public Connection getConnection() {
        return connection;
    }
}
