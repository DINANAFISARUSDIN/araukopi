package ak.assignment;
public class Customer {
    private int customerID;
    private String name;
    private String phone;
    private String email;

    public Customer(int customerID, String name, String phone, String email) {
        this.customerID = customerID;
        this.name = name;
        this.phone = phone;
        this.email = email;
    }

    // Getters
    public int getCustomerID() {
        return customerID;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    // Setters
    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
