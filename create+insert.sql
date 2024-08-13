-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 13, 2024 at 06:22 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `maynimelist`
--

-- --------------------------------------------------------

--
-- Table structure for table `animes`
--

CREATE TABLE `animes` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `genre` varchar(255) NOT NULL,
  `rating` decimal(10,1) NOT NULL,
  `total_episode` int(11) NOT NULL,
  `image_url` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `animes`
--

INSERT INTO `animes` (`id`, `name`, `description`, `genre`, `rating`, `total_episode`, `image_url`) VALUES
(17, 'Kaguya-sama wa Kokurasetai? Tensai-tachi no Renai Zunousen', 'After a slow but eventful summer vacation, Shuchiin Academy\'s second term is now starting in full force. As August transitions into September, Miyuki Shirogane\'s birthday looms ever closer, leaving Kaguya Shinomiya in a serious predicament as to how to celebrate it. Furthermore, the tenure of the school\'s 67th student council is coming to an end. Due to the council members being in different classes, the only time Kaguya and Miyuki have to be together will soon disappear, putting all of their cunning plans at risk. A long and difficult election that will decide the fate of the new student council awaits, as multiple challengers fight for the coveted title of president.', 'Romance', 8.6, 12, '/images/1723521512918_kaguya.jpg'),
(18, 'Sousou no Frieren', 'During their decade-long quest to defeat the Demon King, the members of the hero\'s party—Himmel himself, the priest Heiter, the dwarf warrior Eisen, and the elven mage Frieren—forge bonds through adventures and battles, creating unforgettable precious memories for most of them. However, the time that Frieren spends with her comrades is equivalent to merely a fraction of her life, which has lasted over a thousand years. When the party disbands after their victory, Frieren casually returns to her \"usual\" routine of collecting spells across the continent. Due to her different sense of time, she seemingly holds no strong feelings toward the experiences she went through.', 'Adventure', 9.3, 28, '/images/1723522374792_frieren.jpg'),
(19, 'Kami no Tou: Ouji no Kikan', 'Ja Wangnan can’t seem to pass the 20th floor. Even after failing time and time again, he refuses to give up. On his journey, he meets a mysterious and powerful character named Viole. Wangnan invites Viole to join his team of Regulars. Their journey continues with new challenges at every turn.', 'Action', 7.1, 12, '/images/1723522777268_tog.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `anime_id` int(11) NOT NULL,
  `review` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `anime_id`, `review`) VALUES
(21, 7, 17, 'Kaguya-sama: Love is War is an anime that came out during Winter 2019 and since then, it has become quite a very popular and well-received series.'),
(22, 8, 17, 'Kaguya sama wa kokurasetai season 2 is the disappointment of the season.'),
(23, 7, 18, 'I feel so catered to.  It feels like an eternity since I\'ve been given such a phenomenal anime with a well thought out plot, great art and animation to accompany it, emotional thought provoking moments... more than that, it feels so mature in that it doesn\'t baby me with your typical anime tropes. No obnoxiously screaming kid protags, no overly ecchi scenes meant purely for fanservice, no moments where I have to groan and just deal with whatever stupidity is put before me-- Just a fun and emotional journey that is pure story and human feelings.');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`) VALUES
(7, 'adrian', 'adrian@gmail.com', '$2b$10$MEaffazAwMRDhDWIx9/LpOdrc/YoOi4Kz321dcDNJtsijydJyYlci'),
(8, 'xetha', 'xetha@gmail.com', '$2b$10$sTgaCCaTxPxP8j8shYT0zuFNij4CrdfjWGPxR.14juBYGJ6ZVIROm'),
(9, 'admin', 'admin@gmail.com', '$2b$10$2WfVgORR0FDwqQNf/K1yjON8YGj.Jdjr8L/e9V57.zL0NlGYndGzG');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `animes`
--
ALTER TABLE `animes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_fk` (`user_id`),
  ADD KEY `anime_fk` (`anime_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `animes`
--
ALTER TABLE `animes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `anime_fk` FOREIGN KEY (`anime_id`) REFERENCES `animes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
