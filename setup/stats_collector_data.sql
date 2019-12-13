-- USE THIS TO CREATE THE STATS DB / TABLE IF NOT USING THE ARCHIVESSPACE DB
CREATE DATABASE statscollector CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'statscollector'@'%' IDENTIFIED BY 'password'; -- CHANGE PASSWORD
GRANT ALL ON statscollector.* TO 'statscollector'@'%';

USE statscollector;
CREATE TABLE `stats_collector_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `application` varchar(255) NOT NULL DEFAULT 'archivesspace',
  `date` datetime NOT NULL,
  `global` blob NOT NULL,
  `name` varchar(255) NOT NULL,
  `repository` blob NOT NULL,
  `url` varchar(255) NOT NULL,
  `user` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `stats_collector_data_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
