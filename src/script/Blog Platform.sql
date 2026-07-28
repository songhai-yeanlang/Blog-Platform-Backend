-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blog_post
-- ------------------------------------------------------
-- Server version	8.0.45

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` varchar(500) DEFAULT NULL,
  `refresh_token` varchar(500) DEFAULT NULL,
  `refresh_token_expires` datetime DEFAULT NULL,
  `role` enum('admin','user') DEFAULT 'user',
  `is_active` tinyint(1) DEFAULT '0',
  `is_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(255) DEFAULT NULL,
  `verification_expires` datetime DEFAULT NULL,
  `last_login_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,'langofficial19+1@gmail.com','$2b$10$5yHPqS2LXXF4nmN5Dwnf1uxlX7r/IMI.g7uGvv9tqeNDdWuUCYQzy','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJsYW5nb2ZmaWNpYWwxOSsxQGdtYWlsLmNvbSIsInJvbGUiOiJhZG1pbiIsImlhdCI6MTc4NDQ0Mjk4OSwiZXhwIjoxNzg0NTI5Mzg5fQ.WLYJAcrKEK6NNydZyczApasyqgW94V1dptsvLXcAGl8','0a55c22ac4a7360c536115da9e3940b421db060f45bf726c2143f38761c01e01d41a96e8ad617c21','2026-07-26 13:36:29','admin',1,1,NULL,NULL,NULL,'2026-06-27 14:46:25','2026-07-19 06:36:29'),(2,'langofficial19@gmail.com','$2b$10$mMzVGbm9vpYYb4VJ9nqs2OIF9zAzbCIAU5wDjkjv7Pja/656txiVi',NULL,NULL,NULL,'user',1,1,NULL,NULL,NULL,'2026-06-27 15:29:48','2026-06-28 03:20:01'),(25,'langofficial19+2@gmail.com','$2b$10$cSWeHlJVoBBtyMUgp5tcOOYQ73rscEPERkBRGsCQIzOeR5ixE7y3u','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjUsImVtYWlsIjoibGFuZ29mZmljaWFsMTkrMkBnbWFpbC5jb20iLCJyb2xlIjoidXNlciIsImlhdCI6MTc4Mzc2ODQ1MSwiZXhwIjoxNzgzODU0ODUxfQ.l_QVIZFd9u_GQ938x2gwLZd_XIBm_6rfeYTbnoGPM_4','82bf8e57d3b115bbad448f0dd9a3de48e5c74acf0541b42e3d0474fad2d43474e8a0786d30c00786','2026-07-18 18:14:12','user',1,1,NULL,NULL,NULL,'2026-06-28 03:19:23','2026-07-11 11:14:11'),(26,'langofficial19+121@gmail.com','$2b$10$rgSQal431YDbWaWHUOev3OKWFvvD24k0GsLIV.9cmkcXP7iLBGvpy','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjYsImVtYWlsIjoibGFuZ29mZmljaWFsMTkrMTIxQGdtYWlsLmNvbSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzg0NDY5Mzc5LCJleHAiOjE3ODQ1NTU3Nzl9.RfgkWpbmRgIoRIBK5x2R3SE5LENhhSnr6ROz0XfL2pM','f3346c704708b36235c90972fc7baae5c9e5d2b75fbc759b9133c29e2e8f0c51437c3f994b89a793','2026-07-26 20:56:19','user',1,1,NULL,NULL,NULL,'2026-07-17 02:18:27','2026-07-19 13:56:19'),(27,'langofficial19+221@gmail.com','$2b$10$xjSdlMa5Y9ryZGAHv7iMs.Od7JHmrjzS8r8LsaVl4qaS1dSQDAH6m','eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjcsImVtYWlsIjoibGFuZ29mZmljaWFsMTkrMjIxQGdtYWlsLmNvbSIsInJvbGUiOiJ1c2VyIiwiaWF0IjoxNzg0Mjk3NDU1LCJleHAiOjE3ODQzODM4NTV9.fqON_p7dNy9b9fXjwy01Q1QX6H6xPLbenar-GUHh8Yg','57c12f1fb139833bb7983227f9d034d1fac160a02c7e752bcce29ddcd0e6a10242f76db8b98298ca','2026-07-24 21:10:56','user',1,1,NULL,NULL,NULL,'2026-07-17 14:02:21','2026-07-17 14:10:55'),(28,'testuser@example.com','$2b$10$IjWC3agYWyy/jl0fSduZNu1Qlut/a9bu/PLECzaEkHhm8jJxWGgjq',NULL,NULL,NULL,'user',0,0,'520af6bebf2a0ecb001e1befdf00c78f9ee059e56eb7e680622a86b7eaceb2b3','2026-07-18 21:39:03',NULL,'2026-07-17 14:39:03','2026-07-17 14:39:03'),(29,'testuser2@example.com','$2b$10$Sey9IiVEuXy4bqhmGVVs5OcM3p6NtLQfu9uFoLfmXxxRf8ud0ePVS',NULL,NULL,NULL,'user',0,0,'c8a5b14f5fe549cf9805bf9bd23075ee5ca510cd59f4104610dafd1b92617fb8','2026-07-18 21:46:54',NULL,'2026-07-17 14:46:54','2026-07-17 14:46:54');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `address` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_post`
