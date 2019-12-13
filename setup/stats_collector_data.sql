-- USE THIS TO CREATE THE STATS TABLE IF NOT USING THE ARCHIVESSPACE DB
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
