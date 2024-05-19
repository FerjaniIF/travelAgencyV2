package service;

import controllers.RoomController;
import javafx.fxml.FXML;
import javafx.scene.control.Alert;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.ListView;
import javafx.scene.control.RadioButton;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.control.ToggleGroup;
import models.Room;
import models.RoomType;

public class RoomViewService {

    private RoomController roomController;

    @FXML
    private ChoiceBox<Integer> isAvailableField;
    @FXML
    private ChoiceBox<String> hotelNameField;
    @FXML
    private TextField roomNumField;
    @FXML
    private TextField priceField;
    @FXML
    private ListView<String> roomListView;

    @FXML
    private RadioButton singleRadioButton, doubleRadioButton, suiteRadioButton, deluxeRadioButton;

    private ToggleGroup roomTypeToggleGroup;

    public RoomViewService() {
        roomController = new RoomController();
    }

    @FXML
    private void initialize() {
        roomTypeToggleGroup = new ToggleGroup();
        singleRadioButton.setToggleGroup(roomTypeToggleGroup);
        doubleRadioButton.setToggleGroup(roomTypeToggleGroup);
        suiteRadioButton.setToggleGroup(roomTypeToggleGroup);
        deluxeRadioButton.setToggleGroup(roomTypeToggleGroup);

        isAvailableField.getItems().addAll(0, 1);
        RoomController.populateHotelComboBox(hotelNameField);
        refreshRoomList();
    }

    private void refreshRoomList() {
        roomListView.getItems().clear();
        for (Room room : RoomController.getAllRooms()) {
            roomListView.getItems().add(room.getRoomNum() + " - " + room.getType() + " - " + room.getPrice() + " - " + room.isAvailable());
        }
    }

    @FXML
    private void handleAddRoom() {
        RoomType selectedRoomType = getSelectedRoomType();
        if (selectedRoomType != null) {
            RoomController.handleAddRoom(selectedRoomType, isAvailableField.getValue(), Double.parseDouble(priceField.getText()), hotelNameField.getValue());
            refreshRoomList();
        } else {
            showAlert("Error", "Room Type Selection Error", "Please select a valid room type.");
        }
    }

    @FXML
    private void handleUpdateRoom() {
        RoomType selectedRoomType = getSelectedRoomType();
        if (selectedRoomType != null) {
            RoomController.updateRoom(Integer.parseInt(roomNumField.getText()), selectedRoomType, isAvailableField.getValue(), Double.parseDouble(priceField.getText()), hotelNameField.getValue());
            refreshRoomList();
        } else {
            showAlert("Error", "Room Type Selection Error", "Please select a valid room type.");
        }
    }

    @FXML
    private void handleDeleteRoom() {
        RoomController.deleteRoom(Integer.parseInt(roomNumField.getText()));
        refreshRoomList();
    }

    @FXML
    private void handleRoomSelection(MouseEvent event) {
        String selectedRoomString = roomListView.getSelectionModel().getSelectedItem();
        if (selectedRoomString != null) {
            String[] parts = selectedRoomString.split(" - ");
            int roomNum = Integer.parseInt(parts[0]);
            RoomType type = RoomType.valueOf(parts[1]);
            double price = Double.parseDouble(parts[2]);
            int isAvailable = Integer.parseInt(parts[3]);

            roomNumField.setText(String.valueOf(roomNum));
            selectRoomTypeRadioButton(type);
            isAvailableField.setValue(isAvailable);
            priceField.setText(String.valueOf(price));
        }
    }

    private RoomType getSelectedRoomType() {
        RadioButton selectedRadioButton = (RadioButton) roomTypeToggleGroup.getSelectedToggle();
        if (selectedRadioButton != null) {
            return RoomType.valueOf(selectedRadioButton.getText().toUpperCase());
        }
        return null;
    }

    private void selectRoomTypeRadioButton(RoomType type) {
        switch (type) {
            case SINGLE:
                roomTypeToggleGroup.selectToggle(singleRadioButton);
                break;
            case DOUBLE:
                roomTypeToggleGroup.selectToggle(doubleRadioButton);
                break;
            case SUITE:
                roomTypeToggleGroup.selectToggle(suiteRadioButton);
                break;
            case DELUXE:
                roomTypeToggleGroup.selectToggle(deluxeRadioButton);
                break;
        }
    }

    private void showAlert(String title, String header, String content) {
        Alert alert = new Alert(Alert.AlertType.ERROR);
        alert.setTitle(title);
        alert.setHeaderText(header);
        alert.setContentText(content);
        alert.showAndWait();
    }
}
