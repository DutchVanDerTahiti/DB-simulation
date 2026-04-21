-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 21, 2026 at 07:10 PM
-- Wersja serwera: 10.4.32-MariaDB
-- Wersja PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `biblioteka_koncowe`
--

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `autorzy`
--

CREATE TABLE `autorzy` (
  `autor_id` int(11) NOT NULL,
  `imie` varchar(50) DEFAULT NULL,
  `nazwisko` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `autorzy`
--

INSERT INTO `autorzy` (`autor_id`, `imie`, `nazwisko`) VALUES
(1, 'Adam', 'Mickiewicz'),
(2, 'Henryk', 'Sienkiewicz'),
(3, 'Stephen', 'King');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kary`
--

CREATE TABLE `kary` (
  `kara_id` int(11) NOT NULL,
  `wypozyczenie_id` int(11) DEFAULT NULL,
  `kwota` decimal(6,2) DEFAULT NULL,
  `powod` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kary`
--

INSERT INTO `kary` (`kara_id`, `wypozyczenie_id`, `kwota`, `powod`) VALUES
(1, 1, 10.00, 'Przekroczony termin zwrotu');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `kategorie`
--

CREATE TABLE `kategorie` (
  `kategoria_id` int(11) NOT NULL,
  `nazwa` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategorie`
--

INSERT INTO `kategorie` (`kategoria_id`, `nazwa`) VALUES
(1, 'Powieść'),
(2, 'Historia'),
(3, 'Horror');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `klienci`
--

CREATE TABLE `klienci` (
  `klient_id` int(11) NOT NULL,
  `imie` varchar(50) DEFAULT NULL,
  `nazwisko` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `adres` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `klienci`
--

INSERT INTO `klienci` (`klient_id`, `imie`, `nazwisko`, `email`, `telefon`, `adres`) VALUES
(1, 'Anna', 'Kowalska', 'anna.k@example.com', '123456789', 'Wieliczka, ul. Stefana Batorego 14/2'),
(2, 'Jan', 'Nowak', 'jan.n@example.com', '987654321', 'Kraków, ul Lea 25/1'),
(3, 'Daniel', 'Grabowski', 'd.graboswski@example.com', '486359245', 'Kraków, ul. Wrocławska 23/5');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ksiazki_kategorie`
--

CREATE TABLE `ksiazki_kategorie` (
  `ksiazka_id` int(11) NOT NULL,
  `kategoria_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ksiazki_kategorie`
--

INSERT INTO `ksiazki_kategorie` (`ksiazka_id`, `kategoria_id`) VALUES
(1, 1),
(2, 2),
(3, 1),
(3, 3);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `ksiażki`
--

CREATE TABLE `ksiażki` (
  `ksiazka_id` int(11) NOT NULL,
  `tytul` varchar(100) DEFAULT NULL,
  `autor_id` int(11) DEFAULT NULL,
  `rok_wydania` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ksiażki`
--

INSERT INTO `ksiażki` (`ksiazka_id`, `tytul`, `autor_id`, `rok_wydania`) VALUES
(1, 'Pan Tadeusz', 1, 1834),
(2, 'Quo Vadis', 2, 1896),
(3, 'Lśnienie', 3, 1977);

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `pracownicy`
--

CREATE TABLE `pracownicy` (
  `pracownik_id` int(11) NOT NULL,
  `imie` varchar(50) DEFAULT NULL,
  `nazwisko` varchar(50) DEFAULT NULL,
  `stanowisko` varchar(50) DEFAULT NULL,
  `adres` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pracownicy`
--

INSERT INTO `pracownicy` (`pracownik_id`, `imie`, `nazwisko`, `stanowisko`, `adres`) VALUES
(1, 'Maria', 'Zielińska', 'Bibliotekarz', 'Kraków, ul. Królewska 37/2'),
(2, 'Tomasz', 'Wiśniewski', 'Asystent', 'Kraków, ul. Urzędnicza 2/4');

-- --------------------------------------------------------

--
-- Struktura tabeli dla tabeli `wypozyczenia`
--

CREATE TABLE `wypozyczenia` (
  `wypozyczenie_id` int(11) NOT NULL,
  `klient_id` int(11) DEFAULT NULL,
  `ksiazka_id` int(11) DEFAULT NULL,
  `pracownik_id` int(11) DEFAULT NULL,
  `data_wypozyczenia` date DEFAULT NULL,
  `data_zwrotu` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `wypozyczenia`
--

INSERT INTO `wypozyczenia` (`wypozyczenie_id`, `klient_id`, `ksiazka_id`, `pracownik_id`, `data_wypozyczenia`, `data_zwrotu`) VALUES
(1, 1, 1, 1, '2025-05-01', '2025-05-15'),
(2, 2, 2, 2, '2025-05-10', NULL),
(3, 3, 3, 2, '2025-05-23', '2025-06-06');

--
-- Indeksy dla zrzutów tabel
--

--
-- Indeksy dla tabeli `autorzy`
--
ALTER TABLE `autorzy`
  ADD PRIMARY KEY (`autor_id`);

--
-- Indeksy dla tabeli `kary`
--
ALTER TABLE `kary`
  ADD PRIMARY KEY (`kara_id`),
  ADD KEY `wypozyczenie_id` (`wypozyczenie_id`);

--
-- Indeksy dla tabeli `kategorie`
--
ALTER TABLE `kategorie`
  ADD PRIMARY KEY (`kategoria_id`);

--
-- Indeksy dla tabeli `klienci`
--
ALTER TABLE `klienci`
  ADD PRIMARY KEY (`klient_id`);

--
-- Indeksy dla tabeli `ksiazki_kategorie`
--
ALTER TABLE `ksiazki_kategorie`
  ADD PRIMARY KEY (`ksiazka_id`,`kategoria_id`),
  ADD KEY `fk_ksiazki_kategorie_kategoria_id` (`kategoria_id`);

--
-- Indeksy dla tabeli `ksiażki`
--
ALTER TABLE `ksiażki`
  ADD PRIMARY KEY (`ksiazka_id`),
  ADD KEY `autor_id` (`autor_id`);

--
-- Indeksy dla tabeli `pracownicy`
--
ALTER TABLE `pracownicy`
  ADD PRIMARY KEY (`pracownik_id`);

--
-- Indeksy dla tabeli `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD PRIMARY KEY (`wypozyczenie_id`),
  ADD KEY `klient_id` (`klient_id`),
  ADD KEY `ksiazka_id` (`ksiazka_id`),
  ADD KEY `pracownik_id` (`pracownik_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `autorzy`
--
ALTER TABLE `autorzy`
  MODIFY `autor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kary`
--
ALTER TABLE `kary`
  MODIFY `kara_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `kategorie`
--
ALTER TABLE `kategorie`
  MODIFY `kategoria_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `klienci`
--
ALTER TABLE `klienci`
  MODIFY `klient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ksiażki`
--
ALTER TABLE `ksiażki`
  MODIFY `ksiazka_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pracownicy`
--
ALTER TABLE `pracownicy`
  MODIFY `pracownik_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  MODIFY `wypozyczenie_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kary`
--
ALTER TABLE `kary`
  ADD CONSTRAINT `kary_ibfk_1` FOREIGN KEY (`wypozyczenie_id`) REFERENCES `wypozyczenia` (`wypozyczenie_id`);

--
-- Constraints for table `ksiazki_kategorie`
--
ALTER TABLE `ksiazki_kategorie`
  ADD CONSTRAINT `fk_ksiazki_kategorie_kategoria_id` FOREIGN KEY (`kategoria_id`) REFERENCES `kategorie` (`kategoria_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ksiazki_kategorie_ksiazka_id` FOREIGN KEY (`ksiazka_id`) REFERENCES `ksiażki` (`ksiazka_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ksiażki`
--
ALTER TABLE `ksiażki`
  ADD CONSTRAINT `ksiażki_ibfk_1` FOREIGN KEY (`autor_id`) REFERENCES `autorzy` (`autor_id`);

--
-- Constraints for table `wypozyczenia`
--
ALTER TABLE `wypozyczenia`
  ADD CONSTRAINT `wypozyczenia_ibfk_1` FOREIGN KEY (`klient_id`) REFERENCES `klienci` (`klient_id`),
  ADD CONSTRAINT `wypozyczenia_ibfk_2` FOREIGN KEY (`ksiazka_id`) REFERENCES `ksiażki` (`ksiazka_id`),
  ADD CONSTRAINT `wypozyczenia_ibfk_3` FOREIGN KEY (`pracownik_id`) REFERENCES `pracownicy` (`pracownik_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
