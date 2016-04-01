/*
SQLyog v10.2 
MySQL - 5.6.20 : Database - template
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`template` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `template`;

/*Table structure for table `t_action_log` */

DROP TABLE IF EXISTS `t_action_log`;

CREATE TABLE `t_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '操作日志',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `bus_id` varchar(60) DEFAULT NULL COMMENT '业务id',
  `bus_name` varchar(100) DEFAULT NULL COMMENT '业务模块名',
  `entity_class` varchar(100) DEFAULT NULL COMMENT '实体类名',
  `action_descr` varchar(100) DEFAULT NULL COMMENT '行为描述',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '操作时间',
  `create_id` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT NULL COMMENT '删除标记',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5869 DEFAULT CHARSET=utf8;

/*Data for the table `t_action_log` */

insert  into `t_action_log`(`id`,`user_id`,`bus_id`,`bus_name`,`entity_class`,`action_descr`,`create_time`,`create_id`,`update_time`,`update_id`,`del_flag`) values (5861,38,'26','用户','com.libsamp.entity.User','删除','2016-04-01 17:04:05',38,NULL,NULL,1),(5862,38,NULL,'数据字典','com.libsamp.entity.Dictionary','删除','2016-04-01 17:14:06',38,NULL,NULL,1),(5863,38,NULL,'数据字典','com.libsamp.entity.Dictionary','删除','2016-04-01 17:14:11',38,NULL,NULL,1),(5864,38,NULL,'数据字典','com.libsamp.entity.Dictionary','删除','2016-04-01 17:14:13',38,NULL,NULL,1),(5865,38,NULL,'数据字典','com.libsamp.entity.Dictionary','删除','2016-04-01 17:14:19',38,NULL,NULL,1),(5866,38,NULL,'数据字典','com.libsamp.entity.Dictionary','删除','2016-04-01 17:14:23',38,NULL,NULL,1),(5867,38,NULL,'数据字典','com.libsamp.entity.Dictionary','删除','2016-04-01 17:15:11',38,NULL,NULL,1),(5868,38,NULL,'资源菜单','com.libsamp.entity.Resource','删除菜单节点资源菜单','2016-04-01 17:18:14',38,NULL,NULL,1);

/*Table structure for table `t_attachment` */

DROP TABLE IF EXISTS `t_attachment`;

CREATE TABLE `t_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '附件名',
  `uid` varchar(60) DEFAULT NULL COMMENT '附件唯一标识',
  `uri` varchar(120) DEFAULT NULL COMMENT '附件相对路径',
  `suffix` varchar(20) DEFAULT NULL COMMENT '后缀名',
  `source_id` int(11) DEFAULT NULL COMMENT '附件关联对象id',
  `source_entity` varchar(60) DEFAULT NULL COMMENT '关联对象类名',
  `source_type` varchar(30) DEFAULT NULL COMMENT '关联对象属性分类',
  `size` bigint(60) DEFAULT NULL COMMENT '附件大小',
  `down_count` int(22) DEFAULT NULL COMMENT '下载次数',
  `descr` varchar(60) DEFAULT NULL COMMENT '附件备注',
  `create_time` timestamp NULL DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT NULL COMMENT '删除标记 0删除',
  `private_attr` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_attachment` */

/*Table structure for table `t_comment` */

DROP TABLE IF EXISTS `t_comment`;

CREATE TABLE `t_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '评论表',
  `userId` int(11) DEFAULT NULL COMMENT '发表评论人id',
  `sourceId` int(11) DEFAULT NULL COMMENT '业务id',
  `sourceEntity` varchar(50) DEFAULT NULL COMMENT '业务表',
  `content` text COMMENT '评论内容',
  `contentType` tinyint(2) DEFAULT NULL COMMENT '类型，0语音；1文本',
  `atUser` int(11) DEFAULT NULL COMMENT '@对象',
  `goodCount` int(26) DEFAULT NULL COMMENT '点赞数',
  `replyCount` int(26) DEFAULT NULL COMMENT '回复数',
  `level` tinyint(3) DEFAULT NULL COMMENT '等级,0普通;1最佳;2推荐;3热门',
  `medals` varchar(30) DEFAULT NULL COMMENT '标签 多个用逗号分隔',
  `isGoodluck` tinyint(2) DEFAULT NULL COMMENT '是否获得奖励',
  `createTime` datetime DEFAULT NULL COMMENT '评论时间',
  `createId` int(11) DEFAULT NULL COMMENT '创建人',
  `updateTime` timestamp NULL DEFAULT NULL,
  `delFlag` tinyint(2) DEFAULT NULL COMMENT '删除标记',
  `updateId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_comment` */

