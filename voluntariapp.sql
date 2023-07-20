-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: voluntariapp
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `id_answer` int NOT NULL,
  `answer` varchar(255) NOT NULL,
  `is_Correct` varchar(45) NOT NULL,
  `fk_question` int NOT NULL,
  `fk_form` int NOT NULL,
  `fk_volunteer_answer` int NOT NULL,
  PRIMARY KEY (`id_answer`),
  KEY `fk_question` (`fk_question`),
  KEY `fk_volunteer_answer` (`fk_volunteer_answer`),
  KEY `fk_form` (`fk_form`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`fk_question`) REFERENCES `questions` (`id_question`),
  CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`fk_volunteer_answer`) REFERENCES `volunteers_answers` (`id_volunteer_answer`),
  CONSTRAINT `answers_ibfk_3` FOREIGN KEY (`fk_form`) REFERENCES `forms` (`id_form`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `configurations`
--

DROP TABLE IF EXISTS `configurations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `configurations` (
  `id_person_color` int NOT NULL,
  `primary_color` varchar(255) DEFAULT NULL,
  `secondary_color` varchar(45) DEFAULT NULL,
  `url_logo` mediumblob NOT NULL,
  `fk_organization` int NOT NULL,
  `fk_user` int NOT NULL,
  PRIMARY KEY (`id_person_color`),
  KEY `fk_organization` (`fk_organization`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `configurations_ibfk_1` FOREIGN KEY (`fk_organization`) REFERENCES `organizations` (`id_organization`),
  CONSTRAINT `configurations_ibfk_2` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `configurations`
--

LOCK TABLES `configurations` WRITE;
/*!40000 ALTER TABLE `configurations` DISABLE KEYS */;
/*!40000 ALTER TABLE `configurations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_has_photos`
--

DROP TABLE IF EXISTS `event_has_photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_has_photos` (
  `id_event_has_photo` int NOT NULL,
  `photo` mediumblob NOT NULL,
  `fk_event` int NOT NULL,
  PRIMARY KEY (`id_event_has_photo`),
  KEY `fk_event` (`fk_event`),
  CONSTRAINT `event_has_photos_ibfk_1` FOREIGN KEY (`fk_event`) REFERENCES `events` (`id_event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_has_photos`
--

LOCK TABLES `event_has_photos` WRITE;
/*!40000 ALTER TABLE `event_has_photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_has_photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id_event` int NOT NULL,
  `name` varchar(45) NOT NULL,
  `event_date` date NOT NULL,
  `description` text NOT NULL,
  `street` varchar(45) NOT NULL,
  `cologne` varchar(45) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  `municypaly` varchar(45) NOT NULL,
  `fk_user` int NOT NULL,
  `fk_organization` int NOT NULL,
  PRIMARY KEY (`id_event`),
  KEY `fk_user` (`fk_user`),
  KEY `fk_organization` (`fk_organization`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`),
  CONSTRAINT `events_ibfk_2` FOREIGN KEY (`fk_organization`) REFERENCES `organizations` (`id_organization`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forms`
--

DROP TABLE IF EXISTS `forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `forms` (
  `id_form` int NOT NULL,
  `name_forms` varchar(45) NOT NULL,
  `instructions` text NOT NULL,
  `fk_event` int NOT NULL,
  PRIMARY KEY (`id_form`),
  KEY `fk_event` (`fk_event`),
  CONSTRAINT `forms_ibfk_1` FOREIGN KEY (`fk_event`) REFERENCES `events` (`id_event`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forms`
--

LOCK TABLES `forms` WRITE;
/*!40000 ALTER TABLE `forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organizations`
--

DROP TABLE IF EXISTS `organizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organizations` (
  `id_organization` int NOT NULL AUTO_INCREMENT,
  `bussines_name` varchar(45) NOT NULL,
  `street` varchar(45) NOT NULL,
  `cologne` varchar(45) NOT NULL,
  `postal_code` varchar(5) NOT NULL,
  `municipality` varchar(45) NOT NULL,
  `rfc` varchar(13) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `fk_user` int NOT NULL,
  PRIMARY KEY (`id_organization`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `organizations_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organizations`
--

LOCK TABLES `organizations` WRITE;
/*!40000 ALTER TABLE `organizations` DISABLE KEYS */;
/*!40000 ALTER TABLE `organizations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `photos`
--

DROP TABLE IF EXISTS `photos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photos` (
  `id_photo` int NOT NULL,
  `photo` mediumblob,
  `type` varchar(45) DEFAULT NULL,
  `fk_user` int NOT NULL,
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `photos_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photos`
--

LOCK TABLES `photos` WRITE;
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `postulations`
--

DROP TABLE IF EXISTS `postulations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `postulations` (
  `id_postulation` int NOT NULL,
  `is_Accept` tinyint NOT NULL,
  `fk_volunteer` int NOT NULL,
  `fk_user` int NOT NULL,
  `fk_event` int NOT NULL,
  PRIMARY KEY (`id_postulation`),
  KEY `fk_volunteer` (`fk_volunteer`),
  KEY `fk_event` (`fk_event`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `postulations_ibfk_1` FOREIGN KEY (`fk_volunteer`) REFERENCES `volunteers` (`id_volunteer`),
  CONSTRAINT `postulations_ibfk_2` FOREIGN KEY (`fk_event`) REFERENCES `events` (`id_event`),
  CONSTRAINT `postulations_ibfk_3` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `postulations`
--

LOCK TABLES `postulations` WRITE;
/*!40000 ALTER TABLE `postulations` DISABLE KEYS */;
/*!40000 ALTER TABLE `postulations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `id_question` int NOT NULL,
  `question` varchar(45) NOT NULL,
  `fk_form` int NOT NULL,
  PRIMARY KEY (`id_question`),
  KEY `fk_form` (`fk_form`),
  CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`fk_form`) REFERENCES `forms` (`id_form`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id_role` int NOT NULL AUTO_INCREMENT,
  `description` varchar(45) NOT NULL,
  `fk_user` int NOT NULL,
  PRIMARY KEY (`id_role`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `roles_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ADMIN',1),(2,'ORGANIZATION',2),(3,'VOLUNTEER',3),(4,'ADMIN',4);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(12) NOT NULL,
  `is_active` tinyint NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jassiel@gmail.com','admin',1),(2,'miguel@gmail.com','migue',1),(3,'erik@gmail.com','erik',1),(4,'wendy@gmail.com','wendy',1),(6,'carsi','maxi',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteers`
--

DROP TABLE IF EXISTS `volunteers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteers` (
  `id_volunteer` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `surname` varchar(45) NOT NULL,
  `lastanme` varchar(45) NOT NULL,
  `birthday` date NOT NULL,
  `address` varchar(100) NOT NULL,
  `phone` varchar(10) NOT NULL,
  `curp` varchar(18) NOT NULL,
  `fk_user` int NOT NULL,
  PRIMARY KEY (`id_volunteer`),
  KEY `fk_user` (`fk_user`),
  CONSTRAINT `volunteers_ibfk_1` FOREIGN KEY (`fk_user`) REFERENCES `users` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteers`
--

LOCK TABLES `volunteers` WRITE;
/*!40000 ALTER TABLE `volunteers` DISABLE KEYS */;
/*!40000 ALTER TABLE `volunteers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `volunteers_answers`
--

DROP TABLE IF EXISTS `volunteers_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `volunteers_answers` (
  `id_volunteer_answer` int NOT NULL AUTO_INCREMENT,
  `fk_postulations` int NOT NULL,
  PRIMARY KEY (`id_volunteer_answer`),
  KEY `fk_postulations` (`fk_postulations`),
  CONSTRAINT `volunteers_answers_ibfk_1` FOREIGN KEY (`fk_postulations`) REFERENCES `postulations` (`id_postulation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `volunteers_answers`
--

LOCK TABLES `volunteers_answers` WRITE;
/*!40000 ALTER TABLE `volunteers_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `volunteers_answers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-07-20 17:51:10
