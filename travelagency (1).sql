-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : dim. 19 mai 2024 à 19:17
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `travelagency`
--

-- --------------------------------------------------------

--
-- Structure de la table `aircraft`
--

CREATE TABLE `aircraft` (
  `aircraft_id` int(11) NOT NULL,
  `model` varchar(255) NOT NULL,
  `economic_cap` int(11) NOT NULL,
  `business_cap` int(11) NOT NULL,
  `first_cap` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `aircraft`
--

INSERT INTO `aircraft` (`aircraft_id`, `model`, `economic_cap`, `business_cap`, `first_cap`) VALUES
(1, 'Boeing 737', 150, 20, 8),
(2, 'Airbus A320', 180, 20, 4),
(3, 'Airbus A320', 120, 4, 10);

-- --------------------------------------------------------

--
-- Structure de la table `airline`
--

CREATE TABLE `airline` (
  `airline_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `convention` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `airline`
--

INSERT INTO `airline` (`airline_id`, `name`, `convention`) VALUES
(1, 'turkish', 14256),
(2, 'tunisaire', 456);

-- --------------------------------------------------------

--
-- Structure de la table `billflight`
--

CREATE TABLE `billflight` (
  `Billflight_id` int(11) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `feedbackhotel`
--

CREATE TABLE `feedbackhotel` (
  `feedback_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `rates` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `flight`
--

CREATE TABLE `flight` (
  `flight_id` int(11) NOT NULL,
  `flight_num` varchar(25) NOT NULL,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `d_depart` date NOT NULL,
  `d_arrival` date NOT NULL,
  `t_depart` time NOT NULL,
  `t_arrival` time NOT NULL,
  `Availability` tinyint(1) NOT NULL,
  `aircraft_id` int(11) NOT NULL,
  `airline_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `flight`
--

INSERT INTO `flight` (`flight_id`, `flight_num`, `origin`, `destination`, `d_depart`, `d_arrival`, `t_depart`, `t_arrival`, `Availability`, `aircraft_id`, `airline_id`) VALUES
(7, '4537', 'tunisie', 'london', '2024-05-23', '2024-05-27', '11:30:00', '13:00:00', 1, 2, 1),
(8, '1234', 'turkei', 'chine', '2024-05-31', '2024-06-06', '08:00:00', '11:30:00', 1, 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `flightreservation`
--

CREATE TABLE `flightreservation` (
  `flightrev_id` int(11) NOT NULL,
  `flight_id` int(11) NOT NULL,
  `passenger_id` int(11) NOT NULL,
  `reservationDate` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `priceTotal` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` int(20) NOT NULL,
  `country` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `convention` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `name`, `address`, `email`, `phoneNumber`, `country`, `city`, `convention`) VALUES
(1, 'Hotel California', '123 Sunset Boulevard', 'info@hotelcalifornia.com', 1234567890, 'United States', 'Los Angeles', 5),
(4, 'Le Meurice', '228 Rue de Rivoli', 'info@lemeurice.com', 475649, 'France', 'Paris', 5),
(5, 'Burj Al Arab', 'Jumeirah Street', 'info@burjalarab.com', 34567890, 'United Arab Emirates', 'Dubai', 7);

-- --------------------------------------------------------

--
-- Structure de la table `hotelreservation`
--

CREATE TABLE `hotelreservation` (
  `rev_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `TotPrice` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `room`
--

CREATE TABLE `room` (
  `room_num` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `isAvailable` tinyint(1) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `cin` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL,
  `passport` int(11) NOT NULL,
  `account_status` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`user_id`, `fullName`, `cin`, `phone`, `email`, `password`, `address`, `role`, `passport`, `account_status`) VALUES
(1, 'malak', '11122245', '216458722', 'malak@gmail.com', 'malak', 'nabeul,dar chaabene', 'User', 14786529, 'Active');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `aircraft`
--
ALTER TABLE `aircraft`
  ADD PRIMARY KEY (`aircraft_id`);

--
-- Index pour la table `airline`
--
ALTER TABLE `airline`
  ADD PRIMARY KEY (`airline_id`);

--
-- Index pour la table `billflight`
--
ALTER TABLE `billflight`
  ADD PRIMARY KEY (`Billflight_id`);

--
-- Index pour la table `feedbackhotel`
--
ALTER TABLE `feedbackhotel`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `feedback_fk1` (`client_id`),
  ADD KEY `feedback_fk2` (`hotel_id`);

--
-- Index pour la table `flight`
--
ALTER TABLE `flight`
  ADD PRIMARY KEY (`flight_id`),
  ADD KEY `flight_fk_1` (`aircraft_id`),
  ADD KEY `flight_fk2` (`airline_id`);

--
-- Index pour la table `flightreservation`
--
ALTER TABLE `flightreservation`
  ADD PRIMARY KEY (`flightrev_id`),
  ADD KEY `flight_fk3` (`flight_id`),
  ADD KEY `flight_fk4` (`passenger_id`);

--
-- Index pour la table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotel_id`);

--
-- Index pour la table `hotelreservation`
--
ALTER TABLE `hotelreservation`
  ADD PRIMARY KEY (`rev_id`),
  ADD KEY `rev_fk1` (`room_id`),
  ADD KEY `rev_fk2` (`user_id`);

--
-- Index pour la table `room`
--
ALTER TABLE `room`
  ADD PRIMARY KEY (`room_num`),
  ADD KEY `room_fk1` (`hotel_id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `aircraft`
--
ALTER TABLE `aircraft`
  MODIFY `aircraft_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `airline`
--
ALTER TABLE `airline`
  MODIFY `airline_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `billflight`
--
ALTER TABLE `billflight`
  MODIFY `Billflight_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `feedbackhotel`
--
ALTER TABLE `feedbackhotel`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `flight`
--
ALTER TABLE `flight`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `flightreservation`
--
ALTER TABLE `flightreservation`
  MODIFY `flightrev_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `hotel`
--
ALTER TABLE `hotel`
  MODIFY `hotel_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `hotelreservation`
--
ALTER TABLE `hotelreservation`
  MODIFY `rev_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `room`
--
ALTER TABLE `room`
  MODIFY `room_num` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `feedbackhotel`
--
ALTER TABLE `feedbackhotel`
  ADD CONSTRAINT `feedback_fk1` FOREIGN KEY (`client_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `feedback_fk2` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `flight`
--
ALTER TABLE `flight`
  ADD CONSTRAINT `flight_fk1` FOREIGN KEY (`aircraft_id`) REFERENCES `aircraft` (`aircraft_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flight_fk2` FOREIGN KEY (`airline_id`) REFERENCES `airline` (`airline_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `flightreservation`
--
ALTER TABLE `flightreservation`
  ADD CONSTRAINT `flight_fk3` FOREIGN KEY (`flight_id`) REFERENCES `flight` (`flight_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flight_fk4` FOREIGN KEY (`passenger_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `hotelreservation`
--
ALTER TABLE `hotelreservation`
  ADD CONSTRAINT `rev_fk1` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_num`) ON DELETE CASCADE,
  ADD CONSTRAINT `rev_fk2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `room`
--
ALTER TABLE `room`
  ADD CONSTRAINT `room_fk1` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
