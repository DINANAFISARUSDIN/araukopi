import java.math.BigDecimal;

public class MenuItem {
    private int menuItemID;
    private String name;
    private BigDecimal price;

    public MenuItem(int menuItemID, String name, BigDecimal price) {
        this.menuItemID = menuItemID;
        this.name = name;
        this.price = price;
    }

    // Getters
    public int getMenuItemID() {
        return menuItemID;
    }

    public String getName() {
        return name;
    }

    public BigDecimal getPrice() {
        return price;
    }

    // Setters
    public void setMenuItemID(int menuItemID) {
        this.menuItemID = menuItemID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }
}