/*Table structure for table `t_dictionary` */

DROP TABLE IF EXISTS `t_dictionary`;

CREATE TABLE `t_dictionary` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dic_key` varchar(50) DEFAULT NULL,
  `dic_value` varchar(50) DEFAULT NULL,
  `dic_pid` bigint(20) DEFAULT NULL,
  `level_id` bigint(20) DEFAULT NULL,
  `sort_num` int(20) DEFAULT NULL,
  `remark` varchar(60) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_key` (`dic_key`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;

/*Data for the table `t_dictionary` */

insert  into `t_dictionary`(`id`,`dic_key`,`dic_value`,`dic_pid`,`level_id`,`sort_num`,`remark`,`create_time`,`create_id`,`update_time`,`update_id`,`del_flag`) values (0,'ROOT','字典根目录',-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(13,'LOGIN_TYPE','登录类型',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(17,'ADMIN','超级管理员',13,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(18,'DEVICE','设备类型',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(19,'PHONE','手机',18,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(23,'USER_STATUS','用户状态',0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1),(24,'1','可用',23,NULL,NULL,NULL,NULL,NULL,'2015-12-15 19:46:03',38,1),(25,'0','无效',23,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1);

/*Table structure for table `t_feedback` */

DROP TABLE IF EXISTS `t_feedback`;

CREATE TABLE `t_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL COMMENT '反馈用户id',
  `content` text,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delFlag` tinyint(2) DEFAULT NULL,
  `status` tinyint(2) DEFAULT NULL COMMENT '处理状态 1已回 0 未处理',
  `createId` int(11) DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL,
  `updateId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

/*Data for the table `t_feedback` */

insert  into `t_feedback`(`id`,`userId`,`content`,`createTime`,`delFlag`,`status`,`createId`,`updateTime`,`updateId`) values (1,11,'密码忘了怎么办？出发斯蒂芬','2015-09-07 15:34:21',NULL,1,NULL,NULL,NULL),(3,7,'反馈内容','2015-10-19 15:16:23',NULL,1,NULL,NULL,NULL),(4,7,'hhjjj','2015-09-09 10:25:06',NULL,0,NULL,NULL,NULL),(5,7,'hhjjj','2015-09-09 10:27:43',NULL,0,NULL,NULL,NULL),(6,7,'hhjjj','2015-09-09 10:28:16',NULL,0,NULL,NULL,NULL),(7,7,'ggh','2015-09-09 10:59:18',NULL,0,NULL,NULL,NULL),(8,7,'gg','2015-09-09 15:53:13',NULL,1,NULL,NULL,NULL),(9,7,'dgghjjj','2015-09-10 14:48:18',NULL,1,NULL,NULL,NULL),(10,7,'dhhh','2015-09-10 15:29:08',NULL,0,NULL,NULL,NULL),(11,7,'wettyuuhggggg','2015-09-10 16:16:50',NULL,0,NULL,NULL,NULL),(12,7,'qqqqqqqqqq','2015-09-10 16:25:28',NULL,0,NULL,NULL,NULL),(13,7,'rrrtttt','2015-09-10 16:27:54',NULL,0,NULL,NULL,NULL),(14,7,'uuuuu','2015-09-10 16:29:02',NULL,0,NULL,NULL,NULL),(15,7,'ertttyy','2015-09-10 16:32:54',NULL,0,NULL,NULL,NULL),(16,7,'qqqqeertt','2015-09-10 16:35:07',NULL,0,NULL,NULL,NULL),(17,7,'fdddffff','2015-09-10 16:39:42',NULL,0,NULL,NULL,NULL),(18,7,'wwwwww','2015-09-11 09:52:41',NULL,0,NULL,NULL,NULL),(19,7,'dfghhj','2015-09-11 10:43:22',NULL,0,NULL,NULL,NULL),(20,42,'test','2015-10-19 15:17:44',NULL,0,NULL,NULL,NULL),(21,41,'乳房v个如过\n','2015-10-21 16:19:31',NULL,0,NULL,NULL,NULL),(22,50,'rfxhufhiugdddfgdd\n','2015-10-22 17:10:27',NULL,0,NULL,NULL,NULL),(23,31,'fgyuui','2015-10-23 17:34:27',NULL,0,NULL,NULL,NULL),(24,31,'ghjjjii','2015-10-23 17:35:02',NULL,0,NULL,NULL,NULL),(25,31,'gzhzhsjs','2015-10-26 09:39:44',NULL,0,NULL,NULL,NULL);

/*Table structure for table `t_feedback_reply` */

DROP TABLE IF EXISTS `t_feedback_reply`;

CREATE TABLE `t_feedback_reply` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feedbackId` int(11) DEFAULT NULL,
  `userId` int(11) DEFAULT NULL COMMENT '回复人id',
  `content` text,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `delFlag` tinyint(2) DEFAULT NULL,
  `createId` int(11) DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL,
  `updateId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;

/*Data for the table `t_feedback_reply` */

insert  into `t_feedback_reply`(`id`,`feedbackId`,`userId`,`content`,`createTime`,`delFlag`,`createId`,`updateTime`,`updateId`) values (1,11,1,'您好 请到用户中心点击找回密码！','2015-09-07 15:10:43',NULL,NULL,NULL,NULL),(2,1,1,'请通过邮箱找回密码','2015-09-07 15:16:01',NULL,NULL,NULL,NULL),(3,1,1,'通过手机可以找回','2015-09-07 15:33:41',NULL,NULL,NULL,NULL),(4,8,1,'乒乒乓乓判re','2015-09-09 15:52:30',NULL,NULL,NULL,NULL),(5,9,7,'ghjjjj','2015-09-10 14:20:23',NULL,NULL,NULL,NULL),(6,9,7,'fghjjjjppppp','2015-09-10 14:39:53',NULL,NULL,NULL,NULL),(7,9,7,'nnjkkkkkkk','2015-09-10 14:40:06',NULL,NULL,NULL,NULL),(8,9,7,'fgghjk','2015-09-10 14:41:44',NULL,NULL,NULL,NULL),(9,9,1,'哈哈哈！','2015-09-10 14:47:29',NULL,NULL,NULL,NULL),(10,8,7,'gjjkkk','2015-09-10 15:09:25',NULL,NULL,NULL,NULL),(11,9,7,'fghhjjj','2015-09-10 15:18:06',NULL,NULL,NULL,NULL),(12,9,7,'ghhjjkk','2015-09-10 15:19:20',NULL,NULL,NULL,NULL),(13,9,7,'ftyui','2015-09-10 15:20:05',NULL,NULL,NULL,NULL),(14,18,7,'dfghhjj','2015-09-11 10:12:27',NULL,NULL,NULL,NULL),(15,17,7,'xfggh','2015-09-11 10:13:24',NULL,NULL,NULL,NULL),(16,17,7,'xvvvvbb','2015-09-11 10:13:40',NULL,NULL,NULL,NULL),(17,17,7,'hjjii','2015-09-11 10:13:47',NULL,NULL,NULL,NULL),(18,17,7,'gghuuu','2015-09-11 10:14:24',NULL,NULL,NULL,NULL),(19,18,7,'sfghhj','2015-09-11 10:19:11',NULL,NULL,NULL,NULL),(20,18,7,'fgjjkk','2015-09-11 10:19:17',NULL,NULL,NULL,NULL),(21,17,7,'gghhj','2015-09-11 10:20:46',NULL,NULL,NULL,NULL),(22,17,7,'jklopo','2015-09-11 10:20:53',NULL,NULL,NULL,NULL),(23,17,7,'dtuik','2015-09-11 10:21:01',NULL,NULL,NULL,NULL),(24,18,7,'dfghj','2015-09-11 10:34:58',NULL,NULL,NULL,NULL),(25,3,43,'白3持夺','2015-10-19 15:16:23',NULL,NULL,NULL,NULL),(26,3,43,'梦工厂枯','2015-10-19 15:16:31',NULL,NULL,NULL,NULL),(27,24,31,'cvhhj','2015-10-23 17:35:49',NULL,NULL,NULL,NULL),(28,25,31,'fgghhhj','2015-10-26 14:20:30',NULL,NULL,NULL,NULL),(29,25,31,'cgghj','2015-10-26 14:20:45',NULL,NULL,NULL,NULL);

/*Table structure for table `t_resource` */

DROP TABLE IF EXISTS `t_resource`;

CREATE TABLE `t_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  `uri` varchar(50) DEFAULT NULL,
  `pid` int(11) DEFAULT NULL,
  `descr` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT '1',
  `update_time` timestamp NULL DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

/*Data for the table `t_resource` */

insert  into `t_resource`(`id`,`name`,`code`,`uri`,`pid`,`descr`,`create_time`,`create_id`,`del_flag`,`update_time`,`update_id`) values (0,'系统菜单','root','/',-1,NULL,'2015-08-11 09:50:18',NULL,1,NULL,NULL),(14,'客服管理','customer','/customer/',0,'客服管理',NULL,NULL,1,NULL,NULL),(15,'技术管理','techMgr','/tech/',0,'技术管理',NULL,NULL,1,NULL,NULL),(16,'系统管理','systemMgr','/system/',0,'系统管理',NULL,NULL,1,NULL,NULL),(20,'操作日志','tech','/common/actionLog/list',16,'操作日志',NULL,NULL,1,'2015-12-16 11:39:23',38),(21,'用户管理','userMgr','/common/user/list',16,'用户管理',NULL,NULL,1,'2015-12-16 11:39:33',38),(22,'资源管理','resMgr','/common/res/list',16,'资源管理',NULL,NULL,1,NULL,NULL),(23,'数据字典','data_dic','/common/dic/list',16,'',NULL,NULL,1,NULL,NULL),(24,'角色管理','roleMgr','/common/role/list',16,'',NULL,NULL,1,NULL,NULL),(31,'反馈处理','feedback','/customer/feedback/list',14,'',NULL,NULL,1,NULL,NULL),(33,'版本管理','version','/tech/version/list',15,'',NULL,NULL,1,NULL,NULL),(34,'接口测试','api-test','/api-test.html',15,'',NULL,NULL,1,NULL,NULL);

/*Table structure for table `t_role` */

DROP TABLE IF EXISTS `t_role`;

CREATE TABLE `t_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `code` varchar(30) DEFAULT NULL,
  `descr` varchar(50) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `create_id` int(11) DEFAULT NULL,
  `del_flag` tinyint(2) DEFAULT '1',
  `update_time` timestamp NULL DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_role` */

insert  into `t_role`(`id`,`name`,`code`,`descr`,`create_time`,`create_id`,`del_flag`,`update_time`,`update_id`) values (1,'超级管理员','super','超级管理员，开发',NULL,NULL,1,'2015-12-15 17:52:08',38),(2,'管理员','admin','普通管理员',NULL,NULL,1,NULL,NULL),(3,'客服','customer','客服权限',NULL,NULL,1,NULL,NULL);

/*Table structure for table `t_role_resource` */

DROP TABLE IF EXISTS `t_role_resource`;

CREATE TABLE `t_role_resource` (
  `role_id` int(11) DEFAULT NULL,
  `res_id` int(11) DEFAULT NULL,
  UNIQUE KEY `roleId` (`role_id`,`res_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_role_resource` */

insert  into `t_role_resource`(`role_id`,`res_id`) values (1,-1),(1,0),(1,12),(1,13),(1,14),(1,15),(1,16),(1,17),(1,18),(1,19),(1,20),(1,21),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(1,29),(1,30),(1,31),(1,32),(1,33),(1,34),(2,0),(2,15),(2,16),(2,20),(2,21),(2,22),(2,23),(2,24),(3,0),(3,14),(3,19),(3,31),(3,32),(5,0),(5,12),(5,14),(5,17),(5,19),(5,25),(5,26),(5,27),(5,28);

/*Table structure for table `t_schedule_job` */

DROP TABLE IF EXISTS `t_schedule_job`;

CREATE TABLE `t_schedule_job` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jobName` varchar(255) DEFAULT NULL COMMENT '任务名称',
  `jobGroup` varchar(255) DEFAULT NULL COMMENT '任务分组',
  `jobStatus` varchar(20) DEFAULT NULL COMMENT '任务状态(是否启动)',
  `cronExpression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `beanClass` varchar(255) DEFAULT NULL COMMENT '类名(包名+类名)',
  `isConcurrent` varchar(10) DEFAULT NULL COMMENT '是否有状态',
  `springId` varchar(30) DEFAULT NULL COMMENT 'spring bean id',
  `methodName` varchar(255) DEFAULT NULL COMMENT '执行方法名',
  `methodArgs` varchar(255) DEFAULT NULL COMMENT '方法参数,多个用逗号分隔',
  `createId` int(11) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL,
  `updateId` int(11) DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL,
  `delFlag` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_schedule_job` */

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '系统用户表',
  `name` varchar(30) DEFAULT NULL COMMENT '登录名',
  `nick_name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `password` varchar(100) DEFAULT NULL COMMENT '登录密码',
  `email` varchar(30) DEFAULT NULL COMMENT '邮箱',
  `tel` varchar(30) DEFAULT NULL COMMENT '电话',
  `sex` tinyint(2) DEFAULT NULL COMMENT '性别',
  `depart` varchar(20) DEFAULT NULL COMMENT '部门',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `create_id` int(11) DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `update_id` int(11) DEFAULT NULL,
  `is_enable` tinyint(2) DEFAULT NULL COMMENT '是否有效',
  `del_flag` tinyint(2) DEFAULT '1',
  `open_id` varchar(60) DEFAULT NULL COMMENT '第三方id',
  `user_type` int(11) DEFAULT NULL COMMENT '用户类型',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`id`,`name`,`nick_name`,`password`,`email`,`tel`,`sex`,`depart`,`create_time`,`create_id`,`update_time`,`update_id`,`is_enable`,`del_flag`,`open_id`,`user_type`) values (1,'hlb','hlb','5+9Zzu3cGsGUxAs7c0GpjFb6xxXpnXGCtPzauHfJncmWZBkoTSBueITla3CqLa8m','234234@qq.com',NULL,0,NULL,'2015-11-26 16:44:01',NULL,'2015-11-26 16:44:01',38,1,1,NULL,1),(2,'lee','lee','5h2zzjMjxd9ZXakz+ydCsg7hlpJiOsExKNEvO8HiNLXZlXApcwd/GtHHF8dBtCIy','',NULL,0,NULL,'2016-04-01 16:34:38',NULL,'2016-04-01 16:34:38',38,0,1,NULL,NULL),(3,'user1111111','user1111111','mgqC8MDPMUcNev/t40BsyaqEEGcVILcnBE7aFbTCVTKptc2Kr5zsSRnXYlW2v7AP','',NULL,0,NULL,'2015-11-26 15:33:49',NULL,'2015-09-02 12:26:51',NULL,1,0,NULL,NULL),(4,'admin1','admin1','mgqC8MDPMUcNev/t40BsyaqEEGcVILcnBE7aFbTCVTKptc2Kr5zsSRnXYlW2v7AP','',NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 12:26:51',NULL,1,1,NULL,NULL),(5,'qwweervvv','qwweervvv',NULL,NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 12:26:51',NULL,NULL,1,NULL,NULL),(6,'ttyy','ttyy','DiBlk7IXHTL+vsh4WNF8Z6DB2YCLbJXs/56U/EAJ21Lq41B0eGWTz6v/UPiZbqiS',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 12:26:51',NULL,NULL,1,NULL,NULL),(7,'qwerty','dd','-7639-21-45-100-12494-7565123127122-8131-10536',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 12:26:51',NULL,NULL,1,NULL,NULL),(8,'dghh','dghh','-60-4943-118874750-2916-22-115-598544993',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 12:26:51',NULL,NULL,1,NULL,NULL),(9,NULL,NULL,'-9582-246512057202011075-517957166-122',NULL,NULL,0,NULL,'2015-11-13 16:45:57',NULL,'2015-09-02 12:26:51',NULL,NULL,0,NULL,NULL),(10,'123456','123456','-3110-365773-7089-85-6686-3287-1415-12062',NULL,NULL,0,NULL,'2015-11-26 16:29:13',NULL,'2015-09-02 14:19:15',NULL,1,0,NULL,NULL),(11,'poi','poi','-42-31-6492-118-127-62-82116-57-82-34-91-20-110-63',NULL,NULL,1,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 15:38:17',NULL,1,1,NULL,NULL),(12,'hhhhhh','hhhhhh','12447-82-2-2056-43-81-6017-49110-7755-9-27',NULL,NULL,0,NULL,'2015-11-26 15:34:59',NULL,'2015-09-02 16:23:37',NULL,1,0,NULL,NULL),(13,'zxc','zxc','95-893588-16-76-5794493125-24-55-922470',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-02 17:37:06',NULL,1,1,NULL,NULL),(14,'123','123','3244-7198-8489791-10675721453575112',NULL,NULL,0,NULL,'2015-11-26 16:37:12',NULL,'2015-09-07 17:35:18',NULL,1,0,NULL,NULL),(15,'y123','y123','-3110-365773-7089-85-6686-3287-1415-12062',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-07 17:35:18',NULL,1,1,NULL,NULL),(16,'y123','y123','3244-7198-8489791-10675721453575112',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-07 17:35:18',NULL,1,1,NULL,NULL),(17,'123','123','3244-7198-8489791-10675721453575112',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-07 17:35:18',NULL,1,1,NULL,NULL),(18,'asdfgh','asdfgh','-9582-246512057202011075-517957166-122',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-08 10:00:54',NULL,1,1,NULL,NULL),(19,'y123456','y123456','-3110-365773-7089-85-6686-3287-1415-12062',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-08 10:09:35',NULL,1,1,NULL,NULL),(20,'poiuyt','cgbnnnnnnn','-100-79-18124-14127-48-100-78-399-102-2-498-121',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-21 17:16:56',NULL,1,1,NULL,NULL),(22,'1','a','-60-546656-96-7135-12613-5280-102111117-124-101',NULL,NULL,0,NULL,'2016-04-01 16:49:29',NULL,'2015-09-22 11:40:32',NULL,1,0,NULL,NULL),(23,'zxcvbn','zxcvbn','-7639-21-45-100-12494-7565123127122-8131-10536',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-23 10:40:45',NULL,1,1,NULL,NULL),(24,'q','q','wvB4nmrSjD9vhdofuYKNeQ==',NULL,NULL,0,NULL,'2016-04-01 16:59:13',NULL,'2015-09-24 11:29:26',NULL,1,0,NULL,NULL),(25,'aab','aab','e62595ee98b585153dac87ce1ab69c3c',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-25 14:55:50',NULL,1,1,NULL,NULL),(26,'z','z','ZOsY9qj3k2ia0esRNvQ8zw==',NULL,NULL,0,NULL,'2016-04-01 17:04:05',NULL,'2015-09-25 15:03:07',NULL,1,0,NULL,NULL),(27,'a','a','b2AqQNFLyLVOexWa8cFa5Q==',NULL,NULL,0,NULL,'2016-04-01 16:52:03',NULL,'2015-09-25 15:10:26',NULL,1,0,NULL,NULL),(28,'asd','asd','2HKFMrkRMVmol6WA0MH5mg==',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-25 15:20:19',NULL,1,1,NULL,NULL),(29,'w','w','e358efa489f58062f10dd7316b65649e',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-09-25 15:53:55',NULL,1,1,NULL,NULL),(30,'pp','pp','c483f6ce851c9ecd9fb835ff7551737c',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-08 09:47:11',NULL,1,1,NULL,NULL),(31,'qwe','qwe','76d80224611fc919a5d54f0ff9fba446',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-13 21:24:47',NULL,1,1,NULL,NULL),(32,'zxca','zxca','54dd1d58dfdf49eaf9f261d68ccd6d01',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-10 16:20:34',NULL,1,1,NULL,NULL),(33,'zxcvbnm','zxcvbnm','2c75fb22c75b23dc963c7eb91a062cc',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-16 19:47:09',NULL,1,1,NULL,NULL),(34,'test','test','xMpCOKC5I4INzFCab3WEmw==','',NULL,NULL,NULL,'2015-11-26 15:23:52',NULL,'2015-10-15 16:52:39',NULL,1,1,NULL,NULL),(35,'fox','fox','123',NULL,NULL,1,NULL,'2015-11-26 15:23:52',NULL,'2015-10-16 11:53:11',NULL,1,1,NULL,NULL),(38,'admin','admin','opDJegqWL3YJ3Xp6fMSvJA==','',NULL,NULL,NULL,'2015-11-26 15:23:52',NULL,'2015-10-16 17:30:58',NULL,1,1,NULL,NULL),(40,'pingce','pingce','NH6AwQvci+tIsPU5s+DzTQ==','',NULL,NULL,NULL,'2015-11-26 15:23:52',NULL,'2015-10-17 11:14:32',NULL,1,1,NULL,NULL),(41,'qiansanniao','qiansanniao','84aa91015e865409e9cfab76a1104da5',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-17 16:03:29',NULL,1,1,NULL,NULL),(42,'qianniaofei','qianniaofei','84aa91015e865409e9cfab76a1104da5',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-18 12:17:12',NULL,1,1,NULL,NULL),(43,'admin0','admin0','D+a4mBv+tl/ZT5fycERndQ==','',NULL,NULL,NULL,'2015-11-26 15:23:52',NULL,'2015-10-19 10:21:18',NULL,1,1,NULL,NULL),(44,'123456wq','123456wq','e807f1fcf82d132f9bb018ca6738a19f',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-19 14:52:51',NULL,1,1,NULL,NULL),(45,'ww1234','ww1234','e807f1fcf82d132f9bb018ca6738a19f',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-19 14:53:46',NULL,1,1,NULL,NULL),(46,'qwe12','qwe12','e807f1fcf82d132f9bb018ca6738a19f',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-19 14:54:20',NULL,1,1,NULL,NULL),(47,'qwe11','qwe11','e807f1fcf82d132f9bb018ca6738a19f',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-19 14:55:00',NULL,1,1,NULL,NULL),(48,'qq11','qq11','e807f1fcf82d132f9bb018ca6738a19f',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-19 14:55:18',NULL,1,1,NULL,NULL),(49,'13823344435','13823344435','894097db8659545a326dd22f47ac2a0a',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-20 15:48:26',NULL,1,1,NULL,NULL),(50,'yang','yrdgy','d8578edf8458ce06fbc5bb76a58c5ca4',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-21 15:33:30',NULL,1,1,NULL,NULL),(51,'1234567','1234567','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-10-23 10:16:59',NULL,1,1,NULL,NULL),(52,'aaa','aaa','47bce5c74f589f4867dbd57e9ca9f808',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-13 18:20:36',NULL,1,1,NULL,NULL),(53,'yangtest','yangtest','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-14 14:43:33',NULL,1,1,NULL,NULL),(54,'yangtest1','yangtest1','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-04 10:25:36',NULL,1,1,NULL,NULL),(55,'yangtest2','yangtest2','e10adc3949ba59abbe56e057f20f883e',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-04 10:26:13',NULL,1,1,NULL,NULL),(56,'ewq','ewq','4d1ea1367acf0560c6716dd076a84d7f',NULL,NULL,0,NULL,'2015-11-26 15:23:52',NULL,'2015-11-13 20:10:10',NULL,1,1,NULL,NULL),(57,'yy','yy','25f9e794323b453885f5181f1b624d0b',NULL,NULL,1,NULL,'2015-11-26 15:23:52',NULL,'2015-11-12 12:58:48',NULL,1,1,NULL,NULL),(58,'pppplib','这是昵称','123456',NULL,NULL,NULL,NULL,'2015-11-26 15:23:52',NULL,NULL,NULL,NULL,1,NULL,NULL);

/*Table structure for table `t_user_role` */

DROP TABLE IF EXISTS `t_user_role`;

CREATE TABLE `t_user_role` (
  `user_id` int(11) DEFAULT NULL,
  `role_id` int(11) DEFAULT NULL,
  UNIQUE KEY `userId` (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_user_role` */

insert  into `t_user_role`(`user_id`,`role_id`) values (1,1),(1,3),(2,5),(2,6),(3,2),(4,1),(4,6),(5,3),(5,5),(6,2),(6,3),(8,6),(19,6),(36,5),(37,5),(38,1),(39,5),(40,5),(43,1);

/* Procedure structure for procedure `jia` */

/*!50003 DROP PROCEDURE IF EXISTS  `jia` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `jia`(in eid int)
begin 
select sum(employee_salary) from employees where employee_id <= eid;
end */$$
DELIMITER ;

/* Procedure structure for procedure `ta` */

/*!50003 DROP PROCEDURE IF EXISTS  `ta` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`zeusg9`@`localhost` PROCEDURE `ta`()
BEGIN
SELECT AVG(employee_salary) AS aver FROM employees;
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
