/*
Navicat MySQL Data Transfer

Source Server         : cloud
Source Server Version : 50552
Source Host           : localhost:3306
Source Database       : chaoshi

Target Server Type    : MYSQL
Target Server Version : 50552
File Encoding         : 65001

Date: 2017-09-09 20:13:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bg_good`
-- ----------------------------
DROP TABLE IF EXISTS `bg_good`;
CREATE TABLE `bg_good` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `goodName` varchar(50) NOT NULL,
  `price` double NOT NULL,
  `type` tinyint(4) NOT NULL,
  `goodPic` varchar(50) DEFAULT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'CURRENT_TIMESTAMP',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bg_good
-- ----------------------------
INSERT INTO `bg_good` VALUES ('27', '小香肠180g', '18.9', '1', '/images/goodPic/1495622679703.png', '2017-05-24 18:44:39');
INSERT INTO `bg_good` VALUES ('28', '三只松鼠猪肉铺210g', '19.3', '1', '/images/goodPic/1495621893129.png', '2017-05-24 18:31:33');
INSERT INTO `bg_good` VALUES ('29', '老襄阳手工锅巴400g', '13.5', '1', '/images/goodPic/1495622506749.png', '2017-05-24 18:41:46');
INSERT INTO `bg_good` VALUES ('30', '五味园脆薯条', '9.9', '1', '/images/goodPic/1495622547361.png', '2017-05-24 18:42:27');
INSERT INTO `bg_good` VALUES ('31', 'Tipo面包', '15.8', '1', '/images/goodPic/1495622590100.8.png', '2017-05-24 18:43:10');
INSERT INTO `bg_good` VALUES ('32', '77松塔千层酥', '14.9', '1', '/images/goodPic/1495622636965.9.png', '2017-05-24 18:43:57');
INSERT INTO `bg_good` VALUES ('33', '王老吉', '4.5', '2', '/images/goodPic/1495622899446.png', '2017-05-24 18:48:19');
INSERT INTO `bg_good` VALUES ('34', '柠檬茶', '2.6', '2', '/images/goodPic/1495622923141.png', '2017-05-24 18:48:43');
INSERT INTO `bg_good` VALUES ('35', '蒙牛真果粒', '3.6', '2', '/images/goodPic/1495622949093.png', '2017-05-24 18:49:09');
INSERT INTO `bg_good` VALUES ('36', '蒙牛酸酸乳', '2.5', '2', '/images/goodPic/1495622976169.png', '2017-05-24 18:49:36');
INSERT INTO `bg_good` VALUES ('37', '六个核桃', '5.6', '2', '/images/goodPic/1495623000162.png', '2017-05-24 18:50:00');
INSERT INTO `bg_good` VALUES ('38', '真彩0.35中性笔芯', '1.2', '4', '/images/goodPic/1495623427776.35中性笔芯.png', '2017-05-24 18:57:07');
INSERT INTO `bg_good` VALUES ('39', '圆珠笔', '2', '4', '/images/goodPic/1495623309198.png', '2017-05-24 18:55:09');
INSERT INTO `bg_good` VALUES ('40', '彩色水彩铅笔', '2.5', '4', '/images/goodPic/1495623332408.png', '2017-05-24 18:55:32');
INSERT INTO `bg_good` VALUES ('41', '笔记本', '15', '4', '/images/goodPic/1495623353348.png', '2017-05-24 18:55:53');
INSERT INTO `bg_good` VALUES ('42', '白板笔', '3.2', '4', '/images/goodPic/1495623371294.png', '2017-05-24 18:56:11');
INSERT INTO `bg_good` VALUES ('43', '洗发液', '56', '3', '/images/goodPic/1495623689567.png', '2017-05-24 19:01:29');
INSERT INTO `bg_good` VALUES ('44', '沐浴露', '62', '3', '/images/goodPic/1495623712746.png', '2017-05-24 19:01:52');
INSERT INTO `bg_good` VALUES ('45', '双肩包', '120', '3', '/images/goodPic/1495623733509.png', '2017-05-24 19:02:13');
INSERT INTO `bg_good` VALUES ('46', '拉杆箱', '150', '3', '/images/goodPic/1495623750818.png', '2017-05-24 19:02:30');
INSERT INTO `bg_good` VALUES ('47', '卷纸', '6.5', '3', '/images/goodPic/1495623764647.png', '2017-05-24 19:02:44');
INSERT INTO `bg_good` VALUES ('48', '耳机', '63', '5', '/images/goodPic/1495623938738.png', '2017-05-24 19:05:38');
INSERT INTO `bg_good` VALUES ('49', '键盘', '166', '5', '/images/goodPic/1495623960635.png', '2017-05-24 19:06:00');
INSERT INTO `bg_good` VALUES ('50', '鼠标', '132', '5', '/images/goodPic/1495623981165.png', '2017-05-24 19:06:21');
INSERT INTO `bg_good` VALUES ('51', '内存卡', '56', '5', '/images/goodPic/1495624005968.png', '2017-05-24 19:06:45');

-- ----------------------------
-- Table structure for `bg_manager`
-- ----------------------------
DROP TABLE IF EXISTS `bg_manager`;
CREATE TABLE `bg_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(100) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bg_manager
-- ----------------------------
INSERT INTO `bg_manager` VALUES ('10', 'ICy5YqxZB1uWSwcVLSNLcA==', 'zsf', '123456');
INSERT INTO `bg_manager` VALUES ('11', 'ICy5YqxZB1uWSwcVLSNLcA==', 'zhang', '110');
INSERT INTO `bg_manager` VALUES ('12', 'b49XcVCQ2iYyRTmI2aFQGw==', 'm', '123');
INSERT INTO `bg_manager` VALUES ('13', 'ICy5YqxZB1uWSwcVLSNLcA==', 'ml', '321');

-- ----------------------------
-- Table structure for `fg_order`
-- ----------------------------
DROP TABLE IF EXISTS `fg_order`;
CREATE TABLE `fg_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `p_id` int(11) DEFAULT '1',
  `good_id` int(11) NOT NULL DEFAULT '0',
  `count` int(11) NOT NULL DEFAULT '1',
  `money` double NOT NULL,
  `creatTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0:未付款；1：已付款；2：出货',
  PRIMARY KEY (`id`),
  KEY `fk_userid` (`user_id`),
  KEY `fk_goodid` (`good_id`),
  KEY `fk_pid` (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fg_order
-- ----------------------------
INSERT INTO `fg_order` VALUES ('17', '10', '1', '11', '1', '12', '2017-02-03 17:24:40', '1');
INSERT INTO `fg_order` VALUES ('18', '10', '1', '11', '1', '12', '2017-02-03 19:05:01', '1');
INSERT INTO `fg_order` VALUES ('19', '10', '1', '11', '1', '12', '2017-02-03 19:10:13', '1');
INSERT INTO `fg_order` VALUES ('20', '10', '1', '11', '1', '12', '2017-02-03 19:44:30', '1');
INSERT INTO `fg_order` VALUES ('21', '10', '15', '10', '2', '24', '2017-02-03 19:48:33', '1');
INSERT INTO `fg_order` VALUES ('22', '10', '16', '10', '1', '12', '2017-02-03 19:52:26', '1');
INSERT INTO `fg_order` VALUES ('24', '10', '1', '10', '1', '12', '2017-02-03 20:23:22', '0');
INSERT INTO `fg_order` VALUES ('39', '14', '20', '16', '1', '14.3', '2017-02-03 21:27:39', '1');
INSERT INTO `fg_order` VALUES ('42', '14', '22', '17', '2', '4.6', '2017-02-03 21:37:12', '1');
INSERT INTO `fg_order` VALUES ('43', '16', '23', '15', '1', '12.6', '2017-02-03 22:18:13', '1');
INSERT INTO `fg_order` VALUES ('44', '17', '24', '17', '1', '2.3', '2017-02-03 22:20:56', '1');
INSERT INTO `fg_order` VALUES ('45', '17', '24', '17', '1', '2.3', '2017-02-03 22:20:56', '1');
INSERT INTO `fg_order` VALUES ('46', '18', '25', '17', '1', '2.3', '2017-02-03 22:26:45', '1');
INSERT INTO `fg_order` VALUES ('49', '11', '1', '10', '0', '0', '2017-02-06 23:35:43', '0');
INSERT INTO `fg_order` VALUES ('57', '20', '34', '18', '1', '8.7', '2017-02-08 20:07:55', '1');
INSERT INTO `fg_order` VALUES ('58', '20', '34', '17', '1', '2.3', '2017-02-08 20:08:08', '2');
INSERT INTO `fg_order` VALUES ('63', '11', '39', '22', '1', '3', '2017-04-09 21:49:03', '1');
INSERT INTO `fg_order` VALUES ('64', '11', '39', '21', '1', '2', '2017-04-09 21:49:03', '1');
INSERT INTO `fg_order` VALUES ('65', '11', '1', '23', '0', '0', '2017-04-09 22:08:18', '0');
INSERT INTO `fg_order` VALUES ('66', '11', '1', '23', '0', '0', '2017-04-09 22:08:23', '0');
INSERT INTO `fg_order` VALUES ('67', '11', '40', '23', '1', '7.7', '2017-04-09 22:08:38', '1');
INSERT INTO `fg_order` VALUES ('69', '11', '1', '18', '0', '0', '2017-04-09 22:14:26', '0');
INSERT INTO `fg_order` VALUES ('70', '11', '1', '23', '0', '0', '2017-04-09 22:14:32', '0');
INSERT INTO `fg_order` VALUES ('71', '11', '41', '18', '1', '8.7', '2017-04-09 22:14:53', '1');
INSERT INTO `fg_order` VALUES ('72', '11', '42', '23', '1', '7.7', '2017-04-09 22:37:32', '1');
INSERT INTO `fg_order` VALUES ('73', '11', '42', '18', '1', '8.7', '2017-04-09 22:37:32', '1');
INSERT INTO `fg_order` VALUES ('75', '21', '43', '22', '1', '3', '2017-04-10 16:05:52', '1');
INSERT INTO `fg_order` VALUES ('76', '21', '44', '11', '1', '12', '2017-05-24 19:12:04', '2');
INSERT INTO `fg_order` VALUES ('78', '11', '1', '23', '0', '0', '2017-04-11 00:07:51', '0');
INSERT INTO `fg_order` VALUES ('79', '11', '1', '28', '0', '0', '2017-05-18 22:39:18', '0');
INSERT INTO `fg_order` VALUES ('80', '11', '1', '28', '0', '0', '2017-05-18 22:38:57', '0');
INSERT INTO `fg_order` VALUES ('81', '11', '1', '28', '0', '0', '2017-05-18 23:39:46', '0');
INSERT INTO `fg_order` VALUES ('82', '20', '1', '28', '0', '0', '2017-05-18 22:49:56', '0');
INSERT INTO `fg_order` VALUES ('83', '20', '1', '27', '0', '0', '2017-05-18 22:49:50', '0');
INSERT INTO `fg_order` VALUES ('85', '20', '1', '28', '0', '0', '2017-05-18 23:12:16', '0');
INSERT INTO `fg_order` VALUES ('86', '11', '1', '27', '0', '0', '2017-05-18 23:39:49', '0');
INSERT INTO `fg_order` VALUES ('87', '11', '1', '27', '0', '0', '2017-05-18 23:39:54', '0');
INSERT INTO `fg_order` VALUES ('88', '11', '1', '27', '0', '0', '2017-05-18 23:40:26', '0');
INSERT INTO `fg_order` VALUES ('89', '11', '46', '27', '1', '18.9', '2017-05-24 21:58:48', '1');
INSERT INTO `fg_order` VALUES ('91', '11', '1', '28', '0', '0', '2017-05-23 20:22:34', '0');
INSERT INTO `fg_order` VALUES ('92', '11', '1', '28', '0', '0', '2017-05-23 19:27:20', '0');
INSERT INTO `fg_order` VALUES ('93', '20', '1', '28', '0', '0', '2017-05-24 11:01:04', '0');
INSERT INTO `fg_order` VALUES ('94', '20', '47', '28', '1', '19.3', '2017-05-24 22:06:24', '1');
INSERT INTO `fg_order` VALUES ('96', '20', '47', '48', '1', '63', '2017-05-24 22:06:24', '1');
INSERT INTO `fg_order` VALUES ('97', '20', '47', '34', '1', '2.6', '2017-05-24 22:06:24', '1');
INSERT INTO `fg_order` VALUES ('98', '11', '46', '31', '1', '15.8', '2017-05-24 21:58:48', '1');
INSERT INTO `fg_order` VALUES ('99', '20', '47', '32', '1', '14.9', '2017-05-24 22:06:24', '1');
INSERT INTO `fg_order` VALUES ('112', '20', '48', '32', '1', '14.9', '2017-05-25 10:55:19', '1');
INSERT INTO `fg_order` VALUES ('113', '20', '48', '31', '1', '15.8', '2017-05-25 10:55:19', '1');

-- ----------------------------
-- Table structure for `fg_pay`
-- ----------------------------
DROP TABLE IF EXISTS `fg_pay`;
CREATE TABLE `fg_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payId` varchar(50) NOT NULL COMMENT '记录支付编号',
  `orderIds` varchar(20) NOT NULL COMMENT '记录支付所涉及的订单以“Ha”为间隔',
  `payType` tinyint(4) NOT NULL COMMENT '0:在线 ；1：货到付款',
  `payTime` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fg_pay
-- ----------------------------
INSERT INTO `fg_pay` VALUES ('1', '2017020300570b1cHa4Ha2Ha1', '4Ha2Ha1', '0', '201702030057');
INSERT INTO `fg_pay` VALUES ('2', '2017020301000b1cHa4Ha2Ha1', '4Ha2Ha1', '0', '201702030100');
INSERT INTO `fg_pay` VALUES ('3', '2017020301010b1cHa9', '9', '0', '201702030101');
INSERT INTO `fg_pay` VALUES ('4', '2017020301030b1cHa10', '10', '0', '201702030103');
INSERT INTO `fg_pay` VALUES ('5', '2017020301030b1cHa10', '10', '0', '201702030103');
INSERT INTO `fg_pay` VALUES ('6', '2017020301050b1cHa11', '11', '0', '201702030105');
INSERT INTO `fg_pay` VALUES ('7', '2017020301070b1cHa12', '12', '0', '201702030107');
INSERT INTO `fg_pay` VALUES ('8', '2017020301110b1cHa13', '13', '0', '201702030111');
INSERT INTO `fg_pay` VALUES ('9', '2017020301120b1cHa14', '14', '0', '201702030112');
INSERT INTO `fg_pay` VALUES ('10', '2017020301260b1cHa15', '15', '0', '201702030126');
INSERT INTO `fg_pay` VALUES ('11', '2017020317240b1cHa17', '17', '0', '201702031724');
INSERT INTO `fg_pay` VALUES ('12', '2017020319040b1cHa18', '18', '0', '201702031904');
INSERT INTO `fg_pay` VALUES ('13', '2017020319100b1cHa19', '19', '0', '201702031910');
INSERT INTO `fg_pay` VALUES ('14', '2017020319430b1cHa20', '20', '0', '201702031943');
INSERT INTO `fg_pay` VALUES ('15', '2017020319480b1cHa21', '21', '0', '201702031948');
INSERT INTO `fg_pay` VALUES ('16', '2017020319520b1cHa22', '22', '0', '201702031952');
INSERT INTO `fg_pay` VALUES ('17', '2017020320380b1cHa28', '28', '1', '201702032038');
INSERT INTO `fg_pay` VALUES ('18', '2017020321120b1cHa37', '37', '1', '201702032112');
INSERT INTO `fg_pay` VALUES ('19', '2017020321210b1cHa38', '38', '1', '201702032121');
INSERT INTO `fg_pay` VALUES ('20', '2017020321270b1cHa39', '39', '1', '201702032127');
INSERT INTO `fg_pay` VALUES ('21', '2017020321310b1cHa41', '41', '1', '201702032131');
INSERT INTO `fg_pay` VALUES ('22', '2017020321370b1cHa42', '42', '1', '201702032137');
INSERT INTO `fg_pay` VALUES ('23', '2017020322180b1cHa43', '43', '0', '201702032218');
INSERT INTO `fg_pay` VALUES ('24', '2017020322200b1cHa45Ha44', '45Ha44', '0', '201702032220');
INSERT INTO `fg_pay` VALUES ('25', '2017020322260b1cHa46', '46', '0', '201702032226');
INSERT INTO `fg_pay` VALUES ('26', '2017020322270b1cHa47', '47', '0', '201702032227');
INSERT INTO `fg_pay` VALUES ('27', '2017020623350b1cHa48', '48', '0', '201702062335');
INSERT INTO `fg_pay` VALUES ('28', '2017020623370b1cHa50', '50', '0', '201702062337');
INSERT INTO `fg_pay` VALUES ('29', '2017020719090b1cHa51', '51', '0', '201702071909');
INSERT INTO `fg_pay` VALUES ('30', '2017020719200b1cHa52', '52', '0', '201702071920');
INSERT INTO `fg_pay` VALUES ('31', '2017020719210b1cHa53', '53', '0', '201702071921');
INSERT INTO `fg_pay` VALUES ('32', '2017020721110b1cHa55', '55', '1', '201702072111');
INSERT INTO `fg_pay` VALUES ('33', '2017020819530b1cHa56', '56', '0', '201702081953');
INSERT INTO `fg_pay` VALUES ('34', '2017020820070b1cHa58Ha57', '58Ha57', '0', '201702082007');
INSERT INTO `fg_pay` VALUES ('35', '2017020820090b1cHa54Ha59Ha55', '54Ha59Ha55', '0', '201702082009');
INSERT INTO `fg_pay` VALUES ('36', '2017020820150b1cHa61Ha60', '61Ha60', '0', '201702082015');
INSERT INTO `fg_pay` VALUES ('37', '2017040815440b1cHa63Ha62', '63Ha62', '0', '201704081544');
INSERT INTO `fg_pay` VALUES ('38', '2017040921480b1cHa62', '62', '0', '201704092148');
INSERT INTO `fg_pay` VALUES ('39', '2017040921490b1cHa64Ha63', '64Ha63', '0', '201704092149');
INSERT INTO `fg_pay` VALUES ('40', '2017040922080b1cHa68Ha67', '68Ha67', '1', '201704092208');
INSERT INTO `fg_pay` VALUES ('41', '2017040922140b1cHa71', '71', '0', '201704092214');
INSERT INTO `fg_pay` VALUES ('42', '2017040922370b1cHa73Ha72', '73Ha72', '0', '201704092237');
INSERT INTO `fg_pay` VALUES ('43', '2017041016050b1cHa75Ha74', '75Ha74', '0', '201704101605');
INSERT INTO `fg_pay` VALUES ('44', '2017041016070b1cHa76', '76', '0', '201704101607');
INSERT INTO `fg_pay` VALUES ('45', '2017041100060b1cHa77', '77', '0', '201704110006');
INSERT INTO `fg_pay` VALUES ('46', '2017052421580b1cHa98Ha89', '98Ha89', '0', '201705242158');
INSERT INTO `fg_pay` VALUES ('47', '2017052422060b1cHa99Ha97Ha96Ha94', '99Ha97Ha96Ha94', '0', '201705242206');
INSERT INTO `fg_pay` VALUES ('48', '2017052510550b1cHa113Ha112', '113Ha112', '1', '201705251055');

-- ----------------------------
-- Table structure for `fg_user`
-- ----------------------------
DROP TABLE IF EXISTS `fg_user`;
CREATE TABLE `fg_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(20) NOT NULL,
  `password` varchar(100) NOT NULL COMMENT 'md5加密',
  `grade` varchar(10) DEFAULT NULL,
  `sushe` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '用户申请账号的时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of fg_user
-- ----------------------------
INSERT INTO `fg_user` VALUES ('9', '1111', 'ZRK9Q9nKpuAsmQsKgmUtyg==', '111', '111', '1111', '2017-01-30 20:28:22');
INSERT INTO `fg_user` VALUES ('10', 'zhang', 'ICy5YqxZB1uWSwcVLSNLcA==', '356', '356', '356', '2017-01-31 15:21:57');
INSERT INTO `fg_user` VALUES ('11', 'zsf', 'ICy5YqxZB1uWSwcVLSNLcA==', '9', '7-704', '133', '2017-04-09 22:15:24');
INSERT INTO `fg_user` VALUES ('14', 'admin', 'ICy5YqxZB1uWSwcVLSNLcA==', '12-3', '12', '111111', '2017-02-03 21:27:23');
INSERT INTO `fg_user` VALUES ('15', 'xsf', 'ICy5YqxZB1uWSwcVLSNLcA==', '12', '12', '1111', '2017-02-03 21:30:55');
INSERT INTO `fg_user` VALUES ('16', '454', '28TYS/z+IoS6Eb7/uFOoxA==', '454', '454', '454545454', '2017-02-03 22:17:57');
INSERT INTO `fg_user` VALUES ('17', 'm', 'b49XcVCQ2iYyRTmI2aFQGw==', '2013', '29515', '123', '2017-02-03 22:20:18');
INSERT INTO `fg_user` VALUES ('18', 'zsf', 'ICy5YqxZB1uWSwcVLSNLcA==', '123', '123', '123', '2017-02-03 22:26:24');
INSERT INTO `fg_user` VALUES ('19', 'zss', 'ICy5YqxZB1uWSwcVLSNLcA==', '2015', '704', '13111', '2017-02-08 19:52:48');
INSERT INTO `fg_user` VALUES ('20', 'm', 'ICy5YqxZB1uWSwcVLSNLcA==', '2013', '29515', '130', '2017-02-08 20:07:00');
INSERT INTO `fg_user` VALUES ('21', '1', 'xMpCOKC5I4INzFCab3WEmw==', '13', '29', '188', '2017-04-10 16:04:51');
