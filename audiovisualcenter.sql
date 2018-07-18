/*
Navicat MySQL Data Transfer

Source Server         : remote
Source Server Version : 50718
Source Host           : 169.254.65.40:3306
Source Database       : audiovisualcenter

Target Server Type    : MYSQL
Target Server Version : 50718
File Encoding         : 65001

Date: 2018-01-10 20:25:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for borrow
-- ----------------------------
DROP TABLE IF EXISTS `borrow`;
CREATE TABLE `borrow` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) DEFAULT NULL,
  `manager_name` varchar(50) DEFAULT NULL,
  `borrow_time` datetime DEFAULT NULL,
  `return_time` datetime DEFAULT NULL,
  `borrow_introduce` bit(1) DEFAULT NULL,
  `borrow_msg` varchar(255) DEFAULT NULL,
  `borrow_purpose` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of borrow
-- ----------------------------
INSERT INTO `borrow` VALUES ('1', '19', 'ss', '2018-01-03 15:17:03', null, '\0', null, 'ss');

-- ----------------------------
-- Table structure for borrow_basket
-- ----------------------------
DROP TABLE IF EXISTS `borrow_basket`;
CREATE TABLE `borrow_basket` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `equip_id` bigint(20) DEFAULT NULL,
  `con` int(4) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of borrow_basket
-- ----------------------------

-- ----------------------------
-- Table structure for borrow_equip
-- ----------------------------
DROP TABLE IF EXISTS `borrow_equip`;
CREATE TABLE `borrow_equip` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `borrow_id` bigint(20) DEFAULT NULL,
  `equip_id` bigint(20) DEFAULT NULL,
  `con` bit(1) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=366 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of borrow_equip
-- ----------------------------
INSERT INTO `borrow_equip` VALUES ('254', '2', '6', '', '1');
INSERT INTO `borrow_equip` VALUES ('256', '2', '14', '', '1');
INSERT INTO `borrow_equip` VALUES ('257', '3', '45', '', '1');
INSERT INTO `borrow_equip` VALUES ('258', '4', '52', '', '1');
INSERT INTO `borrow_equip` VALUES ('259', '5', '53', '', '1');
INSERT INTO `borrow_equip` VALUES ('260', '6', '55', '', '1');
INSERT INTO `borrow_equip` VALUES ('261', '7', '56', '', '1');
INSERT INTO `borrow_equip` VALUES ('262', '8', '58', '', '1');
INSERT INTO `borrow_equip` VALUES ('263', '9', '59', '', '1');
INSERT INTO `borrow_equip` VALUES ('264', '10', '39', '', '1');
INSERT INTO `borrow_equip` VALUES ('265', '11', '22', '', '1');
INSERT INTO `borrow_equip` VALUES ('266', '12', '23', '', '1');
INSERT INTO `borrow_equip` VALUES ('267', '13', '31', '', '1');
INSERT INTO `borrow_equip` VALUES ('268', '14', '24', '', '1');
INSERT INTO `borrow_equip` VALUES ('269', '14', '15', '', '1');
INSERT INTO `borrow_equip` VALUES ('270', '14', '2', '', '1');
INSERT INTO `borrow_equip` VALUES ('271', '14', '85', '', '1');
INSERT INTO `borrow_equip` VALUES ('272', '14', '67', '', '1');
INSERT INTO `borrow_equip` VALUES ('273', '14', '64', '', '1');
INSERT INTO `borrow_equip` VALUES ('274', '14', '61', '', '1');
INSERT INTO `borrow_equip` VALUES ('275', '14', '183', '', '1');
INSERT INTO `borrow_equip` VALUES ('276', '14', '190', '', '1');
INSERT INTO `borrow_equip` VALUES ('277', '14', '198', '', '1');
INSERT INTO `borrow_equip` VALUES ('278', '14', '205', '', '1');
INSERT INTO `borrow_equip` VALUES ('279', '14', '218', '', '1');
INSERT INTO `borrow_equip` VALUES ('280', '14', '224', '', '1');
INSERT INTO `borrow_equip` VALUES ('281', '14', '232', '', '1');
INSERT INTO `borrow_equip` VALUES ('282', '14', '235', '', '1');
INSERT INTO `borrow_equip` VALUES ('283', '14', '256', '', '1');
INSERT INTO `borrow_equip` VALUES ('284', '14', '245', '', '1');
INSERT INTO `borrow_equip` VALUES ('285', '14', '268', '', '1');
INSERT INTO `borrow_equip` VALUES ('286', '15', '40', '', '1');
INSERT INTO `borrow_equip` VALUES ('287', '15', '20', '', '1');
INSERT INTO `borrow_equip` VALUES ('288', '15', '25', '', '1');
INSERT INTO `borrow_equip` VALUES ('289', '15', '32', '', '1');
INSERT INTO `borrow_equip` VALUES ('290', '15', '86', '', '1');
INSERT INTO `borrow_equip` VALUES ('291', '15', '184', '', '1');
INSERT INTO `borrow_equip` VALUES ('292', '15', '82', '', '1');
INSERT INTO `borrow_equip` VALUES ('293', '16', '3', '', '1');
INSERT INTO `borrow_equip` VALUES ('294', '17', '4', '', '1');
INSERT INTO `borrow_equip` VALUES ('295', '18', '41', '', '1');
INSERT INTO `borrow_equip` VALUES ('296', '18', '42', '', '1');
INSERT INTO `borrow_equip` VALUES ('297', '18', '43', '', '1');
INSERT INTO `borrow_equip` VALUES ('298', '18', '27', '', '1');
INSERT INTO `borrow_equip` VALUES ('299', '18', '46', '', '1');
INSERT INTO `borrow_equip` VALUES ('300', '18', '252', '', '1');
INSERT INTO `borrow_equip` VALUES ('301', '18', '246', '', '1');
INSERT INTO `borrow_equip` VALUES ('302', '18', '242', '', '1');
INSERT INTO `borrow_equip` VALUES ('303', '18', '240', '', '1');
INSERT INTO `borrow_equip` VALUES ('304', '18', '270', '', '1');
INSERT INTO `borrow_equip` VALUES ('305', '18', '267', '', '1');
INSERT INTO `borrow_equip` VALUES ('306', '19', '26', '', '1');
INSERT INTO `borrow_equip` VALUES ('307', '19', '47', '', '1');
INSERT INTO `borrow_equip` VALUES ('308', '19', '33', '', '1');
INSERT INTO `borrow_equip` VALUES ('309', '19', '16', '', '1');
INSERT INTO `borrow_equip` VALUES ('310', '19', '5', '', '1');
INSERT INTO `borrow_equip` VALUES ('311', '19', '83', '', '1');
INSERT INTO `borrow_equip` VALUES ('312', '19', '170', '', '1');
INSERT INTO `borrow_equip` VALUES ('313', '19', '73', '', '1');
INSERT INTO `borrow_equip` VALUES ('314', '19', '65', '', '1');
INSERT INTO `borrow_equip` VALUES ('315', '19', '62', '', '1');
INSERT INTO `borrow_equip` VALUES ('316', '19', '260', '', '1');
INSERT INTO `borrow_equip` VALUES ('317', '19', '243', '', '1');
INSERT INTO `borrow_equip` VALUES ('318', '19', '271', '', '1');
INSERT INTO `borrow_equip` VALUES ('319', '19', '295', '', '1');
INSERT INTO `borrow_equip` VALUES ('320', '20', '48', '', '1');
INSERT INTO `borrow_equip` VALUES ('321', '20', '17', '', '1');
INSERT INTO `borrow_equip` VALUES ('322', '20', '6', '', '1');
INSERT INTO `borrow_equip` VALUES ('323', '20', '88', '', '1');
INSERT INTO `borrow_equip` VALUES ('324', '20', '161', '', '1');
INSERT INTO `borrow_equip` VALUES ('325', '20', '171', '', '1');
INSERT INTO `borrow_equip` VALUES ('326', '20', '185', '', '1');
INSERT INTO `borrow_equip` VALUES ('327', '20', '68', '', '1');
INSERT INTO `borrow_equip` VALUES ('328', '20', '74', '', '1');
INSERT INTO `borrow_equip` VALUES ('329', '20', '236', '', '1');
INSERT INTO `borrow_equip` VALUES ('330', '20', '232', '', '1');
INSERT INTO `borrow_equip` VALUES ('331', '20', '222', '', '1');
INSERT INTO `borrow_equip` VALUES ('332', '20', '206', '', '1');
INSERT INTO `borrow_equip` VALUES ('333', '20', '199', '', '1');
INSERT INTO `borrow_equip` VALUES ('334', '20', '219', '', '1');
INSERT INTO `borrow_equip` VALUES ('335', '20', '191', '', '1');
INSERT INTO `borrow_equip` VALUES ('336', '21', '7', '', '1');
INSERT INTO `borrow_equip` VALUES ('337', '21', '18', '', '1');
INSERT INTO `borrow_equip` VALUES ('338', '21', '28', '', '1');
INSERT INTO `borrow_equip` VALUES ('339', '21', '34', '', '1');
INSERT INTO `borrow_equip` VALUES ('340', '21', '49', '', '1');
INSERT INTO `borrow_equip` VALUES ('341', '21', '75', '', '1');
INSERT INTO `borrow_equip` VALUES ('342', '21', '69', '', '1');
INSERT INTO `borrow_equip` VALUES ('343', '21', '89', '', '1');
INSERT INTO `borrow_equip` VALUES ('344', '21', '162', '', '1');
INSERT INTO `borrow_equip` VALUES ('345', '21', '172', '', '1');
INSERT INTO `borrow_equip` VALUES ('346', '21', '186', '', '1');
INSERT INTO `borrow_equip` VALUES ('347', '21', '207', '', '1');
INSERT INTO `borrow_equip` VALUES ('348', '22', '8', '', '1');
INSERT INTO `borrow_equip` VALUES ('349', '22', '29', '', '1');
INSERT INTO `borrow_equip` VALUES ('350', '22', '35', '', '1');
INSERT INTO `borrow_equip` VALUES ('351', '22', '50', '', '1');
INSERT INTO `borrow_equip` VALUES ('352', '22', '70', '', '1');
INSERT INTO `borrow_equip` VALUES ('353', '22', '76', '', '1');
INSERT INTO `borrow_equip` VALUES ('354', '22', '90', '', '1');
INSERT INTO `borrow_equip` VALUES ('355', '22', '163', '', '1');
INSERT INTO `borrow_equip` VALUES ('356', '22', '173', '', '1');
INSERT INTO `borrow_equip` VALUES ('357', '22', '187', '', '1');
INSERT INTO `borrow_equip` VALUES ('358', '22', '192', '', '1');
INSERT INTO `borrow_equip` VALUES ('359', '22', '200', '', '1');
INSERT INTO `borrow_equip` VALUES ('360', '22', '208', '', '1');
INSERT INTO `borrow_equip` VALUES ('361', '23', '9', '', '1');
INSERT INTO `borrow_equip` VALUES ('362', '23', '36', '', '1');
INSERT INTO `borrow_equip` VALUES ('363', '23', '296', '', '1');
INSERT INTO `borrow_equip` VALUES ('364', '23', '232', '', '1');
INSERT INTO `borrow_equip` VALUES ('365', '1', '10', '', '1');

-- ----------------------------
-- Table structure for client
-- ----------------------------
DROP TABLE IF EXISTS `client`;
CREATE TABLE `client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `no` int(10) DEFAULT NULL,
  `flag` bit(1) DEFAULT NULL,
  `cls_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of client
-- ----------------------------
INSERT INTO `client` VALUES ('17', 'sushuoyang', '17643093430', '20153671', '', '16');
INSERT INTO `client` VALUES ('18', '赵斓淇', '17643093505', '20153563', '', '17');
INSERT INTO `client` VALUES ('19', 'ggh', '15754335612', '2015', '', '17');

-- ----------------------------
-- Table structure for cls
-- ----------------------------
DROP TABLE IF EXISTS `cls`;
CREATE TABLE `cls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cls_no` int(11) DEFAULT NULL,
  `college_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cls
-- ----------------------------
INSERT INTO `cls` VALUES ('16', '151405', '3');
INSERT INTO `cls` VALUES ('17', '151401', '1');

-- ----------------------------
-- Table structure for college
-- ----------------------------
DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `college` varchar(30) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of college
-- ----------------------------
INSERT INTO `college` VALUES ('1', '数字媒体技术', '2');
INSERT INTO `college` VALUES ('2', '信息传播工程学院', '0');
INSERT INTO `college` VALUES ('3', '广播电视编导', '2');
INSERT INTO `college` VALUES ('4', '人文信息学院', '0');
INSERT INTO `college` VALUES ('5', '人文专业', '4');
INSERT INTO `college` VALUES ('6', '基础科学学院', '0');
INSERT INTO `college` VALUES ('7', '外国语学院', '0');
INSERT INTO `college` VALUES ('8', '艺术设计学院', '0');
INSERT INTO `college` VALUES ('9', '信息与计算科学', '6');
INSERT INTO `college` VALUES ('10', '统计学', '6');
INSERT INTO `college` VALUES ('11', '日语', '7');
INSERT INTO `college` VALUES ('12', '俄语', '7');
INSERT INTO `college` VALUES ('13', '对外汉语', '7');

-- ----------------------------
-- Table structure for equip
-- ----------------------------
DROP TABLE IF EXISTS `equip`;
CREATE TABLE `equip` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `no` varchar(30) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `surplus` int(11) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `type_id` int(11) DEFAULT NULL,
  `con` int(2) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=297 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equip
-- ----------------------------
INSERT INTO `equip` VALUES ('1', 'HDV', '', '10', '3', '', '1', '1', '0', null);
INSERT INTO `equip` VALUES ('2', '60', '60', '1', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('3', '2', '2', '1', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('4', '3', '3', '3', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('5', '11', '11', '1', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('6', '4', '4', '1', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('7', '8', '8', '1', '1', '\0', '1', '1', '1', '有麦无套');
INSERT INTO `equip` VALUES ('8', '314662', '314662', '1', '1', '\0', '1', '1', '1', '无麦无套');
INSERT INTO `equip` VALUES ('9', '10', '10', '1', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('10', '1', '1', '1', '1', '\0', '1', '1', '1', '有麦有套');
INSERT INTO `equip` VALUES ('11', '5', '5', '1', '1', '', '1', '1', '1', '无麦无套');
INSERT INTO `equip` VALUES ('12', 'FS-7', null, '6', '1', '', '1', '1', '0', null);
INSERT INTO `equip` VALUES ('13', '0049114', '0049114', '1', '1', '', '1', '1', '12', null);
INSERT INTO `equip` VALUES ('14', '0049135', '0049135', '1', '1', '\0', '1', '1', '12', null);
INSERT INTO `equip` VALUES ('15', '0049126', '0049126', '1', '1', '\0', '1', '1', '12', null);
INSERT INTO `equip` VALUES ('16', '0049127', '0049127', '1', '1', '\0', '1', '1', '12', null);
INSERT INTO `equip` VALUES ('17', '0049149', '0049149', '1', '1', '\0', '1', '1', '12', null);
INSERT INTO `equip` VALUES ('18', '0049147', '1', '1', '1', '\0', '1', '1', '12', null);
INSERT INTO `equip` VALUES ('19', 'F55', null, '1', '0', '', '1', '1', '0', null);
INSERT INTO `equip` VALUES ('20', '500193', '500193', '1', '1', '\0', '1', '1', '19', null);
INSERT INTO `equip` VALUES ('21', '6D', null, '8', '0', '', '2', '1', '0', null);
INSERT INTO `equip` VALUES ('22', '364051006709', '364051006709', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('23', '364051006711', '364051006711', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('24', '364051007097', '364051007097', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('25', '364051006721', '364051006721', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('26', '364051006694', '364051006694', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('27', '364051007095', '364051007095', '1', '1', '\0', '2', '1', '21', '无遮光罩');
INSERT INTO `equip` VALUES ('28', '364051006708', '364051006708', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('29', '364051005998', '364051005998', '1', '1', '\0', '2', '1', '21', null);
INSERT INTO `equip` VALUES ('30', '5D', '', '7', '1', '', '2', '1', '0', null);
INSERT INTO `equip` VALUES ('31', '164028005601', '164028005601', '1', '1', '\0', '3', '1', '30', null);
INSERT INTO `equip` VALUES ('32', '204025001809', '204025001809', '1', '1', '\0', '2', '1', '30', null);
INSERT INTO `equip` VALUES ('33', '204025002218', '204025002218', '1', '1', '\0', '2', '1', '30', null);
INSERT INTO `equip` VALUES ('34', '204025001860', '204025001860', '1', '1', '\0', '2', '1', '30', null);
INSERT INTO `equip` VALUES ('35', '204025001112', '204025001112', '1', '1', '\0', '2', '1', '30', null);
INSERT INTO `equip` VALUES ('36', '204025002341', '204025002341', '1', '1', '\0', '2', '1', '30', null);
INSERT INTO `equip` VALUES ('37', '204025001188', '204025001188', '1', '1', '', '2', '1', '30', null);
INSERT INTO `equip` VALUES ('38', '50', null, '5', '0', '', '3', '1', '0', null);
INSERT INTO `equip` VALUES ('39', '6981460', '6981460', '1', '1', '\0', '3', '1', '38', null);
INSERT INTO `equip` VALUES ('40', '7044326', '7044326', '1', '1', '\0', '3', '1', '38', null);
INSERT INTO `equip` VALUES ('41', '7003282', '7003282', '1', '1', '\0', '3', '1', '38', null);
INSERT INTO `equip` VALUES ('42', '7004147', '7004147', '1', '1', '\0', '3', '1', '38', null);
INSERT INTO `equip` VALUES ('43', '7042564', '7042564', '1', '1', '\0', '3', '1', '38', null);
INSERT INTO `equip` VALUES ('44', '85', null, '6', '0', '', '3', '1', '0', null);
INSERT INTO `equip` VALUES ('45', '310837', '310837', '1', '1', '\0', '3', '1', '44', null);
INSERT INTO `equip` VALUES ('46', '314218', '314218', '1', '1', '\0', '4', '1', '44', null);
INSERT INTO `equip` VALUES ('47', '317219', '317219', '1', '1', '\0', '3', '1', '44', null);
INSERT INTO `equip` VALUES ('48', '317155', '317155', '1', '1', '\0', '3', '1', '44', null);
INSERT INTO `equip` VALUES ('49', '315669', '315669', '1', '1', '\0', '3', '1', '44', null);
INSERT INTO `equip` VALUES ('50', '310930', '310930', '1', '1', '\0', '3', '1', '44', null);
INSERT INTO `equip` VALUES ('51', '24-70', '', '2', '0', '', '3', '1', '0', null);
INSERT INTO `equip` VALUES ('52', '5155002390', '5155002390', '1', '1', '\0', '3', '1', '51', '');
INSERT INTO `equip` VALUES ('53', '5140001488', '5140001488', '1', '1', '\0', '3', '1', '51', '');
INSERT INTO `equip` VALUES ('54', '16-35', null, '2', '0', '', '3', '1', '0', null);
INSERT INTO `equip` VALUES ('55', '4710001680', '4710001680', '1', '1', '\0', '3', '1', '54', null);
INSERT INTO `equip` VALUES ('56', '4710005320', '4710005320', '1', '1', '\0', '3', '1', '54', null);
INSERT INTO `equip` VALUES ('57', '70-200', null, '2', '0', '', '3', '1', '0', null);
INSERT INTO `equip` VALUES ('58', '5120007737', '5120007737', '1', '1', '\0', '3', '1', '57', null);
INSERT INTO `equip` VALUES ('59', '5120007739', '5120007739', '1', '1', '\0', '3', '1', '57', null);
INSERT INTO `equip` VALUES ('60', '飞机', null, '2', '0', '', '4', '1', '0', null);
INSERT INTO `equip` VALUES ('61', '09YDDCML040717', '09YDDCML040717', '1', '1', '\0', '4', '1', '60', null);
INSERT INTO `equip` VALUES ('62', '09YDDCML040715', '09YDDCML040715', '1', '1', '\0', '4', '1', '60', null);
INSERT INTO `equip` VALUES ('63', '充电器', null, '2', '0', '', '4', '1', '0', null);
INSERT INTO `equip` VALUES ('64', 'F184741649007914', 'F184741649007914', '1', '1', '\0', '4', '1', '63', null);
INSERT INTO `equip` VALUES ('65', 'F184741649007912', 'F184741649007912', '1', '1', '\0', '4', '1', '63', null);
INSERT INTO `equip` VALUES ('66', '遥控器', null, '5', '1', '', '4', '1', '0', null);
INSERT INTO `equip` VALUES ('67', '0D4JDCH0C20086', '0D4JDCH0C20086', '1', '1', '\0', '4', '1', '66', null);
INSERT INTO `equip` VALUES ('68', '0D4JE270C10378', '0D4JE270C10378', '1', '1', '\0', '4', '1', '66', null);
INSERT INTO `equip` VALUES ('69', '0D4JE6F0C20031', '0D4JE6F0C20031', '1', '1', '\0', '4', '1', '66', null);
INSERT INTO `equip` VALUES ('70', '0D4JDCD0C20501', '0D4JDCD0C20501', '1', '1', '\0', '4', '1', '66', null);
INSERT INTO `equip` VALUES ('71', '0D4JE690C20093', '0D4JE690C20093', '1', '1', '', '4', '1', '66', null);
INSERT INTO `equip` VALUES ('72', '电池', null, '8', '4', '', '4', '1', '0', null);
INSERT INTO `equip` VALUES ('73', '09UADCM03100XV', '09UADCM03100XV', '1', '1', '\0', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('74', '09UAE1G03108P2', '09UAE1G03108P2', '1', '1', '\0', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('75', '09UAE1B031014L', '09UAE1B031014L', '1', '1', '\0', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('76', '09UADCM03100TS', '09UADCM03100TS', '1', '1', '\0', '5', '1', '72', null);
INSERT INTO `equip` VALUES ('77', '09UADCM0310937', '09UADCM0310937', '1', '1', '', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('78', '09UAE1B0310643', '09UAE1B0310643', '1', '1', '', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('79', '09UAE1B03102PN', '09UAE1B03102PN', '1', '1', '', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('80', '09UADCM03100V3', '09UADCM03100V3', '1', '1', '', '4', '1', '72', null);
INSERT INTO `equip` VALUES ('81', '电池充电器', null, '2', '0', '', '4', '1', '0', null);
INSERT INTO `equip` VALUES ('82', '0CPKDC9081002S', '0CPKDC9081002S', '1', '1', '\0', '4', '1', '81', null);
INSERT INTO `equip` VALUES ('83', '0CPKDC9081002T', '0CPKDC9081002T', '1', '1', '\0', '4', '1', '81', null);
INSERT INTO `equip` VALUES ('84', '镜头', null, '2', '0', '', '4', '1', '0', null);
INSERT INTO `equip` VALUES ('85', '0ABDDL27030868', '0ABDDL27030868', '1', '1', '\0', '4', '1', '84', null);
INSERT INTO `equip` VALUES ('86', '0ABDED22030413', '0ABDED22030413', '1', '1', '\0', '4', '1', '84', null);
INSERT INTO `equip` VALUES ('87', '黑色 小', null, '13', '10', '', '5', '1', '0', null);
INSERT INTO `equip` VALUES ('88', 'DJ101', 'DJ101', '1', '1', '\0', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('89', 'DJ102', 'DJ102', '1', '1', '\0', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('90', 'DJ103', 'DJ103', '1', '1', '\0', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('91', 'DJ104', 'DJ104', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('92', 'DJ105', 'DJ105', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('93', 'DJ106', 'DJ106', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('94', 'DJ127', 'DJ127', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('95', 'DJ130', 'DJ130', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('96', 'DJ131', 'DJ131', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('97', '65126', '65126', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('98', '65128', '65128', '1', '1', '', '6', '1', '87', null);
INSERT INTO `equip` VALUES ('99', '65129', '65129', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('100', '65133', '65133', '1', '1', '', '5', '1', '87', null);
INSERT INTO `equip` VALUES ('160', '黑色 大', '', '8', '5', '', '5', '1', '0', null);
INSERT INTO `equip` VALUES ('161', 'H17052465(云台)/T17060078(三脚架)', 'H17052465(云台)/T17060078(三脚架)', '1', '1', '\0', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('162', 'H17031568(云台)/T17053696(三脚架)', 'H17031568(云台)/T17053696(三脚架)', '1', '1', '\0', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('163', 'H17052400(云台)/T17053723(三脚架)', 'H17052400(云台)/T17053723(三脚架)', '1', '1', '\0', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('164', 'H17052471(云台)/T17053693(三脚架)', 'H17052471(云台)/T17053693(三脚架)', '1', '1', '', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('165', 'H17052393(云台)/T17060028(三脚架)', 'H17052393(云台)/T17060028(三脚架)', '1', '1', '', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('166', 'H17031576(云台)/T17060099(三脚架)', 'H17031576(云台)/T17060099(三脚架)', '1', '1', '', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('167', 'H17030662(云台)/T17053703(三脚架)', 'H17030662(云台)/T17053703(三脚架)', '1', '1', '', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('168', 'H17052338(云台)/T17053692(三脚架)', 'H17052338(云台)/T17053692(三脚架)', '1', '1', '', '5', '1', '160', '');
INSERT INTO `equip` VALUES ('169', '电池', 'S-8U63', '12', '8', '', '6', '1', '0', null);
INSERT INTO `equip` VALUES ('170', '00255698', '00255698', '1', '1', '\0', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('171', '00255654', '00255654', '1', '1', '\0', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('172', '00255647', '00255647', '1', '1', '\0', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('173', '00249341', '00249341', '1', '1', '\0', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('174', '00255649', '00255649', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('175', '00255628', '00255628', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('176', '00228330', '00228330', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('177', '00228382', '00228382', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('178', '00151606', '00151606', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('179', '00151644', '00151644', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('180', '00151646', '00151646', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('181', '00151655', '00151655', '1', '1', '', '6', '1', '169', '');
INSERT INTO `equip` VALUES ('182', '电池', 'BP-U30', '6', '1', '', '6', '1', '0', null);
INSERT INTO `equip` VALUES ('183', '0323746', '0323746', '1', '1', '\0', '6', '1', '182', '');
INSERT INTO `equip` VALUES ('184', '0323797', '0323797', '1', '1', '\0', '6', '1', '182', '');
INSERT INTO `equip` VALUES ('185', '0324649', '0324649', '1', '1', '\0', '6', '1', '182', '');
INSERT INTO `equip` VALUES ('186', '0323869', '0323869', '1', '1', '\0', '6', '1', '182', '');
INSERT INTO `equip` VALUES ('187', '0324406', '0324406', '1', '1', '\0', '6', '1', '182', '');
INSERT INTO `equip` VALUES ('188', '0324646', '0324646', '1', '1', '', '6', '1', '182', '');
INSERT INTO `equip` VALUES ('189', '电池充电器', 'BC-U1', '7', '4', '', '6', '1', '0', null);
INSERT INTO `equip` VALUES ('190', '17072000596', '17072000596', '1', '1', '\0', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('191', '17072000652', '17072000652', '1', '1', '\0', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('192', '17072000575', '17072000575', '1', '1', '\0', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('193', '17072000658', '17072000658', '1', '1', '', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('194', '17072000594', '17072000594', '1', '1', '', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('195', '17072000643', '17072000643', '1', '1', '', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('196', '16033000500', '16033000500', '1', '1', '', '6', '1', '189', '');
INSERT INTO `equip` VALUES ('197', 'FS-7充电器', 'AC-UES1230', '6', '3', '', '6', '1', '0', null);
INSERT INTO `equip` VALUES ('198', '0013695', '0013695', '1', '1', '\0', '6', '1', '197', '');
INSERT INTO `equip` VALUES ('199', '0013567', '0013567', '1', '1', '\0', '6', '1', '197', '');
INSERT INTO `equip` VALUES ('200', '0013703', '0013703', '1', '1', '\0', '6', '1', '197', '');
INSERT INTO `equip` VALUES ('201', '0013687', '0013687', '1', '1', '', '6', '1', '197', '');
INSERT INTO `equip` VALUES ('202', '0013563', '0013563', '1', '1', '', '6', '1', '197', '');
INSERT INTO `equip` VALUES ('203', '0013570', '0013570', '1', '1', '', '6', '1', '197', '');
INSERT INTO `equip` VALUES ('204', '电池', 'GP-L130B', '12', '8', '', '7', '1', '0', null);
INSERT INTO `equip` VALUES ('205', 'BP0503438', 'BP0503438', '1', '1', '\0', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('206', 'BP19120457', 'BP19120457', '1', '1', '\0', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('207', 'BP08010272', 'BP08010272', '1', '1', '\0', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('208', 'BP19150113', 'BP19150113', '1', '1', '\0', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('209', 'BP19140959', 'BP19140959', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('210', 'BP0505466', 'BP0505466', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('211', 'BP0505461', 'BP0505461', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('212', 'BP19150081', 'BP19150081', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('213', 'BP0505470', 'BP0505470', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('214', 'BP19120491', 'BP19120491', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('215', 'BP0505462', 'BP0505462', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('216', 'BP0505460', 'BP0505460', '1', '1', '', '7', '1', '204', '');
INSERT INTO `equip` VALUES ('217', '电池', 'DS-130S', '3', '1', '', '7', '1', '0', null);
INSERT INTO `equip` VALUES ('218', 'DY-1105B123', 'DY-1105B123', '1', '1', '\0', '7', '1', '217', '');
INSERT INTO `equip` VALUES ('219', 'DY-1105B125', 'DY-1105B125', '1', '1', '\0', '7', '1', '217', '');
INSERT INTO `equip` VALUES ('220', 'DY-1105B124', 'DY-1105B124', '1', '1', '', '7', '1', '217', '');
INSERT INTO `equip` VALUES ('221', '电池', 'BP-2000', '1', '0', '', '7', '1', '0', null);
INSERT INTO `equip` VALUES ('222', 'BP13011010344', 'BP13011010344', '1', '1', '\0', '7', '1', '221', '');
INSERT INTO `equip` VALUES ('223', '电池充电器', 'S-3802S', '1', '0', '', '7', '1', '0', null);
INSERT INTO `equip` VALUES ('224', '11-71080', '11-71080', '1', '1', '\0', '7', '1', '223', '');
INSERT INTO `equip` VALUES ('225', 'LED灯', '', '6', '6', '', '7', '0', '0', null);
INSERT INTO `equip` VALUES ('226', 'DJ01', 'DJ01', '1', '1', '', '7', '1', '225', '');
INSERT INTO `equip` VALUES ('227', 'DJ02', 'DJ02', '1', '1', '', '7', '1', '225', '');
INSERT INTO `equip` VALUES ('228', 'DJ03', 'DJ03', '1', '1', '', '7', '0', '225', '');
INSERT INTO `equip` VALUES ('229', 'DJ04', 'DJ04', '1', '1', '', '7', '1', '225', '');
INSERT INTO `equip` VALUES ('230', 'DJ05', 'DJ05', '1', '1', '', '7', '1', '225', '');
INSERT INTO `equip` VALUES ('231', 'DJ06', 'DJ06', '1', '1', '', '7', '1', '225', '');
INSERT INTO `equip` VALUES ('232', '柔光板', '', '4', '1', '', '1', '1', '0', null);
INSERT INTO `equip` VALUES ('233', '充电器', '', '6', '6', '', '7', '1', '0', null);
INSERT INTO `equip` VALUES ('234', '灯架', '', '4', '2', '', '7', '1', '0', null);
INSERT INTO `equip` VALUES ('235', 'DJ801', 'DJ801', '1', '1', '\0', '7', '1', '234', '');
INSERT INTO `equip` VALUES ('236', 'DJ802', 'DJ802', '1', '1', '\0', '7', '1', '234', '');
INSERT INTO `equip` VALUES ('237', 'DJ803', 'DJ803', '1', '1', '', '7', '1', '234', '');
INSERT INTO `equip` VALUES ('238', 'DJ804', 'DJ804', '1', '1', '', '7', '1', '234', '');
INSERT INTO `equip` VALUES ('239', '522录音调音台', '', '1', '0', '', '8', '1', '0', null);
INSERT INTO `equip` VALUES ('240', 'HY0610295001', 'HY0610295001', '1', '1', '\0', '8', '1', '239', '');
INSERT INTO `equip` VALUES ('241', '无线领夹', 'UTX-B1', '2', '0', '', '8', '1', '0', null);
INSERT INTO `equip` VALUES ('242', '314809', '314809', '1', '1', '\0', '8', '1', '241', '');
INSERT INTO `equip` VALUES ('243', '314810', '314810', '1', '1', '\0', '8', '1', '241', '');
INSERT INTO `equip` VALUES ('244', '无线领夹', 'UTX-B2', '2', '0', '', '1', '1', '0', null);
INSERT INTO `equip` VALUES ('245', '521428', '521428', '1', '1', '\0', '1', '1', '244', '');
INSERT INTO `equip` VALUES ('246', '521021', '521021', '1', '1', '\0', '1', '1', '244', '');
INSERT INTO `equip` VALUES ('247', 'SONY无线话筒', 'UTX-H1', '2', '2', '', '8', '1', '0', null);
INSERT INTO `equip` VALUES ('248', '305606', '305606', '1', '1', '', '8', '1', '247', '');
INSERT INTO `equip` VALUES ('249', '305605', '305605', '1', '1', '', '8', '1', '247', '');
INSERT INTO `equip` VALUES ('251', 'SONY无线话筒接收盒', 'UTX-H1', '4', '3', '\0', '8', '1', '0', null);
INSERT INTO `equip` VALUES ('252', '316465', '316465', '1', '1', '\0', '8', '1', '251', '');
INSERT INTO `equip` VALUES ('253', '316466', '316466', '1', '1', '', '8', '1', '251', '');
INSERT INTO `equip` VALUES ('254', '316688', '316688', '1', '1', '', '8', '1', '251', '');
INSERT INTO `equip` VALUES ('255', '316689', '316689', '1', '1', '', '8', '1', '251', '');
INSERT INTO `equip` VALUES ('256', 'AKG无线话筒', '', '1', '0', '', '8', '1', '0', null);
INSERT INTO `equip` VALUES ('259', '电池充电器', 'DS510103', '3', '2', '', '9', '1', '0', null);
INSERT INTO `equip` VALUES ('260', 'DDGB', 'DDGB', '1', '1', '\0', '9', '1', '259', '');
INSERT INTO `equip` VALUES ('261', 'DDGA', 'DDGA', '1', '1', '', '9', '1', '259', '');
INSERT INTO `equip` VALUES ('262', 'EEGA', 'EEGA', '1', '1', '', '9', '1', '259', '');
INSERT INTO `equip` VALUES ('266', '电池充电器', 'LC-E6E', '1', '0', '', '9', '1', '0', null);
INSERT INTO `equip` VALUES ('267', 'BCDC', 'BCDC', '1', '1', '\0', '9', '1', '266', '');
INSERT INTO `equip` VALUES ('268', '电池充电器', 'LC-E8C', '1', '0', '', '9', '1', '0', null);
INSERT INTO `equip` VALUES ('269', '电池', '', '13', '11', '', '9', '1', '0', null);
INSERT INTO `equip` VALUES ('270', 'DJ01', 'DJ01', '1', '1', '\0', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('271', 'DJ02', 'DJ02', '1', '1', '\0', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('272', 'DJ03', 'DJ03', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('273', 'DJ04', 'DJ04', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('274', 'DJ05', 'DJ05', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('275', 'DJ06', 'DJ06', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('276', 'DJ07', 'DJ07', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('277', 'DJ08', 'DJ08', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('278', 'DJ09', 'DJ09', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('279', 'DJ10', 'DJ10', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('280', 'DJ11', 'DJ11', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('281', 'DJ12', 'DJ12', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('282', 'DJ13', 'DJ13', '1', '1', '', '9', '1', '269', '');
INSERT INTO `equip` VALUES ('283', '电池', '', '9', '9', '', '10', '1', '0', null);
INSERT INTO `equip` VALUES ('284', '1', '1', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('285', '2', '2', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('286', '3', '3', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('287', '4', '4', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('288', '7', '7', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('289', '8', '8', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('290', '10', '10', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('291', '11', '11', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('292', '14', '14', '1', '1', '', '10', '1', '283', '');
INSERT INTO `equip` VALUES ('294', '卡农线', '', '999', '999', '', '11', '1', '0', '');
INSERT INTO `equip` VALUES ('295', '直插线', '', '999', '998', '', '11', '1', '0', '');
INSERT INTO `equip` VALUES ('296', '卡农转3.5线', '', '999', '998', '', '11', '1', '0', '');

-- ----------------------------
-- Table structure for equip_category
-- ----------------------------
DROP TABLE IF EXISTS `equip_category`;
CREATE TABLE `equip_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equip_category
-- ----------------------------
INSERT INTO `equip_category` VALUES ('1', '摄像机');
INSERT INTO `equip_category` VALUES ('2', '单反');
INSERT INTO `equip_category` VALUES ('3', '单反镜头');
INSERT INTO `equip_category` VALUES ('4', '飞机');
INSERT INTO `equip_category` VALUES ('5', '三脚架');
INSERT INTO `equip_category` VALUES ('6', 'FS-7');
INSERT INTO `equip_category` VALUES ('7', 'LED灯');
INSERT INTO `equip_category` VALUES ('8', '话筒');
INSERT INTO `equip_category` VALUES ('9', '佳能');
INSERT INTO `equip_category` VALUES ('10', 'HDV');
INSERT INTO `equip_category` VALUES ('11', '线');

-- ----------------------------
-- Table structure for group
-- ----------------------------
DROP TABLE IF EXISTS `group`;
CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group
-- ----------------------------

-- ----------------------------
-- Table structure for group_module
-- ----------------------------
DROP TABLE IF EXISTS `group_module`;
CREATE TABLE `group_module` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL,
  `module_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of group_module
-- ----------------------------

-- ----------------------------
-- Table structure for module
-- ----------------------------
DROP TABLE IF EXISTS `module`;
CREATE TABLE `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `url` varchar(30) DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `icon_class` varchar(30) DEFAULT NULL,
  `seq` tinyint(4) DEFAULT NULL,
  `level` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of module
-- ----------------------------
INSERT INTO `module` VALUES ('1', '器材借用', '0', 'pages/index.jsp', '', 'icon-facetime-video', '1', '1');
INSERT INTO `module` VALUES ('2', '合借框', '0', 'basket', '', 'icon-gift', '2', '1');
INSERT INTO `module` VALUES ('3', '器材管理', '0', 'pages/adminconfirm.jsp', '', 'icon-desktop', '3', '1');
INSERT INTO `module` VALUES ('4', '借单管理', '0', null, '', 'icon-edit', '4', '1');
INSERT INTO `module` VALUES ('5', '等待归还', '4', 'waitreturnPage', '', 'icon-double-angle-right', '1', '1');
INSERT INTO `module` VALUES ('6', '历史记录', '4', 'historyPage', '', 'icon-double-angle-right', '2', '1');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(20) DEFAULT NULL,
  `login_password` varchar(20) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `status` bit(1) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', '电教中心', '493d01', '2017-11-22 14:57:27', '', '1');
