-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 22, 2022 at 02:09 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `first_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(20) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'Default Name', 'defaultemail@gmail.com', '123456789', 'Default Message Here.', '2022-09-19 18:50:35'),
(2, 'Testing', 'test@email.com', '+123123123456', 'Hi this is a test message.', NULL),
(5, 'asdf', 'sd@sf.dsa', 'asfd', 'sdf', NULL),
(6, 'asdf', 'sd@sf.dsa', 'asfd', 'sdf', '0000-00-00 00:00:00'),
(7, 'asdf', 'saf@adf.safd', '123123', 'safhsjafd', '0000-00-00 00:00:00'),
(8, 'asdf', 'saf@adf.safd', '123123', 'safhsjafd', '2022-09-19 19:08:02'),
(9, 'Test', 'test@email.com', '12312312', 'HI this is a test message with datetime.', '2022-09-19 19:09:23'),
(10, 'Test Name', 'tahairshad20@gmail.com', '123456789', 'Hi this is a test message how are you?', '2022-09-20 18:41:56'),
(11, 'Test Name', 'tahairshad20@gmail.com', '123456789', 'Hi this is a test message how are you?', '2022-09-20 18:45:24'),
(12, 'Test Name', 'tahairshad20@gmail.com', '123456789', 'Hi this is a test message how are you?', '2022-09-20 18:49:11'),
(13, 'Jameel Ahmed', 'jameelahmed123@gmail.com', '+92123456789', 'Hi,\r\nThis is a test message, I like your work.\r\nLooking forward to work with you.\r\nIt will be an honor sir.', '2022-09-20 19:02:02'),
(14, 'Jameel Ahmed', 'jameelahmed123@gmail.com', '+92123456789', 'Hi,\r\nThis is a test message, I like your work.\r\nLooking forward to work with you.\r\nIt will be an honor sir.', '2022-09-20 19:02:41'),
(15, 'Jameel Ahmed', 'jameelahmed123@gmail.com', '+92123456789', 'Hi,\r\nThis is a test message, I like your work.\r\nLooking forward to work with you.\r\nIt will be an honor sir.', '2022-09-20 22:28:16');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `slug` varchar(40) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `bg_file` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `slug`, `content`, `date`, `bg_file`) VALUES
(1, 'My First Post Title', 'first-post', 'This is my first post, just for checking purposes.\r\nThank You', '2022-09-20 22:21:50', 'post-bg.jpg'),
(2, 'Second Post', 'second-post', 'This is my second post. I have created this post to check for loop in jinja.', '2022-09-20 23:02:40', 'about-bg.jpg'),
(3, 'Third Post', 'third-post', 'this is my third post', '2022-09-20 23:20:06', 'home-bg.jpg'),
(4, 'Fourth post', 'fourth', 'THis is my fourth post welcome.', '2022-09-20 23:20:42', 'post-bg.jpg'),
(5, 'Fifth Post Edited', 'fifth-post', 'This is my fifth post hello welcome how are you?', '2022-09-20 23:21:55', 'about-bg.jpg'),
(6, 'Sixth Post E', 'sixth', 'Hi this is my sixth post and this will not show in list of my posts at homepage of my blog.', '2022-09-20 23:22:56', 'home-bg.jpg'),
(7, 'Seventh Post', 'seventh-post', 'Hi this is my seventh post and I am adding it via new post page.', '2022-09-21 00:13:17', 'post-bg.jpg'),
(8, 'My Post HereEdited', 'my-post-here-edit', 'Hi this is my post.post to home', '2022-09-21 10:31:48', 'home-bg.jpg'),
(13, 'I edited this post', 'my-edited-post', 'Hi I edited my post and also changed bg file to home from post bg.', '2022-09-21 10:52:47', 'home-bg.jpg'),
(16, 'My Edited Here', 'my-edit-here', 'Hi I edited this post. and changed bg img from post to home.', '2022-09-21 11:00:44', 'home-bg.jpg'),
(18, 'Lalalala', 'lala-lala', 'Hi this is a lalalala post', '2022-09-21 11:31:21', 'lala-bg.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`),
  ADD KEY `sno` (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