--

DROP TABLE IF EXISTS `blog_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `blog_post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `blog_post_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_post`
--

LOCK TABLES `blog_post` WRITE;
/*!40000 ALTER TABLE `blog_post` DISABLE KEYS */;
INSERT INTO `blog_post` VALUES (12,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782577873708.webp','2026-06-27 16:31:13','2026-06-27 16:31:13'),(13,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782577875074.webp','2026-06-27 16:31:15','2026-06-27 16:31:15'),(14,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782577882110.webp','2026-06-27 16:31:22','2026-06-27 16:31:22'),(15,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782577883032.webp','2026-06-27 16:31:23','2026-06-27 16:31:23'),(16,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782577883822.webp','2026-06-27 16:31:23','2026-06-27 16:31:23'),(17,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782581574054.webp','2026-06-27 17:32:54','2026-06-27 17:32:54'),(18,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782581575688.webp','2026-06-27 17:32:55','2026-06-27 17:32:55'),(19,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782581576513.webp','2026-06-27 17:32:56','2026-06-27 17:32:56'),(20,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782581577297.webp','2026-06-27 17:32:57','2026-06-27 17:32:57'),(21,1,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/1_1782581577968.webp','2026-06-27 17:32:58','2026-06-27 17:32:58'),(22,3,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/3_1782620225217.webp','2026-06-28 04:17:05','2026-06-28 04:17:05'),(23,3,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/3_1782620227295.webp','2026-06-28 04:17:07','2026-06-28 04:17:07'),(27,4,4,'sadfas','dfdsfas','/uploads/blogs/4_1784467428852.webp','2026-07-19 13:23:48','2026-07-19 13:23:48'),(28,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469359634.webp','2026-07-19 13:55:59','2026-07-19 13:55:59'),(29,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469360513.webp','2026-07-19 13:56:00','2026-07-19 13:56:00'),(30,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469361267.webp','2026-07-19 13:56:01','2026-07-19 13:56:01'),(31,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469362767.webp','2026-07-19 13:56:02','2026-07-19 13:56:02'),(32,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469363533.webp','2026-07-19 13:56:03','2026-07-19 13:56:03'),(33,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469364313.webp','2026-07-19 13:56:04','2026-07-19 13:56:04'),(34,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469364997.webp','2026-07-19 13:56:05','2026-07-19 13:56:05'),(35,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469365753.webp','2026-07-19 13:56:05','2026-07-19 13:56:05'),(36,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469366453.webp','2026-07-19 13:56:06','2026-07-19 13:56:06'),(37,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469367179.webp','2026-07-19 13:56:07','2026-07-19 13:56:07'),(38,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469367858.webp','2026-07-19 13:56:07','2026-07-19 13:56:07'),(39,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469368544.webp','2026-07-19 13:56:08','2026-07-19 13:56:08'),(40,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469369216.webp','2026-07-19 13:56:09','2026-07-19 13:56:09'),(41,4,1,'The Architecture of Routine: How to Rewire Your Brain for Unbreakable Habits','Introduction: The Motivation Trap\nMost people rely on a fleeting emotion—motivation—to achieve their goals. The problem with motivation is that it is highly unpredictable. It spikes after reading an inspiring book and vanishes on a rainy Monday morning. The secret to long-term success is not motivation; it is the architecture of your routines. By understanding how the human brain processes habits, you can bypass the need for endless willpower and put your success on autopilot.\n\nThe Neuroscience of Routine\nWhen a behavior is repeated enough times, the brain physically changes. This concept, known as neuroplasticity, allows the brain to create efficient neural pathways. When you first learn to drive a car, it requires immense conscious effort. After a few years, you can drive home from work without remembering the commute. Your brain shifts the activity from the prefrontal cortex (the conscious, decision-making center) to the basal ganglia (the automatic, pattern-recognition center). The goal of habit formation is to move positive behaviors into the basal ganglia.','/uploads/blogs/4_1784469369889.webp','2026-07-19 13:56:09','2026-07-19 13:56:09');
/*!40000 ALTER TABLE `blog_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blog_post_tags`
--

DROP TABLE IF EXISTS `blog_post_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_post_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `blog_post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `blog_post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_post_tags`
--

LOCK TABLES `blog_post_tags` WRITE;
/*!40000 ALTER TABLE `blog_post_tags` DISABLE KEYS */;
INSERT INTO `blog_post_tags` VALUES (12,1),(13,1),(14,1),(15,1),(16,1),(17,1),(18,1),(19,1),(20,1),(21,1),(22,1),(23,1),(28,1),(29,1),(30,1),(31,1),(32,1),(33,1),(34,1),(35,1),(36,1),(37,1),(38,1),(39,1),(40,1),(41,1),(27,2);
/*!40000 ALTER TABLE `blog_post_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Web','2026-06-27 14:51:39','2026-06-27 14:51:39'),(2,'General','2026-07-18 01:24:06','2026-07-18 01:24:06'),(3,'Attacker','2026-07-18 01:24:22','2026-07-18 01:24:22'),(4,'Cyber','2026-07-18 01:24:31','2026-07-18 01:24:31');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment_notifications`
--

DROP TABLE IF EXISTS `comment_notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment_notifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `receiver_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `post_id` int NOT NULL,
  `comment_id` int NOT NULL,
  `is_read` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `sender_id` (`sender_id`),
  KEY `post_id` (`post_id`),
  KEY `comment_id` (`comment_id`),
  KEY `idx_receiver_unread` (`receiver_id`,`is_read`),
  CONSTRAINT `comment_notifications_ibfk_1` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_notifications_ibfk_2` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_notifications_ibfk_3` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_notifications_ibfk_4` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment_notifications`
--

LOCK TABLES `comment_notifications` WRITE;
/*!40000 ALTER TABLE `comment_notifications` DISABLE KEYS */;
INSERT INTO `comment_notifications` VALUES (15,3,4,22,18,0,'2026-07-19 06:56:19'),(28,1,4,21,33,0,'2026-07-19 07:41:03'),(29,1,4,17,34,0,'2026-07-19 12:23:59'),(30,1,4,17,35,0,'2026-07-19 12:24:04');
/*!40000 ALTER TABLE `comment_notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `idx_post_comments` (`post_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (18,22,4,'hell','2026-07-19 06:56:19','2026-07-19 06:56:19'),(33,21,4,'Hello','2026-07-19 07:41:03','2026-07-19 07:41:03'),(34,17,4,'hi','2026-07-19 12:23:59','2026-07-19 12:23:59'),(35,17,4,'sdasdsds','2026-07-19 12:24:04','2026-07-19 12:24:04');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `post_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_post_favorite` (`user_id`,`post_id`),
  KEY `post_id` (`post_id`),
  CONSTRAINT `favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `favorites_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `favorites`
--

LOCK TABLES `favorites` WRITE;
/*!40000 ALTER TABLE `favorites` DISABLE KEYS */;
/*!40000 ALTER TABLE `favorites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,'js','2026-06-27 14:51:19','2026-06-27 14:51:19'),(2,'Bootstrap5','2026-07-18 01:16:23','2026-07-18 01:16:23'),(3,'JavaScript','2026-07-18 01:16:43','2026-07-18 01:16:43'),(4,'Vue.js','2026-07-18 01:16:49','2026-07-18 01:16:49'),(5,'React.js','2026-07-18 01:16:57','2026-07-18 01:16:57'),(6,'Tailwind CSS','2026-07-18 01:27:39','2026-07-18 01:27:39');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `bio` text,
  `avatar` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `username` varchar(255) DEFAULT NULL,
  `timezone` varchar(255) DEFAULT NULL,
  `time_format` varchar(50) DEFAULT NULL,
  `start_of_week` varchar(50) DEFAULT NULL,
  `language` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`account_id`) REFERENCES `account` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,1,'Lang2','061883888','Hi ','/uploads/avatars/1_1782620776714.webp','2026-06-27 14:46:25','2026-06-28 04:26:16',NULL,NULL,NULL,NULL,NULL),(2,2,'Test User',NULL,NULL,NULL,'2026-06-27 15:29:48','2026-06-27 15:29:48',NULL,NULL,NULL,NULL,NULL),(3,25,'HongJeou',NULL,NULL,'/uploads/avatars/25_1782620212558.webp','2026-06-28 03:19:23','2026-06-28 04:16:52',NULL,NULL,NULL,NULL,NULL),(4,26,'Lang Dev.','+855 61 883 888','Full-Stack Developer | Vue.js, Express & RESTful API.','/uploads/avatars/26_1784349028072.webp','2026-07-17 02:18:27','2026-07-19 01:54:42',NULL,NULL,NULL,NULL,NULL),(5,27,'Yeanlangr444',NULL,NULL,NULL,'2026-07-17 14:02:21','2026-07-17 14:02:21',NULL,NULL,NULL,NULL,NULL),(6,28,'Test User',NULL,NULL,NULL,'2026-07-17 14:39:03','2026-07-17 14:39:03',NULL,NULL,NULL,NULL,NULL),(7,29,'Test User Two',NULL,NULL,NULL,'2026-07-17 14:46:54','2026-07-17 14:46:54',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `view_blog`
--

DROP TABLE IF EXISTS `view_blog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `view_blog` (
  `id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `viewed_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_view` (`post_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `view_blog_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `blog_post` (`id`) ON DELETE CASCADE,
  CONSTRAINT `view_blog_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `view_blog`
--

LOCK TABLES `view_blog` WRITE;
/*!40000 ALTER TABLE `view_blog` DISABLE KEYS */;
INSERT INTO `view_blog` VALUES (7,15,1,'2026-06-27 16:52:14'),(8,12,1,'2026-06-27 16:53:36'),(9,13,1,'2026-06-27 16:55:55'),(10,14,1,'2026-06-27 17:22:28'),(11,16,1,'2026-06-27 17:22:30'),(12,17,1,'2026-06-27 17:38:28'),(13,21,1,'2026-06-27 17:39:01'),(14,20,1,'2026-06-27 17:43:17'),(15,19,1,'2026-06-28 03:10:45'),(16,18,1,'2026-06-28 03:11:09'),(17,20,3,'2026-06-28 03:21:05'),(18,21,3,'2026-06-28 03:28:45'),(19,12,3,'2026-06-28 03:28:51'),(20,22,1,'2026-06-28 04:17:18'),(21,23,1,'2026-06-28 04:27:58'),(22,23,4,'2026-07-17 02:19:45'),(23,20,4,'2026-07-17 02:25:19'),(24,19,4,'2026-07-17 02:31:21'),(25,22,4,'2026-07-17 02:37:57'),(29,21,4,'2026-07-18 01:31:15'),(30,18,4,'2026-07-18 03:15:15'),(31,17,4,'2026-07-19 12:23:53'),(32,41,4,'2026-07-19 13:56:56'),(33,38,4,'2026-07-20 01:36:28'),(34,37,4,'2026-07-20 01:40:16'),(35,40,4,'2026-07-20 01:51:22');
/*!40000 ALTER TABLE `view_blog` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-07-28  9:54:20
