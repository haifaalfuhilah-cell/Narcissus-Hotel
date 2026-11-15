package CSC380;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import java.awt.*;
import java.sql.*;

public class NarcissusHotel extends JFrame {
	   private static final String DB_URL = "jdbc:mysql://localhost:3306/narcissushotel";

	    private static final String DB_USER = "root";

	    private static final String DB_PASSWORD = "root";


	    public NarcissusHotel() {

	        setTitle("Narcissus Hotel Reservation System");

	        setSize(1700, 900);

	        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	        setLocationRelativeTo(null);


	        JTabbedPane tabs = new JTabbedPane();

	        tabs.addTab("Guest", createPanel(

	                "GUEST",

	                new String[]{"Guest_id", "National_id", "First_name", "Last_name", "Phone_number", "Email", "Nationality"},

	                "Guest_id"

	        ));


	        tabs.addTab("Room", createPanel(

	                "ROOM",

	                new String[]{"Room_id", "Room_number", "Room_type", "Price_per_night", "Capacity", "Room_status", "Branch_id"},

	                "Room_id"

	        ));


	        tabs.addTab("Booking", createPanel(

	                "BOOKING",

	                new String[]{"Booking_id", "Guest_id", "Room_id", "Booking_date", "Check_in_date", "Check_out_date", "Booking_status", "Number_of_guests"},

	                "Booking_id"

	        ));


	        tabs.addTab("Payment", createPanel(

	                "PAYMENT",

	                new String[]{"Payment_id", "Payment_date", "Payment_amount", "Payment_status", "Payment_method", "BookingId"},

	                "Payment_id"

	        ));


	        tabs.addTab("Employee", createPanel(

	                "EMPLOYEE",

	                new String[]{"Employee_id", "Name", "Job_title", "Phone_number", "Email", "Salary", "Branch_id"},

	                "Employee_id"

	        ));


	        tabs.addTab("Branch", createPanel(

	                "BRANCH",

	                new String[]{"Branch_id", "Branch_name", "City", "Address", "Phone", "Email", "Manager_id"},

	                "Branch_id"

	        ));

	        add(tabs);

	    }


	    private JPanel createPanel(String tableName, String[] columns, String primaryKey) {

	        JPanel panel = new JPanel(new BorderLayout());


	        JPanel formPanel = new JPanel(new GridLayout(0, 4, 10, 10));

	        JTextField[] fields = new JTextField[columns.length];


	        for (int i = 0; i < columns.length; i++) {

	            formPanel.add(new JLabel(columns[i]));

	            fields[i] = new JTextField();

	            formPanel.add(fields[i]);

	        }


	        DefaultTableModel model = new DefaultTableModel(columns, 0);

	        JTable table = new JTable(model);

	        JScrollPane scrollPane = new JScrollPane(table);


	        JPanel buttonPanel = new JPanel();


	        JButton addBtn = new JButton("Add");

	        JButton updateBtn = new JButton("Update");

	        JButton deleteBtn = new JButton("Delete");

	        JButton searchBtn = new JButton("Search");

	        JButton displayBtn = new JButton("Display All");


	        buttonPanel.add(addBtn);

	        buttonPanel.add(updateBtn);

	        buttonPanel.add(deleteBtn);

	        buttonPanel.add(searchBtn);

	        buttonPanel.add(displayBtn);


	        addBtn.addActionListener(e -> {

	            try {

	                Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);


	                StringBuilder sql = new StringBuilder("INSERT INTO " + tableName + " VALUES (");


	                for (int i = 0; i < columns.length; i++) {

	                    sql.append("?");

	                    if (i < columns.length - 1) {

	                        sql.append(",");

	                    }

	                }


	                sql.append(")");


	                PreparedStatement ps = con.prepareStatement(sql.toString());


	                for (int i = 0; i < columns.length; i++) {

	                    String value = fields[i].getText().trim();


	                    if (value.isEmpty()) {

	                        ps.setNull(i + 1, java.sql.Types.NULL);

	                    } else {

	                        ps.setString(i + 1, value);

	                    }

	                }


	                ps.executeUpdate();


	                JOptionPane.showMessageDialog(null, "Added Successfully");


	                con.close();


	            } catch (Exception ex) {

	                JOptionPane.showMessageDialog(null, ex.getMessage());//

	            }

	        });


