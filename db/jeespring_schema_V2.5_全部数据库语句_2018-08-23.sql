# Host: localhost  (Version: 5.5.54-log)
# Date: 2018-08-23 14:08:22
# Generator: MySQL-Front 5.3  (Build 4.234)

/*!40101 SET NAMES utf8 */;

#
# Structure for table "calendar"
#

CREATE TABLE `calendar` (
  `id` varchar(64) NOT NULL COMMENT '主键',
  `title` varchar(64) DEFAULT NULL COMMENT '事件标题',
  `starttime` varchar(64) CHARACTER SET latin1 DEFAULT NULL COMMENT '事件开始时间',
  `endtime` varchar(64) CHARACTER SET latin1 DEFAULT NULL COMMENT '事件结束时间',
  `allday` varchar(64) CHARACTER SET latin1 DEFAULT NULL COMMENT '是否为全天时间',
  `color` varchar(64) CHARACTER SET latin1 DEFAULT NULL COMMENT '时间的背景色',
  `userid` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='日历';

#
# Data for table "calendar"
#

INSERT INTO `calendar` VALUES ('19f080b820f84117b37bcf8395fc7a77','1111','2017-12-20','','1','#360','1'),('1e2b01de73ee40cbabab6438c37ceaa0','1111','2018-01-10','','1','#f30','1'),('2d8f14cc2be54b0cabd8a03fe42508bf','下雨 国庆','2018-07-11','','1','#360','1'),('32bfc09b0d184eb9b44df71f1694314d','111','2017-12-27','','1','#06c','1'),('343ed3c7486f41298a9bc9df342b8d27','sss','2016-04-27','','1','#f30','1'),('657732bf5a694d9aa42cbb0f2d0cea4c','2222','2018-01-11','','1','#f30','1'),('74b3da86093c4d8eb3a95093d6c8b212','333','2016-05-04','','1','#06c','1'),('77230f3891904c469eda43a68ba8b950','eeee','2017-12-16','','1','#f30','1'),('ac9d77bb842a4e7f9afb55d26e8fd51d','上午开会','2016-04-05 080000','2016-04-05 120000','0','#f30',NULL),('ca8dd8d37f2e4a169666240c02323f8b','wwww','2017-12-15','','1','#06c','1'),('d468d4f2982e409280c1d328d9f3d1c0','一起吃饭','2016-04-21','','1','#360',NULL),('de17b6c7af16456bbffcf8f42d451441','2222','2017-12-21','','1','#f30','1'),('ed8112f26f764301b73ee6671806b6e1','去看电影','2016-04-23','','1','#06c',NULL),('ef72e895035145f79a1e5e1202379f9d','qqq','2017-12-07','','1','#f30','1'),('fe29fbbdc50e4d27b266b15fb90f0d41','早上要开会','2016-04-07','2016-04-07','1','#06c',NULL);
