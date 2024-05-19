package controllers;

import models.Room;
import models.RoomType;
import connexion.Connexion;
import javafx.fxml.FXML;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.control.ToggleGroup;

import java.sql.*;
import java.util.*;

public class RoomController {
	
	@FXML
	private ChoiceBox<String> HotelComboBox;

    private static Map<String, Integer> availabilityMap;

    static {
        availabilityMap = new HashMap<>();
        availabilityMap.put("Available", 1);
        availabilityMap.put("Not Available", 0);
    }

    public static void handleAddRoom(RoomType type, int isAvailable, Double price, String hotelName) {
        int hotel_id = getHotelIdFromName(hotelName);
        String sql = "INSERT INTO room (hotel_id, type, isAvailable, price) VALUES (?, ?, ?, ?)";
        try (Connection conn = Connexion.obtenirConnexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, hotel_id);
            pstmt.setString(2, type.toString());
            pstmt.setInt(3, isAvailable);
            pstmt.setDouble(4, price);

            pstmt.executeUpdate();

            System.out.println("Room added successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static int getHotelIdFromName(String hotelName) {
        try (Connection connection = Connexion.obtenirConnexion();
             PreparedStatement searchstmt = connection.prepareStatement("SELECT hotel_id FROM hotel WHERE name = ?")) {
             
            searchstmt.setString(1, hotelName);
            ResultSet resultSet = searchstmt.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("hotel_id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public static List<Room> getAllRooms() {
        List<Room> rooms = new ArrayList<>();
        String sql = "SELECT * FROM room";
        try (Connection conn = Connexion.obtenirConnexion();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int roomNum = rs.getInt("room_num");
                String roomTypeStr = rs.getString("type");
                RoomType type = RoomType.valueOf(roomTypeStr.toUpperCase());
                int isAvailable = rs.getInt("isAvailable");
                double price = rs.getDouble("price");
                int hotelId = rs.getInt("hotel_id");

                Room room = new Room(roomNum, type, price, hotelId);
                room.setAvailable(isAvailable);
                rooms.add(room);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rooms;
    }

    public static Room getRoomByNumber(int roomNum) {
        String sql = "SELECT * FROM room WHERE room_num = ?";
        try (Connection conn = Connexion.obtenirConnexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomNum);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String roomTypeStr = rs.getString("type");
                RoomType type = RoomType.valueOf(roomTypeStr.toUpperCase());
                int isAvailable = rs.getInt("isAvailable");
                double price = rs.getDouble("price");
                int hotelId = rs.getInt("hotel_id");

                Room room = new Room(roomNum, type, price, hotelId);
                room.setAvailable(isAvailable);
                return room;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Room updateRoom(int roomNum, RoomType type, Integer isAvailable, Double price, String hotelName) {
        Room oldRoom = getRoomByNumber(roomNum);
        if (oldRoom == null) {
            return null;
        }

        RoomType newType = (type != null) ? type : oldRoom.getType();
        int newIsAvailable = (isAvailable != null) ? isAvailable : oldRoom.isAvailable();
        Double newPrice = (price != null) ? price : oldRoom.getPrice();
        Integer newHotelId = (hotelName != null) ? RoomController.getHotelIdFromName(hotelName) : oldRoom.getHotel_id();

        String sql = "UPDATE room SET type = ?, isAvailable = ?, price = ?, hotel_id = ? WHERE room_num = ?";
        try (Connection conn = Connexion.obtenirConnexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, newType.toString());
            pstmt.setInt(2, newIsAvailable);
            pstmt.setDouble(3, newPrice);
            pstmt.setInt(4, newHotelId);
            pstmt.setInt(5, roomNum);

            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                return new Room(roomNum, newType, newPrice, newHotelId);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static Boolean deleteRoom(int roomNum) {
        String sql = "DELETE FROM room WHERE room_num = ?";
        try (Connection conn = Connexion.obtenirConnexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, roomNum);
            int affectedRows = pstmt.executeUpdate();
            if (affectedRows > 0) {
                System.out.println("Room deleted successfully!");
                return true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void populateHotelComboBox(ChoiceBox<String> hotelComboBox) {
        try (Connection connection = Connexion.obtenirConnexion();
             PreparedStatement pstmt = connection.prepareStatement("SELECT name FROM hotel");
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                hotelComboBox.getItems().add(rs.getString("name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