	        displayBtn.addActionListener(e -> {

	            try {

	                Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);


	                String sql = "SELECT * FROM " + tableName;


	                PreparedStatement ps = con.prepareStatement(sql);

	                ResultSet rs = ps.executeQuery();


	                model.setRowCount(0);


	                while (rs.next()) {

	                    Object[] row = new Object[columns.length];


	                    for (int i = 0; i < columns.length; i++) {

	                        row[i] = rs.getObject(columns[i]);

	                    }


	                    model.addRow(row);

	                }


	                con.close();


	            } catch (Exception ex) {

	                JOptionPane.showMessageDialog(null, ex.getMessage());

	            }

	        });


	        searchBtn.addActionListener(e -> {

	            try {

	                Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);


	                String sql = "SELECT * FROM " + tableName + " WHERE " + primaryKey + "=?";


	                PreparedStatement ps = con.prepareStatement(sql);

	                ps.setString(1, fields[0].getText());


	                ResultSet rs = ps.executeQuery();


	                model.setRowCount(0);


	                while (rs.next()) {

	                    Object[] row = new Object[columns.length];


	                    for (int i = 0; i < columns.length; i++) {

	                        row[i] = rs.getObject(columns[i]);

	                    }


	                    model.addRow(row);

	                }


	                con.close();


	            } catch (Exception ex) {

	                JOptionPane.showMessageDialog(null, ex.getMessage());

	            }

	        });


	        updateBtn.addActionListener(e -> {

	            try {

	                Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);


	                StringBuilder sql = new StringBuilder("UPDATE " + tableName + " SET ");


	                for (int i = 1; i < columns.length; i++) {

	                    sql.append(columns[i]).append("=?");


	                    if (i < columns.length - 1) {

	                        sql.append(",");

	                    }

	                }


	                sql.append(" WHERE ").append(primaryKey).append("=?");


	                PreparedStatement ps = con.prepareStatement(sql.toString());


	                int index = 1;


	                for (int i = 1; i < columns.length; i++) {

	                    ps.setString(index++, fields[i].getText());

	                }


	                ps.setString(index, fields[0].getText());


	                ps.executeUpdate();


	                JOptionPane.showMessageDialog(null, "Updated Successfully");


	                con.close();


	            } catch (Exception ex) {

	                JOptionPane.showMessageDialog(null, ex.getMessage());

	            }

	        });


	        deleteBtn.addActionListener(e -> {

	            try {

	                Connection con = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);


	                String sql = "DELETE FROM " + tableName + " WHERE " + primaryKey + "=?";


	                PreparedStatement ps = con.prepareStatement(sql);

	                ps.setString(1, fields[0].getText());


	                ps.executeUpdate();


	                JOptionPane.showMessageDialog(null, "Deleted Successfully");


	                con.close();


	            } catch (Exception ex) {

	                JOptionPane.showMessageDialog(null, ex.getMessage());

	            }

	        });

	        panel.add(formPanel, BorderLayout.NORTH);
	        panel.add(scrollPane, BorderLayout.CENTER);
	        panel.add(buttonPanel, BorderLayout.SOUTH);

	        return panel;

	    }


	    public static void main(String[] args) {

	        UIManager.put("Label.font",
	                new Font("Times New Roman", Font.PLAIN, 25));

	        UIManager.put("Button.font",
	                new Font("Times New Roman", Font.BOLD, 25));

	        UIManager.put("TextField.font",
	                new Font("Times New Roman", Font.PLAIN, 25));

	        UIManager.put("Table.font",
	                new Font("Times New Roman", Font.PLAIN, 25));

	        UIManager.put("Table.font",
	                new Font("Times New Roman", Font.BOLD, 15));

	        UIManager.put("Button.font",
	                new Font("Times New Roman", Font.BOLD, 25));

	        UIManager.put("Label.font",
	                new Font("Times New Roman", Font.BOLD, 25));

	        UIManager.put("TabbedPane.font",
	                new Font("Times New Roman", Font.BOLD, 30));

	        UIManager.put("TableHeader.font",
	                new Font("Times New Roman", Font.BOLD , 20));

	        SwingUtilities.invokeLater(() -> {

	            new NarcissusHotel()
	                    .setVisible(true);

	        });

	    }
	}
