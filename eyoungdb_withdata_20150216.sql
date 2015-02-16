/*
Navicat MySQL Data Transfer

Source Server         : E-Young
Source Server Version : 50537
Source Host           : 121.41.104.220:3306
Source Database       : eyoungdb

Target Server Type    : MYSQL
Target Server Version : 50537
File Encoding         : 65001

Date: 2015-02-16 13:56:22
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbl_address
-- ----------------------------
DROP TABLE IF EXISTS `tbl_address`;
CREATE TABLE `tbl_address` (
  `pk_addr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `addr_cust_id` int(10) unsigned NOT NULL,
  `addr_name` varchar(10) DEFAULT NULL COMMENT '地址1，地址2，...',
  `addr_isdefault` tinyint(1) DEFAULT '0' COMMENT '是否为默认地址\n0：非默认地址\n1：默认地址',
  `addr_city` varchar(10) DEFAULT NULL COMMENT '城市',
  `addr_range` tinyint(3) unsigned DEFAULT NULL COMMENT '地址范围：\n0：内环内\n1：内环外，中环内\n2：中环外，外环内\n3：外环外\n4：非上海',
  `addr_district` varchar(10) DEFAULT NULL COMMENT '区',
  `addr_street` varchar(20) DEFAULT NULL COMMENT '街道名称',
  `addr_community` varchar(20) DEFAULT NULL COMMENT '小区名',
  `addr_addr` varchar(200) DEFAULT NULL COMMENT '详细地址',
  `addr_create_time` datetime DEFAULT NULL,
  `addr_update_time` datetime DEFAULT NULL,
  `addr_postcode` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`pk_addr_id`),
  KEY `fk_address_customer` (`addr_cust_id`),
  CONSTRAINT `fk_address_customer` FOREIGN KEY (`addr_cust_id`) REFERENCES `tbl_customer` (`pk_cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7000007 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_address
-- ----------------------------
INSERT INTO `tbl_address` VALUES ('7000000', '1000005', null, '1', null, null, null, null, null, '测试地址4', null, null, null);
INSERT INTO `tbl_address` VALUES ('7000001', '1000006', null, '1', null, null, null, null, null, '的的饿饿饿饿饿饿饿饿饿饿饿饿的饿饿饿饿饿饿饿饿饿饿的饿饿饿饿饿饿饿饿饿123号321', null, null, null);
INSERT INTO `tbl_address` VALUES ('7000002', '1000007', null, '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_address` VALUES ('7000003', '1000008', null, '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_address` VALUES ('7000004', '1000009', null, '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_address` VALUES ('7000005', '1000010', null, '1', null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_address` VALUES ('7000006', '1000011', null, '1', null, null, null, null, null, '中华人民共和国上海市黄浦区西藏南路888弄88号8幢8层8室啊锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕反复反反复复反反复复', null, null, null);

-- ----------------------------
-- Table structure for tbl_admin
-- ----------------------------
DROP TABLE IF EXISTS `tbl_admin`;
CREATE TABLE `tbl_admin` (
  `pk_adm_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `adm_level` tinyint(4) NOT NULL COMMENT '管理员级别\n0：普通管理员\n1：boss管理员',
  PRIMARY KEY (`pk_adm_id`),
  UNIQUE KEY `idAdmin_UNIQUE` (`pk_adm_id`),
  CONSTRAINT `fk_admin_user` FOREIGN KEY (`pk_adm_id`) REFERENCES `tbl_user` (`pk_usr_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_admin
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_appointment
-- ----------------------------
DROP TABLE IF EXISTS `tbl_appointment`;
CREATE TABLE `tbl_appointment` (
  `pk_aptm_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '预约单号（系统自动生成）',
  `aptm_beau_id` int(10) unsigned NOT NULL COMMENT '预约美容师id（由系统自动分配）（外键）',
  `aptm_time` datetime NOT NULL COMMENT '预约上门日期&时间（时间可与默认时间不同）\n上午：默认10点-13点\n下午：默认14点-17点\n晚上：默认19点-21点',
  `aptm_ord_item_id` int(10) unsigned NOT NULL,
  `aptm_status` tinyint(4) NOT NULL COMMENT '预约状态\n0：待预约\n1：待服务（已预约）\n2：待确认\n3：已完成\n4：已取消',
  `aptm_course_no` smallint(6) NOT NULL COMMENT '本次预约为在疗程中的第几次',
  `aptm_cust_name` varchar(20) NOT NULL COMMENT '顾客姓名\n默认为CustBasicInfo中的realName\n',
  `aptm_cust_tel` varchar(15) NOT NULL COMMENT '顾客电话\n默认为CustBasicInfo中得mobil',
  `aptm_cust_addr` varchar(200) NOT NULL COMMENT '顾客地址：\n默认为CustBasicInfo中的默认address',
  PRIMARY KEY (`pk_aptm_id`),
  UNIQUE KEY `appointNo_UNIQUE` (`pk_aptm_id`),
  KEY `beauticianID_idx` (`aptm_beau_id`),
  KEY `fk_aptm_orderitem_idx` (`aptm_ord_item_id`),
  CONSTRAINT `fk_aptm_beau` FOREIGN KEY (`aptm_beau_id`) REFERENCES `tbl_beautician` (`pk_beau_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_aptm_orderitem` FOREIGN KEY (`aptm_ord_item_id`) REFERENCES `tbl_order_item` (`pk_ord_itm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_appointment
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_beautician
-- ----------------------------
DROP TABLE IF EXISTS `tbl_beautician`;
CREATE TABLE `tbl_beautician` (
  `pk_beau_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '美容师编号',
  `beau_realname` varchar(20) NOT NULL COMMENT '真实姓名',
  `beau_nickname` varchar(20) DEFAULT NULL COMMENT '英文名',
  `beau_idcard_id` varchar(25) NOT NULL COMMENT '身份证号码',
  `beau_level` smallint(6) NOT NULL COMMENT '美容师等级',
  `beau_tel1` varchar(15) NOT NULL COMMENT '联系方式1',
  `beau_tel2` varchar(15) DEFAULT NULL COMMENT '联系方式2',
  `beau_tel3` varchar(15) DEFAULT NULL COMMENT '联系方式3',
  `beau_sex` varchar(4) NOT NULL,
  `beau_birthday` date NOT NULL,
  `beau_email` varchar(100) DEFAULT NULL,
  `beau_intro` varchar(200) NOT NULL COMMENT '简介',
  PRIMARY KEY (`pk_beau_id`),
  UNIQUE KEY `idBeautician_UNIQUE` (`pk_beau_id`),
  UNIQUE KEY `IDcard_UNIQUE` (`beau_idcard_id`),
  CONSTRAINT `fk_beau_user` FOREIGN KEY (`pk_beau_id`) REFERENCES `tbl_user` (`pk_usr_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_beautician
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_brand
-- ----------------------------
DROP TABLE IF EXISTS `tbl_brand`;
CREATE TABLE `tbl_brand` (
  `pk_brand_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(45) NOT NULL,
  `brand_intro` varchar(500) DEFAULT NULL COMMENT '品牌介绍',
  PRIMARY KEY (`pk_brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_brand
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_cart
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cart`;
CREATE TABLE `tbl_cart` (
  `pk_cart_cust_id` int(10) unsigned NOT NULL COMMENT '顾客ID\n购物车表内，顾客ID和商品ID一起作为复合主键',
  `pk_cart_comm_id` int(10) unsigned NOT NULL COMMENT '商品ID\n购物车表内，顾客ID和商品ID一起作为复合主键',
  `cart_num` int(10) unsigned NOT NULL COMMENT '购买商品数量',
  PRIMARY KEY (`pk_cart_cust_id`,`pk_cart_comm_id`),
  KEY `fk_cart_commodity` (`pk_cart_comm_id`),
  CONSTRAINT `fk_cart_commodity` FOREIGN KEY (`pk_cart_comm_id`) REFERENCES `tbl_commodity` (`pk_comm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cart_customer` FOREIGN KEY (`pk_cart_cust_id`) REFERENCES `tbl_customer` (`pk_cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_cart
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_code
-- ----------------------------
DROP TABLE IF EXISTS `tbl_code`;
CREATE TABLE `tbl_code` (
  `pk_code_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `code_tbl_name` varchar(50) NOT NULL,
  `code_name` varchar(45) NOT NULL,
  `code_value` int(11) NOT NULL,
  `code_meaning` varchar(50) NOT NULL,
  PRIMARY KEY (`pk_code_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_code
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_commodity
-- ----------------------------
DROP TABLE IF EXISTS `tbl_commodity`;
CREATE TABLE `tbl_commodity` (
  `pk_comm_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `comm_kind` int(11) NOT NULL COMMENT '商品种别：\n0：服务\n1：实物商品（活肤乳之类）',
  `comm_on_shelve_time` datetime DEFAULT NULL COMMENT '产品上架时间',
  `comm_off_shelve_time` datetime DEFAULT NULL COMMENT '产品下架时间',
  `comm_update_time` datetime DEFAULT NULL COMMENT '产品变更时间',
  `comm_check_times` int(11) NOT NULL DEFAULT '0' COMMENT '产品被点击次数',
  `comm_price` decimal(10,2) NOT NULL COMMENT '商品价格',
  `comm_discount` decimal(10,2) NOT NULL COMMENT '折扣信息：\n100：不打折\n75：75折\n50：5折\n0：免费',
  `comm_name` varchar(45) NOT NULL COMMENT '商品名称',
  `comm_intro1` varchar(500) NOT NULL COMMENT '商品介绍',
  `comm_intro2` varchar(500) DEFAULT NULL,
  `comm_intro3` varchar(500) DEFAULT NULL,
  `comm_intro4` varchar(500) DEFAULT NULL,
  `comm_intro5` varchar(500) DEFAULT NULL,
  `comm_is_hot` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为热门商品\n0：非热门\n1：热门',
  `comm_is_show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否显示该商品\n0：不显示\n1：显示',
  `comm_sort_order` int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (`pk_comm_id`),
  UNIQUE KEY `idCommodity_UNIQUE` (`pk_comm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10007 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_commodity
-- ----------------------------
INSERT INTO `tbl_commodity` VALUES ('10000', '1', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-基础美肤', 'test', null, null, null, null, '1', '1', '1');
INSERT INTO `tbl_commodity` VALUES ('10001', '1', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-洁净美肤', 'test', null, null, null, null, '1', '1', '2');
INSERT INTO `tbl_commodity` VALUES ('10002', '1', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-水润美肤', 'test', '', '', '', '', '1', '1', '3');
INSERT INTO `tbl_commodity` VALUES ('10003', '1', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-白皙美肤', 'test', null, null, null, null, '1', '1', '4');
INSERT INTO `tbl_commodity` VALUES ('10004', '1', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-细滑美肤', 'test', '', '', '', '', '1', '1', '5');
INSERT INTO `tbl_commodity` VALUES ('10005', '1', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-紧致美肤', 'test', '', '', '', '', '1', '1', '6');
INSERT INTO `tbl_commodity` VALUES ('10006', '2', '2015-02-15 17:09:16', '2016-02-15 17:09:24', '2015-02-15 17:09:47', '0', '1000.00', '888.00', 'YOUNG-紧致美肤', 'test', '', '', '', '', '1', '1', '6');

-- ----------------------------
-- Table structure for tbl_commodity_product
-- ----------------------------
DROP TABLE IF EXISTS `tbl_commodity_product`;
CREATE TABLE `tbl_commodity_product` (
  `pk_prod_id` int(10) unsigned NOT NULL,
  `prod_kind` smallint(6) NOT NULL COMMENT '商品种类：\n0：实体商品\n1：虚拟商品（充值卡）',
  `prod_stock` int(11) NOT NULL DEFAULT '0' COMMENT '剩余库存',
  `prod_brand_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pk_prod_id`),
  UNIQUE KEY `idProduct_UNIQUE` (`pk_prod_id`),
  KEY `fk_prod_brand_idx` (`prod_brand_id`),
  CONSTRAINT `fk_prod_brand` FOREIGN KEY (`prod_brand_id`) REFERENCES `tbl_brand` (`pk_brand_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_prod_comm` FOREIGN KEY (`pk_prod_id`) REFERENCES `tbl_commodity` (`pk_comm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_commodity_product
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_commodity_service
-- ----------------------------
DROP TABLE IF EXISTS `tbl_commodity_service`;
CREATE TABLE `tbl_commodity_service` (
  `pk_serv_id` int(10) unsigned NOT NULL,
  `serv_kind` smallint(6) NOT NULL COMMENT '服务类别：\n0：脸部护理\n1：胸部护理\n2：腹部护理\n3：臀部护理\n4：腿部护理\n5：手臂护理',
  `serv_duration` int(11) NOT NULL COMMENT '单次服务时长',
  `serv_single` tinyint(1) NOT NULL COMMENT 'service是否可以单次出售:\n0：不可以\n1：可以',
  `serv_time` smallint(6) NOT NULL COMMENT '一个疗程的服务次数',
  PRIMARY KEY (`pk_serv_id`),
  UNIQUE KEY `idService_UNIQUE` (`pk_serv_id`),
  CONSTRAINT `fk_serv_comm` FOREIGN KEY (`pk_serv_id`) REFERENCES `tbl_commodity` (`pk_comm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_commodity_service
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_coupon
-- ----------------------------
DROP TABLE IF EXISTS `tbl_coupon`;
CREATE TABLE `tbl_coupon` (
  `pk_coupon_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_no` varchar(100) NOT NULL COMMENT 'xx券号码',
  `coupon_seller` smallint(6) NOT NULL COMMENT 'xx券提供商：\n0：本站提供\n1：大众点评\n2：美团',
  `coupon_kind` smallint(6) NOT NULL COMMENT 'xx券用途：\n0：折扣券\n1：抵价券\n2：体验券',
  `coupon_status` tinyint(4) NOT NULL COMMENT 'xx券状态：\n0：未使用\n1：已使用\n2：已作废',
  `coupon_create_date` date NOT NULL,
  `coupon_period` smallint(6) NOT NULL,
  PRIMARY KEY (`pk_coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_coupon
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_cust_body_info
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cust_body_info`;
CREATE TABLE `tbl_cust_body_info` (
  `pk_cust_id` int(10) unsigned NOT NULL COMMENT '外键：用户id\n与Date构成复合主键',
  `custbd_mesure_date` date NOT NULL COMMENT '测量身体信息的日期\n与custID构成复合主键',
  `custbd_height` smallint(5) unsigned DEFAULT NULL COMMENT '身高（毫米）',
  `custbd_weight` decimal(5,2) unsigned DEFAULT NULL COMMENT '体重（千克）',
  `custbd_bust` smallint(5) unsigned DEFAULT NULL COMMENT '胸围（毫米）',
  `custbd_waistline` smallint(5) unsigned DEFAULT NULL COMMENT '腰围（毫米）',
  `custbd_buttock` smallint(5) unsigned DEFAULT NULL COMMENT '臀围（毫米）',
  `custbd_left_upper_arm` smallint(5) DEFAULT NULL COMMENT '左上臂围（毫米）',
  `custbd_right_upper_arm` smallint(5) DEFAULT NULL COMMENT '右上臂围（毫米）',
  `custbd_left_thigh` smallint(5) unsigned DEFAULT NULL COMMENT '左大腿围（毫米）',
  `custbd_right_thigh` smallint(5) DEFAULT NULL COMMENT '右大腿围（毫米）',
  `custbd_left_shank` smallint(5) unsigned DEFAULT NULL COMMENT '左小腿围（毫米）',
  `custbd_right_shank` smallint(5) DEFAULT NULL COMMENT '右小腿围（毫米）',
  `custbd_bmi` decimal(5,2) DEFAULT NULL COMMENT 'BMI值',
  `custbd_bmi_bmr` decimal(5,2) DEFAULT NULL COMMENT 'BMI基础代谢率',
  `custbd_whr` decimal(5,2) DEFAULT NULL COMMENT 'WHR腰臀比',
  `custbd_fat` decimal(5,2) DEFAULT NULL COMMENT 'FAT%脂肪率',
  `custbd_rsev_num_1` float DEFAULT NULL,
  `custbd_rsev_num_2` float DEFAULT NULL,
  `custbd_rsev_num_3` float DEFAULT NULL,
  `custbd_rsev_num_4` float DEFAULT NULL,
  `custbd_rsev_num_5` float DEFAULT NULL,
  `custbd_rsev_num_6` float DEFAULT NULL,
  `custbd_rsev_num_7` float DEFAULT NULL,
  `custbd_rsev_num_8` float DEFAULT NULL,
  `custbd_rsev_num_9` float DEFAULT NULL,
  `custbd_rsev_num_10` float DEFAULT NULL,
  PRIMARY KEY (`pk_cust_id`,`custbd_mesure_date`),
  CONSTRAINT `fk_body_customer` FOREIGN KEY (`pk_cust_id`) REFERENCES `tbl_customer` (`pk_cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_cust_body_info
-- ----------------------------
INSERT INTO `tbl_cust_body_info` VALUES ('1000005', '2015-02-10', '170', '55.00', '85', '60', '85', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000005', '2015-02-11', '170', '54.00', '84', '60', '84', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000005', '2015-02-12', '170', '53.00', '83', '60', '83', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000005', '2015-02-13', '170', '52.00', '82', '60', '82', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000006', '2015-02-15', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000007', '2015-02-16', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000008', '2015-02-16', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000009', '2015-02-16', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000010', '2015-02-16', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);
INSERT INTO `tbl_cust_body_info` VALUES ('1000011', '2015-02-16', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null);

-- ----------------------------
-- Table structure for tbl_cust_review
-- ----------------------------
DROP TABLE IF EXISTS `tbl_cust_review`;
CREATE TABLE `tbl_cust_review` (
  `pk_custrvw_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `custrvw_cust_id` int(10) unsigned NOT NULL COMMENT '顾客ID（外键）',
  `custrvw_att_grade` tinyint(4) NOT NULL COMMENT '服务态度星级：\n1-5颗星',
  `custrvw_qua_grade` tinyint(4) NOT NULL COMMENT '服务质量星级：\n1-5颗星',
  `custrvw_text` text COMMENT '留言板正文',
  `custrvw_create_time` datetime NOT NULL,
  `custrvw_aptm_id` int(10) unsigned DEFAULT NULL COMMENT '产品id',
  `custrvw_read_times` int(11) NOT NULL COMMENT 'review被阅读过的次数',
  PRIMARY KEY (`pk_custrvw_id`),
  UNIQUE KEY `idMessage_UNIQUE` (`pk_custrvw_id`),
  KEY `custID_idx` (`custrvw_cust_id`),
  KEY `fk_custrvw_aptm_idx` (`custrvw_aptm_id`),
  CONSTRAINT `fk_custrvw_aptm` FOREIGN KEY (`custrvw_aptm_id`) REFERENCES `tbl_appointment` (`pk_aptm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_custrvw_customer` FOREIGN KEY (`custrvw_cust_id`) REFERENCES `tbl_customer` (`pk_cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_cust_review
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_customer
-- ----------------------------
DROP TABLE IF EXISTS `tbl_customer`;
CREATE TABLE `tbl_customer` (
  `pk_cust_id` int(10) unsigned NOT NULL COMMENT '用户id：自增int',
  `cust_level` smallint(5) unsigned NOT NULL DEFAULT '1' COMMENT '客户等级',
  `cust_balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账户余额',
  `cust_point` int(11) NOT NULL DEFAULT '0' COMMENT '剩余积分',
  `cust_realname` varchar(20) DEFAULT NULL COMMENT '用户真实姓名',
  `cust_mobile1` varchar(15) DEFAULT NULL COMMENT '用户手机号码1',
  `cust_mobile2` varchar(15) DEFAULT NULL COMMENT '用户手机号码2',
  `cust_phone` varchar(15) DEFAULT NULL COMMENT '用户家庭座机（可以不填）',
  `cust_sex` varchar(4) DEFAULT NULL,
  `cust_birthday` date DEFAULT NULL,
  `cust_email1` varchar(100) DEFAULT NULL,
  `cust_email2` varchar(100) DEFAULT NULL,
  `cust_child_no` tinyint(4) DEFAULT NULL COMMENT '第几胎',
  `cust_childbearing_age` tinyint(4) DEFAULT NULL COMMENT '最近一次生育年龄',
  PRIMARY KEY (`pk_cust_id`),
  UNIQUE KEY `index_UNIQUE` (`pk_cust_id`),
  UNIQUE KEY `user_tel_cell_UNIQUE` (`cust_mobile1`),
  CONSTRAINT `fk_customer_user` FOREIGN KEY (`pk_cust_id`) REFERENCES `tbl_user` (`pk_usr_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_customer
-- ----------------------------
INSERT INTO `tbl_customer` VALUES ('1000005', '1', '0.00', '0', '测试用户3', '13918843617', null, null, '女', '1990-01-01', null, null, null, '12');
INSERT INTO `tbl_customer` VALUES ('1000006', '1', '0.00', '0', '张磊', '13917152026', null, null, '女', '1983-06-14', null, null, null, '30');
INSERT INTO `tbl_customer` VALUES ('1000007', '1', '0.00', '0', null, null, null, null, '女', null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('1000008', '1', '0.00', '0', null, null, null, null, '女', null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('1000009', '1', '0.00', '0', null, null, null, null, '女', null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('1000010', '1', '0.00', '0', null, null, null, null, '女', null, null, null, null, null);
INSERT INTO `tbl_customer` VALUES ('1000011', '1', '0.00', '0', '陈晨', '13764580797', null, null, '女', '1982-06-09', null, null, null, '29');

-- ----------------------------
-- Table structure for tbl_image
-- ----------------------------
DROP TABLE IF EXISTS `tbl_image`;
CREATE TABLE `tbl_image` (
  `pk_img_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `img_path` varchar(500) NOT NULL,
  `img_width` int(11) NOT NULL,
  `img_height` int(11) NOT NULL,
  `img_alt` varchar(45) NOT NULL,
  PRIMARY KEY (`pk_img_id`),
  UNIQUE KEY `idCommodityImage_UNIQUE` (`pk_img_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_image
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_img_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_img_relation`;
CREATE TABLE `tbl_img_relation` (
  `pk_img_rel_comm_id` int(10) unsigned NOT NULL,
  `pk_img_rel_img_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pk_img_rel_img_id`,`pk_img_rel_comm_id`),
  KEY `commID_idx` (`pk_img_rel_comm_id`),
  CONSTRAINT `fk_imagerela_comm` FOREIGN KEY (`pk_img_rel_comm_id`) REFERENCES `tbl_commodity` (`pk_comm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_imagerela_image` FOREIGN KEY (`pk_img_rel_img_id`) REFERENCES `tbl_image` (`pk_img_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_img_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_order
-- ----------------------------
DROP TABLE IF EXISTS `tbl_order`;
CREATE TABLE `tbl_order` (
  `pk_ord_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '订单号（系统生成）',
  `ord_cust_id` int(10) unsigned NOT NULL COMMENT '顾客id（外键）',
  `ord_status` smallint(6) NOT NULL COMMENT '订单状态\n0：待付款\n1：到付（处理与 待服务 一致）\n2：待服务（已付款）\n3：已完成\n4：已取消',
  `ord_cust_name` varchar(20) NOT NULL COMMENT '顾客姓名\n默认为tbl_customer中的realName\n\n只是为了单独销售商品时使用',
  `ord_cust_tel` varchar(15) NOT NULL COMMENT '顾客电话\n默认为tbl_customer中的Mobile\n\n只是为了单独销售商品时使用',
  `ord_cust_addr` varchar(200) NOT NULL COMMENT '顾客地址\n默认为tbl_customer中的address\n\n只是为了单独销售商品时使用',
  `ord_cust_postcode` varchar(10) NOT NULL COMMENT '顾客邮编\n默认为tbl_customer中的postCode\n\n只是为了单独销售商品时使用',
  `ord_pay_way` tinyint(4) DEFAULT NULL COMMENT '订单支付方式',
  PRIMARY KEY (`pk_ord_id`),
  UNIQUE KEY `idOrder_UNIQUE` (`pk_ord_id`),
  KEY `custID_idx` (`ord_cust_id`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`ord_cust_id`) REFERENCES `tbl_customer` (`pk_cust_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_order
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_order_item
-- ----------------------------
DROP TABLE IF EXISTS `tbl_order_item`;
CREATE TABLE `tbl_order_item` (
  `pk_ord_itm_id` int(10) unsigned NOT NULL,
  `pk_ord_itm_ord_id` int(10) unsigned NOT NULL,
  `ord_item_comm_id` int(10) unsigned NOT NULL,
  `ord_item_num` int(11) NOT NULL,
  `ord_item_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`pk_ord_itm_id`),
  KEY `fk_orderitem_order_idx` (`pk_ord_itm_ord_id`),
  KEY `fk_orderitem_commodity_idx` (`ord_item_comm_id`),
  CONSTRAINT `fk_orderitem_commodity` FOREIGN KEY (`ord_item_comm_id`) REFERENCES `tbl_commodity` (`pk_comm_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderitem_order` FOREIGN KEY (`pk_ord_itm_ord_id`) REFERENCES `tbl_order` (`pk_ord_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_order_item
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_service_tool_relation
-- ----------------------------
DROP TABLE IF EXISTS `tbl_service_tool_relation`;
CREATE TABLE `tbl_service_tool_relation` (
  `pk_strela_serv_id` int(10) unsigned NOT NULL,
  `pk_strela_tool_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pk_strela_serv_id`,`pk_strela_tool_id`),
  KEY `fk_strela_tool_idx` (`pk_strela_tool_id`),
  CONSTRAINT `fk_strela_serv` FOREIGN KEY (`pk_strela_serv_id`) REFERENCES `tbl_commodity_service` (`pk_serv_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_strela_tool` FOREIGN KEY (`pk_strela_tool_id`) REFERENCES `tbl_tool` (`pk_tool_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_service_tool_relation
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_tool
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tool`;
CREATE TABLE `tbl_tool` (
  `pk_tool_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tool_sn` varchar(45) NOT NULL COMMENT '设备编号',
  `tool_name` varchar(45) NOT NULL COMMENT '工具名称',
  `tool_status` tinyint(4) NOT NULL COMMENT '设备状态\n0：可使用\n1：故障，修理中\n2：已报废',
  `tool_brand_id` int(10) unsigned NOT NULL COMMENT '工具品牌',
  `tool_buy_date` date NOT NULL COMMENT '设备购入时间',
  `tool_buy_price` decimal(10,2) NOT NULL COMMENT '设备购入价格',
  `tool_receipt_id` varchar(100) DEFAULT NULL COMMENT '设备购入时发票编号',
  `tool_depreciation` tinyint(4) DEFAULT NULL COMMENT '折旧率',
  `tool_scrap_date` date DEFAULT NULL COMMENT '设备报废时间',
  PRIMARY KEY (`pk_tool_id`),
  UNIQUE KEY `tool_sn_UNIQUE` (`tool_sn`),
  KEY `fk_tool_brand_idx` (`tool_brand_id`),
  CONSTRAINT `fk_tool_brand` FOREIGN KEY (`tool_brand_id`) REFERENCES `tbl_brand` (`pk_brand_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tool
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_tool_lend_history
-- ----------------------------
DROP TABLE IF EXISTS `tbl_tool_lend_history`;
CREATE TABLE `tbl_tool_lend_history` (
  `pk_tlh_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tlh_tool_id` int(10) unsigned NOT NULL,
  `tlh_lend_people` varchar(10) NOT NULL COMMENT '借出者姓名',
  `tlh_lend_time` datetime NOT NULL COMMENT '借出时间',
  `tlh_predict_return_time` datetime NOT NULL COMMENT '预计归还时间',
  `tlh_act_return_time` datetime DEFAULT NULL COMMENT '实际归还时间',
  PRIMARY KEY (`pk_tlh_id`),
  KEY `fk_tlh_tool` (`tlh_tool_id`),
  CONSTRAINT `fk_tlh_tool` FOREIGN KEY (`tlh_tool_id`) REFERENCES `tbl_tool` (`pk_tool_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_tool_lend_history
-- ----------------------------

-- ----------------------------
-- Table structure for tbl_user
-- ----------------------------
DROP TABLE IF EXISTS `tbl_user`;
CREATE TABLE `tbl_user` (
  `pk_usr_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `usr_kind` tinyint(4) NOT NULL COMMENT '网站用户类别：\n0：管理员\n1：理疗师\n2：顾客',
  `usr_reg_kind` tinyint(4) NOT NULL COMMENT '用户注册来源：\n0：微信用户\n1：新浪微博用户\n2：QQ用户\n3：腾讯微博用户\n4：网站直接注册用户',
  `usr_open_id` varchar(200) DEFAULT NULL COMMENT 'openid（唯一）\n微信或微博或qq\n\n网站直接注册用户：留空',
  `usr_username` varchar(45) NOT NULL COMMENT '网站注册用用户名\n第三方账户登录用户：留空',
  `usr_password` varchar(45) NOT NULL COMMENT '网站注册用密码（MD5加密保存）\n第三方账户登录用户：留空',
  `usr_create_time` datetime NOT NULL COMMENT '用户创建时间',
  `usr_last_login` datetime NOT NULL COMMENT '用户上次登录时间',
  `usr_status` tinyint(4) NOT NULL COMMENT '用户当前状态：\n0：离线\n1：在线',
  `usr_pic_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`pk_usr_id`),
  UNIQUE KEY `idUser_UNIQUE` (`pk_usr_id`),
  UNIQUE KEY `usr_username_UNIQUE` (`usr_username`),
  KEY `fk_usr_image_idx` (`usr_pic_id`),
  CONSTRAINT `fk_usr_image` FOREIGN KEY (`usr_pic_id`) REFERENCES `tbl_image` (`pk_img_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1000012 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbl_user
-- ----------------------------
INSERT INTO `tbl_user` VALUES ('1000005', '2', '2', null, 'eeee', '670da91be64127c92faac35c8300e814', '2015-02-10 14:00:57', '2015-02-16 00:12:06', '100', null);
INSERT INTO `tbl_user` VALUES ('1000006', '2', '2', null, 'zhanglei', '200820e3227815ed1756a6b531e7e0d2', '2015-02-15 14:41:52', '2015-02-16 00:28:39', '100', null);
INSERT INTO `tbl_user` VALUES ('1000007', '2', '2', null, 'zhanglicc', 'e10adc3949ba59abbe56e057f20f883e', '2015-02-16 09:36:43', '2015-02-16 09:36:43', '100', null);
INSERT INTO `tbl_user` VALUES ('1000008', '2', '2', null, 'rockingzl', 'e10adc3949ba59abbe56e057f20f883e', '2015-02-16 10:19:13', '2015-02-16 10:19:13', '100', null);
INSERT INTO `tbl_user` VALUES ('1000009', '2', '2', null, 'guoguo', 'e10adc3949ba59abbe56e057f20f883e', '2015-02-16 10:20:27', '2015-02-16 10:20:27', '100', null);
INSERT INTO `tbl_user` VALUES ('1000010', '2', '2', null, 'chenyi', 'e10adc3949ba59abbe56e057f20f883e', '2015-02-16 10:23:05', '2015-02-16 10:23:05', '100', null);
INSERT INTO `tbl_user` VALUES ('1000011', '2', '2', null, '13764580797', 'c6d1cc938d08b0a3db23d632412eb6b9', '2015-02-16 10:29:14', '2015-02-16 10:29:14', '100', null);
