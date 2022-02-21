/*
 Navicat Premium Data Transfer

 Source Server         : vagrant
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:1234
 Source Schema         : mancando_dev

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 08/01/2022 17:09:14
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `customer_type` smallint(6) NOT NULL COMMENT '客户类型(3000加盟商，4000修理厂)',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_number` char(10) COLLATE utf8_bin NOT NULL COMMENT '客户编号',
  `customer_name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '客户名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系电话',
  `balance` decimal(16,2) NOT NULL COMMENT '余额',
  `special_balance` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '专项款余额',
  `status` smallint(6) NOT NULL COMMENT '账户状态(1000有效，9000已删除)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `customer_number` (`customer_number`),
  KEY `customer_id` (`customer_id`,`customer_type`),
  KEY `customer_name` (`customer_name`)
) ENGINE=InnoDB AUTO_INCREMENT=41143 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账户';

-- ----------------------------
-- Table structure for account_item
-- ----------------------------
DROP TABLE IF EXISTS `account_item`;
CREATE TABLE `account_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账目ID',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `type_id` int(11) NOT NULL COMMENT '账目类型ID',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已生成，1100已销账，1200反销账)',
  `adjust_type` smallint(6) NOT NULL COMMENT '调账类型(1000非调账账目，2000冲正，3000优惠)',
  `transaction_type_id` int(11) NOT NULL COMMENT '交易类型ID',
  `transaction_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '交易单号',
  `sub_transaction_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '子交易单ID',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `create_time` datetime NOT NULL COMMENT '交易时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '交易明细',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`),
  KEY `create_time` (`create_time`),
  KEY `transaction_number` (`transaction_number`)
) ENGINE=InnoDB AUTO_INCREMENT=834549 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账目(大表)';

-- ----------------------------
-- Table structure for account_item_type
-- ----------------------------
DROP TABLE IF EXISTS `account_item_type`;
CREATE TABLE `account_item_type` (
  `id` int(11) NOT NULL COMMENT '账目类型ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '账目类型名称',
  `catalog_id` int(11) NOT NULL COMMENT '所属目录ID(0没有归属目录)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账目类型';

-- ----------------------------
-- Table structure for account_item_type_catalog
-- ----------------------------
DROP TABLE IF EXISTS `account_item_type_catalog`;
CREATE TABLE `account_item_type_catalog` (
  `id` int(11) NOT NULL COMMENT '目录ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '目录名称',
  `parent_id` int(11) NOT NULL COMMENT '父目录ID',
  `level` smallint(6) NOT NULL COMMENT '目录级别',
  `orderby` int(11) NOT NULL COMMENT '目录排序',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账目类型目录';

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(6) NOT NULL COMMENT '活动类型(10秒杀，20促销)',
  `name` varchar(60) NOT NULL COMMENT '活动名称',
  `distribution_activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商活动ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动';

-- ----------------------------
-- Table structure for activity_coupon_issue
-- ----------------------------
DROP TABLE IF EXISTS `activity_coupon_issue`;
CREATE TABLE `activity_coupon_issue` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '活动名称',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `pop_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '弹框图片',
  `app_banner_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT 'APPbanner图',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:禁用)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='优惠券发放活动';

-- ----------------------------
-- Table structure for activity_coupon_issue_coupon_template
-- ----------------------------
DROP TABLE IF EXISTS `activity_coupon_issue_coupon_template`;
CREATE TABLE `activity_coupon_issue_coupon_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `template_id` int(11) NOT NULL COMMENT '优惠券模板ID',
  `issue_num` int(11) NOT NULL COMMENT '每日发放数量',
  `limit_quantity` tinyint(4) NOT NULL COMMENT '修理厂每日领券数量限制',
  `received_num` int(11) NOT NULL DEFAULT '0' COMMENT '已领取数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='发放活动优惠券模板';

-- ----------------------------
-- Table structure for activity_coupon_issue_receive_record
-- ----------------------------
DROP TABLE IF EXISTS `activity_coupon_issue_receive_record`;
CREATE TABLE `activity_coupon_issue_receive_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `template_id` int(11) NOT NULL COMMENT '优惠券模板ID',
  `receive_date` date NOT NULL COMMENT '领券结束时间',
  `received_num` int(11) NOT NULL DEFAULT '0' COMMENT '已领取数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`template_id`,`receive_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='发放活动领取记录表';

-- ----------------------------
-- Table structure for activity_customer_purchase
-- ----------------------------
DROP TABLE IF EXISTS `activity_customer_purchase`;
CREATE TABLE `activity_customer_purchase` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `expand_id` int(11) NOT NULL DEFAULT '0' COMMENT '扩展ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '购买数量',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`expand_id`,`customer_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='客户参加活动数量';

-- ----------------------------
-- Table structure for activity_distribution
-- ----------------------------
DROP TABLE IF EXISTS `activity_distribution`;
CREATE TABLE `activity_distribution` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(1参加，2不参加)',
  `purchase_status` tinyint(4) NOT NULL COMMENT '生成进货单(0未生成，1已生成)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COMMENT='参加活动服务商';

-- ----------------------------
-- Table structure for activity_order
-- ----------------------------
DROP TABLE IF EXISTS `activity_order`;
CREATE TABLE `activity_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `expand_id` int(11) NOT NULL DEFAULT '0' COMMENT '扩展ID',
  `number` char(20) NOT NULL COMMENT '订单编号',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '下单用户ID',
  `customer_name` varchar(64) NOT NULL DEFAULT '' COMMENT '客户名称',
  `customer_tel` varchar(20) NOT NULL DEFAULT '' COMMENT '客户联系电话',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `distribution_name` varchar(64) NOT NULL DEFAULT '' COMMENT '加盟商名称',
  `type` tinyint(4) NOT NULL COMMENT '订单类型(1秒杀订单)',
  `status` tinyint(4) NOT NULL COMMENT '订单状态(10待受理，20已完成，30已取消，40已删除)',
  `total_quantity` int(11) NOT NULL COMMENT '数量',
  `total_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '金额(元)',
  `coupon_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券金额(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(20) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  KEY `customer_id` (`customer_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动订单';

-- ----------------------------
-- Table structure for activity_order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `activity_order_coupon`;
CREATE TABLE `activity_order_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `coupon_id` int(11) NOT NULL COMMENT '优惠券ID',
  `discount_amount` decimal(12,2) NOT NULL COMMENT '优惠金额',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`,`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动订单优惠券详情';

-- ----------------------------
-- Table structure for activity_order_item
-- ----------------------------
DROP TABLE IF EXISTS `activity_order_item`;
CREATE TABLE `activity_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `product_description` varchar(255) NOT NULL DEFAULT '' COMMENT '产品描述',
  `join_unit_price` decimal(8,2) NOT NULL COMMENT '加盟单价(元)',
  `sale_unit_price` decimal(8,2) NOT NULL COMMENT '销售单价(元)',
  `join_activity_unit_price` decimal(8,2) NOT NULL COMMENT '加盟活动成交单价(元)',
  `join_activity_total_price` decimal(10,2) NOT NULL COMMENT '加盟活动成交总价(元)',
  `sale_activity_unit_price` decimal(8,2) NOT NULL COMMENT '销售活动单价(元)',
  `sale_activity_total_price` decimal(10,2) NOT NULL COMMENT '销售活动总价(元)',
  `note` varchar(20) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动订单详情';

-- ----------------------------
-- Table structure for activity_promote
-- ----------------------------
DROP TABLE IF EXISTS `activity_promote`;
CREATE TABLE `activity_promote` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `name` varchar(60) NOT NULL COMMENT '活动名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(1正常，2已禁用，3已删除)',
  `publish_status` tinyint(4) NOT NULL COMMENT '发布状态(0未发布，1已发布)',
  `purchase_status` tinyint(4) NOT NULL COMMENT '生成进货单(0未生成，1已生成)',
  `cancel_order_end_time` datetime NOT NULL COMMENT '取消订单截止时间',
  `purchase_order_end_time` datetime NOT NULL COMMENT '服务商进货截止时间',
  `preheat_start_time` datetime NOT NULL COMMENT '预热开始时间',
  `preheat_end_time` datetime NOT NULL COMMENT '预热结束时间',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `pic1` varchar(120) NOT NULL COMMENT 'pc预热图片',
  `pic2` varchar(120) NOT NULL COMMENT 'pc活动图片',
  `pic3` varchar(120) NOT NULL COMMENT 'app预热图片',
  `pic4` varchar(120) NOT NULL COMMENT 'app活动图片',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销活动';

-- ----------------------------
-- Table structure for activity_promote_coupon_template
-- ----------------------------
DROP TABLE IF EXISTS `activity_promote_coupon_template`;
CREATE TABLE `activity_promote_coupon_template` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `coupon_template_id` int(11) NOT NULL COMMENT '优惠券模板ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`coupon_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销活动优惠券';

-- ----------------------------
-- Table structure for activity_promote_item
-- ----------------------------
DROP TABLE IF EXISTS `activity_promote_item`;
CREATE TABLE `activity_promote_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_mpq` int(11) NOT NULL DEFAULT '1' COMMENT '产品最小包装量',
  `quantity` int(11) NOT NULL COMMENT '活动数量',
  `limit_quantity` int(11) NOT NULL COMMENT '限制购买数量（-1不限制）',
  `promote_price` decimal(8,2) NOT NULL COMMENT '促销价格(元)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `order_by` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销活动规则';

-- ----------------------------
-- Table structure for activity_promote_lucky_draw
-- ----------------------------
DROP TABLE IF EXISTS `activity_promote_lucky_draw`;
CREATE TABLE `activity_promote_lucky_draw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `reach` decimal(12,2) NOT NULL COMMENT '达到金额',
  `reward` int(11) NOT NULL COMMENT '奖励',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`lucky_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='促销活动抽奖';

-- ----------------------------
-- Table structure for activity_rule_description
-- ----------------------------
DROP TABLE IF EXISTS `activity_rule_description`;
CREATE TABLE `activity_rule_description` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `pc_description` text COMMENT 'pc规则',
  `app_description` text COMMENT 'app规则',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动规则描述';

-- ----------------------------
-- Table structure for activity_seckill
-- ----------------------------
DROP TABLE IF EXISTS `activity_seckill`;
CREATE TABLE `activity_seckill` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `name` varchar(60) NOT NULL COMMENT '活动名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(1正常，2已失效，3已删除)',
  `publish_status` tinyint(4) NOT NULL COMMENT '发布状态(0未发布，1已发布)',
  `purchase_status` tinyint(4) NOT NULL COMMENT '生成进货单(0未生成，1已生成)',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀活动';

-- ----------------------------
-- Table structure for activity_seckill_item
-- ----------------------------
DROP TABLE IF EXISTS `activity_seckill_item`;
CREATE TABLE `activity_seckill_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '秒杀活动ID',
  `name` varchar(60) NOT NULL COMMENT '名称',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_mpq` int(11) NOT NULL DEFAULT '1' COMMENT '产品最小包装量',
  `quantity` int(11) NOT NULL COMMENT '活动数量',
  `attend_quantity` int(11) NOT NULL COMMENT '已参加活动数量',
  `limit_quantity` int(11) NOT NULL COMMENT '限制购买数量（-1不限制）',
  `join_activity_unit_price` decimal(8,2) NOT NULL COMMENT '加盟活动单价(元)',
  `sale_activity_unit_price` decimal(8,2) NOT NULL COMMENT '销售活动单价(元)',
  `join_unit_price` decimal(8,2) NOT NULL COMMENT '加盟单价(元)',
  `sale_unit_price` decimal(8,2) NOT NULL COMMENT '销售单价(元)',
  `start_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='秒杀活动详情';

-- ----------------------------
-- Table structure for activity_stock
-- ----------------------------
DROP TABLE IF EXISTS `activity_stock`;
CREATE TABLE `activity_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `activity_item_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动规则ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '活动数量',
  `attend_quantity` int(11) NOT NULL COMMENT '已参加活动数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`activity_item_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动库存';

-- ----------------------------
-- Table structure for activity_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `activity_storehouse`;
CREATE TABLE `activity_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `storehouse_id` int(11) NOT NULL COMMENT '发货仓库ID',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动发货仓库';

-- ----------------------------
-- Table structure for adjust_account
-- ----------------------------
DROP TABLE IF EXISTS `adjust_account`;
CREATE TABLE `adjust_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '调账账目ID',
  `type` smallint(6) NOT NULL COMMENT '调账类型(2000冲正，3000优惠)',
  `item_id` bigint(20) NOT NULL COMMENT '账目ID',
  `source_item_id` bigint(20) NOT NULL COMMENT '被调账账目ID',
  `amount` decimal(16,2) NOT NULL COMMENT '调账金额',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `create_time` datetime NOT NULL COMMENT '调账时间',
  `reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '调账原因',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `source_item_id` (`source_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3221 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='调账账目(大表)';

-- ----------------------------
-- Table structure for allocation_order
-- ----------------------------
DROP TABLE IF EXISTS `allocation_order`;
CREATE TABLE `allocation_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `in_storehouse_id` int(11) NOT NULL COMMENT '调入仓库ID',
  `out_storehouse_id` int(11) NOT NULL COMMENT '调出仓库ID',
  `stock_lock_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '库存锁定单号',
  `status` smallint(6) NOT NULL COMMENT '状态(11000待审核，12000待发货，13000待收货，14000已完成，20000已取消，21000已退单)',
  `user_id` int(11) NOT NULL COMMENT '申请员工ID',
  `audit_id` int(11) NOT NULL DEFAULT '0' COMMENT '审核员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `arrival_date` date DEFAULT NULL COMMENT '到货日期',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总金额(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `audit_time` datetime DEFAULT NULL COMMENT '发货时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '物流支付方式',
  `logistics_cost_amount` decimal(8,2) DEFAULT NULL COMMENT '物流费用金额',
  `logistics_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `box_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '发货箱数',
  `stock_in_transit_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '在途库存单号',
  `receipt_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实收数量',
  `receipt_price` decimal(14,4) DEFAULT NULL COMMENT '实收总价(元)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `in_storehouse_id` (`in_storehouse_id`),
  KEY `out_storehouse_id` (`out_storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='调拨单';

-- ----------------------------
-- Table structure for allocation_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `allocation_order_contact`;
CREATE TABLE `allocation_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '调拨单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1发货方联系人，2收货方联系人)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='调拨单联系信息';

-- ----------------------------
-- Table structure for allocation_order_item
-- ----------------------------
DROP TABLE IF EXISTS `allocation_order_item`;
CREATE TABLE `allocation_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '调拨单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '调拨数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `deliver_quantity` int(11) DEFAULT NULL COMMENT '实际发货数量',
  `receipt_quantity` int(11) DEFAULT NULL COMMENT '实际收货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='调拨单行';

-- ----------------------------
-- Table structure for allocation_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `allocation_order_trace`;
CREATE TABLE `allocation_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '调拨单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='调拨单跟踪';

-- ----------------------------
-- Table structure for attribute_specification
-- ----------------------------
DROP TABLE IF EXISTS `attribute_specification`;
CREATE TABLE `attribute_specification` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性规格ID',
  `key` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '属性KEY',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '属性名称',
  `type` smallint(6) NOT NULL COMMENT '属性类型(1000整形，1100浮点型，1200文本型)',
  `option` varchar(300) COLLATE utf8_bin NOT NULL DEFAULT '[]' COMMENT '选项',
  `required` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否必填(0:否,1:是)',
  `unit` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '属性单位',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10013102 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品属性规格';

-- ----------------------------
-- Table structure for average_daily_sales_volume
-- ----------------------------
DROP TABLE IF EXISTS `average_daily_sales_volume`;
CREATE TABLE `average_daily_sales_volume` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `date` date NOT NULL COMMENT '统计日期',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待处理，1100已完成，1200已过期)',
  `days` int(11) NOT NULL COMMENT '累计天数',
  `create_time` datetime NOT NULL COMMENT '报表生成时间',
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='平均日销量报表(补货量)';

-- ----------------------------
-- Table structure for average_daily_sales_volume_item
-- ----------------------------
DROP TABLE IF EXISTS `average_daily_sales_volume_item`;
CREATE TABLE `average_daily_sales_volume_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `average_quantity` decimal(18,6) NOT NULL COMMENT '累计平均日销量',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='平均日销量报表行(补货量)';

-- ----------------------------
-- Table structure for balance_log
-- ----------------------------
DROP TABLE IF EXISTS `balance_log`;
CREATE TABLE `balance_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '余额日志ID',
  `balance_id` int(11) NOT NULL COMMENT '余额帐本ID',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `balance` decimal(16,2) NOT NULL COMMENT '余额',
  `account_item_id` bigint(20) NOT NULL COMMENT '账目ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `balance_id` (`balance_id`),
  KEY `account_item_id` (`account_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=777066 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='余额日志(大表)';

-- ----------------------------
-- Table structure for brand
-- ----------------------------
DROP TABLE IF EXISTS `brand`;
CREATE TABLE `brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品牌ID',
  `number` char(6) COLLATE utf8_bin NOT NULL COMMENT '品牌编号',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '品牌名称',
  `type` tinyint(4) NOT NULL COMMENT '类型(1自有品牌，2第三方品牌)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已入库，1100已上架，2000已下架)',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT '品牌权重',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '品牌描述',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品牌';

-- ----------------------------
-- Table structure for brand_category
-- ----------------------------
DROP TABLE IF EXISTS `brand_category`;
CREATE TABLE `brand_category` (
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  PRIMARY KEY (`brand_id`,`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品牌品类';

-- ----------------------------
-- Table structure for brand_supplier
-- ----------------------------
DROP TABLE IF EXISTS `brand_supplier`;
CREATE TABLE `brand_supplier` (
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  PRIMARY KEY (`brand_id`,`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品牌供应商';

-- ----------------------------
-- Table structure for bulk_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `bulk_payment_order`;
CREATE TABLE `bulk_payment_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `transaction_type_id` int(11) NOT NULL COMMENT '交易类型ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10待支付，20支付成功)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='批量支付订单';

-- ----------------------------
-- Table structure for bulk_payment_order_item
-- ----------------------------
DROP TABLE IF EXISTS `bulk_payment_order_item`;
CREATE TABLE `bulk_payment_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `transaction_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '交易单号',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='批量支付订单行';

-- ----------------------------
-- Table structure for business_entity
-- ----------------------------
DROP TABLE IF EXISTS `business_entity`;
CREATE TABLE `business_entity` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名字',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '类型(10:公司,20:直营店)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '类型(10:正常,20:被删除)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='营业主体';

-- ----------------------------
-- Table structure for business_reference
-- ----------------------------
DROP TABLE IF EXISTS `business_reference`;
CREATE TABLE `business_reference` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `source_table` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '源表',
  `source_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '源业务名称',
  `target_table` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '目标表',
  `target_name` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '目标业务名称',
  `reference_value` int(11) NOT NULL COMMENT '引用值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `reference_value` (`reference_value`,`target_table`,`source_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='业务值引用表';

-- ----------------------------
-- Table structure for cabinet
-- ----------------------------
DROP TABLE IF EXISTS `cabinet`;
CREATE TABLE `cabinet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `type_id` int(11) NOT NULL COMMENT '型号ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属服务商ID',
  `garage_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属修理厂ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `join_front_project_status` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '参加公司产品前置项目状态(10参加,20不参加)',
  `join_front_project_time` datetime DEFAULT NULL COMMENT '参加公司产品前置项目时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜';

-- ----------------------------
-- Table structure for cabinet_cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_cart_item`;
CREATE TABLE `cabinet_cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '客户ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `car_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '车型ID',
  `garage_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户登录用户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`garage_id`,`garage_user_id`,`cabinet_id`,`product_id`,`car_type_id`),
  KEY `distribution_id_2` (`distribution_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜购物车行(大表)';

-- ----------------------------
-- Table structure for cabinet_cart_item_history
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_cart_item_history`;
CREATE TABLE `cabinet_cart_item_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '客户ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `car_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '车型ID',
  `garage_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户登录用户ID',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `garage_id` (`garage_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜购物车行历史表(大表)';

-- ----------------------------
-- Table structure for cabinet_inspection_task
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_inspection_task`;
CREATE TABLE `cabinet_inspection_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '巡检任务单号',
  `cabinet_id` int(11) NOT NULL DEFAULT '0' COMMENT '配件柜ID',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '截止日期',
  `inventory_plan_id` int(11) NOT NULL DEFAULT '0' COMMENT '配件柜盘点计划ID',
  `garage_address` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '修理厂地址',
  `garage_lng` decimal(10,7) DEFAULT NULL COMMENT '修理厂经度',
  `garage_lat` decimal(10,7) DEFAULT NULL COMMENT '修理厂纬度',
  `sign_lng` decimal(10,7) DEFAULT NULL COMMENT '打卡地点经度',
  `sign_lat` decimal(10,7) DEFAULT NULL COMMENT '打卡地点纬度',
  `sign_time` datetime DEFAULT NULL COMMENT '打卡时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10未完成,20已完成)',
  `review_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '审核状态(10待审核,20合格,30不合格)',
  `review_note` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '审核说明',
  `review_user_id` int(11) NOT NULL COMMENT '操作人ID',
  `review_user_name` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `review_time` datetime DEFAULT NULL COMMENT '审核时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜巡检任务';

-- ----------------------------
-- Table structure for cabinet_inspection_task_extend_picture
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_inspection_task_extend_picture`;
CREATE TABLE `cabinet_inspection_task_extend_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_id` int(11) NOT NULL COMMENT '配件柜巡检任务ID',
  `pic` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜巡检任务图片表';

-- ----------------------------
-- Table structure for cabinet_inspection_task_tracking
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_inspection_task_tracking`;
CREATE TABLE `cabinet_inspection_task_tracking` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cabinet_id` int(11) NOT NULL DEFAULT '0' COMMENT '配件柜ID',
  `first_shop_goods_date` date DEFAULT NULL COMMENT '第一次铺货上架时间',
  `last_task_end_date` date DEFAULT NULL COMMENT '最后一个任务的截止时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cabinet_id` (`cabinet_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜巡检任务跟踪表(脚本使用)';

-- ----------------------------
-- Table structure for cabinet_inventory_plan
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_inventory_plan`;
CREATE TABLE `cabinet_inventory_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '盘点单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属服务商ID',
  `garage_id` int(11) NOT NULL DEFAULT '0' COMMENT '修理厂ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `date` date NOT NULL COMMENT '盘点日期',
  `type` tinyint(4) NOT NULL COMMENT '类型(10全盘点，20部分盘点)',
  `status` tinyint(4) NOT NULL COMMENT '类型(10待审核，20已完成，30已取消)',
  `profit_product_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '盘盈产品数量',
  `loss_product_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '盘亏产品数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `garage_id` (`garage_id`,`cabinet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜盘点计划';

-- ----------------------------
-- Table structure for cabinet_inventory_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_inventory_plan_item`;
CREATE TABLE `cabinet_inventory_plan_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL DEFAULT '0' COMMENT '盘点计划ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `stock_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '库存数量',
  `inventory_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '盘点数量',
  `note` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB AUTO_INCREMENT=306 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜盘点明细';

-- ----------------------------
-- Table structure for cabinet_location
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_location`;
CREATE TABLE `cabinet_location` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `digit` tinyint(5) NOT NULL COMMENT '数字',
  `symbol` varchar(5) COLLATE utf8mb4_bin NOT NULL COMMENT '符号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `cabinet_id` (`cabinet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜库位';

-- ----------------------------
-- Table structure for cabinet_sales_order
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_sales_order`;
CREATE TABLE `cabinet_sales_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(100表示开单,200表示退货)',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `garage_user_id` int(11) DEFAULT '0' COMMENT '下单用户ID',
  `garage_user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '下单用户名称',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '成交总价(元)',
  `distribution_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '服务商成交总价(元)',
  `garage_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '修理厂成交总价(元)',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `status` tinyint(3) unsigned NOT NULL COMMENT '状态(5:待出库,10:待入库,20:已完成,25:已退货,30:已取消)',
  `vin` char(17) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '车架号',
  `car_type` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '车型',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `source` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '来源',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `delete_user_id` int(11) DEFAULT '0' COMMENT '取消用户ID',
  `delete_user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '取消用户名称',
  `outstock_user_id` int(11) DEFAULT '0' COMMENT '出库用户ID',
  `outstock_user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '出库用户名称',
  `instock_user_id` int(11) DEFAULT '0' COMMENT '入库用户ID',
  `instock_user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '入库用户名称',
  `delete_time` datetime DEFAULT NULL COMMENT '取消时间',
  `outstock_time` datetime DEFAULT NULL COMMENT '出库时间',
  `instock_time` datetime DEFAULT NULL COMMENT '入库时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `garage_id` (`garage_id`),
  KEY `complete_time` (`complete_time`)
) ENGINE=InnoDB AUTO_INCREMENT=262 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜销售单';

-- ----------------------------
-- Table structure for cabinet_sales_order_item
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_sales_order_item`;
CREATE TABLE `cabinet_sales_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `location_id` int(11) NOT NULL DEFAULT '0' COMMENT '库位ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `join_unit_price` decimal(8,2) NOT NULL COMMENT '加盟单价(元)',
  `distribution_unit_price` decimal(8,2) NOT NULL COMMENT '服务商门店单价(元)',
  `distribution_total_price` decimal(10,2) NOT NULL COMMENT '服务商门店总价(元)',
  `garage_unit_price` decimal(8,2) NOT NULL COMMENT '修理厂门店单价(元)',
  `garage_total_price` decimal(10,2) NOT NULL COMMENT '修理厂门店总价(元)',
  `bargain_unit_price` decimal(8,2) NOT NULL COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL COMMENT '成交总价(元)',
  `note` varchar(20) CHARACTER SET utf8 NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=281 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜销售单明细';

-- ----------------------------
-- Table structure for cabinet_sales_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_sales_order_trace`;
CREATE TABLE `cabinet_sales_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '配件柜销售单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `ip_addr` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'IP地址',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=476 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜销售单跟踪';

-- ----------------------------
-- Table structure for cabinet_shop_goods_order
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_shop_goods_order`;
CREATE TABLE `cabinet_shop_goods_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '铺货单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属服务商ID',
  `garage_id` int(11) NOT NULL DEFAULT '0' COMMENT '修理厂ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10开单，20退单)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10待上架，20已完成，90已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`garage_id`,`cabinet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=256 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜铺货单';

-- ----------------------------
-- Table structure for cabinet_shop_goods_order_item
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_shop_goods_order_item`;
CREATE TABLE `cabinet_shop_goods_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '配件柜铺货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '铺货数量',
  `shelve_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10表示待上架,20表示上架中,30表示已上架,40表示上架失败)',
  `shelve_quantity` int(11) NOT NULL COMMENT '上架数量',
  `location_id` int(11) NOT NULL DEFAULT '0' COMMENT '上架库位ID',
  `location_name` varchar(5) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '上架库位编号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=361 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜铺货单行';

-- ----------------------------
-- Table structure for cabinet_shop_goods_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_shop_goods_order_trace`;
CREATE TABLE `cabinet_shop_goods_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '配件柜铺货单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `ip_addr` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'IP地址',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=405 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜铺货单跟踪';

-- ----------------------------
-- Table structure for cabinet_stock
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_stock`;
CREATE TABLE `cabinet_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属服务商ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '库存数量',
  `pending_out` int(11) NOT NULL DEFAULT '0' COMMENT '待出库数量',
  `pending_in` int(11) NOT NULL DEFAULT '0' COMMENT '待入库数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`cabinet_id`,`product_id`),
  KEY `cabinet_id` (`cabinet_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜库存';

-- ----------------------------
-- Table structure for cabinet_stock_item
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_stock_item`;
CREATE TABLE `cabinet_stock_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `inout` tinyint(4) NOT NULL COMMENT '出入库(1入库，2出库)',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '出入库数量',
  `surplus` int(11) NOT NULL DEFAULT '0' COMMENT '剩余库存数量',
  `type` tinyint(4) NOT NULL COMMENT '类型(11上架，21销售，22退货，31盘盈，32盘亏)',
  `order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `cabinet_id` (`cabinet_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=412 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜库存流水';

-- ----------------------------
-- Table structure for cabinet_stockout_item
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_stockout_item`;
CREATE TABLE `cabinet_stockout_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属服务商ID',
  `cabinet_id` int(11) NOT NULL COMMENT '配件柜ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10表示正常,20表示被删除)',
  `quantity` int(11) NOT NULL COMMENT '缺货数量',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`cabinet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜缺货单明细';

-- ----------------------------
-- Table structure for cabinet_type
-- ----------------------------
DROP TABLE IF EXISTS `cabinet_type`;
CREATE TABLE `cabinet_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='配件柜型号';

-- ----------------------------
-- Table structure for car
-- ----------------------------
DROP TABLE IF EXISTS `car`;
CREATE TABLE `car` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` smallint(6) NOT NULL COMMENT '类型(11000刹车片，12000滤清器，13000火花塞)',
  `line_id` int(11) NOT NULL COMMENT '车系ID',
  `line_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '车系名称',
  `name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '车型名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `type` (`type`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=47204 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='汽车车型';

-- ----------------------------
-- Table structure for car_brand
-- ----------------------------
DROP TABLE IF EXISTS `car_brand`;
CREATE TABLE `car_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品牌ID',
  `first_letter` char(1) COLLATE utf8_bin NOT NULL COMMENT '品牌首字母',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '品牌名称',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT '品牌权重',
  `logo` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'LOGO图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=177 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='汽车品牌';

-- ----------------------------
-- Table structure for car_brand_keyword
-- ----------------------------
DROP TABLE IF EXISTS `car_brand_keyword`;
CREATE TABLE `car_brand_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `keyword` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '关键字',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `brand_id` (`brand_id`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='品牌关键字';

-- ----------------------------
-- Table structure for car_line
-- ----------------------------
DROP TABLE IF EXISTS `car_line`;
CREATE TABLE `car_line` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '车系ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '车系名称',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT '权重',
  `logo` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'LOGO图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=369 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='汽车车系';

-- ----------------------------
-- Table structure for car_maker
-- ----------------------------
DROP TABLE IF EXISTS `car_maker`;
CREATE TABLE `car_maker` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '厂商ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '厂商名称',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=241 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='汽车厂商';

-- ----------------------------
-- Table structure for car_param
-- ----------------------------
DROP TABLE IF EXISTS `car_param`;
CREATE TABLE `car_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `car_id` int(11) NOT NULL COMMENT '车型ID',
  `type` smallint(6) NOT NULL COMMENT '类型(10100年款，10200排量，10300发动机型号)',
  `value` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '参数值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `car_id` (`car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54700 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='车型参数';

-- ----------------------------
-- Table structure for car_series
-- ----------------------------
DROP TABLE IF EXISTS `car_series`;
CREATE TABLE `car_series` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '车系ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '车系名称',
  `maker_id` int(11) NOT NULL COMMENT '厂商ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1902 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='汽车车系';

-- ----------------------------
-- Table structure for car_series_keyword
-- ----------------------------
DROP TABLE IF EXISTS `car_series_keyword`;
CREATE TABLE `car_series_keyword` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `series_id` int(11) NOT NULL COMMENT '车系ID',
  `keyword` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '关键字',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `series_id` (`series_id`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB AUTO_INCREMENT=3155 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='车系关键字';

-- ----------------------------
-- Table structure for car_style
-- ----------------------------
DROP TABLE IF EXISTS `car_style`;
CREATE TABLE `car_style` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `maker_id` int(11) NOT NULL COMMENT '厂商ID',
  `series_id` int(11) NOT NULL COMMENT '车系ID',
  `brand_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '品牌名称',
  `maker_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '厂商名称',
  `series_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '车系名称',
  `displacement` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '排量',
  `ext_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '车名称扩展',
  `engine` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '发动机编号',
  `start_year` smallint(6) NOT NULL COMMENT '生产年份',
  `end_year` smallint(6) NOT NULL DEFAULT '9999' COMMENT '停产年份',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6054 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='车型';

-- ----------------------------
-- Table structure for cart_activity_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_activity_item`;
CREATE TABLE `cart_activity_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`customer_id`,`product_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='活动购物车';

-- ----------------------------
-- Table structure for cart_item
-- ----------------------------
DROP TABLE IF EXISTS `cart_item`;
CREATE TABLE `cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `customer_id` (`customer_id`,`distribution_id`,`product_id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='购物车行(大表)';

-- ----------------------------
-- Table structure for cart_item_history
-- ----------------------------
DROP TABLE IF EXISTS `cart_item_history`;
CREATE TABLE `cart_item_history` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  KEY `customer_id` (`customer_id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `product_id` (`product_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='购物车行历史表(大表)';

-- ----------------------------
-- Table structure for channel_distribution
-- ----------------------------
DROP TABLE IF EXISTS `channel_distribution`;
CREATE TABLE `channel_distribution` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道服务商表';

-- ----------------------------
-- Table structure for channel_distribution_bill
-- ----------------------------
DROP TABLE IF EXISTS `channel_distribution_bill`;
CREATE TABLE `channel_distribution_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '账单编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `month` int(11) NOT NULL COMMENT '账单周期',
  `month_start` date NOT NULL COMMENT '账单周期起始日期',
  `month_end` date NOT NULL COMMENT '账单周期截止日期',
  `amount` decimal(12,2) NOT NULL COMMENT '账单总金额(元)',
  `payable_amount` decimal(12,2) NOT NULL COMMENT '应付金额(元)',
  `payment_amount` decimal(12,2) NOT NULL COMMENT '实付金额(元)',
  `join_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '加盟总金额(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待付款,10:已付款)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商账单';

-- ----------------------------
-- Table structure for channel_distribution_bill_order
-- ----------------------------
DROP TABLE IF EXISTS `channel_distribution_bill_order`;
CREATE TABLE `channel_distribution_bill_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL COMMENT '服务商账单ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商账单订单';

-- ----------------------------
-- Table structure for channel_distribution_bill_trace
-- ----------------------------
DROP TABLE IF EXISTS `channel_distribution_bill_trace`;
CREATE TABLE `channel_distribution_bill_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL COMMENT '服务商账单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `old_payable_amount` decimal(12,2) NOT NULL COMMENT '原应付金额(元)',
  `new_payable_amount` decimal(12,2) NOT NULL COMMENT '新应付金额(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商账单日志';

-- ----------------------------
-- Table structure for channel_distribution_settle_bill
-- ----------------------------
DROP TABLE IF EXISTS `channel_distribution_settle_bill`;
CREATE TABLE `channel_distribution_settle_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `month` int(11) NOT NULL COMMENT '月份',
  `total_order_num` int(11) NOT NULL COMMENT '订单数',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待结算,10:已结算)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`month`,`merchants_id`),
  KEY `merchants_id` (`merchants_id`,`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商渠道结算账单';

-- ----------------------------
-- Table structure for channel_garage
-- ----------------------------
DROP TABLE IF EXISTS `channel_garage`;
CREATE TABLE `channel_garage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `merchants_garage_id` int(11) DEFAULT NULL COMMENT '渠道商汽修厂ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`garage_id`),
  UNIQUE KEY `merchants_garage_id` (`merchants_id`,`merchants_garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8 COMMENT='渠道修理厂关系表';

-- ----------------------------
-- Table structure for channel_garage_apply
-- ----------------------------
DROP TABLE IF EXISTS `channel_garage_apply`;
CREATE TABLE `channel_garage_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `source` tinyint(4) NOT NULL DEFAULT '10' COMMENT '来源类型(10:渠道商平台,20:开放接口)',
  `name` varchar(30) NOT NULL COMMENT '店名',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `merchants_garage_id` int(11) DEFAULT NULL COMMENT '渠道商汽修厂ID',
  `merchants_related_number` varchar(30) DEFAULT NULL COMMENT '渠道商申请相关编号',
  `distribution_id` int(11) NOT NULL COMMENT '所属服务商ID',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(100) NOT NULL COMMENT '详细地址',
  `lng` decimal(10,7) NOT NULL DEFAULT '0.0000000' COMMENT '经度',
  `lat` decimal(10,7) NOT NULL DEFAULT '0.0000000' COMMENT '纬度',
  `contact_name` varchar(10) NOT NULL COMMENT '联系人姓名',
  `contact_mobi` varchar(20) NOT NULL COMMENT '联系电话',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待审核,20:删除,30:审核不通过,40:审核通过)',
  `reason` varchar(255) NOT NULL DEFAULT '' COMMENT '不通过原因',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchants_related_number` (`merchants_id`,`merchants_related_number`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8 COMMENT='渠道门店申请';

-- ----------------------------
-- Table structure for channel_merchants
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants`;
CREATE TABLE `channel_merchants` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) NOT NULL COMMENT '渠道商名称',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(100) NOT NULL COMMENT '详细地址',
  `contact_name` varchar(10) NOT NULL COMMENT '联系人姓名',
  `contact_mobi` varchar(20) NOT NULL COMMENT '联系电话',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:禁用)',
  `rule_id` int(11) NOT NULL COMMENT '定价规则ID',
  `approve_quota` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '授信额度',
  `business_license_pic` varchar(120) NOT NULL DEFAULT '' COMMENT '营业执照',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `license` tinyint(4) NOT NULL DEFAULT '1' COMMENT '许可方式(1全品类，2部分品类)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20000025 DEFAULT CHARSET=utf8 COMMENT='渠道商';

-- ----------------------------
-- Table structure for channel_merchants_bill
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_bill`;
CREATE TABLE `channel_merchants_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '账单编号',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `month` int(11) NOT NULL COMMENT '账单周期',
  `month_start` date NOT NULL COMMENT '账单周期起始日期',
  `month_end` date NOT NULL COMMENT '账单周期截止日期',
  `amount` decimal(12,2) NOT NULL COMMENT '账单金额(元)',
  `payable_amount` decimal(12,2) NOT NULL COMMENT '应付金额(元)',
  `payment_amount` decimal(12,2) NOT NULL COMMENT '实付金额(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待付款，15:已付款)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`month`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='渠道商账单';

-- ----------------------------
-- Table structure for channel_merchants_bill_order
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_bill_order`;
CREATE TABLE `channel_merchants_bill_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL COMMENT '渠道商结算账单ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单id',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='渠道商账单订单';

-- ----------------------------
-- Table structure for channel_merchants_bill_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_bill_payment_order`;
CREATE TABLE `channel_merchants_bill_payment_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL COMMENT '渠道商账单ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `number` char(20) NOT NULL COMMENT '付款单编号',
  `amount` decimal(12,2) NOT NULL COMMENT '付款金额(元)',
  `transfer_method` tinyint(4) NOT NULL DEFAULT '5' COMMENT '转款方式(5:银行转账)',
  `transfer_user_name` varchar(64) NOT NULL DEFAULT '' COMMENT '转款用户名',
  `transfer_date` date NOT NULL COMMENT '转账日期',
  `transfer_receipt_pic` varchar(120) NOT NULL DEFAULT '' COMMENT '转款回执上传',
  `receipt_account_number` char(20) NOT NULL COMMENT '收款账号',
  `receipt_account_bank_name` varchar(128) NOT NULL COMMENT '收款账号开户行名字',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待确认,10:已支付)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `confirm_time` datetime DEFAULT NULL COMMENT '确认时间',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='渠道商账单付款单';

-- ----------------------------
-- Table structure for channel_merchants_bill_payment_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_bill_payment_order_trace`;
CREATE TABLE `channel_merchants_bill_payment_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '渠道商付款单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='渠道商付款单日志';

-- ----------------------------
-- Table structure for channel_merchants_bill_trace
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_bill_trace`;
CREATE TABLE `channel_merchants_bill_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL COMMENT '渠道商结算账单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `old_payable_amount` decimal(12,2) NOT NULL COMMENT '原应付金额(元)',
  `new_payable_amount` decimal(12,2) NOT NULL COMMENT '新应付金额(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='渠道商账单日志';

-- ----------------------------
-- Table structure for channel_merchants_contract
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_contract`;
CREATE TABLE `channel_merchants_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(10有效、20作废)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道商合同';

-- ----------------------------
-- Table structure for channel_merchants_contract_pic
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_contract_pic`;
CREATE TABLE `channel_merchants_contract_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `contract_id` int(11) NOT NULL COMMENT '渠道商合同id',
  `pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道商合同图片';

-- ----------------------------
-- Table structure for channel_merchants_garage
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_garage`;
CREATE TABLE `channel_merchants_garage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `merchants_garage_id` varchar(30) NOT NULL COMMENT '渠道商汽修厂ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`merchants_garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商汽修厂表';

-- ----------------------------
-- Table structure for channel_merchants_interface_config
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_interface_config`;
CREATE TABLE `channel_merchants_interface_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `url` varchar(500) COLLATE utf8_bin NOT NULL COMMENT '地址',
  `secret_key` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '秘钥',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchants_id` (`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道商接口配置表';

-- ----------------------------
-- Table structure for channel_merchants_level_config
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_level_config`;
CREATE TABLE `channel_merchants_level_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '配置状态,10表示正常，20表示被删除',
  `level` tinyint(4) NOT NULL DEFAULT '1' COMMENT '等级,1表示默认等级,2表示A级价格,以此类推',
  `create_time` datetime NOT NULL DEFAULT '1980-01-01 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '1980-01-01 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道商等级配置';

-- ----------------------------
-- Table structure for channel_merchants_settle_bill
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_settle_bill`;
CREATE TABLE `channel_merchants_settle_bill` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '订单编号',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `month` int(11) NOT NULL COMMENT '月份',
  `total_order_num` int(11) NOT NULL COMMENT '订单数',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待结算,10:已结算)',
  `pay_mode` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付方式(1:未指定,2:微信,3:支付宝,4:银行卡)',
  `pay_account` varchar(50) NOT NULL DEFAULT '' COMMENT '支付账号',
  `pay_serial_number` varchar(50) NOT NULL DEFAULT '' COMMENT '支付流水号',
  `pay_date` date DEFAULT NULL COMMENT '支付日期',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`month`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商结算账单';

-- ----------------------------
-- Table structure for channel_merchants_settle_bill_trace
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_settle_bill_trace`;
CREATE TABLE `channel_merchants_settle_bill_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bill_id` int(11) NOT NULL COMMENT '渠道商结算账单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `bill_id` (`bill_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商结算账单日志';

-- ----------------------------
-- Table structure for channel_merchants_user
-- ----------------------------
DROP TABLE IF EXISTS `channel_merchants_user`;
CREATE TABLE `channel_merchants_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `username` varchar(20) NOT NULL COMMENT '登录手机号',
  `password_hash` char(60) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `is_admin` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否超级管理员(1是，0否)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10有效，11冻结，90已注销)',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `merchants_id` (`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='渠道商用户';

-- ----------------------------
-- Table structure for channel_product_channel_price
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_channel_price`;
CREATE TABLE `channel_product_channel_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(8,2) NOT NULL COMMENT '渠道价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品渠道自定价';

-- ----------------------------
-- Table structure for channel_product_channel_price_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_channel_price_log`;
CREATE TABLE `channel_product_channel_price_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10新增自定义价，20删除自定义价，30调整自定义价)',
  `old_price` decimal(8,2) DEFAULT NULL COMMENT '原渠道价(元)',
  `new_price` decimal(8,2) NOT NULL COMMENT '新渠道价(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品渠道自定价日志';

-- ----------------------------
-- Table structure for channel_product_garage_price
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_garage_price`;
CREATE TABLE `channel_product_garage_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(8,2) NOT NULL COMMENT '价格(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`merchants_id`),
  KEY `merchants_id` (`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品修理厂自定价';

-- ----------------------------
-- Table structure for channel_product_garage_price_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_garage_price_log`;
CREATE TABLE `channel_product_garage_price_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10新增自定义价，20删除自定义价，30调整自定义价)',
  `old_price` decimal(8,2) DEFAULT NULL COMMENT '原渠道价(元)',
  `new_price` decimal(8,2) NOT NULL COMMENT '新渠道价(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`),
  KEY `product_id` (`product_id`,`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品修理厂自定价日志';

-- ----------------------------
-- Table structure for channel_product_guide_price
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_guide_price`;
CREATE TABLE `channel_product_guide_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rule_id` int(11) NOT NULL COMMENT '定价规则ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `channel_price` decimal(8,2) NOT NULL COMMENT '渠道价(元)',
  `distribution_rebate` decimal(8,2) NOT NULL COMMENT '服务商返利(元)',
  `garage_price` decimal(8,2) NOT NULL COMMENT '修理厂价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品指导价';

-- ----------------------------
-- Table structure for channel_product_guide_price_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_guide_price_log`;
CREATE TABLE `channel_product_guide_price_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rule_id` int(11) NOT NULL COMMENT '定价规则ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_channel_price` decimal(8,2) DEFAULT NULL COMMENT '原渠道价(元)',
  `new_channel_price` decimal(8,2) NOT NULL COMMENT '新渠道价(元)',
  `old_distribution_rebate` decimal(8,2) DEFAULT NULL COMMENT '原服务商返利(元)',
  `new_distribution_rebate` decimal(8,2) NOT NULL COMMENT '新服务商返利(元)',
  `old_garage_price` decimal(8,2) DEFAULT NULL COMMENT '原修理厂价(元)',
  `new_garage_price` decimal(8,2) NOT NULL COMMENT '新修理厂价(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`,`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品指导价日志';

-- ----------------------------
-- Table structure for channel_product_license
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_license`;
CREATE TABLE `channel_product_license` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `category_id` int(11) NOT NULL COMMENT '品类id',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=120 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品销售许可';

-- ----------------------------
-- Table structure for channel_product_price
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_price`;
CREATE TABLE `channel_product_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(8,2) NOT NULL COMMENT '销售价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商产品价格';

-- ----------------------------
-- Table structure for channel_product_price_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_price_log`;
CREATE TABLE `channel_product_price_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_price` decimal(8,2) NOT NULL COMMENT '原销售价(元)',
  `new_price` decimal(8,2) NOT NULL COMMENT '新销售价(元)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商产品价格日志';

-- ----------------------------
-- Table structure for channel_product_pricing_rule
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_pricing_rule`;
CREATE TABLE `channel_product_pricing_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10，20)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10正常，90关闭)',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `channel_price_params` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '渠道价格参数',
  `rebate_params` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '返利参数',
  `allow_customize_channel` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否允许自定义渠道价格(0否，1是)',
  `allow_customize_garage` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否允许自定义修理厂价格(0否，1是)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='渠道产品定价规则';

-- ----------------------------
-- Table structure for channel_product_rebate_amount
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_rebate_amount`;
CREATE TABLE `channel_product_rebate_amount` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `amount` decimal(8,2) NOT NULL COMMENT '返利金额(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27593 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商返利金额';

-- ----------------------------
-- Table structure for channel_product_rebate_amount_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_rebate_amount_log`;
CREATE TABLE `channel_product_rebate_amount_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_amount` decimal(8,2) DEFAULT NULL COMMENT '原返利金额(元)',
  `new_amount` decimal(8,2) NOT NULL COMMENT '新返利金额(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104008 DEFAULT CHARSET=utf8 COMMENT='服务商返利金额日志';

-- ----------------------------
-- Table structure for channel_product_store_guide_price
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_store_guide_price`;
CREATE TABLE `channel_product_store_guide_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(8,2) NOT NULL COMMENT '门店指导价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27593 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道产品门店指导价';

-- ----------------------------
-- Table structure for channel_product_store_guide_price_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_store_guide_price_log`;
CREATE TABLE `channel_product_store_guide_price_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_price` decimal(8,2) NOT NULL COMMENT '旧的门店指导价(元)',
  `new_price` decimal(8,2) NOT NULL COMMENT '新的门店指导价(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=104007 DEFAULT CHARSET=utf8 COMMENT='渠道产品门店价日志';

-- ----------------------------
-- Table structure for channel_product_store_price
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_store_price`;
CREATE TABLE `channel_product_store_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `price` decimal(8,2) NOT NULL COMMENT '门店价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`),
  KEY `product_id` (`product_id`,`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道产品门店价格';

-- ----------------------------
-- Table structure for channel_product_store_price_log
-- ----------------------------
DROP TABLE IF EXISTS `channel_product_store_price_log`;
CREATE TABLE `channel_product_store_price_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_price` decimal(8,2) DEFAULT NULL COMMENT '原门店价(元)',
  `new_price` decimal(8,2) DEFAULT NULL COMMENT '新门店价(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `merchants_id` (`merchants_id`),
  KEY `product_id` (`product_id`,`merchants_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道产品门店价格日志';

-- ----------------------------
-- Table structure for channel_remote_request
-- ----------------------------
DROP TABLE IF EXISTS `channel_remote_request`;
CREATE TABLE `channel_remote_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `serial_number` char(32) NOT NULL COMMENT '序列号',
  `related_number` varchar(30) NOT NULL DEFAULT '' COMMENT '相关单号',
  `url` varchar(200) NOT NULL COMMENT '接口地址',
  `content` varchar(2000) NOT NULL COMMENT '内容',
  `num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '次数',
  `return_message` varchar(200) NOT NULL DEFAULT '' COMMENT '接口返回消息',
  `last_time` datetime DEFAULT NULL COMMENT '最后请求时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='远程请求表';

-- ----------------------------
-- Table structure for channel_remote_request_result
-- ----------------------------
DROP TABLE IF EXISTS `channel_remote_request_result`;
CREATE TABLE `channel_remote_request_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `serial_number` char(32) NOT NULL COMMENT '序列号',
  `related_number` varchar(30) NOT NULL DEFAULT '' COMMENT '相关单号',
  `url` varchar(200) NOT NULL COMMENT '接口地址',
  `content` varchar(2000) NOT NULL COMMENT '内容',
  `status` tinyint(4) NOT NULL COMMENT '执行状态(10:成功，20:失败)',
  `num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '次数',
  `return_message` varchar(200) NOT NULL DEFAULT '' COMMENT '接口返回消息',
  `last_time` datetime DEFAULT NULL COMMENT '最后请求时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `serial_number` (`serial_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='远程请求结果表';

-- ----------------------------
-- Table structure for channel_sale_order
-- ----------------------------
DROP TABLE IF EXISTS `channel_sale_order`;
CREATE TABLE `channel_sale_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '订单编号',
  `merchant_order_number` varchar(30) NOT NULL COMMENT '商户订单号',
  `merchants_id` int(11) NOT NULL COMMENT '渠道商ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `garage_name` varchar(50) NOT NULL COMMENT '修理厂名称',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总金额(元)',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `contact` varchar(10) NOT NULL COMMENT '联系人',
  `contact_mobi` varchar(20) NOT NULL COMMENT '联系电话',
  `address` varchar(100) NOT NULL COMMENT '联系地址',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待发货,10:待收货,30:已收货,55:退单申请,60:已退单,70:已取消)',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `merchants_id` (`merchants_id`,`merchant_order_number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `complete_time` (`complete_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商销售单';

-- ----------------------------
-- Table structure for channel_sale_order_item
-- ----------------------------
DROP TABLE IF EXISTS `channel_sale_order_item`;
CREATE TABLE `channel_sale_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '渠道商采购单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `join_price` decimal(8,2) NOT NULL COMMENT '加盟价(元)',
  `price` decimal(8,2) NOT NULL COMMENT '产品价格(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商销售单明细';

-- ----------------------------
-- Table structure for channel_sale_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `channel_sale_order_trace`;
CREATE TABLE `channel_sale_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '渠道商采购单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `ip_addr` varchar(30) NOT NULL DEFAULT '' COMMENT 'IP地址',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道商销售单日志';

-- ----------------------------
-- Table structure for channel_task_queue
-- ----------------------------
DROP TABLE IF EXISTS `channel_task_queue`;
CREATE TABLE `channel_task_queue` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:服务商结算)',
  `content` varchar(1000) NOT NULL COMMENT '任务内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='渠道任务队列';

-- ----------------------------
-- Table structure for chexy_garage_distribution
-- ----------------------------
DROP TABLE IF EXISTS `chexy_garage_distribution`;
CREATE TABLE `chexy_garage_distribution` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `garage_id_distribution_id` (`garage_id`,`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='车小养门店和加盟商关系表';

-- ----------------------------
-- Table structure for citicbank_clearing_order
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_clearing_order`;
CREATE TABLE `citicbank_clearing_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `status` smallint(6) NOT NULL COMMENT '状态(10待清分,20清分中,30清分成功,40清分失败)',
  `date` date NOT NULL COMMENT '清分日期',
  `file_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '清分文件名,用于和中信银行通信',
  `retry_count` int(11) NOT NULL DEFAULT '0' COMMENT '重试次数',
  `file_count` int(11) NOT NULL DEFAULT '0' COMMENT '清分明细行数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `file_name` (`file_name`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信清分单据';

-- ----------------------------
-- Table structure for citicbank_clearing_order_item
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_clearing_order_item`;
CREATE TABLE `citicbank_clearing_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '中信清分单据ID',
  `payment_clearing_order_id` bigint(20) NOT NULL COMMENT '服务商支付清分单ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信清分单据明细';

-- ----------------------------
-- Table structure for citicbank_clearing_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_clearing_order_trace`;
CREATE TABLE `citicbank_clearing_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信清分单据跟踪';

-- ----------------------------
-- Table structure for citicbank_transfer_order
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_transfer_order`;
CREATE TABLE `citicbank_transfer_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `trans_ssn` char(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '中信侧交易流水号',
  `req_ssn` char(40) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '中信侧请求流水号',
  `business_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '业务类型ID',
  `business_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '业务单号',
  `payment_account_id` int(11) NOT NULL COMMENT '支付账户ID',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(10待划拨,20划拨中,30划拨成功,40划拨失败)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `payment_recharge_order_id` (`business_type_id`),
  KEY `payment_account_id` (`payment_account_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信划拨单';

-- ----------------------------
-- Table structure for citicbank_transfer_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_transfer_order_trace`;
CREATE TABLE `citicbank_transfer_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信划拨单跟踪';

-- ----------------------------
-- Table structure for citicbank_withdraw_order
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_withdraw_order`;
CREATE TABLE `citicbank_withdraw_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `trans_ssn` char(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '中信侧交易流水号',
  `payment_withdraw_order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '服务商提现单',
  `payment_account_id` int(11) NOT NULL COMMENT '第三方支付账户ID',
  `dest_bank_card_id` int(11) NOT NULL COMMENT '提现目标银行卡',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `handling_fee` decimal(10,2) NOT NULL COMMENT '手续费',
  `status` smallint(6) NOT NULL COMMENT '状态(10待提现,20提现中,30提现成功,40提现失败)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `req_ssn` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `idx_account` (`payment_account_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信提现单据';

-- ----------------------------
-- Table structure for citicbank_withdraw_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `citicbank_withdraw_order_trace`;
CREATE TABLE `citicbank_withdraw_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='中信提现单据跟踪';

-- ----------------------------
-- Table structure for code_item
-- ----------------------------
DROP TABLE IF EXISTS `code_item`;
CREATE TABLE `code_item` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `list_id` int(11) NOT NULL COMMENT '列表ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `active_status` tinyint(4) NOT NULL COMMENT '是否有效(0否，1是)',
  `modify_status` tinyint(4) NOT NULL COMMENT '是否可修改(0否，1是)',
  `orderby` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `list_id` (`list_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统代码';

-- ----------------------------
-- Table structure for code_list
-- ----------------------------
DROP TABLE IF EXISTS `code_list`;
CREATE TABLE `code_list` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `active_status` tinyint(4) NOT NULL COMMENT '是否有效(0否，1是)',
  `modify_status` tinyint(4) NOT NULL COMMENT '是否可修改(0否，1是)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='系统代码列表';

-- ----------------------------
-- Table structure for consumer_event
-- ----------------------------
DROP TABLE IF EXISTS `consumer_event`;
CREATE TABLE `consumer_event` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `queue` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '投递队列',
  `type` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '事件类型',
  `key` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '关键字',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态(0未处理，1已处理)',
  `payload` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `process_time` datetime DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='消费者事件';

-- ----------------------------
-- Table structure for coupon
-- ----------------------------
DROP TABLE IF EXISTS `coupon`;
CREATE TABLE `coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `template_id` int(11) NOT NULL COMMENT '优惠券模板ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `use_scope` tinyint(4) NOT NULL COMMENT '使用范围(1:线上,2:线下)',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `order_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额(元)',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额(元)',
  `description` text COLLATE utf8_bin COMMENT '说明',
  `effective_time` datetime NOT NULL COMMENT '生效时间',
  `expire_time` datetime NOT NULL COMMENT '失效时间',
  `receive_type` tinyint(4) NOT NULL COMMENT '领取类型(1:PC端,2:APP端)',
  `use_status` tinyint(4) NOT NULL COMMENT '使用状态(10:未使用,30:已使用)',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '使用的服务商',
  `use_time` datetime DEFAULT NULL COMMENT '使用时间',
  `order_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '订单类型(1.活动预订单,2:服务商销售单)',
  `related_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`),
  KEY `template_id` (`template_id`,`garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动优惠券表';

-- ----------------------------
-- Table structure for coupon_receive_record
-- ----------------------------
DROP TABLE IF EXISTS `coupon_receive_record`;
CREATE TABLE `coupon_receive_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `template_id` int(11) NOT NULL COMMENT '优惠券模板ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `receive_date` date NOT NULL COMMENT '领取日期',
  `quantity` int(11) NOT NULL COMMENT '领取数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `template_id` (`template_id`,`garage_id`,`receive_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动优惠券模板领取记录';

-- ----------------------------
-- Table structure for coupon_template
-- ----------------------------
DROP TABLE IF EXISTS `coupon_template`;
CREATE TABLE `coupon_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `order_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '订单金额(元)',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '金额(元)',
  `validity_period_type` tinyint(4) NOT NULL COMMENT '有效期类型(1:按领券日起,2:固定时间区间)',
  `validity_period_days` smallint(6) NOT NULL DEFAULT '0' COMMENT '有效天数',
  `effective_time` datetime DEFAULT NULL COMMENT '生效时间',
  `expire_time` datetime DEFAULT NULL COMMENT '失效时间',
  `receive_start_time` datetime NOT NULL COMMENT '领券开始时间',
  `receive_end_time` datetime NOT NULL COMMENT '领券结束时间',
  `description` text COLLATE utf8_bin COMMENT '说明',
  `received_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '已领取数量',
  `used_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '已使用数量',
  `status` tinyint(4) NOT NULL COMMENT '状态(40:已启用,60:已禁用)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动优惠券模板';

-- ----------------------------
-- Table structure for csr_group
-- ----------------------------
DROP TABLE IF EXISTS `csr_group`;
CREATE TABLE `csr_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `float_button` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '图标代码',
  `chat_box` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '窗口地址',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='客服分组';

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父部门ID,顶级为0',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '部门名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000正常，9000已删除)',
  `description` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '部门说明',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='部门';

-- ----------------------------
-- Table structure for discharge_cargo_order
-- ----------------------------
DROP TABLE IF EXISTS `discharge_cargo_order`;
CREATE TABLE `discharge_cargo_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `instock_order_id` int(11) NOT NULL COMMENT '入库单ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `quality_inspection_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '质检单号',
  `receivable_salver_quantity` smallint(6) DEFAULT '0' COMMENT '应收托数',
  `receivable_box_quantity` smallint(6) NOT NULL COMMENT '应收件数',
  `receipt_salver_quantity` smallint(6) DEFAULT '0' COMMENT '实收托数',
  `receipt_box_quantity` smallint(6) NOT NULL COMMENT '实收件数',
  `status` tinyint(4) NOT NULL COMMENT '状态(10：正常, 20：撤销)',
  `operate_date` date NOT NULL COMMENT '卸货日期',
  `operator` varchar(150) COLLATE utf8_bin NOT NULL COMMENT '卸货人',
  `attachment` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件',
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `instock_order_id` (`instock_order_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='卸货单';

-- ----------------------------
-- Table structure for discrepancy_order
-- ----------------------------
DROP TABLE IF EXISTS `discrepancy_order`;
CREATE TABLE `discrepancy_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库id',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:上架单)',
  `related_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '相关单号',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数',
  `missing_quantity` int(11) NOT NULL COMMENT '缺失数量',
  `exceed_quantity` int(11) NOT NULL COMMENT '超出数量',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待审核,50:已完成)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='差异单';

-- ----------------------------
-- Table structure for discrepancy_order_item
-- ----------------------------
DROP TABLE IF EXISTS `discrepancy_order_item`;
CREATE TABLE `discrepancy_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '差异单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '库位名称',
  `batch_id` int(11) NOT NULL COMMENT '批次ID',
  `batch_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '批次号',
  `type` tinyint(4) NOT NULL COMMENT '差异类型(-1:缺失,1:超出)',
  `original_quantity` int(11) NOT NULL COMMENT '原数量',
  `discrepancy_quantity` int(11) NOT NULL COMMENT '差异数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='差异单明细';

-- ----------------------------
-- Table structure for discrepancy_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `discrepancy_order_trace`;
CREATE TABLE `discrepancy_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '差异单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='差异单跟踪';

-- ----------------------------
-- Table structure for distribution
-- ----------------------------
DROP TABLE IF EXISTS `distribution`;
CREATE TABLE `distribution` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '加盟商ID',
  `number` char(10) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `type` smallint(6) NOT NULL COMMENT '类型(1000个人)',
  `nature` tinyint(4) NOT NULL DEFAULT '1' COMMENT '性质(1独立经营，2自营，3合资)',
  `level_id` int(11) NOT NULL DEFAULT '1' COMMENT '级别ID',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '详细地址',
  `lng` decimal(10,7) NOT NULL COMMENT '经度',
  `lat` decimal(10,7) NOT NULL COMMENT '纬度',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系电话',
  `contact_email` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '电子邮件',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，9000已删除)',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `user_type` smallint(6) NOT NULL COMMENT '创建人类型',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `license` tinyint(4) NOT NULL DEFAULT '1' COMMENT '许可方式(1全品类，2部分品类)',
  `default_storehouse_id` int(11) NOT NULL COMMENT '默认配送仓库ID',
  `partner_id` int(11) NOT NULL DEFAULT '0',
  `partner_section_id` int(11) NOT NULL DEFAULT '0' COMMENT '运营中心片区id',
  `develop_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开发类型(0无，1新区开发，2老区替换)',
  `tax_qualification` tinyint(4) NOT NULL DEFAULT '0' COMMENT '税务资质(0无，1有)',
  `parent_distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级服务商ID',
  `retail_level` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '分销等级(10无级别,20小店,30区域王者)',
  `max_users` smallint(6) NOT NULL DEFAULT '3' COMMENT '最大用户数',
  `self_store_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务中心ID',
  `partition_priority` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '拆单优先级,可以存json(不同仓类型值的字符串,10主仓,20辅仓,30活动辅仓,40服务中心)',
  `self_store_stock_daily_status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '日常进货时服务中心库存状态(10开启,20关闭)',
  `self_store_stock_activity_status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '活动进货时服务中心库存状态(10开启,20关闭)',
  `allocation_permission` tinyint(4) NOT NULL DEFAULT '10' COMMENT '调拨权限(10允许被调拨,20不允许被调拨)',
  `store_tel` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '门店电话',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `freeze_time` datetime DEFAULT NULL COMMENT '冻结时间',
  `close_time` datetime DEFAULT NULL COMMENT '关闭时间',
  `delete_time` datetime DEFAULT NULL COMMENT '删除时间',
  `close_date` date DEFAULT NULL COMMENT '关闭日期',
  `business_entity_id` int(11) NOT NULL DEFAULT '0' COMMENT '营业主体ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `name` (`name`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`),
  KEY `district_id` (`district_id`),
  KEY `lng` (`lng`),
  KEY `lat` (`lat`)
) ENGINE=InnoDB AUTO_INCREMENT=2508 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商';

-- ----------------------------
-- Table structure for distribution_account_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_account_item`;
CREATE TABLE `distribution_account_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `account_item_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '账目类型ID',
  `settlement_method_id` int(11) NOT NULL DEFAULT '0' COMMENT '结算方式ID',
  `inout` tinyint(4) NOT NULL COMMENT '收支(1收，-1支)',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '账目金额(元)',
  `date` date NOT NULL COMMENT '记账日期',
  `business_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '业务类型ID',
  `business_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '业务单号',
  `business_description` varchar(512) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '业务简要描述',
  `business_date` date NOT NULL COMMENT '业务发生日期',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution_customer` (`distribution_id`,`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商账目';

-- ----------------------------
-- Table structure for distribution_account_item_type
-- ----------------------------
DROP TABLE IF EXISTS `distribution_account_item_type`;
CREATE TABLE `distribution_account_item_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `inout` tinyint(4) NOT NULL COMMENT '收支(1收，-1支)',
  `status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '状态(10启用,20禁用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商账目类型';

-- ----------------------------
-- Table structure for distribution_activity
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity`;
CREATE TABLE `distribution_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` smallint(6) NOT NULL COMMENT '活动类型(1001折扣，1002授信贷款)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '截止时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `overlay` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '是否叠加其他活动，10表示是，20表示否',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1003388 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商活动';

-- ----------------------------
-- Table structure for distribution_activity_attachment
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity_attachment`;
CREATE TABLE `distribution_activity_attachment` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `path` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '文件路径',
  `real_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '原文件名',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商活动附件表';

-- ----------------------------
-- Table structure for distribution_activity_blacklist
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity_blacklist`;
CREATE TABLE `distribution_activity_blacklist` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '服务商id',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10有效,20停用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商活动黑名单';

-- ----------------------------
-- Table structure for distribution_activity_inventory
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity_inventory`;
CREATE TABLE `distribution_activity_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`activity_id`,`product_id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='活动产品清单';

-- ----------------------------
-- Table structure for distribution_activity_purchase_count
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity_purchase_count`;
CREATE TABLE `distribution_activity_purchase_count` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `activity_id` (`activity_id`,`distribution_id`,`product_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商活动采购计数';

-- ----------------------------
-- Table structure for distribution_activity_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity_storehouse`;
CREATE TABLE `distribution_activity_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=309 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商活动仓库';

-- ----------------------------
-- Table structure for distribution_activity_target_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_activity_target_rule`;
CREATE TABLE `distribution_activity_target_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动id',
  `partner_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '运营中心id',
  `province_id` int(11) NOT NULL DEFAULT '0' COMMENT '省份',
  `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '城市',
  `district_id` int(11) NOT NULL DEFAULT '0' COMMENT '区县',
  `distribution_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '服务商id',
  `target_list` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '指定目标名单(10全部服务商,20仅白名单可用,30仅黑名单可用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=596 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商活动指定目标表';

-- ----------------------------
-- Table structure for distribution_admin_cart
-- ----------------------------
DROP TABLE IF EXISTS `distribution_admin_cart`;
CREATE TABLE `distribution_admin_cart` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商id',
  `storehouse_id` int(11) NOT NULL COMMENT '发货仓库',
  `is_set_sale_price` int(2) NOT NULL COMMENT '是否设置为修理厂单价',
  `quantity` int(11) DEFAULT NULL COMMENT '进货数量',
  `discount` int(11) NOT NULL DEFAULT '100' COMMENT '折扣',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商管理员购物车表';

-- ----------------------------
-- Table structure for distribution_admin_cart_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_admin_cart_item`;
CREATE TABLE `distribution_admin_cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `cart_id` int(11) NOT NULL COMMENT '购物车Id',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) DEFAULT NULL COMMENT '进货数量',
  `price` decimal(10,2) DEFAULT NULL COMMENT '当前价格',
  `is_gift` tinyint(2) NOT NULL DEFAULT '0' COMMENT '是否赠品(0否 1是)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `type` tinyint(4) DEFAULT '10' COMMENT '类型(10正常, 20待移入购物车)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商管理员购物车行表';

-- ----------------------------
-- Table structure for distribution_allocation_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_allocation_order`;
CREATE TABLE `distribution_allocation_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `in_distribution_id` int(11) NOT NULL COMMENT '调入加盟商ID',
  `out_distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '调出加盟商ID',
  `status` smallint(6) NOT NULL COMMENT '状态(10000待处理，11000待确认，12000待发货，13000待收货，14000已完成，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL COMMENT '总金额(元)',
  `markup_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '加价金额(元)',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `payment_method` smallint(6) NOT NULL COMMENT '支付方式(10000线上支付，11000线下付款)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `in_distribution_id` (`in_distribution_id`),
  KEY `out_distribution_id` (`out_distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商调拨单';

-- ----------------------------
-- Table structure for distribution_allocation_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `distribution_allocation_order_contact`;
CREATE TABLE `distribution_allocation_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '调拨单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1发货方联系人，2收货方联系人)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商调拨单联系信息';

-- ----------------------------
-- Table structure for distribution_allocation_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_allocation_order_item`;
CREATE TABLE `distribution_allocation_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '调拨单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '调拨数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `bargain_unit_price` decimal(8,2) NOT NULL COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL COMMENT '成交总价(元)',
  `deliver_quantity` int(11) DEFAULT NULL COMMENT '实际发货数量',
  `receipt_quantity` int(11) DEFAULT NULL COMMENT '实际收货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商调拨单行';

-- ----------------------------
-- Table structure for distribution_allocation_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_allocation_order_trace`;
CREATE TABLE `distribution_allocation_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '调拨单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商调拨单跟踪';

-- ----------------------------
-- Table structure for distribution_allocation_price
-- ----------------------------
DROP TABLE IF EXISTS `distribution_allocation_price`;
CREATE TABLE `distribution_allocation_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `markup` decimal(6,4) NOT NULL COMMENT '加价',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，2000已取消)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`,`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商调拨价格';

-- ----------------------------
-- Table structure for distribution_app_banner_setting
-- ----------------------------
DROP TABLE IF EXISTS `distribution_app_banner_setting`;
CREATE TABLE `distribution_app_banner_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '标题',
  `pic` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图片',
  `status` tinyint(3) unsigned NOT NULL COMMENT '状态(10草稿,20已发布)',
  `action_type` tinyint(3) unsigned NOT NULL COMMENT '动作类型(10无,20APP内跳转,30打开网页)',
  `action_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '动作名称',
  `action_route` varchar(256) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '动作路由',
  `action_params` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '动作参数',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `publish_time` (`publish_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商APP Banner设置';

-- ----------------------------
-- Table structure for distribution_authentication
-- ----------------------------
DROP TABLE IF EXISTS `distribution_authentication`;
CREATE TABLE `distribution_authentication` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `mobi` varchar(11) NOT NULL COMMENT '手机号',
  `identity_number` varchar(18) NOT NULL COMMENT '身份证号',
  `identity_pic1` varchar(120) NOT NULL COMMENT '身份证正面照',
  `identity_pic2` varchar(120) NOT NULL COMMENT '身份证反面照',
  `identity_pic3` varchar(120) NOT NULL COMMENT '手持身份证照片',
  `issued_by` varchar(120) NOT NULL DEFAULT '' COMMENT '身份证签发机关',
  `validfrom_date` datetime DEFAULT NULL COMMENT '身份证有效起始时间',
  `expiration_date` datetime DEFAULT NULL COMMENT '身份证有效结束时间',
  `address` varchar(120) NOT NULL DEFAULT '' COMMENT '身份证地址',
  `ethnic` varchar(10) NOT NULL DEFAULT '' COMMENT '身份证名族',
  `gender` varchar(10) NOT NULL DEFAULT '' COMMENT '身份证性别',
  `birthday` date DEFAULT NULL COMMENT '身份证生日',
  `company_name` varchar(64) NOT NULL DEFAULT '' COMMENT '企业名称(企业)',
  `legal_name` varchar(20) NOT NULL DEFAULT '' COMMENT '法人姓名(企业)',
  `identifier` varchar(18) NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `licence_pic` varchar(120) NOT NULL DEFAULT '' COMMENT '营业执照(企业)',
  `type` tinyint(4) NOT NULL COMMENT '类型(1个人认证，2企业认证)',
  `personal_id_addr` varchar(64) NOT NULL DEFAULT '' COMMENT '秒钛坊个人SecId',
  `personal_owner_account` varchar(64) NOT NULL DEFAULT '' COMMENT '秒钛坊个人钱包地址',
  `company_id_addr` varchar(64) NOT NULL DEFAULT '' COMMENT '秒钛坊企业SecId',
  `company_owner_account` varchar(64) NOT NULL DEFAULT '' COMMENT '秒钛坊企业钱包地址',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1798 DEFAULT CHARSET=utf8 COMMENT='服务商认证';

-- ----------------------------
-- Table structure for distribution_authentication_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_authentication_order`;
CREATE TABLE `distribution_authentication_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '申请单ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `mobi` varchar(11) NOT NULL COMMENT '手机号',
  `identity_number` varchar(18) NOT NULL COMMENT '身份证号',
  `identity_pic1` varchar(120) NOT NULL COMMENT '身份证正面照',
  `identity_pic2` varchar(120) NOT NULL COMMENT '身份证反面照',
  `identity_pic3` varchar(120) NOT NULL COMMENT '手持身份证照片',
  `company_name` varchar(64) NOT NULL DEFAULT '' COMMENT '企业名称(企业)',
  `legal_name` varchar(20) NOT NULL DEFAULT '' COMMENT '法人姓名(企业)',
  `identifier` varchar(18) NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `licence_pic` varchar(120) NOT NULL DEFAULT '' COMMENT '营业执照(企业)',
  `status` tinyint(4) NOT NULL COMMENT '状态(0待审核，1审核通过，2审核不通过)',
  `type` tinyint(4) NOT NULL COMMENT '类型(1个人认证，2企业认证)',
  `note` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2383 DEFAULT CHARSET=utf8 COMMENT='服务商认证申请单';

-- ----------------------------
-- Table structure for distribution_business_type
-- ----------------------------
DROP TABLE IF EXISTS `distribution_business_type`;
CREATE TABLE `distribution_business_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(68) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(156) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10启用,20禁用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商业务类型';

-- ----------------------------
-- Table structure for distribution_cabinet_in_transit_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_cabinet_in_transit_item`;
CREATE TABLE `distribution_cabinet_in_transit_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `inout` tinyint(4) NOT NULL COMMENT '出入库(1入库，2出库)',
  `type` smallint(6) NOT NULL COMMENT '类型(1000开配件柜铺货单、1100取消配件柜铺货单、2000配件柜铺货单上架)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `surplus` int(11) NOT NULL COMMENT '剩余库存',
  `voucher` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `create_time` (`create_time`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37114818 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商配件柜在途库存流水';

-- ----------------------------
-- Table structure for distribution_cart_gift
-- ----------------------------
DROP TABLE IF EXISTS `distribution_cart_gift`;
CREATE TABLE `distribution_cart_gift` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `gift_package_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动赠品套餐ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '赠品数量',
  `is_last_selected` tinyint(4) NOT NULL DEFAULT '10' COMMENT '是否是最后一次选择的赠品(10是,20否)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`activity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商选择的满赠活动赠品';

-- ----------------------------
-- Table structure for distribution_cart_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_cart_item`;
CREATE TABLE `distribution_cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `notice_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否到货提醒(0否，1是)',
  `notice_times` smallint(6) NOT NULL DEFAULT '0' COMMENT '到货提醒次数',
  `source` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品添加来源',
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分组ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `notice_time` datetime DEFAULT NULL COMMENT '到货提醒时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`,`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23686900 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商购物车行(大表)';

-- ----------------------------
-- Table structure for distribution_cart_item_history
-- ----------------------------
DROP TABLE IF EXISTS `distribution_cart_item_history`;
CREATE TABLE `distribution_cart_item_history` (
  `id` bigint(20) NOT NULL COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `notice_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否到货提醒(0否，1是)',
  `notice_times` smallint(6) NOT NULL DEFAULT '0' COMMENT '到货提醒次数',
  `source` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '商品添加来源',
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分组ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `notice_time` datetime DEFAULT NULL COMMENT '到货提醒时间',
  KEY `distribution_id` (`distribution_id`),
  KEY `product_id` (`product_id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商购物车行历史表(大表)';

-- ----------------------------
-- Table structure for distribution_cart_join_activity
-- ----------------------------
DROP TABLE IF EXISTS `distribution_cart_join_activity`;
CREATE TABLE `distribution_cart_join_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商选择参加的活动';

-- ----------------------------
-- Table structure for distribution_contract
-- ----------------------------
DROP TABLE IF EXISTS `distribution_contract`;
CREATE TABLE `distribution_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '合同编号',
  `start_date` date NOT NULL COMMENT '起始日期',
  `end_date` date NOT NULL COMMENT '终止日期',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100到期失效、2000作废)',
  `salesman` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '签约业务员',
  `deposit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保证金',
  `franchise_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '加盟费',
  `software_fee` decimal(10,2) NOT NULL COMMENT '软件使用费',
  `additional_agreement_1` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附加约定1',
  `additional_agreement_2` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附加约定2',
  `additional_agreement_3` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附加约定3',
  `additional_agreement_4` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附加约定4',
  `additional_agreement_5` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附加约定5',
  `quarterly_mission` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '季度任务量',
  `first_payment` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '首批货款金额',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `pic1` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档1',
  `pic2` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档2',
  `pic3` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档3',
  `pic4` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档4',
  `pic5` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档5',
  `pic6` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档6',
  `pic7` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档7',
  `pic8` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '合同电子档8',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1个人签约，2企业签约)',
  `signatory_type` tinyint(4) NOT NULL COMMENT '签约人类型(5:个体工商户,10:个人投资企业,15:合伙企业,20:有限公司,50:中华人民共和国公民)',
  `franchise_decorate_subsidy` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '装修费用补贴限额',
  `start_business_subsidy` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '开业补贴',
  `signed_pdf` mediumtext COLLATE utf8_bin COMMENT '签章合同',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '详细地址',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`status`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商合同信息';

-- ----------------------------
-- Table structure for distribution_contract_white_list
-- ----------------------------
DROP TABLE IF EXISTS `distribution_contract_white_list`;
CREATE TABLE `distribution_contract_white_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sign_year` year(4) NOT NULL COMMENT '签约年份',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `quarterly_mission` decimal(10,2) NOT NULL COMMENT '季度进货金额',
  `status` tinyint(4) NOT NULL COMMENT '状态(0未签署；1已签署）',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `sign_year` (`sign_year`,`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商签约白名单';

-- ----------------------------
-- Table structure for distribution_coupon
-- ----------------------------
DROP TABLE IF EXISTS `distribution_coupon`;
CREATE TABLE `distribution_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `coupon_templet_id` int(11) NOT NULL COMMENT '优惠券模板ID',
  `transaction_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `transaction_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '实际使用金额',
  `status` tinyint(4) NOT NULL COMMENT '使用状态(1未使用，2已使用, 3已失效)',
  `name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `overlay` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否叠加(0否，1是)',
  `discount_amount` decimal(11,2) DEFAULT NULL COMMENT '优惠金额',
  `reach_amount` decimal(11,2) DEFAULT NULL COMMENT '符合满减的金额',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `start_time` date NOT NULL COMMENT '起始时间',
  `end_time` date NOT NULL COMMENT '结束时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `coupon_templet_id` (`coupon_templet_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商优惠券';

-- ----------------------------
-- Table structure for distribution_coupon_exchanged
-- ----------------------------
DROP TABLE IF EXISTS `distribution_coupon_exchanged`;
CREATE TABLE `distribution_coupon_exchanged` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `point_exchange_id` int(11) NOT NULL COMMENT '兑换中心ID',
  `quantity` int(11) NOT NULL COMMENT '兑换数量',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id_2` (`distribution_id`,`point_exchange_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商优惠券已兑换数量';

-- ----------------------------
-- Table structure for distribution_coupon_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_coupon_rule`;
CREATE TABLE `distribution_coupon_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `coupon_id` int(11) NOT NULL COMMENT '优惠券ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `coupon_id` (`coupon_id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商优惠券规则';

-- ----------------------------
-- Table structure for distribution_coupon_template
-- ----------------------------
DROP TABLE IF EXISTS `distribution_coupon_template`;
CREATE TABLE `distribution_coupon_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `overlay` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否互斥券(0是，1否)',
  `discount_amount` decimal(11,2) DEFAULT NULL COMMENT '优惠金额',
  `reach_amount` decimal(11,2) DEFAULT NULL COMMENT '符合满减的金额',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(4) NOT NULL COMMENT '状态(1正常，2已删除)',
  `start_time` date NOT NULL COMMENT '起始时间',
  `end_time` date NOT NULL COMMENT '结束时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `overlay_activity` tinyint(3) unsigned NOT NULL DEFAULT '20' COMMENT '是否叠加其他活动，10表示是，20表示否',
  `quantity_per_order` int(11) NOT NULL DEFAULT '-1' COMMENT '同一个模板的优惠券一个订单最多使用张数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='优惠券模板';

-- ----------------------------
-- Table structure for distribution_coupon_template_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_coupon_template_rule`;
CREATE TABLE `distribution_coupon_template_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `coupon_templet_id` int(11) NOT NULL COMMENT '模板ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL COMMENT '产品ID,0为所有',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `coupon_templet_id` (`coupon_templet_id`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='优惠券模板规则';

-- ----------------------------
-- Table structure for distribution_credit_loan_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_credit_loan_order`;
CREATE TABLE `distribution_credit_loan_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `type_id` int(11) NOT NULL COMMENT '类型ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `amount` decimal(12,2) NOT NULL COMMENT '贷款金额',
  `total_amount` decimal(12,2) DEFAULT NULL COMMENT '需还款金额',
  `repayment_amount` decimal(12,2) DEFAULT NULL COMMENT '还款金额',
  `expire_date` date DEFAULT NULL COMMENT '截至日期',
  `repayment_type` tinyint(4) NOT NULL COMMENT '还款类型(10一次性还款，20分期还款)',
  `repayment_period` smallint(6) DEFAULT NULL COMMENT '分期还款-还款期数',
  `first_repayment_month` int(11) DEFAULT NULL COMMENT '分期还款-起始还款月份(yyyyMM)',
  `monthly_repayment_day` tinyint(4) DEFAULT NULL COMMENT '分期还款-每月还款日',
  `period_of_repayment` smallint(6) DEFAULT NULL COMMENT '分期还款-已还款期数',
  `next_repayment_amount` decimal(12,2) DEFAULT NULL COMMENT '分期还款-下期还款金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待审核、1100待还款、1110还款中、1200已还款、2000取消)',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `loan_time` datetime DEFAULT NULL COMMENT '放款时间',
  `repayment_time` datetime DEFAULT NULL COMMENT '还款时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商授信贷款单';

-- ----------------------------
-- Table structure for distribution_credit_loan_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_credit_loan_order_trace`;
CREATE TABLE `distribution_credit_loan_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商授信贷款单跟踪';

-- ----------------------------
-- Table structure for distribution_credit_loan_repayment_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_credit_loan_repayment_item`;
CREATE TABLE `distribution_credit_loan_repayment_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `type` tinyint(4) NOT NULL COMMENT '还款类型（10余额还款，20线下还款）',
  `period` int(11) NOT NULL COMMENT '分期还款-已还款期数',
  `need_repayment_amount` decimal(12,2) NOT NULL COMMENT '本期应还款金额',
  `need_repayment_date` date NOT NULL COMMENT '本期应还款日期',
  `actual_repayment_amount` decimal(12,2) NOT NULL COMMENT '本期实际还款金额',
  `actual_repayment_date` date NOT NULL COMMENT '本期实际还款日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商授信贷款还款明细';

-- ----------------------------
-- Table structure for distribution_credit_loan_type
-- ----------------------------
DROP TABLE IF EXISTS `distribution_credit_loan_type`;
CREATE TABLE `distribution_credit_loan_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商授信贷款类型';

-- ----------------------------
-- Table structure for distribution_csr_group
-- ----------------------------
DROP TABLE IF EXISTS `distribution_csr_group`;
CREATE TABLE `distribution_csr_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `group_id` int(11) NOT NULL COMMENT '客服分组ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商客服分组';

-- ----------------------------
-- Table structure for distribution_data_permission
-- ----------------------------
DROP TABLE IF EXISTS `distribution_data_permission`;
CREATE TABLE `distribution_data_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20001 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商数据权限';

-- ----------------------------
-- Table structure for distribution_debt_account
-- ----------------------------
DROP TABLE IF EXISTS `distribution_debt_account`;
CREATE TABLE `distribution_debt_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `balance` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '欠款余额',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '10正常,20被删除',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution_customer` (`distribution_id`,`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商欠款账户';

-- ----------------------------
-- Table structure for distribution_delivery_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `distribution_delivery_storehouse`;
CREATE TABLE `distribution_delivery_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10正常,20被删除)',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10主仓,20辅仓)',
  `sort` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商配送仓库';

-- ----------------------------
-- Table structure for distribution_discount
-- ----------------------------
DROP TABLE IF EXISTS `distribution_discount`;
CREATE TABLE `distribution_discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `discount` decimal(5,4) NOT NULL COMMENT '折扣',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，2000已取消)',
  `valid_start_date` date NOT NULL COMMENT '有效起始日期',
  `valid_end_date` date NOT NULL COMMENT '有效结束日期',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商折扣';

-- ----------------------------
-- Table structure for distribution_electronic_signature
-- ----------------------------
DROP TABLE IF EXISTS `distribution_electronic_signature`;
CREATE TABLE `distribution_electronic_signature` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(14) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:进货单)',
  `related_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '相关订单编号',
  `pos_type` tinyint(4) NOT NULL COMMENT '定位类型(10:关键字定位,20:坐标定位)',
  `pos_params` varchar(300) COLLATE utf8mb4_bin NOT NULL COMMENT '定位参数',
  `signature_user_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '签章人姓名',
  `certificate_type` tinyint(4) NOT NULL COMMENT '证件类型(10:身份证)',
  `certificate_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '证件号',
  `source_file` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '源文件',
  `signature_file` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '签章',
  `signed_file` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '签证文件',
  `status` tinyint(4) NOT NULL COMMENT '状态(40:待同步,45:同步失败,50:已完成)',
  `result` varchar(1000) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '同步结果',
  `ability_provider` tinyint(4) NOT NULL COMMENT '能力提供方(1:e签宝)',
  `ability_provider_account` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '能力提供方账号',
  `external_sign_id` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '外部签证号',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商电子签章';

-- ----------------------------
-- Table structure for distribution_extend_picture_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_extend_picture_item`;
CREATE TABLE `distribution_extend_picture_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `pic` varchar(120) NOT NULL COMMENT '图片',
  `type` tinyint(4) NOT NULL COMMENT '类型(1租赁合同，2产权证)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商扩展图片';

-- ----------------------------
-- Table structure for distribution_finance_lark
-- ----------------------------
DROP TABLE IF EXISTS `distribution_finance_lark`;
CREATE TABLE `distribution_finance_lark` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `user_id` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '拉卡拉userID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商拉卡拉金融贷款信息表';

-- ----------------------------
-- Table structure for distribution_finance_loan
-- ----------------------------
DROP TABLE IF EXISTS `distribution_finance_loan`;
CREATE TABLE `distribution_finance_loan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `person_identity` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '个人身份ID',
  `person_account_id` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '个人钱包账号',
  `person_certificates` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '个人证件号',
  `enterprise_identity` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '企业身份ID',
  `enterprise_certificates` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '企业证件号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `person_identity` (`person_identity`),
  KEY `enterprise_identity` (`enterprise_identity`)
) ENGINE=InnoDB AUTO_INCREMENT=1259 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商金融贷款信息表';

-- ----------------------------
-- Table structure for distribution_finance_loan_capital
-- ----------------------------
DROP TABLE IF EXISTS `distribution_finance_loan_capital`;
CREATE TABLE `distribution_finance_loan_capital` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '资方名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='金融贷款资方列表';

-- ----------------------------
-- Table structure for distribution_finance_loan_white_list
-- ----------------------------
DROP TABLE IF EXISTS `distribution_finance_loan_white_list`;
CREATE TABLE `distribution_finance_loan_white_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `capital_id` int(11) NOT NULL COMMENT '资方ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=817 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='金融贷款白名单';

-- ----------------------------
-- Table structure for distribution_full_gift_activity
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_gift_activity`;
CREATE TABLE `distribution_full_gift_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10未发布,20已发布,30已撤回,40被删除)',
  `max_gift_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '最大赠送金额',
  `gift_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '已赠送金额',
  `overlay_coupon` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '是否叠加优惠券，10表示是，20表示否',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_name_status` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商满赠活动';

-- ----------------------------
-- Table structure for distribution_full_gift_activity_condition
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_gift_activity_condition`;
CREATE TABLE `distribution_full_gift_activity_condition` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '类型(10按金额,20按数量,30按金额和金额上限,40按数量和数量上限,50按阶梯)',
  `min_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '能参加活动的金额下限,当为0时表示任意金额',
  `min_amount_limit` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '每笔满赠最低金额限制,当为0时表示不限制',
  `max_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '能参加活动的金额上限,当为0时表示无穷大',
  `min_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '能参加活动的产品数量下限,当为0时表示任意数量',
  `max_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '能参加活动的产品数量上限,当为0时表示无穷大',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商满赠活动条件';

-- ----------------------------
-- Table structure for distribution_full_gift_activity_gift_package
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_gift_activity_gift_package`;
CREATE TABLE `distribution_full_gift_activity_gift_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(8) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '套餐名称',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `condition_id` int(11) NOT NULL DEFAULT '0' COMMENT '条件ID',
  `max_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '限制金额,为0时表示不受限制',
  `max_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '限制数量,为0时表示不受限制',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '类型(10固定套餐,20自选套餐)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `status` tinyint(4) NOT NULL DEFAULT '10',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商满赠活动赠品套餐';

-- ----------------------------
-- Table structure for distribution_full_gift_activity_gift_package_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_gift_activity_gift_package_item`;
CREATE TABLE `distribution_full_gift_activity_gift_package_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `gift_package_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动赠品套餐ID',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID,0为所有',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '赠品数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `gift_packet_id` (`gift_package_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商满赠活动的赠品';

-- ----------------------------
-- Table structure for distribution_full_gift_activity_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_gift_activity_rule`;
CREATE TABLE `distribution_full_gift_activity_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID,0为所有',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=179 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商满赠活动的产品规则';

-- ----------------------------
-- Table structure for distribution_full_reduction_activity
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_reduction_activity`;
CREATE TABLE `distribution_full_reduction_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '活动名称',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `discount_content` varchar(512) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '优惠内容,以json的格式存储',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '活动状态',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `storehouse_id` int(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商满减活动';

-- ----------------------------
-- Table structure for distribution_full_reduction_activity_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_full_reduction_activity_rule`;
CREATE TABLE `distribution_full_reduction_activity_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL COMMENT '产品ID,0为所有',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=227 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商满减活动的产品规则';

-- ----------------------------
-- Table structure for distribution_garage
-- ----------------------------
DROP TABLE IF EXISTS `distribution_garage`;
CREATE TABLE `distribution_garage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `monthly_statement` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否支持月结(0否，1是)',
  `on_account` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否支持挂账(0否，1是)',
  `consumption_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '消费数量',
  `last_order_time` datetime DEFAULT NULL COMMENT '最后一次订单结算时间',
  `last_hang_bill_type` smallint(6) NOT NULL DEFAULT '1' COMMENT '最后一次订单挂账方式',
  `last_payment_method` smallint(6) DEFAULT NULL COMMENT '最后一次订单结算方式',
  `need_quotation` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否需要报价(0否，1是)',
  `show_inventory` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否显示库存(0不显示，1显示)',
  `inventory_authorization` tinyint(4) NOT NULL DEFAULT '0' COMMENT '库存管理授权(0否，1是)',
  `price_level` tinyint(1) NOT NULL DEFAULT '1' COMMENT '修理厂的价格等级,1表示默认等级价格，2表示A级价格，3表示B级价格，以此类推',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=238078 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商客户';

-- ----------------------------
-- Table structure for distribution_income_expenditure_difference_reason
-- ----------------------------
DROP TABLE IF EXISTS `distribution_income_expenditure_difference_reason`;
CREATE TABLE `distribution_income_expenditure_difference_reason` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(68) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(156) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10启用,20禁用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商收支差异原因';

-- ----------------------------
-- Table structure for distribution_inout_stock
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inout_stock`;
CREATE TABLE `distribution_inout_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `inout` tinyint(4) NOT NULL COMMENT '出入库(1入库，2出库)',
  `type` smallint(6) NOT NULL COMMENT '类型(1000补货、1100配送、2000核增、2100核减)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `surplus` int(11) NOT NULL COMMENT '剩余库存',
  `voucher` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `create_time` (`create_time`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2633517 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商出入库明细(特大表)';

-- ----------------------------
-- Table structure for distribution_inventory_plan
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inventory_plan`;
CREATE TABLE `distribution_inventory_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '盘点计划单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000变动盘点，1200全库盘点)',
  `status` smallint(6) NOT NULL COMMENT '状态(10000待录入，10100待审核，10200已完成，20000已取消)',
  `plan_date` date NOT NULL COMMENT '盘点日期',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='盘点计划';

-- ----------------------------
-- Table structure for distribution_inventory_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inventory_plan_item`;
CREATE TABLE `distribution_inventory_plan_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL COMMENT '盘点计划ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `position` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '仓位',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实存数量',
  `inventory_quantity` int(11) DEFAULT NULL COMMENT '盘点数量',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='盘点计划明细';

-- ----------------------------
-- Table structure for distribution_inventory_plan_period
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inventory_plan_period`;
CREATE TABLE `distribution_inventory_plan_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `plan_id` int(11) NOT NULL COMMENT '盘点计划ID',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='变动盘点周期';

-- ----------------------------
-- Table structure for distribution_inventory_plan_shelves
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inventory_plan_shelves`;
CREATE TABLE `distribution_inventory_plan_shelves` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `plan_id` int(11) NOT NULL COMMENT '盘点计划ID',
  `shelves_id` int(11) NOT NULL COMMENT '仓位ID',
  `shelves_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '仓位名称',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓位盘点';

-- ----------------------------
-- Table structure for distribution_inventory_plan_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inventory_plan_trace`;
CREATE TABLE `distribution_inventory_plan_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='盘点计划跟踪';

-- ----------------------------
-- Table structure for distribution_inventory_warning
-- ----------------------------
DROP TABLE IF EXISTS `distribution_inventory_warning`;
CREATE TABLE `distribution_inventory_warning` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `lower_limit` int(11) DEFAULT NULL COMMENT '下限',
  `upper_limit` int(11) DEFAULT NULL COMMENT '上限',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商库存预警';

-- ----------------------------
-- Table structure for distribution_kxb_open_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_kxb_open_order`;
CREATE TABLE `distribution_kxb_open_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `status` tinyint(4) NOT NULL COMMENT '订单状态(10待付款，50已开通)',
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '金额(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `open_time` datetime DEFAULT NULL COMMENT '开通时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `username` varchar(64) COLLATE utf8_bin NOT NULL,
  `password` varchar(64) COLLATE utf8_bin NOT NULL,
  `valid_order_number` int(11) NOT NULL DEFAULT '0' COMMENT '180天内有效订单数目',
  `refund` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否退费（0 未退费， 1已退费）',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商快修保开通订单';

-- ----------------------------
-- Table structure for distribution_level
-- ----------------------------
DROP TABLE IF EXISTS `distribution_level`;
CREATE TABLE `distribution_level` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '级别名称',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '级别次序(越大级别越高)',
  `is_vip` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否VIP',
  `icon` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图标',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商级别';

-- ----------------------------
-- Table structure for distribution_logistics_last
-- ----------------------------
DROP TABLE IF EXISTS `distribution_logistics_last`;
CREATE TABLE `distribution_logistics_last` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `logistics_id` int(11) NOT NULL COMMENT '物流方式ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`storehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商最近使用物流';

-- ----------------------------
-- Table structure for distribution_logistics_times
-- ----------------------------
DROP TABLE IF EXISTS `distribution_logistics_times`;
CREATE TABLE `distribution_logistics_times` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `logistics_id` int(11) NOT NULL COMMENT '物流方式ID',
  `times` int(11) NOT NULL COMMENT '次数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`logistics_id`),
  KEY `logistics_id` (`logistics_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商物流计数';

-- ----------------------------
-- Table structure for distribution_marketing_pic_setting
-- ----------------------------
DROP TABLE IF EXISTS `distribution_marketing_pic_setting`;
CREATE TABLE `distribution_marketing_pic_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `title` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '标题',
  `pic` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '标题',
  `status` tinyint(3) unsigned NOT NULL COMMENT '状态,10表示草稿,20表示已发布',
  `activity_type` tinyint(3) unsigned NOT NULL COMMENT '活动类型,10表示新品推荐,20表示促销,30表示积分抽奖',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动id',
  `activity_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '活动名称',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '排序',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `title` (`title`),
  KEY `publish_time` (`publish_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商营销图片设置';

-- ----------------------------
-- Table structure for distribution_menu_remind
-- ----------------------------
DROP TABLE IF EXISTS `distribution_menu_remind`;
CREATE TABLE `distribution_menu_remind` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作平台(0PC，1APP)',
  `expire_time` datetime NOT NULL COMMENT '过期时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`platform`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商菜单提醒';

-- ----------------------------
-- Table structure for distribution_menu_remind_catalog
-- ----------------------------
DROP TABLE IF EXISTS `distribution_menu_remind_catalog`;
CREATE TABLE `distribution_menu_remind_catalog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(60) NOT NULL COMMENT '菜单名称',
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '操作平台(0PC，1APP)',
  `parent_id` int(11) NOT NULL COMMENT '父菜单ID',
  `level` smallint(6) NOT NULL COMMENT '菜单级别',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10003 DEFAULT CHARSET=utf8 COMMENT='菜单提醒模块';

-- ----------------------------
-- Table structure for distribution_module
-- ----------------------------
DROP TABLE IF EXISTS `distribution_module`;
CREATE TABLE `distribution_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '模块名称',
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型(0PC，1APP)',
  `code` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '模块编号',
  `catalog_id` int(11) NOT NULL COMMENT '所属目录ID(0没有归属目录)',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '模块描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62003002 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商模块';

-- ----------------------------
-- Table structure for distribution_module_catalog
-- ----------------------------
DROP TABLE IF EXISTS `distribution_module_catalog`;
CREATE TABLE `distribution_module_catalog` (
  `id` int(11) NOT NULL COMMENT '目录ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '目录名称',
  `platform` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型(0PC，1APP)',
  `parent_id` int(11) NOT NULL COMMENT '父目录ID',
  `level` smallint(6) NOT NULL COMMENT '目录级别',
  `orderby` int(11) NOT NULL COMMENT '目录排序',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商模块目录';

-- ----------------------------
-- Table structure for distribution_module_route
-- ----------------------------
DROP TABLE IF EXISTS `distribution_module_route`;
CREATE TABLE `distribution_module_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `route` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '模块路由',
  PRIMARY KEY (`id`),
  UNIQUE KEY `route` (`route`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1450 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商模块路由';

-- ----------------------------
-- Table structure for distribution_number_sequence
-- ----------------------------
DROP TABLE IF EXISTS `distribution_number_sequence`;
CREATE TABLE `distribution_number_sequence` (
  `id` char(12) COLLATE utf8_bin NOT NULL COMMENT '键',
  `value` int(11) NOT NULL COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商编号自增序列';

-- ----------------------------
-- Table structure for distribution_offline_promotion
-- ----------------------------
DROP TABLE IF EXISTS `distribution_offline_promotion`;
CREATE TABLE `distribution_offline_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10有效，20已取消)',
  `valid_start_date` date NOT NULL COMMENT '有效起始日期',
  `valid_end_date` date NOT NULL COMMENT '有效结束日期',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `description` text COLLATE utf8_bin COMMENT '描述',
  `attachment` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商线下促销';

-- ----------------------------
-- Table structure for distribution_old_battery_recycle_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_old_battery_recycle_order`;
CREATE TABLE `distribution_old_battery_recycle_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `date` date NOT NULL COMMENT '回收日期',
  `brand_name` tinyint(4) NOT NULL DEFAULT '0' COMMENT '品牌名称',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `volume` int(11) NOT NULL DEFAULT '0' COMMENT '电池容量(安时)',
  `recycle_unit_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '回收单价(元/安时)',
  `recycle_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '回收总价(元)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待审批,20审批中,30通过,40驳回)',
  `reject_reason` varchar(128) COLLATE utf8mb4_bin DEFAULT '' COMMENT '驳回原因',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商旧电池回收单';

-- ----------------------------
-- Table structure for distribution_old_battery_recycle_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_old_battery_recycle_order_trace`;
CREATE TABLE `distribution_old_battery_recycle_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商旧电池回收单跟踪表';

-- ----------------------------
-- Table structure for distribution_old_battery_recycle_statistics
-- ----------------------------
DROP TABLE IF EXISTS `distribution_old_battery_recycle_statistics`;
CREATE TABLE `distribution_old_battery_recycle_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `date` date NOT NULL COMMENT '日期',
  `recycle_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '回收金额',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商旧电池回收统计';

-- ----------------------------
-- Table structure for distribution_old_battery_sales_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_old_battery_sales_order`;
CREATE TABLE `distribution_old_battery_sales_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `date` date NOT NULL COMMENT '销售日期',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `volume` int(11) NOT NULL DEFAULT '0' COMMENT '电池容量(安时)',
  `sale_unit_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售单价(元/安时)',
  `sale_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '销售总价(元)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待审批,20审批中,30通过,40驳回)',
  `reject_reason` varchar(128) COLLATE utf8mb4_bin DEFAULT '' COMMENT '驳回原因',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商旧电池销售单';

-- ----------------------------
-- Table structure for distribution_old_battery_sales_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_old_battery_sales_order_trace`;
CREATE TABLE `distribution_old_battery_sales_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商旧电池销售单跟踪表';

-- ----------------------------
-- Table structure for distribution_old_battery_stock
-- ----------------------------
DROP TABLE IF EXISTS `distribution_old_battery_stock`;
CREATE TABLE `distribution_old_battery_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `total_volume` int(11) NOT NULL DEFAULT '0' COMMENT '电池总容量(安时)',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '库存总数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商旧电池库存';

-- ----------------------------
-- Table structure for distribution_online_activity
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity`;
CREATE TABLE `distribution_online_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `image` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '活动图片',
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '活动名称',
  `type` smallint(6) NOT NULL DEFAULT '1007' COMMENT '活动类型(1007满减活动,1009满额赠送,1010满量赠送,1011特价活动,1012折扣活动,1013返利活动)',
  `min_settlement_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '最低结算价',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '状态(10待完善,20待发布,30已发布)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '说明',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动';

-- ----------------------------
-- Table structure for distribution_online_activity_cart_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_cart_item`;
CREATE TABLE `distribution_online_activity_cart_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(10商品,20赠品)',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`,`activity_id`,`type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动购物车行(大表)';

-- ----------------------------
-- Table structure for distribution_online_activity_cart_item_history
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_cart_item_history`;
CREATE TABLE `distribution_online_activity_cart_item_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(10商品,20赠品)',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动购物车行(大表)';

-- ----------------------------
-- Table structure for distribution_online_activity_delivery_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_delivery_storehouse`;
CREATE TABLE `distribution_online_activity_delivery_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(10仅主辅仓,20指定仓库)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动配送仓库';

-- ----------------------------
-- Table structure for distribution_online_activity_delivery_storehouse_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_delivery_storehouse_item`;
CREATE TABLE `distribution_online_activity_delivery_storehouse_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动配送仓库明细';

-- ----------------------------
-- Table structure for distribution_online_activity_discount_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_discount_rule`;
CREATE TABLE `distribution_online_activity_discount_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型(10梯度,20占比)',
  `pattern` tinyint(4) DEFAULT NULL COMMENT '模式(10百分比,20固定值)',
  `unit` tinyint(4) DEFAULT NULL COMMENT '单位(10金额,20数量)',
  `max_discount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '优惠上限(0表示不限制)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动优惠规则';

-- ----------------------------
-- Table structure for distribution_online_activity_discount_rule_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_discount_rule_item`;
CREATE TABLE `distribution_online_activity_discount_rule_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rule_id` int(11) NOT NULL DEFAULT '0' COMMENT '规则ID',
  `condition` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '条件(金额/数量)',
  `discount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '优惠(金额/百分比/数量)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_rule` (`rule_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动优惠规则明细';

-- ----------------------------
-- Table structure for distribution_online_activity_gift
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_gift`;
CREATE TABLE `distribution_online_activity_gift` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `rule_id` int(11) NOT NULL DEFAULT '0' COMMENT '规则ID',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID,0为所有',
  `max_quantity_per_distribution` int(11) NOT NULL DEFAULT '0' COMMENT '限制数量,为0时表示不受限制',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_rule` (`rule_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商满赠(满额和满量)活动赠品';

-- ----------------------------
-- Table structure for distribution_online_activity_product
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_product`;
CREATE TABLE `distribution_online_activity_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID, 0为所有',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID，0为所有',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID,0为所有',
  `promotion_rebate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '产品活动折扣',
  `promotion_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '产品活动价',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '活动总限量(0表示不限制)',
  `max_quantity_per_distribution` int(11) NOT NULL DEFAULT '0' COMMENT '单店限量(0表示不限制)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动产品';

-- ----------------------------
-- Table structure for distribution_online_activity_target
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_target`;
CREATE TABLE `distribution_online_activity_target` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `target_scope` tinyint(4) NOT NULL DEFAULT '10' COMMENT '目标范围(10全部,20部分参与,30部分限制)',
  `target_list` tinyint(4) NOT NULL DEFAULT '10' COMMENT '指定目标名单(10全部服务商,20仅白名单可用,30仅黑名单可用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_activity` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动目标对象';

-- ----------------------------
-- Table structure for distribution_online_activity_target_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_activity_target_item`;
CREATE TABLE `distribution_online_activity_target_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `target_id` int(11) NOT NULL DEFAULT '0' COMMENT '目标对象ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_target` (`target_id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商在线活动目标对象明细';

-- ----------------------------
-- Table structure for distribution_online_payment_method
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_payment_method`;
CREATE TABLE `distribution_online_payment_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '支付方式ID',
  `short_name` varchar(16) COLLATE utf8mb4_bin NOT NULL COMMENT '简称',
  `name` varchar(60) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `sort` int(11) NOT NULL COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商在线支付方式';

-- ----------------------------
-- Table structure for distribution_online_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_payment_order`;
CREATE TABLE `distribution_online_payment_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `payment_account_id` int(11) NOT NULL COMMENT '账户ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `method_id` int(11) NOT NULL COMMENT '支付方式ID',
  `type` smallint(6) NOT NULL COMMENT '业务类型(1000应收单收款)',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '关联单号',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `handling_fee` decimal(10,2) NOT NULL COMMENT '手续费',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待支付，1100支付成功，2000支付失败)',
  `create_time` datetime NOT NULL COMMENT '提交时间',
  `return_time` datetime DEFAULT NULL COMMENT '返回时间',
  `return_ip` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '网关服务器IP',
  `trade_no` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '网关交易号',
  `note` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注，失败时记录网关返回的信息',
  `mch_trade_id` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '商户业务单号',
  `success_trade_number` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '成功交易单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `create_time` (`create_time`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商在线支付订单(大表)';

-- ----------------------------
-- Table structure for distribution_online_payment_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_payment_order_trace`;
CREATE TABLE `distribution_online_payment_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商在线支付订单跟踪';

-- ----------------------------
-- Table structure for distribution_online_promotion
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_promotion`;
CREATE TABLE `distribution_online_promotion` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '活动名称',
  `stock_virtual_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '虚拟订单号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '活动状态',
  `promotion_product_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销品数量',
  `activity_declare` text COLLATE utf8_bin COMMENT '活动说明',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `storehouse_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_name_status` (`name`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线上促销活动';

-- ----------------------------
-- Table structure for distribution_online_promotion_copy1
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_promotion_copy1`;
CREATE TABLE `distribution_online_promotion_copy1` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '活动名称',
  `stock_virtual_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '虚拟订单号',
  `start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '活动状态',
  `promotion_product_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '促销品数量',
  `activity_declare` text COLLATE utf8_bin COMMENT '活动说明',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `storehouse_id` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_name_status` (`name`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线上促销活动';

-- ----------------------------
-- Table structure for distribution_online_promotion_product
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_promotion_product`;
CREATE TABLE `distribution_online_promotion_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `activity_id` int(11) NOT NULL DEFAULT '1' COMMENT '活动id',
  `product_id` int(11) unsigned NOT NULL COMMENT '产品id',
  `number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品编号',
  `name` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品名称',
  `picture` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品图片',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '促销品状态，1->正常,2->被删除',
  `detail` text COLLATE utf8_bin COMMENT '产品详情',
  `original_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '产品原价',
  `promotion_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '产品活动价',
  `total_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '总数量',
  `stock_interval_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '可销售数量和总数量的差值',
  `mpq` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '最小包装数量',
  `is_purchase_limitation` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否开启限购，1->是,2->否',
  `is_virtual_stock` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否使用虚拟库存，1->是,2->否',
  `purchase_limitation_quantity` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '限购数量',
  `sort` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '排序',
  `paid_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '已付款数量',
  `waiting_paid_quantity` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '待付款数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线上促销活动产品';

-- ----------------------------
-- Table structure for distribution_online_refund_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_refund_order`;
CREATE TABLE `distribution_online_refund_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `payment_account_id` int(11) NOT NULL COMMENT '第三方支付账户ID',
  `method_id` int(11) NOT NULL COMMENT '退款方式ID',
  `type` smallint(6) NOT NULL COMMENT '业务类型(10直营店修理厂退货)',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '关联单号',
  `payment_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关在线付款单号',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待退款，1100退款成功，2000退款失败)',
  `create_time` datetime NOT NULL COMMENT '提交时间',
  `return_time` datetime DEFAULT NULL COMMENT '返回时间',
  `return_ip` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '网关服务器IP',
  `trade_no` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '网关交易号',
  `note` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注，失败时记录网关返回的信息',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商在线退款订单(大表)';

-- ----------------------------
-- Table structure for distribution_online_refund_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_online_refund_order_trace`;
CREATE TABLE `distribution_online_refund_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商在线退款订单跟踪';

-- ----------------------------
-- Table structure for distribution_open_account_apply_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_open_account_apply_order`;
CREATE TABLE `distribution_open_account_apply_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '相关单号',
  `repayment_plan_id` int(11) NOT NULL COMMENT '还款方案ID',
  `type` smallint(6) NOT NULL COMMENT '进货类型',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '概要',
  `total_amount` decimal(12,4) NOT NULL COMMENT '总金额(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待初审,20:初审驳回,30:待终审,40:终审驳回,50:已完成)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商赊销申请单';

-- ----------------------------
-- Table structure for distribution_open_account_apply_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_open_account_apply_order_item`;
CREATE TABLE `distribution_open_account_apply_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '赊销申请单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `unit_price` decimal(10,4) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(12,4) NOT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商赊销申请单明细';

-- ----------------------------
-- Table structure for distribution_open_account_apply_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_open_account_apply_order_trace`;
CREATE TABLE `distribution_open_account_apply_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '赊销申请单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商赊销申请单跟踪';

-- ----------------------------
-- Table structure for distribution_operate_permissions
-- ----------------------------
DROP TABLE IF EXISTS `distribution_operate_permissions`;
CREATE TABLE `distribution_operate_permissions` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '权限名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='操作权限';

-- ----------------------------
-- Table structure for distribution_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order`;
CREATE TABLE `distribution_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型(0日常，1首批)',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待付款，10100待处理，10200待发货，10300待收货，10400已收货，20000已取消)',
  `priority` tinyint(4) NOT NULL DEFAULT '10' COMMENT '优先级',
  `user_id` int(11) NOT NULL COMMENT '受理员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `actual_total_price` decimal(12,2) NOT NULL COMMENT '实际总价(元)',
  `coupon_discount_amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券优惠金额(元)',
  `rebate_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '返利金额(元)',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `original_total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '原总价(元)',
  `storehouse_type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '仓库类型(10仓库,20服务中心)',
  `stock_source` tinyint(4) NOT NULL DEFAULT '10' COMMENT '库存来源(10仓库,20服务中心)',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '1' COMMENT '物流支付方式',
  `stock_lock_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '库存锁定单号',
  `shipping_order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '物流单ID',
  `is_in_storage` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已入库(0:否,1:是)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `chargeback_reason` smallint(6) DEFAULT NULL COMMENT '退单原因(10000客户要求，20000仓库缺货)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `is_loan_pay` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否垫付订单(0否，1是)',
  `activity_discount_amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '活动优惠金额',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `shipping_order_id` (`shipping_order_id`),
  KEY `deliver_time` (`deliver_time`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商订单(大表)';

-- ----------------------------
-- Table structure for distribution_order_activity
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_activity`;
CREATE TABLE `distribution_order_activity` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `activity_id` int(11) NOT NULL COMMENT '活动id',
  `activity_type` smallint(5) unsigned NOT NULL COMMENT '活动类型',
  `discount_amount` decimal(12,2) NOT NULL COMMENT '优惠金额',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `activity_id` (`activity_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商订单参与的活动记录';

-- ----------------------------
-- Table structure for distribution_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_contact`;
CREATE TABLE `distribution_order_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1收货人)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商订单联系信息(大表)';

-- ----------------------------
-- Table structure for distribution_order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_coupon`;
CREATE TABLE `distribution_order_coupon` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `coupon_id` int(11) NOT NULL COMMENT '优惠券ID',
  `discount_amount` decimal(12,2) NOT NULL COMMENT '优惠金额',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `coupon_id` (`coupon_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商订单优惠券';

-- ----------------------------
-- Table structure for distribution_order_group
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_group`;
CREATE TABLE `distribution_order_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '组编号',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商进货单组';

-- ----------------------------
-- Table structure for distribution_order_group_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_group_item`;
CREATE TABLE `distribution_order_group_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '分组id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '进货单id',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商进货单组明细';

-- ----------------------------
-- Table structure for distribution_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_item`;
CREATE TABLE `distribution_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  `actual_unit_price` decimal(8,2) NOT NULL COMMENT '实际单价(元)',
  `actual_total_price` decimal(10,2) NOT NULL COMMENT '实际总价(元)',
  `original_unit_price` decimal(8,2) NOT NULL COMMENT '原单价(元)',
  `original_total_price` decimal(10,2) NOT NULL COMMENT '原总价(元)',
  `discount_id` int(11) NOT NULL DEFAULT '0' COMMENT '折扣ID',
  `discount_name` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '折扣名称',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际收货数量',
  `coupon_discount_amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '优惠券优惠金额(元)',
  `activity_discount_amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '活动优惠金额',
  `rebate_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '返利金额(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商订单行(大表)';

-- ----------------------------
-- Table structure for distribution_order_package
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_package`;
CREATE TABLE `distribution_order_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `package_id` int(11) NOT NULL COMMENT '产品包ID',
  `quantity` int(11) NOT NULL COMMENT '产品包数量',
  `package_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品包名称',
  `unit_price` decimal(10,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `package_id` (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商订单行产品包(大表)';

-- ----------------------------
-- Table structure for distribution_order_rebate
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_rebate`;
CREATE TABLE `distribution_order_rebate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) NOT NULL COMMENT '进货单ID',
  `rebate_order_id` int(11) NOT NULL COMMENT '返利单ID',
  `rebate_amount` decimal(10,2) NOT NULL COMMENT '返利金额(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`,`rebate_order_id`),
  KEY `order_id_2` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商进货单返利';

-- ----------------------------
-- Table structure for distribution_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_order_trace`;
CREATE TABLE `distribution_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商订单跟踪(大表)';

-- ----------------------------
-- Table structure for distribution_other_income_expenditure_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_other_income_expenditure_order`;
CREATE TABLE `distribution_other_income_expenditure_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账目ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `type_id` int(11) NOT NULL COMMENT '账目类型ID',
  `inout` tinyint(4) NOT NULL COMMENT '收支(1收，-1支)',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `date` date NOT NULL COMMENT '记账日期',
  `way` smallint(6) NOT NULL COMMENT '收支方式(1000现金，2000支付宝，3000微信，4000信用卡，5000储蓄卡，9000其它)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `type_id` (`type_id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='账目(大表)';

-- ----------------------------
-- Table structure for distribution_other_income_expenditure_type
-- ----------------------------
DROP TABLE IF EXISTS `distribution_other_income_expenditure_type`;
CREATE TABLE `distribution_other_income_expenditure_type` (
  `id` int(11) NOT NULL COMMENT '类型ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `inout` tinyint(4) NOT NULL COMMENT '收支(1收，-1支)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '类型名称',
  `parent_id` int(11) NOT NULL COMMENT '上级类型ID',
  `orderby` int(11) NOT NULL COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`inout`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商账目类型';

-- ----------------------------
-- Table structure for distribution_payment_account
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_account`;
CREATE TABLE `distribution_payment_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:禁用,30:注销)',
  `platform_id` int(11) NOT NULL DEFAULT '0' COMMENT '第三方支付平台ID',
  `platform_account_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方平台账户编号',
  `clearing_amount` decimal(16,2) NOT NULL COMMENT '已清分金额',
  `pending_clearing_amount` decimal(16,2) NOT NULL COMMENT '待清分金额',
  `freeze_amount` decimal(16,2) NOT NULL COMMENT '冻结金额',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(10:个人;20:企业)',
  `name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `mobi` varchar(11) COLLATE utf8mb4_bin NOT NULL COMMENT '手机号',
  `identity_number` varchar(18) COLLATE utf8mb4_bin NOT NULL COMMENT '身份证号',
  `company_name` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '企业名称(企业)',
  `identifier` varchar(18) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商第三方支付账号';

-- ----------------------------
-- Table structure for distribution_payment_account_bank_card
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_account_bank_card`;
CREATE TABLE `distribution_payment_account_bank_card` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `payment_account_id` int(11) NOT NULL DEFAULT '0' COMMENT '第三方支付账号ID',
  `number` varchar(32) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '银行卡号',
  `username` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '开户户名',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(10:个人;20:企业)',
  `bank_id` int(11) NOT NULL DEFAULT '0' COMMENT '银行ID',
  `identity_number` varchar(18) COLLATE utf8mb4_bin NOT NULL COMMENT '身份证号',
  `mobi` varchar(11) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '手机号',
  `identifier` varchar(18) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:注销)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`payment_account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商第三方支付账户相关银行卡';

-- ----------------------------
-- Table structure for distribution_payment_account_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_account_item`;
CREATE TABLE `distribution_payment_account_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `payment_account_id` int(11) NOT NULL DEFAULT '0' COMMENT '第三方支付账户ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '修理厂ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待清分,20:已完成)',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `handling_fee` decimal(10,2) NOT NULL COMMENT '手续费',
  `business_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '业务类型ID',
  `business_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '业务单号',
  `business_order_summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '业务订单摘要',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `related_order_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '相关单类型(10付款单,20退款单)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_account` (`payment_account_id`),
  KEY `idx_distribution_customer` (`distribution_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商第三方支付账目';

-- ----------------------------
-- Table structure for distribution_payment_account_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_account_order`;
CREATE TABLE `distribution_payment_account_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待创建,20:创建成功,30:创建失败)',
  `platform_id` int(11) NOT NULL DEFAULT '0' COMMENT '第三方支付平台ID',
  `platform_account_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '第三方平台账户编号',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '类型(10:个人;20:企业)',
  `name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `mobi` varchar(11) COLLATE utf8mb4_bin NOT NULL COMMENT '手机号',
  `identity_number` varchar(18) COLLATE utf8mb4_bin NOT NULL COMMENT '身份证号',
  `company_name` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '企业名称(企业)',
  `identifier` varchar(18) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商第三方支付账号申请单';

-- ----------------------------
-- Table structure for distribution_payment_bank
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_bank`;
CREATE TABLE `distribution_payment_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `number` char(12) COLLATE utf8mb4_bin NOT NULL,
  `logo` char(128) COLLATE utf8mb4_bin NOT NULL,
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:禁用)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商支付相关银行';

-- ----------------------------
-- Table structure for distribution_payment_clearing_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_clearing_order`;
CREATE TABLE `distribution_payment_clearing_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `payment_account_id` int(11) NOT NULL COMMENT '支付账户ID',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(10待清分,20清分中,30清分成功,40清分失败)',
  `date` date NOT NULL COMMENT '清分日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商支付清分单';

-- ----------------------------
-- Table structure for distribution_payment_clearing_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_clearing_order_item`;
CREATE TABLE `distribution_payment_clearing_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '清分单ID',
  `payment_account_item_id` bigint(20) NOT NULL COMMENT '第三方支付账目ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商支付清分单明细';

-- ----------------------------
-- Table structure for distribution_payment_clearing_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_clearing_order_trace`;
CREATE TABLE `distribution_payment_clearing_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商支付清分单跟踪';

-- ----------------------------
-- Table structure for distribution_payment_platform
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_platform`;
CREATE TABLE `distribution_payment_platform` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:禁用)',
  `mobile_transaction_fee_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '手机支付交易手续费率',
  `pos_transaction_fee_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT 'pos机支付交易手续费率',
  `personal_ebank_debit_card_transaction_fee_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '个人网银(储蓄卡)支付交易手续费率',
  `personal_ebank_credit_card_transaction_fee_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '个人网银(信用卡)支付交易手续费率',
  `company_ebank_transaction_fee_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '企业网银支付交易手续费率',
  `withdraw_fee_rate` decimal(5,2) NOT NULL DEFAULT '0.00' COMMENT '提现手续费率',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商接入第三方支付平台信息';

-- ----------------------------
-- Table structure for distribution_payment_recharge_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_recharge_order`;
CREATE TABLE `distribution_payment_recharge_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `payment_account_id` int(11) NOT NULL COMMENT '支付账户ID',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(10充值中,20充值成功,30充值失败)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商充值单据';

-- ----------------------------
-- Table structure for distribution_payment_recharge_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_recharge_order_trace`;
CREATE TABLE `distribution_payment_recharge_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商充值单跟踪';

-- ----------------------------
-- Table structure for distribution_payment_withdraw_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_withdraw_order`;
CREATE TABLE `distribution_payment_withdraw_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `payment_account_id` int(11) NOT NULL COMMENT '第三方支付账户ID',
  `dest_bank_card_id` int(11) NOT NULL COMMENT '提现目标银行卡',
  `amount` decimal(12,2) NOT NULL COMMENT '金额',
  `handling_fee` decimal(10,2) NOT NULL COMMENT '手续费',
  `status` smallint(6) NOT NULL COMMENT '状态(10待提现,20提现中,30提现成功,40提现失败)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `idx_account` (`payment_account_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商提现单据';

-- ----------------------------
-- Table structure for distribution_payment_withdraw_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_payment_withdraw_order_trace`;
CREATE TABLE `distribution_payment_withdraw_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商提现单跟踪';

-- ----------------------------
-- Table structure for distribution_point
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point`;
CREATE TABLE `distribution_point` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `balance` int(11) NOT NULL DEFAULT '0' COMMENT '余额',
  `total_balance` int(11) NOT NULL DEFAULT '0' COMMENT '历史总额',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3229 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商积分';

-- ----------------------------
-- Table structure for distribution_point_balance_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_balance_item`;
CREATE TABLE `distribution_point_balance_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `year` smallint(1) unsigned NOT NULL DEFAULT '0' COMMENT '年份',
  `balance` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '剩余积分',
  `had_deduct` tinyint(1) unsigned NOT NULL DEFAULT '10' COMMENT '是否已经扣减过过期积分，10表示是，20表示否',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution_id_year` (`distribution_id`,`year`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商剩余积分统计';

-- ----------------------------
-- Table structure for distribution_point_exchange
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_exchange`;
CREATE TABLE `distribution_point_exchange` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '积分兑换商品ID',
  `type` tinyint(4) NOT NULL COMMENT '兑换类型(1优惠券)',
  `name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `exchange_amount` int(11) NOT NULL COMMENT '兑换所需积分',
  `quantity` int(11) NOT NULL COMMENT '发行数量',
  `exchang_quantity` int(11) NOT NULL COMMENT '已经兑换数量',
  `limit_quantity` int(11) NOT NULL COMMENT '限制兑换数量(-1不限制)',
  `status` tinyint(4) NOT NULL COMMENT '状态(1正常，2已删除)',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='积分兑换规则';

-- ----------------------------
-- Table structure for distribution_point_exchange_record
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_exchange_record`;
CREATE TABLE `distribution_point_exchange_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `point_exchange_id` int(11) NOT NULL COMMENT '兑换规则ID',
  `quantity` int(11) NOT NULL COMMENT '兑换数量',
  `point` int(11) NOT NULL COMMENT '剩余积分数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `point_exchange_id` (`point_exchange_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='积分兑换记录';

-- ----------------------------
-- Table structure for distribution_point_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_item`;
CREATE TABLE `distribution_point_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `point_id` int(11) NOT NULL COMMENT '积分ID',
  `type` tinyint(4) NOT NULL COMMENT '类型',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `amount` int(11) NOT NULL COMMENT '金额',
  `balance` int(11) NOT NULL COMMENT '余额',
  `total_balance` int(11) NOT NULL COMMENT '历史总额',
  `transaction_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `point_id` (`point_id`)
) ENGINE=InnoDB AUTO_INCREMENT=382017 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商积分流水';

-- ----------------------------
-- Table structure for distribution_point_lucky_draw
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_lucky_draw`;
CREATE TABLE `distribution_point_lucky_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(60) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '名称',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '抽奖类型(1:扭蛋机)',
  `start_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '活动开始时间',
  `end_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '活动截止时间',
  `app_cover_pic` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'APP活动封面图',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '10' COMMENT '抽奖活动状态',
  `description` text COLLATE utf8_bin COMMENT '说明',
  `point_per_draw` int(11) NOT NULL DEFAULT '0' COMMENT '抽奖一次消耗积分',
  `max_draw_num` int(11) NOT NULL DEFAULT '1' COMMENT '每人最多抽奖次数',
  `limit_max_draw_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否限制每人最多抽奖次数,0->限制，1->不限制',
  `max_draw_num_per_day` int(11) NOT NULL DEFAULT '1' COMMENT '每人每天最多抽奖次数',
  `limit_max_draw_num_per_day` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否限制每人每天最多抽奖次数,0->限制，1->不限制',
  `max_winning_num` int(11) NOT NULL DEFAULT '1' COMMENT '每人最多中奖次数',
  `limit_max_winning_num` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否限制每人最多中奖次数, 0->限制，1->不限制',
  `max_winning_num_per_day` int(11) NOT NULL DEFAULT '1' COMMENT '每人每天最多中奖次数',
  `limit_max_winning_num_per_day` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否限制每人每天最多中奖次数, 0->限制，1->不限制',
  `total_draw_num` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '抽奖总次数',
  `limit_total_draw_num` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否限制总抽奖次数,0->限制,1->不限制',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商的积分抽奖活动';

-- ----------------------------
-- Table structure for distribution_point_lucky_draw_awards
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_lucky_draw_awards`;
CREATE TABLE `distribution_point_lucky_draw_awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '奖项名称',
  `prize_type` tinyint(4) NOT NULL COMMENT '奖品类别(1:赠送积分,2:赠送优惠券)',
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '赠送的积分',
  `coupon_template_id` int(11) NOT NULL DEFAULT '0' COMMENT '赠送的优惠券ID',
  `prize_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '奖品名称',
  `prize_num` int(11) NOT NULL DEFAULT '0' COMMENT '奖品数量',
  `hit_num` int(11) NOT NULL DEFAULT '0' COMMENT '奖品中奖次数',
  `winning_rate` double(11,8) NOT NULL DEFAULT '0.00000000' COMMENT '中奖率',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `lucky_draw_id` (`lucky_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商的积分抽奖活动的奖项';

-- ----------------------------
-- Table structure for distribution_point_lucky_draw_record
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_lucky_draw_record`;
CREATE TABLE `distribution_point_lucky_draw_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `lucky_draw_id` int(11) NOT NULL DEFAULT '0' COMMENT '抽奖活动ID',
  `draw_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '抽奖状态(10:未中奖,20:中奖)',
  `award_id` int(11) NOT NULL DEFAULT '0' COMMENT '奖项ID',
  `consume_point` int(11) NOT NULL DEFAULT '0' COMMENT '消耗的积分',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution_id_create_time` (`distribution_id`,`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商积分抽奖记录';

-- ----------------------------
-- Table structure for distribution_point_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_point_rule`;
CREATE TABLE `distribution_point_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1采购)',
  `name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `rule` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '规则详情数据',
  `note` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '规则扼要',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商积分规则';

-- ----------------------------
-- Table structure for distribution_pos
-- ----------------------------
DROP TABLE IF EXISTS `distribution_pos`;
CREATE TABLE `distribution_pos` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `device_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '设备号',
  `push_id` varchar(25) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '消息推送ID',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态(1有效，2删除)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `device_number` (`device_number`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商POS设备';

-- ----------------------------
-- Table structure for distribution_product
-- ----------------------------
DROP TABLE IF EXISTS `distribution_product`;
CREATE TABLE `distribution_product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `sale_price` decimal(8,2) DEFAULT NULL COMMENT '销售价(元)',
  `first_level_price` decimal(8,2) DEFAULT NULL COMMENT 'A级的价格',
  `second_level_price` decimal(8,2) DEFAULT NULL COMMENT 'B级的价格',
  `third_level_price` decimal(8,2) DEFAULT NULL COMMENT 'C级的价格',
  `forth_level_price` decimal(8,2) DEFAULT NULL COMMENT 'D级的价格',
  `fifth_level_price` decimal(8,2) DEFAULT NULL COMMENT 'E级的价格',
  `sixth_level_price` decimal(8,2) DEFAULT NULL COMMENT 'F级的价格',
  `seventh_level_price` decimal(8,2) DEFAULT NULL COMMENT 'G级的价格',
  `eighth_level_price` decimal(8,2) DEFAULT NULL COMMENT 'H级的价格',
  `ninth_level_price` decimal(8,2) DEFAULT NULL COMMENT 'I级的价格',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商产品';

-- ----------------------------
-- Table structure for distribution_product_level_config
-- ----------------------------
DROP TABLE IF EXISTS `distribution_product_level_config`;
CREATE TABLE `distribution_product_level_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '加盟商ID',
  `status` tinyint(1) NOT NULL DEFAULT '10' COMMENT '配置状态,10表示正常，20表示被删除',
  `level` tinyint(1) NOT NULL DEFAULT '1' COMMENT '等级,1表示默认等级,2表示A级价格,以此类推',
  `create_time` datetime NOT NULL DEFAULT '1980-01-01 00:00:00' COMMENT '添加时间',
  `update_time` datetime NOT NULL DEFAULT '1980-01-01 00:00:00' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商分级定价等级配置表';

-- ----------------------------
-- Table structure for distribution_product_license
-- ----------------------------
DROP TABLE IF EXISTS `distribution_product_license`;
CREATE TABLE `distribution_product_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `category_id` int(11) NOT NULL COMMENT '产品品类ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商产品许可';

-- ----------------------------
-- Table structure for distribution_product_note
-- ----------------------------
DROP TABLE IF EXISTS `distribution_product_note`;
CREATE TABLE `distribution_product_note` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商产品备注';

-- ----------------------------
-- Table structure for distribution_product_sales_price_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_product_sales_price_rule`;
CREATE TABLE `distribution_product_sales_price_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `rule_id` int(11) NOT NULL COMMENT '规则ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商产品售价规则';

-- ----------------------------
-- Table structure for distribution_product_sales_price_rule_log
-- ----------------------------
DROP TABLE IF EXISTS `distribution_product_sales_price_rule_log`;
CREATE TABLE `distribution_product_sales_price_rule_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `old_rule_id` int(11) DEFAULT NULL COMMENT '原规则ID',
  `new_rule_id` int(11) DEFAULT NULL COMMENT '新规则ID',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `describe` varchar(80) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商产品售价规则日志';

-- ----------------------------
-- Table structure for distribution_purchase_average_price
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_average_price`;
CREATE TABLE `distribution_purchase_average_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `original_total_price` decimal(14,2) NOT NULL COMMENT '原总价(元)',
  `bargain_total_price` decimal(14,2) NOT NULL COMMENT '成交总价(元)',
  `actual_total_price` decimal(14,2) NOT NULL COMMENT '实际总价(元)',
  `average_price` decimal(10,2) NOT NULL COMMENT '进货均价(元)',
  `note` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商进货均价';

-- ----------------------------
-- Table structure for distribution_purchase_average_price_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_average_price_item`;
CREATE TABLE `distribution_purchase_average_price_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `price_id` int(11) NOT NULL COMMENT '均价ID',
  `distribution_order_item_id` bigint(20) NOT NULL COMMENT '服务商进货单明细ID',
  PRIMARY KEY (`id`),
  KEY `price_id` (`price_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商进货均价明细';

-- ----------------------------
-- Table structure for distribution_purchase_factory_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_factory_storehouse`;
CREATE TABLE `distribution_purchase_factory_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10正常,20被删除)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商可直接采购工厂仓表';

-- ----------------------------
-- Table structure for distribution_purchase_preorder
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_preorder`;
CREATE TABLE `distribution_purchase_preorder` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(11000待受理，18000已受理，20000已取消)',
  `arrival` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否到货(0未到货，1已到货)',
  `user_id` int(11) NOT NULL COMMENT '受理员工ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '受理员工名称',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `original_total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '原总价(元)',
  `stock_lock_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '库存锁定单号',
  `purchase_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '采购单号',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商采购预订单(大表)';

-- ----------------------------
-- Table structure for distribution_purchase_preorder_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_preorder_item`;
CREATE TABLE `distribution_purchase_preorder_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  `original_unit_price` decimal(8,2) NOT NULL COMMENT '原单价(元)',
  `original_total_price` decimal(10,2) NOT NULL COMMENT '原总价(元)',
  `discount_id` int(11) NOT NULL DEFAULT '0' COMMENT '折扣ID',
  `discount_name` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '折扣名称',
  `activity_id` int(11) NOT NULL DEFAULT '0' COMMENT '活动ID',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商采购预订单行(大表)';

-- ----------------------------
-- Table structure for distribution_purchase_preorder_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_preorder_trace`;
CREATE TABLE `distribution_purchase_preorder_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商采购预订单跟踪(大表)';

-- ----------------------------
-- Table structure for distribution_purchase_return_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_return_order`;
CREATE TABLE `distribution_purchase_return_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID(不需要仓库收货传入0)',
  `reason` int(11) NOT NULL COMMENT '原因',
  `order_source` tinyint(4) NOT NULL COMMENT '订单源(5:退货单,10:召回单,15:报废单)',
  `related_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '相关单号',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数',
  `total_price` decimal(12,2) NOT NULL COMMENT '总价(元)',
  `refundable_amount` decimal(12,2) NOT NULL COMMENT '可退款金额(元)',
  `deduct_total_price` decimal(12,2) DEFAULT NULL COMMENT '扣费金额(元)',
  `refund_discount` decimal(5,4) NOT NULL COMMENT '退款折扣',
  `refund_amount` decimal(12,2) DEFAULT NULL COMMENT '退款金额(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待收货,30:待退款,50:已完成,90:已取消)',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  `quality_inspection` tinyint(4) NOT NULL COMMENT '质检(10:需质检,20:已质检,30:免检)',
  `logistics_name` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_attachment` varchar(500) COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' COMMENT '物流附件',
  `box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '发货箱数',
  `salver_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '发货托数',
  `logistics_payment_mode` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人id',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人姓名',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商采购退货单';

-- ----------------------------
-- Table structure for distribution_purchase_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_return_order_item`;
CREATE TABLE `distribution_purchase_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) NOT NULL COMMENT '退货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '退货数量',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实退数量',
  `actual_unit_price` decimal(8,2) DEFAULT NULL COMMENT '实退单价(元)',
  `discrepancy_quantity` int(11) DEFAULT NULL COMMENT '差异数量',
  `discrepancy_reason` varchar(300) COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' COMMENT '差异原因',
  `discrepancy_content` varchar(300) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '差异内容',
  `original_unit_price` decimal(8,2) NOT NULL COMMENT '原单价(元)',
  `original_total_price` decimal(10,2) NOT NULL COMMENT '原总价(元)',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  `deduct_price` decimal(10,2) DEFAULT NULL COMMENT '扣费金额(元)',
  `deduct_reason` varchar(300) COLLATE utf8mb4_bin NOT NULL DEFAULT '[]' COMMENT '扣费原因',
  `deduct_content` varchar(300) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '扣费内容',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商采购退货单明细';

-- ----------------------------
-- Table structure for distribution_purchase_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_return_order_trace`;
CREATE TABLE `distribution_purchase_return_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商采购退货单跟踪';

-- ----------------------------
-- Table structure for distribution_purchase_return_restrict
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_return_restrict`;
CREATE TABLE `distribution_purchase_return_restrict` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_category_id` int(11) NOT NULL COMMENT '产品品类ID(-1表示全部)',
  `product_brand_id` int(11) NOT NULL COMMENT '产品品牌ID(-1表示全部)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_category_id` (`product_category_id`,`product_brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商采购退货限制';

-- ----------------------------
-- Table structure for distribution_purchase_return_restrict_log
-- ----------------------------
DROP TABLE IF EXISTS `distribution_purchase_return_restrict_log`;
CREATE TABLE `distribution_purchase_return_restrict_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_category_id` int(11) NOT NULL COMMENT '产品品类ID',
  `product_brand_id` int(11) NOT NULL COMMENT '产品品牌ID',
  `operate_type` tinyint(4) NOT NULL COMMENT '操作类型(5:新增,60:删除)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_category_id` (`product_category_id`,`product_brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商采购退货限制日志';

-- ----------------------------
-- Table structure for distribution_quotation
-- ----------------------------
DROP TABLE IF EXISTS `distribution_quotation`;
CREATE TABLE `distribution_quotation` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `create_time` datetime NOT NULL COMMENT '报价时间',
  `note` text COLLATE utf8_bin COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商报价单(大表)';

-- ----------------------------
-- Table structure for distribution_quotation_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_quotation_item`;
CREATE TABLE `distribution_quotation_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `sale_price` decimal(8,2) NOT NULL COMMENT '销售单价(元)',
  `unit_price` decimal(8,2) NOT NULL COMMENT '报价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商报价单行(大表)';

-- ----------------------------
-- Table structure for distribution_rebate_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_rebate_order`;
CREATE TABLE `distribution_rebate_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `purchase_total_amount` decimal(12,2) NOT NULL COMMENT '进货单总金额(元)',
  `rebate_total_amount` decimal(12,2) NOT NULL COMMENT '返利总金额(元)',
  `rebate_type` tinyint(4) NOT NULL COMMENT '返利类型(10:日常,20:手工入款单返点)',
  `status` tinyint(4) NOT NULL COMMENT '状态(20:待初审,22:初审驳回,30:待终审,32:终审驳回,50:已完成,60:已取消)',
  `payment_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '付款单号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `user_type` smallint(6) NOT NULL COMMENT '创建人类型',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `payment_number` (`payment_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商返利单';

-- ----------------------------
-- Table structure for distribution_rebate_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_rebate_order_item`;
CREATE TABLE `distribution_rebate_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '返利单ID',
  `distribution_order_id` bigint(20) NOT NULL COMMENT '服务商进货单ID',
  `purchase_price` decimal(12,2) NOT NULL COMMENT '服务商订单总金额',
  `rebate_amount` decimal(10,2) NOT NULL COMMENT '返利金额(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `distribution_order_id` (`distribution_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商返利明细';

-- ----------------------------
-- Table structure for distribution_rebate_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_rebate_order_trace`;
CREATE TABLE `distribution_rebate_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商返利明细跟踪';

-- ----------------------------
-- Table structure for distribution_recall_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recall_order`;
CREATE TABLE `distribution_recall_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '召回单号',
  `product_recall_id` int(11) NOT NULL COMMENT '产品召回单ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` smallint(6) NOT NULL DEFAULT '0' COMMENT 'sku',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `refundable_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '可退款金额(元)',
  `refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额(元)',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `voucher` varchar(200) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证',
  `purchase_return_order_number` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '采购退货单号',
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待受理,10:待发货,15:待收货,20:待退款,25:已完成,40:已取消)',
  `reconciliation_status` tinyint(4) NOT NULL COMMENT '对账状态(10:未就绪,20:待对账,30:已对账)',
  `reconciliation_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '对账单号',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `product_recall_id` (`product_recall_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商产品召回单';

-- ----------------------------
-- Table structure for distribution_recall_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recall_order_item`;
CREATE TABLE `distribution_recall_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '服务商产品召回单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价',
  `quantity` smallint(6) NOT NULL COMMENT '退货数量',
  `total_price` decimal(8,2) NOT NULL COMMENT '总价',
  `actual_quantity` smallint(6) NOT NULL COMMENT '实际退货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商产品召回单明细';

-- ----------------------------
-- Table structure for distribution_recall_order_item_batch
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recall_order_item_batch`;
CREATE TABLE `distribution_recall_order_item_batch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '召回单ID',
  `item_id` bigint(20) NOT NULL COMMENT '召回单明细ID',
  `batch_number` varchar(40) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '批次号',
  `quantity` int(11) NOT NULL COMMENT '收货数量',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实收数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='召回产品明细批次';

-- ----------------------------
-- Table structure for distribution_recall_order_item_batch_attachment
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recall_order_item_batch_attachment`;
CREATE TABLE `distribution_recall_order_item_batch_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `batch_id` bigint(20) NOT NULL COMMENT '批次ID',
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `batch_id` (`batch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='召回产品明细批次附件';

-- ----------------------------
-- Table structure for distribution_recall_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recall_order_trace`;
CREATE TABLE `distribution_recall_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '服务商产品召回单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商产品召回单日志';

-- ----------------------------
-- Table structure for distribution_receipt_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receipt_order`;
CREATE TABLE `distribution_receipt_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收款金额(元)',
  `refunded_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '已经退款金额(元)',
  `settlement_method_id` int(11) NOT NULL DEFAULT '0' COMMENT '结算方式ID',
  `difference_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '差异金额',
  `difference_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '差异原因ID',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `related_order_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '相关单类型(10应收单,20应收账单)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待收款,20已完成)',
  `cancel_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '取消状态(10未取消,20取消中,30已取消)',
  `distribution_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作收款的服务商用户ID。如果是客户自己付款的，则为0',
  `distribution_user_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '操作收款的服务商用户名称',
  `bulk_payment_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '批量支付单号',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `receipt_time` datetime NOT NULL COMMENT '收款完成时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商收款单';

-- ----------------------------
-- Table structure for distribution_receipt_revoke_apply
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receipt_revoke_apply`;
CREATE TABLE `distribution_receipt_revoke_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `receipt_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '收款单号',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待审核,20驳回,30通过)',
  `revoke_reason` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '撤销原因',
  `reject_reason` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '驳回原因',
  `distribution_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作收款的服务商用户ID。如果是客户自己付款的，则为0',
  `distribution_user_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '操作收款的服务商用户名称',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_distribution_customer` (`distribution_id`,`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店收款撤回申请';

-- ----------------------------
-- Table structure for distribution_receipt_revoke_apply_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receipt_revoke_apply_trace`;
CREATE TABLE `distribution_receipt_revoke_apply_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店收款撤回申请单跟踪(大表)';

-- ----------------------------
-- Table structure for distribution_receivable_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_order`;
CREATE TABLE `distribution_receivable_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '类型(10收款,20退款)',
  `hang_bill_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '挂账类型(10现结,20挂账,30月结,40铺货)',
  `business_type_id` int(11) NOT NULL DEFAULT '0' COMMENT '业务类型ID',
  `business_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '业务单号',
  `business_description` varchar(512) COLLATE utf8mb4_bin DEFAULT '' COMMENT '业务简要描述',
  `business_date` date NOT NULL COMMENT '业务日期',
  `receivable_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应收金额',
  `paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实收金额',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待收款,20部分收款,30已收款,40已取消)',
  `reconciliation_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '对账状态(10未对账,20已对账)',
  `difference_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '差异金额',
  `difference_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '差异原因ID',
  `original_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '原始应收单号',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '完成收款的时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `idx_distribution` (`distribution_id`),
  KEY `idx_customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商应收单';

-- ----------------------------
-- Table structure for distribution_receivable_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_order_item`;
CREATE TABLE `distribution_receivable_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '服务商应收单ID',
  `number1` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品或服务的编号1',
  `number2` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品或服务的编号2',
  `name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品或服务的名称',
  `unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品或服务的单位',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '产品或服务的数量',
  `bargain_unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '成交总价(元)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_order` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商应收单行';

-- ----------------------------
-- Table structure for distribution_receivable_order_receipt_record
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_order_receipt_record`;
CREATE TABLE `distribution_receivable_order_receipt_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '相关收款单',
  `receipt_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '服务商收款单号',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收款金额(元)',
  `settlement_method_id` int(11) NOT NULL DEFAULT '0' COMMENT '结算方式ID',
  `receipt_source` tinyint(3) unsigned NOT NULL COMMENT '收款来源(10应收单，20对账单)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10正常,20撤销中,30已撤销)',
  `difference_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '差异金额',
  `difference_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '差异原因ID',
  `distribution_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作收款的服务商用户ID。如果是客户自己付款的，则为0',
  `distribution_user_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '操作收款的服务商用户名称',
  `receipt_time` date NOT NULL COMMENT '收款时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `refund_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `idx_receipt_order` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商应收单的收款记录';

-- ----------------------------
-- Table structure for distribution_receivable_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_order_trace`;
CREATE TABLE `distribution_receivable_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商应收单跟踪(大表)';

-- ----------------------------
-- Table structure for distribution_receivable_reconciliation_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_reconciliation_order`;
CREATE TABLE `distribution_receivable_reconciliation_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `customer_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户ID',
  `customer_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户名称',
  `customer_address` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户收货地址',
  `customer_tel` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户联系电话',
  `month_start` date NOT NULL COMMENT '对账周期起始日期',
  `month_end` date NOT NULL COMMENT '对账周期截止日期',
  `receivable_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '应收金额',
  `paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '实收金额',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '对账状态(10未对账,20已对账)',
  `receipt_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '收款状态(10待收款,20部分收款,30已收款)',
  `difference_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '差异金额',
  `difference_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '差异原因ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `receipt_time` datetime NOT NULL COMMENT '完成收款的时间',
  `confirm_time` datetime NOT NULL COMMENT '确认时间',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `distribution_user_id` int(11) NOT NULL COMMENT '操作对账的服务商用户ID',
  `distribution_user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作对账的服务商用户名称',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `idx_distribution` (`distribution_id`),
  KEY `idx_customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商对账单';

-- ----------------------------
-- Table structure for distribution_receivable_reconciliation_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_reconciliation_order_item`;
CREATE TABLE `distribution_receivable_reconciliation_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `reconciliation_order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '对账单ID',
  `receivable_order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '收款单ID',
  `offset_status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '冲抵状态(10已冲抵,20未冲抵)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_reconciliation_order` (`reconciliation_order_id`),
  KEY `idx_receipt_order` (`receivable_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商对账单行';

-- ----------------------------
-- Table structure for distribution_receivable_reconciliation_order_receipt_record
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_reconciliation_order_receipt_record`;
CREATE TABLE `distribution_receivable_reconciliation_order_receipt_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '相关对账单',
  `receipt_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '服务商收款单号',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '收款金额(元)',
  `settlement_method_id` int(11) NOT NULL DEFAULT '0' COMMENT '结算方式ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10正常,20撤销中,30已撤销)',
  `distribution_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作收款的服务商用户ID。如果是客户自己付款的，则为0',
  `distribution_user_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '操作收款的服务商用户名称',
  `difference_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '差异金额',
  `difference_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '差异原因ID',
  `receipt_time` date NOT NULL COMMENT '收款时间',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_reconciliation_order` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商对账单的收款记录';

-- ----------------------------
-- Table structure for distribution_receivable_reconciliation_order_receipt_record_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receivable_reconciliation_order_receipt_record_item`;
CREATE TABLE `distribution_receivable_reconciliation_order_receipt_record_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `reconciliation_order_receipt_record_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '应收账单收款记录ID',
  `receivable_order_receipt_record_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '应收单收款单收款记录ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商对账单的收款记录明细';

-- ----------------------------
-- Table structure for distribution_receive_address
-- ----------------------------
DROP TABLE IF EXISTS `distribution_receive_address`;
CREATE TABLE `distribution_receive_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人电话',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '详细地址',
  `status` tinyint(2) NOT NULL COMMENT '状态(10 有效  20 删除)',
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '默认(1是  0否)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2398 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商收货地址';

-- ----------------------------
-- Table structure for distribution_recommend_logistics
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recommend_logistics`;
CREATE TABLE `distribution_recommend_logistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `logistics_id` int(11) NOT NULL COMMENT '物流ID',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='服务商推荐物流';

-- ----------------------------
-- Table structure for distribution_recruitment_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recruitment_payment_order`;
CREATE TABLE `distribution_recruitment_payment_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `recruitment_record_id` int(11) NOT NULL DEFAULT '0' COMMENT '招商记录id',
  `online_payment_order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '在线支付订单ID',
  `type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '回款类型(10表示加盟费，20表示首批)',
  `date` date NOT NULL COMMENT '回款日期',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10->待完善,20->待审核,30->确认,40->驳回,50->作废)',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '回款金额',
  `transfer_method` tinyint(4) NOT NULL DEFAULT '0' COMMENT '转款方式(10表示建行)',
  `transfer_user_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '转款用户名',
  `transfer_pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '转款回执上传',
  `source` tinyint(1) NOT NULL DEFAULT '10' COMMENT '来源,10表示app,20表示pc',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='回款记录';

-- ----------------------------
-- Table structure for distribution_recruitment_payment_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recruitment_payment_order_trace`;
CREATE TABLE `distribution_recruitment_payment_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `payment_order_id` bigint(20) NOT NULL COMMENT '回款记录ID',
  `payment_order_type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '回款订单类型(10表示加盟费，20表示首批)',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `payment_order_id` (`payment_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='回款记录跟踪';

-- ----------------------------
-- Table structure for distribution_recruitment_record
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recruitment_record`;
CREATE TABLE `distribution_recruitment_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `channel` int(11) NOT NULL DEFAULT '0' COMMENT '招商渠道',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `partner_id` int(11) NOT NULL DEFAULT '0' COMMENT '运营中心ID',
  `sign_contract_date` date NOT NULL COMMENT '签约日期',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系电话',
  `join_payment` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '加盟费(元)',
  `first_payment` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '首批货款金额(元)',
  `province_id` int(11) NOT NULL DEFAULT '0' COMMENT '省份',
  `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '城市',
  `district_id` int(11) NOT NULL DEFAULT '0' COMMENT '区县',
  `address` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '详细地址',
  `store_name` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '店名',
  `store_type` smallint(6) NOT NULL DEFAULT '0' COMMENT '门店类型(1000表示普通店,1001表示结网店,1002表示分店,2000表示中心店)',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10->正常,20->被删除)',
  `contract_receive_date` date DEFAULT NULL COMMENT '合同收到日期',
  `contract_send_date` date DEFAULT NULL COMMENT '合同寄出日期',
  `join_payment_paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '加盟费累计回款金额(元)',
  `first_payment_paid_amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '首批累计回款金额(元)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `source_type` tinyint(4) DEFAULT NULL,
  `source_number` char(20) COLLATE utf8_bin DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `contact_name` (`contact_name`),
  KEY `sign_contract_date` (`sign_contract_date`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='招商记录';

-- ----------------------------
-- Table structure for distribution_recruitment_record_salesman
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recruitment_record_salesman`;
CREATE TABLE `distribution_recruitment_record_salesman` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `recruitment_record_id` int(11) NOT NULL COMMENT '招商记录ID',
  `salesman_id` int(11) NOT NULL COMMENT '业务员ID',
  PRIMARY KEY (`id`),
  KEY `recruitment_record_id` (`recruitment_record_id`),
  KEY `salesman_id` (`salesman_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='招商记录业务员';

-- ----------------------------
-- Table structure for distribution_recruitment_record_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_recruitment_record_trace`;
CREATE TABLE `distribution_recruitment_record_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `recruitment_record_id` bigint(20) NOT NULL COMMENT '招商记录ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `sign_contract_date` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `recruitment_record_id` (`recruitment_record_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='招商记录跟踪';

-- ----------------------------
-- Table structure for distribution_reduce_price
-- ----------------------------
DROP TABLE IF EXISTS `distribution_reduce_price`;
CREATE TABLE `distribution_reduce_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `activity_id` int(11) NOT NULL COMMENT '活动ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，2000已取消)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `unit_price` decimal(8,2) NOT NULL COMMENT '促销单价(元)',
  `valid_start_date` date NOT NULL COMMENT '有效起始日期',
  `valid_end_date` date NOT NULL COMMENT '有效结束日期',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`id`),
  KEY `activity_id` (`activity_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商减价促销';

-- ----------------------------
-- Table structure for distribution_refund_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_refund_order`;
CREATE TABLE `distribution_refund_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `amount` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额(元)',
  `settlement_method_id` int(11) NOT NULL DEFAULT '0' COMMENT '结算方式ID',
  `receipt_order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关付款单号',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待退款,20退款中,30完成退款)',
  `distribution_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作退款的服务商用户ID。如果是客户自己付款的，则为0',
  `distribution_user_name` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '操作退款的服务商用户名称',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商退款单';

-- ----------------------------
-- Table structure for distribution_remind
-- ----------------------------
DROP TABLE IF EXISTS `distribution_remind`;
CREATE TABLE `distribution_remind` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type_id` int(11) NOT NULL COMMENT '提醒类型ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`,`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商用户提醒表';

-- ----------------------------
-- Table structure for distribution_repayment_plan
-- ----------------------------
DROP TABLE IF EXISTS `distribution_repayment_plan`;
CREATE TABLE `distribution_repayment_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:有效,40:已取消)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `attachment` varchar(1000) COLLATE utf8mb4_bin NOT NULL COMMENT '附件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商赊销还款方案';

-- ----------------------------
-- Table structure for distribution_retail_rise_price_rule
-- ----------------------------
DROP TABLE IF EXISTS `distribution_retail_rise_price_rule`;
CREATE TABLE `distribution_retail_rise_price_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `markup` decimal(6,4) NOT NULL COMMENT '加价',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，2000已取消)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `cancel_time` datetime DEFAULT NULL COMMENT '取消时间',
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`,`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商分销加价规则';

-- ----------------------------
-- Table structure for distribution_return_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_order`;
CREATE TABLE `distribution_return_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(11000待受理，13000待收货，18000待退款，19000已完成，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '受理员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `refundable_amount` decimal(12,2) NOT NULL COMMENT '可退款金额(元)',
  `refund_discount` decimal(5,4) NOT NULL DEFAULT '1.0000' COMMENT '退款折扣',
  `repacking_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更换包装总金额(元)',
  `refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额(元)',
  `purchase_return_order_number` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '采购退货单单号',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `reason` int(11) DEFAULT NULL COMMENT '退货原因(10001001产品质量问题，10001002销量不佳，10001003退出加盟)',
  `order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '进货单号',
  `last_year_sales_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '近1年销售金额(元)',
  `quality_return_quota` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '质量问题退款额度(元)',
  `quality_return_available_quota` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '质量问题退款可用额度(元)',
  `voucher` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `accepted_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '受理备注',
  `accept_time` datetime DEFAULT NULL COMMENT '受理时间',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_payment_mode` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式(10:现付,20:到付)',
  `logistics_attachment` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件',
  `logistics_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '发货箱数',
  `salver_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '发货托数',
  `inspector_id` int(11) NOT NULL DEFAULT '0' COMMENT '检验人ID',
  `conclusion` text COLLATE utf8_bin COMMENT '检验结论',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商退货单(大表)';

-- ----------------------------
-- Table structure for distribution_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_order_item`;
CREATE TABLE `distribution_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `reason` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '原因',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品类ID',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品牌ID',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  `original_unit_price` decimal(8,2) NOT NULL COMMENT '原单价(元)',
  `original_total_price` decimal(10,2) NOT NULL COMMENT '原总价(元)',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际退货数量(仓库实收的数量)',
  `actual_unit_price` decimal(8,2) DEFAULT NULL COMMENT '实退单价(元)',
  `unqualified_quantity` int(11) DEFAULT '0' COMMENT '质检不合格数量',
  `unqualified_reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '质检不合格原因',
  `repacking_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '更换包装数量',
  `repacking_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '更换包装金额',
  `scrap_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '报废数量',
  `no_allowed_returns_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '不允许退货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商退货单行(大表)';

-- ----------------------------
-- Table structure for distribution_return_order_item_attachment
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_order_item_attachment`;
CREATE TABLE `distribution_return_order_item_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `item_id` bigint(20) NOT NULL COMMENT '明细ID',
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商退货单明细附件';

-- ----------------------------
-- Table structure for distribution_return_order_quality_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_order_quality_item`;
CREATE TABLE `distribution_return_order_quality_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '退货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `description` varchar(100) NOT NULL DEFAULT '' COMMENT '异常描述',
  `batch_number` varchar(30) NOT NULL DEFAULT '' COMMENT '批次号',
  `attachment` varchar(1500) NOT NULL DEFAULT '' COMMENT '附件',
  `handler_type` tinyint(4) NOT NULL DEFAULT '5' COMMENT '处理类型(5:寄回,10:就地报废,15:不予退货)',
  `scrap_supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品供应商',
  `reason` varchar(120) NOT NULL DEFAULT '' COMMENT '原因',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='加盟商退货单质量问题明细';

-- ----------------------------
-- Table structure for distribution_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_order_trace`;
CREATE TABLE `distribution_return_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商退货单跟踪(大表)';

-- ----------------------------
-- Table structure for distribution_return_quality_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_quality_order`;
CREATE TABLE `distribution_return_quality_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商id',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL COMMENT '总金额(元)',
  `refund_amount` decimal(12,2) DEFAULT NULL COMMENT '退款金额(元)',
  `user_type` smallint(6) NOT NULL COMMENT '用户类型',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '创建人名称',
  `accept_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '受理备注',
  `return_order_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '采购退货单号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待受理,20:待发货,30:待审核,35审核不通过,45:待退款,50:已完成,60:已取消)',
  `receiving_party` tinyint(4) NOT NULL DEFAULT '0' COMMENT '接收方(10仓库 20供应商)',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库ID',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应商ID',
  `receiver_name` varchar(60) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '收货人名称',
  `receiver_address` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '收货人地址',
  `receiver_contact_mobi` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '收货人联系电话',
  `logistics_name` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '发货箱数',
  `logistics_payment_mode` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式',
  `logistics_attachment` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流附件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商质量问题退货单';

-- ----------------------------
-- Table structure for distribution_return_quality_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_quality_order_item`;
CREATE TABLE `distribution_return_quality_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '质量问题退货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `reason` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '原因',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商质量问题退货单明细';

-- ----------------------------
-- Table structure for distribution_return_quality_order_item_attachment
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_quality_order_item_attachment`;
CREATE TABLE `distribution_return_quality_order_item_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `item_id` bigint(20) NOT NULL COMMENT '明细ID',
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商质量问题退货单明细附件';

-- ----------------------------
-- Table structure for distribution_return_quality_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_quality_order_trace`;
CREATE TABLE `distribution_return_quality_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商质量问题退货单跟踪';

-- ----------------------------
-- Table structure for distribution_return_quota
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_quota`;
CREATE TABLE `distribution_return_quota` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `year` smallint(6) NOT NULL COMMENT '年份',
  `reason` int(11) NOT NULL COMMENT '原因类型',
  `used_quota` decimal(10,2) NOT NULL COMMENT '已使用额度(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`year`,`reason`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商退货额度';

-- ----------------------------
-- Table structure for distribution_return_quota_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_quota_item`;
CREATE TABLE `distribution_return_quota_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `reason` int(11) NOT NULL COMMENT '原因类型',
  `year` smallint(6) NOT NULL COMMENT '年份',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1:增加，-1:扣除)',
  `quota` decimal(10,2) NOT NULL COMMENT '额度(元)',
  `related_number` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`,`year`,`reason`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商退货额度明细';

-- ----------------------------
-- Table structure for distribution_return_reject_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_reject_order`;
CREATE TABLE `distribution_return_reject_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商id',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库ID',
  `storehouse_type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '仓库类型(10仓库,20直营店)',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL COMMENT '总金额(元)',
  `refund_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '退款金额(元)',
  `user_type` smallint(6) NOT NULL COMMENT '用户类型',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '创建人名称',
  `accept_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '受理备注',
  `order_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '原始进货单号',
  `return_order_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '采购退货单号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待受理,20:待发货,30:待审核,35审核不通过,45:待退款,50:已完成,60:已取消)',
  `reject_reason` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '驳回原因',
  `join_activity_status` smallint(6) NOT NULL DEFAULT '10' COMMENT '参与活动状态(10不参加活动，20参加活动)',
  `logistics_name` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(128) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_payment_mode` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式',
  `logistics_attachment` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流附件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='拒收退货单';

-- ----------------------------
-- Table structure for distribution_return_reject_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_reject_order_item`;
CREATE TABLE `distribution_return_reject_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '拒收退货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品类ID',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品牌ID',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='拒收退货单明细';

-- ----------------------------
-- Table structure for distribution_return_reject_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_reject_order_trace`;
CREATE TABLE `distribution_return_reject_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` bigint(20) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='拒收退货单跟踪';

-- ----------------------------
-- Table structure for distribution_return_scrap_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_scrap_order`;
CREATE TABLE `distribution_return_scrap_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '服务商id',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL COMMENT '总金额(元)',
  `refund_amount` decimal(12,2) DEFAULT NULL COMMENT '退款金额(元)',
  `user_type` smallint(6) NOT NULL COMMENT '用户类型',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '创建人名称',
  `use_quota` tinyint(4) NOT NULL COMMENT '是否占用退款额度(0否，1是)',
  `no_use_quota_reason` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '不占用退款额度原因',
  `scrap_voucher` varchar(500) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '废品凭证',
  `accept_voucher` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '受理凭证',
  `accept_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '受理备注',
  `last_year_sales_amount` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '近1年销售金额(元)',
  `total_quota` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '退款总额度(元)',
  `available_quota` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '可用额度(元)',
  `return_order_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '退货单号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待受理,20:待报废,30:待审核,35:审核不通过,40:待退款,50:已完成,60:已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='报废退货单';

-- ----------------------------
-- Table structure for distribution_return_scrap_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_scrap_order_item`;
CREATE TABLE `distribution_return_scrap_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '报废单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='退货报废单明细';

-- ----------------------------
-- Table structure for distribution_return_scrap_order_item_abnormal
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_scrap_order_item_abnormal`;
CREATE TABLE `distribution_return_scrap_order_item_abnormal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '报废单ID',
  `item_id` int(11) NOT NULL COMMENT '明细ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `description` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '异常描述',
  `batch_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '批次号',
  `scrap_voucher` varchar(500) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '报废凭证',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应商ID',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='退货报废单异常明细';

-- ----------------------------
-- Table structure for distribution_return_scrap_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_return_scrap_order_trace`;
CREATE TABLE `distribution_return_scrap_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='退货报废单跟踪';

-- ----------------------------
-- Table structure for distribution_review
-- ----------------------------
DROP TABLE IF EXISTS `distribution_review`;
CREATE TABLE `distribution_review` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `star_level` tinyint(4) NOT NULL COMMENT '星级',
  `total_review` int(11) NOT NULL COMMENT '评价总数',
  `total_star_level` int(11) NOT NULL COMMENT '星级总数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商评价';

-- ----------------------------
-- Table structure for distribution_role
-- ----------------------------
DROP TABLE IF EXISTS `distribution_role`;
CREATE TABLE `distribution_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3690 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商角色';

-- ----------------------------
-- Table structure for distribution_role_data_permission
-- ----------------------------
DROP TABLE IF EXISTS `distribution_role_data_permission`;
CREATE TABLE `distribution_role_data_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` int(11) NOT NULL COMMENT '角色ID',
  `permission_id` int(11) NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商角色数据权限';

-- ----------------------------
-- Table structure for distribution_role_module
-- ----------------------------
DROP TABLE IF EXISTS `distribution_role_module`;
CREATE TABLE `distribution_role_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=343244 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商角色模块';

-- ----------------------------
-- Table structure for distribution_sales_volume
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sales_volume`;
CREATE TABLE `distribution_sales_volume` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '销量ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '销售数量',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商销量统计';

-- ----------------------------
-- Table structure for distribution_sales_volume_report
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sales_volume_report`;
CREATE TABLE `distribution_sales_volume_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1月，2年)',
  `date` char(6) COLLATE utf8_bin NOT NULL COMMENT '年月',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待处理，1100已完成)',
  `total_product` int(11) DEFAULT NULL COMMENT '产品数量',
  `total_quantity` int(11) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '报表生成时间',
  PRIMARY KEY (`id`),
  KEY `date` (`date`),
  KEY `distribution_id` (`distribution_id`,`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商销量报表(销售量统计)';

-- ----------------------------
-- Table structure for distribution_sales_volume_report_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sales_volume_report_item`;
CREATE TABLE `distribution_sales_volume_report_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `average_price` decimal(8,2) NOT NULL COMMENT '平均单价(元)',
  `total_price` decimal(10,2) DEFAULT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商销量报表行(补货量统计)';

-- ----------------------------
-- Table structure for distribution_search_vin_history
-- ----------------------------
DROP TABLE IF EXISTS `distribution_search_vin_history`;
CREATE TABLE `distribution_search_vin_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务商ID',
  `vin` char(17) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '车架号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `vin` (`vin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商VIN查询搜索历史表';

-- ----------------------------
-- Table structure for distribution_self_store_return_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_return_order`;
CREATE TABLE `distribution_self_store_return_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '订单编号',
  `order_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '进货单号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '直营店ID',
  `customer_id` int(11) NOT NULL DEFAULT '10' COMMENT '客户ID',
  `status` smallint(6) NOT NULL DEFAULT '11000' COMMENT '订单状态(11000待审核，13000待收货，18000已完成，19000已取消)',
  `user_id` int(11) NOT NULL COMMENT '受理员工ID',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL DEFAULT '0' COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `original_total_price` decimal(12,2) NOT NULL COMMENT '原总价(元)',
  `voucher` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '凭证',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `reject_reason` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '驳回原因',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_name` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_payment_mode` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式(10:现付,20:到付)',
  `logistics_attachment` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流附件',
  `logistics_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `refund_time` datetime DEFAULT NULL COMMENT '退款时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `idx_order_number` (`order_number`),
  KEY `idx_distribution` (`distribution_id`),
  KEY `idx_customer` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店销售退货单';

-- ----------------------------
-- Table structure for distribution_self_store_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_return_order_item`;
CREATE TABLE `distribution_self_store_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '订单ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品类ID',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品牌ID',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `original_unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '原单价(元)',
  `original_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店销售退货单行(大表)';

-- ----------------------------
-- Table structure for distribution_self_store_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_return_order_trace`;
CREATE TABLE `distribution_self_store_return_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店退货单追踪';

-- ----------------------------
-- Table structure for distribution_self_store_sales_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_sales_order`;
CREATE TABLE `distribution_self_store_sales_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '直营店ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10200待发货，10300已完成，10400已取消)',
  `related_order_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '相关单类型(10服务商进货单)',
  `related_number` varchar(30) COLLATE utf8mb4_bin DEFAULT '' COMMENT '相关单号',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL DEFAULT '0' COMMENT 'sku数量',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '产品数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `original_total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '原总价(元)',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_fee` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '物流费',
  `logistics_fee_payment_type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式(10到付,20包邮并送货上门,30公司付)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`),
  KEY `deliver_time` (`deliver_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店销售单';

-- ----------------------------
-- Table structure for distribution_self_store_sales_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_sales_order_item`;
CREATE TABLE `distribution_self_store_sales_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '销售单ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `original_unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '原单价(元)',
  `original_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '原总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='直营店销售单明细';

-- ----------------------------
-- Table structure for distribution_self_store_sales_order_pre_allocate_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_sales_order_pre_allocate_item`;
CREATE TABLE `distribution_self_store_sales_order_pre_allocate_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `lock_order_id` bigint(20) NOT NULL COMMENT '锁定单ID',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `lock_order_id` (`lock_order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='直营店销售单预分配行(大表)';

-- ----------------------------
-- Table structure for distribution_self_store_sales_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_self_store_sales_order_trace`;
CREATE TABLE `distribution_self_store_sales_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='直营店销售单跟踪';

-- ----------------------------
-- Table structure for distribution_service_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_service_item`;
CREATE TABLE `distribution_service_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `guide_price` decimal(8,2) NOT NULL COMMENT '指导单价(元)',
  `category_id` int(11) NOT NULL COMMENT '类型ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:启用,20:禁用)',
  `pic` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '图片',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商服务项目';

-- ----------------------------
-- Table structure for distribution_service_item_category
-- ----------------------------
DROP TABLE IF EXISTS `distribution_service_item_category`;
CREATE TABLE `distribution_service_item_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:正常,20:被删除)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商服务项目分类';

-- ----------------------------
-- Table structure for distribution_setting
-- ----------------------------
DROP TABLE IF EXISTS `distribution_setting`;
CREATE TABLE `distribution_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `code` int(11) NOT NULL COMMENT '编号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '加盟商ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `type` smallint(6) NOT NULL COMMENT '类型(10001整形，10002浮点型，10003字串)',
  `value` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '值',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `code` (`code`,`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2916 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商系统参数';

-- ----------------------------
-- Table structure for distribution_settlement_method
-- ----------------------------
DROP TABLE IF EXISTS `distribution_settlement_method`;
CREATE TABLE `distribution_settlement_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `name` varchar(68) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '名称',
  `description` varchar(156) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10启用,20禁用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商结算方式';

-- ----------------------------
-- Table structure for distribution_shelves
-- ----------------------------
DROP TABLE IF EXISTS `distribution_shelves`;
CREATE TABLE `distribution_shelves` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '仓位名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(1空置，2已用)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`name`)
) ENGINE=InnoDB AUTO_INCREMENT=309729 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商仓位(大表)';

-- ----------------------------
-- Table structure for distribution_shipping_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_shipping_order`;
CREATE TABLE `distribution_shipping_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待发货，15000已发货，21000已退单)',
  `join_activity_status` smallint(6) NOT NULL DEFAULT '10' COMMENT '参与活动状态(10不参加活动，20参加活动)',
  `priority` tinyint(4) NOT NULL COMMENT '优先级(1-10)',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `storehouse_type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '仓库类型(10仓库,20服务中心)',
  `stock_source` tinyint(4) NOT NULL DEFAULT '10' COMMENT '库存来源(10仓库,20服务中心)',
  `outstock_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '出库单号',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '物流费用(1到付，2包邮)',
  `logistics_cost_amount` decimal(8,2) DEFAULT NULL COMMENT '物流费用金额',
  `box_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '发货箱数',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商物流单(大表)';

-- ----------------------------
-- Table structure for distribution_sign_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sign_order`;
CREATE TABLE `distribution_sign_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '生成的服务商ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '门店名称',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `type` smallint(6) NOT NULL COMMENT '类型',
  `nature` tinyint(4) NOT NULL COMMENT '性质',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '详细地址',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系电话',
  `default_storehouse_id` int(11) NOT NULL COMMENT '默认配送仓库ID',
  `partner_id` int(11) NOT NULL DEFAULT '0',
  `develop_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开发类型(0无，1新区开发，2老区替换)',
  `license` tinyint(4) NOT NULL COMMENT '许可方式(1:全品类，2:部分品类)',
  `account_synchronization` tinyint(4) NOT NULL DEFAULT '5' COMMENT '账号同步(5:未就绪,10:待同步,20:已同步)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `retail_level` tinyint(1) unsigned NOT NULL DEFAULT '10' COMMENT '分销等级，10->无级别,20->小店,30->区域王者',
  `parent_distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级服务商ID',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商签约单';

-- ----------------------------
-- Table structure for distribution_sign_order_authentication
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sign_order_authentication`;
CREATE TABLE `distribution_sign_order_authentication` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '签约单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1个人认证，2企业认证)',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `identity_number` varchar(18) COLLATE utf8_bin NOT NULL COMMENT '身份证号',
  `identity_positive_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '身份证正面照',
  `identity_verso_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '身份证反面照',
  `identity_on_hand_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '手持身份证照片',
  `issued_by` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '身份证签发机关',
  `validfrom_date` datetime DEFAULT NULL COMMENT '身份证有效起始时间',
  `expiration_date` datetime DEFAULT NULL COMMENT '身份证有效结束时间',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '身份证地址',
  `ethnic` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '身份证名族',
  `gender` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '身份证性别',
  `birthday` date DEFAULT NULL COMMENT '身份证生日',
  `company_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '企业名称(企业)',
  `legal_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '法人姓名(企业)',
  `identifier` varchar(18) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `licence_pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '营业执照(企业)',
  `personal_id_addr` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '秒钛坊个人SecId',
  `personal_owner_account` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '秒钛坊个人钱包地址',
  `company_id_addr` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '秒钛坊企业SecId',
  `company_owner_account` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '秒钛坊企业钱包地址',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商签约认证表';

-- ----------------------------
-- Table structure for distribution_sign_order_contract
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sign_order_contract`;
CREATE TABLE `distribution_sign_order_contract` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '签约单ID',
  `deposit` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '保证金',
  `franchise_fee` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '加盟费(元)',
  `quarterly_mission` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '季度任务量(元)',
  `first_payment` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '首批货款金额(元)',
  `type` tinyint(4) DEFAULT NULL COMMENT '类型(1个人签约，2企业签约)',
  `company_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '企业名称(企业)',
  `legal_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '法人姓名(企业)',
  `identity_number` varchar(18) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '法人身份证号',
  `identifier` varchar(18) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '统一社会信用代码(企业)',
  `province_id` int(11) DEFAULT NULL COMMENT '省份',
  `city_id` int(11) DEFAULT NULL COMMENT '城市',
  `district_id` int(11) DEFAULT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '详细地址',
  `number` varchar(30) COLLATE utf8_bin DEFAULT NULL COMMENT '合同编号',
  `start_date` date DEFAULT NULL COMMENT '起始日期',
  `end_date` date DEFAULT NULL COMMENT '终止日期',
  `signed_pdf` mediumtext COLLATE utf8_bin COMMENT '签章合同',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商签约合同表';

-- ----------------------------
-- Table structure for distribution_sign_order_extend_picture
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sign_order_extend_picture`;
CREATE TABLE `distribution_sign_order_extend_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '签约单ID',
  `pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '图片',
  `type` tinyint(4) NOT NULL COMMENT '类型(1租赁合同，2产权证)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='签约单图片表';

-- ----------------------------
-- Table structure for distribution_sign_order_product_license
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sign_order_product_license`;
CREATE TABLE `distribution_sign_order_product_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '签约单ID',
  `category_id` int(11) DEFAULT NULL COMMENT '品类ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='签约单产品授权表';

-- ----------------------------
-- Table structure for distribution_sign_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_sign_order_trace`;
CREATE TABLE `distribution_sign_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '签约单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商签约单日志';

-- ----------------------------
-- Table structure for distribution_stock
-- ----------------------------
DROP TABLE IF EXISTS `distribution_stock`;
CREATE TABLE `distribution_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '库存数量',
  `shelves_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '仓位ID',
  `purchase_in_transit` int(11) NOT NULL DEFAULT '0' COMMENT '在途库存',
  `cabinet_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '配件柜库存',
  `cabinet_in_transit` int(11) NOT NULL DEFAULT '0' COMMENT '配件柜在途库存',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`),
  KEY `distribution_stock_product_id` (`product_id`),
  KEY `shelves_id` (`shelves_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15589466 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商库存(大表)';

-- ----------------------------
-- Table structure for distribution_stock_lock_order
-- ----------------------------
DROP TABLE IF EXISTS `distribution_stock_lock_order`;
CREATE TABLE `distribution_stock_lock_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '单号',
  `distribution_id` int(11) NOT NULL COMMENT '直营店ID',
  `type` smallint(6) NOT NULL DEFAULT '10' COMMENT '类型(10订单占用)',
  `related_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '相关单号(直营店销售单)',
  `status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '订单状态(10已锁定，20已解锁)',
  `user_type` smallint(6) NOT NULL DEFAULT '1000' COMMENT '受理员工类型(1000系统，2000服务商)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '受理员工名称',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `idx_distribution` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商库存锁定单';

-- ----------------------------
-- Table structure for distribution_stock_lock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `distribution_stock_lock_order_item`;
CREATE TABLE `distribution_stock_lock_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL DEFAULT '0' COMMENT '锁定单ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商库存锁定单行';

-- ----------------------------
-- Table structure for distribution_store_apply
-- ----------------------------
DROP TABLE IF EXISTS `distribution_store_apply`;
CREATE TABLE `distribution_store_apply` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '加盟商ID',
  `parent_distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级服务商ID',
  `username` char(11) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '登录手机号',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '名称',
  `province_id` int(11) NOT NULL DEFAULT '0' COMMENT '省份',
  `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '城市',
  `district_id` int(11) NOT NULL DEFAULT '0' COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '详细地址',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系电话',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '10' COMMENT '状态(10待审核,20待签约,30有效,40审核不通过)',
  `license` tinyint(4) NOT NULL DEFAULT '1' COMMENT '许可方式(1全品类，2部分品类)',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_distribution_id` (`parent_distribution_id`),
  KEY `name` (`name`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`),
  KEY `district_id` (`district_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='小店申请';

-- ----------------------------
-- Table structure for distribution_store_extend_picture
-- ----------------------------
DROP TABLE IF EXISTS `distribution_store_extend_picture`;
CREATE TABLE `distribution_store_extend_picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `apply_id` int(11) NOT NULL DEFAULT '0' COMMENT '小店申请ID',
  `pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图片',
  `type` tinyint(4) NOT NULL COMMENT '类型(1租赁合同，2产权证)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='小店扩展图片表';

-- ----------------------------
-- Table structure for distribution_store_product_license
-- ----------------------------
DROP TABLE IF EXISTS `distribution_store_product_license`;
CREATE TABLE `distribution_store_product_license` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `apply_id` int(11) NOT NULL COMMENT '小店申请ID',
  `category_id` int(11) NOT NULL COMMENT '产品品类ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `apply_id` (`apply_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='小店产品许可';

-- ----------------------------
-- Table structure for distribution_trace
-- ----------------------------
DROP TABLE IF EXISTS `distribution_trace`;
CREATE TABLE `distribution_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '用户类型',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `user_name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '用户名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商跟踪';

-- ----------------------------
-- Table structure for distribution_transfer_shelves_log
-- ----------------------------
DROP TABLE IF EXISTS `distribution_transfer_shelves_log`;
CREATE TABLE `distribution_transfer_shelves_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '服务商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_shelves_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '原仓位名称',
  `new_shelves_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '新仓位名称',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务商调仓日志';

-- ----------------------------
-- Table structure for distribution_user
-- ----------------------------
DROP TABLE IF EXISTS `distribution_user`;
CREATE TABLE `distribution_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名(手机号)',
  `password_hash` char(60) COLLATE utf8_bin NOT NULL COMMENT '登录密码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `certificate_number` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '身份证号',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID(预留)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，2000停用，9000已删除)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8919 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商用户';

-- ----------------------------
-- Table structure for distribution_user_esion_account
-- ----------------------------
DROP TABLE IF EXISTS `distribution_user_esion_account`;
CREATE TABLE `distribution_user_esion_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '用户姓名',
  `certificate_type` tinyint(4) NOT NULL COMMENT '证件类型(10:身份证)',
  `certificate_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '证件号',
  `account_id` char(32) COLLATE utf8mb4_bin NOT NULL COMMENT '账户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `certificate_number` (`certificate_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='e签宝账户';

-- ----------------------------
-- Table structure for distribution_user_history
-- ----------------------------
DROP TABLE IF EXISTS `distribution_user_history`;
CREATE TABLE `distribution_user_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名(手机号)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='服务商用户历史';

-- ----------------------------
-- Table structure for distribution_user_operate_permissions
-- ----------------------------
DROP TABLE IF EXISTS `distribution_user_operate_permissions`;
CREATE TABLE `distribution_user_operate_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `permissions_id` int(11) NOT NULL COMMENT '权限ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户操作权限';

-- ----------------------------
-- Table structure for distribution_user_operate_permissions_log
-- ----------------------------
DROP TABLE IF EXISTS `distribution_user_operate_permissions_log`;
CREATE TABLE `distribution_user_operate_permissions_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `permissions_id` int(11) NOT NULL COMMENT '权限ID',
  `operate_type` tinyint(4) NOT NULL COMMENT '操作类型(10:授权,20:撤销)',
  `operator_id` int(11) NOT NULL COMMENT '操作人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='用户操作权限日志';

-- ----------------------------
-- Table structure for distribution_wechat
-- ----------------------------
DROP TABLE IF EXISTS `distribution_wechat`;
CREATE TABLE `distribution_wechat` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `wechat_id` int(11) NOT NULL COMMENT '微信账号ID',
  `openid` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '微信OPEN ID',
  `group_id` int(11) NOT NULL DEFAULT '0' COMMENT '微信分组ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已关注，9000无效)',
  `distribution_user_id` int(11) NOT NULL COMMENT '加盟商用户ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `wechat_id` (`wechat_id`),
  KEY `openid` (`openid`),
  KEY `distribution_user_id` (`distribution_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商绑定微信账号';

-- ----------------------------
-- Table structure for exempted_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `exempted_storehouse`;
CREATE TABLE `exempted_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='免检仓库';

-- ----------------------------
-- Table structure for exempted_supplier
-- ----------------------------
DROP TABLE IF EXISTS `exempted_supplier`;
CREATE TABLE `exempted_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='免检供应商';

-- ----------------------------
-- Table structure for form_history
-- ----------------------------
DROP TABLE IF EXISTS `form_history`;
CREATE TABLE `form_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `key` smallint(6) NOT NULL COMMENT '键',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='表单历史';

-- ----------------------------
-- Table structure for garage
-- ----------------------------
DROP TABLE IF EXISTS `garage`;
CREATE TABLE `garage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '修理厂ID',
  `number` char(10) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `type` smallint(6) NOT NULL COMMENT '类型(1000个人，2000企业)',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '地址',
  `lng` decimal(10,7) NOT NULL COMMENT '经度',
  `lat` decimal(10,7) NOT NULL COMMENT '纬度',
  `contact_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '联系电话',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，9000已删除)',
  `default_distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '默认加盟商ID',
  `note` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
  `user_type` smallint(6) NOT NULL COMMENT '创建人类型',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `register_channel` tinyint(4) NOT NULL DEFAULT '0' COMMENT '创建渠道（0 为默认方式服务商创建或者分店，1 邀请注册）',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `name` (`name`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`),
  KEY `district_id` (`district_id`),
  KEY `lng` (`lng`),
  KEY `lat` (`lat`)
) ENGINE=InnoDB AUTO_INCREMENT=209257 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='修理厂';

-- ----------------------------
-- Table structure for garage_account
-- ----------------------------
DROP TABLE IF EXISTS `garage_account`;
CREATE TABLE `garage_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `balance` decimal(10,2) NOT NULL COMMENT '余额',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂账户';

-- ----------------------------
-- Table structure for garage_account_item
-- ----------------------------
DROP TABLE IF EXISTS `garage_account_item`;
CREATE TABLE `garage_account_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账目ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `type` smallint(6) NOT NULL COMMENT '账目类型(10100现金付款，20100现金货款，20200月结货款，20300铺货货款)',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `amount` decimal(10,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000未销账，1100已销账，1200反销账)',
  `adjust_type` smallint(6) NOT NULL COMMENT '调账类型(1000非调账账目)',
  `transaction_type` smallint(6) NOT NULL COMMENT '交易类型(10000下单，11000退单)',
  `transaction_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '交易单号',
  `sub_transaction_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '子交易单ID',
  `create_time` datetime NOT NULL COMMENT '交易时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `payment_time` datetime DEFAULT NULL COMMENT '付款时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '交易明细',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`),
  KEY `transaction_number` (`transaction_number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂账目(大表)';

-- ----------------------------
-- Table structure for garage_account_write_off
-- ----------------------------
DROP TABLE IF EXISTS `garage_account_write_off`;
CREATE TABLE `garage_account_write_off` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '账目ID',
  `amount` decimal(8,2) NOT NULL COMMENT '销账金额',
  `payment_method` smallint(6) NOT NULL COMMENT '付款方式(10000余额付款，10100现金付款)',
  `payment_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '付款账目ID',
  `create_time` datetime NOT NULL COMMENT '销账时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂销账(大表)';

-- ----------------------------
-- Table structure for garage_certificate
-- ----------------------------
DROP TABLE IF EXISTS `garage_certificate`;
CREATE TABLE `garage_certificate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '认证ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `certificate_pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '证件图片',
  `storefront_pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '门店图片',
  `status` tinyint(4) NOT NULL COMMENT '状态(1未认证，2已认证)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂认证信息';

-- ----------------------------
-- Table structure for garage_certificate_order
-- ----------------------------
DROP TABLE IF EXISTS `garage_certificate_order`;
CREATE TABLE `garage_certificate_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '申请单ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系电话',
  `certificate_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '证件图片',
  `storefront_pic` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '门店图片',
  `status` tinyint(4) NOT NULL COMMENT '状态(0待审核，1审核通过，2审核不通过)',
  `user_id` int(11) NOT NULL COMMENT '申请人',
  `audit_id` int(11) NOT NULL COMMENT '审核人',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂实名认证申请单';

-- ----------------------------
-- Table structure for garage_number_sequence
-- ----------------------------
DROP TABLE IF EXISTS `garage_number_sequence`;
CREATE TABLE `garage_number_sequence` (
  `id` char(3) COLLATE utf8_bin NOT NULL COMMENT '键',
  `value` int(11) NOT NULL COMMENT '值',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂编号自增序列';

-- ----------------------------
-- Table structure for garage_receive_address
-- ----------------------------
DROP TABLE IF EXISTS `garage_receive_address`;
CREATE TABLE `garage_receive_address` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `contact_name` varchar(20) NOT NULL COMMENT '联系人姓名',
  `contact_mobi` varchar(20) NOT NULL COMMENT '联系人手机号码',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(255) NOT NULL COMMENT '具体地址',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `is_default` tinyint(4) NOT NULL DEFAULT '10' COMMENT '是否默认地址(10是，20否)',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='修理厂收货地址';

-- ----------------------------
-- Table structure for garage_user
-- ----------------------------
DROP TABLE IF EXISTS `garage_user`;
CREATE TABLE `garage_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '修理厂ID',
  `username` varchar(20) COLLATE utf8_bin DEFAULT NULL COMMENT '用户名(手机号)',
  `password_hash` char(60) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '登录密码',
  `role_id` int(11) NOT NULL DEFAULT '0' COMMENT '角色ID(预留)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，2000停用，9000已删除)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38351 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修理厂用户';

-- ----------------------------
-- Table structure for inbound_order
-- ----------------------------
DROP TABLE IF EXISTS `inbound_order`;
CREATE TABLE `inbound_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '入库单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(11采购，12调拨，31销售退货)',
  `business_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '业务单号',
  `warehouse_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '仓储单号',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数量',
  `total_quantity` int(11) NOT NULL COMMENT '数量',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应商ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单';

-- ----------------------------
-- Table structure for inbound_order_item
-- ----------------------------
DROP TABLE IF EXISTS `inbound_order_item`;
CREATE TABLE `inbound_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '入库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '入库数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单行';

-- ----------------------------
-- Table structure for instock_order
-- ----------------------------
DROP TABLE IF EXISTS `instock_order`;
CREATE TABLE `instock_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '入库单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000采购，1100调仓，1200配送)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号(采购单、调拨单、加盟商退货单)',
  `supplier_number` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '供应方单号',
  `quality_inspection` tinyint(4) NOT NULL DEFAULT '0' COMMENT '质检(0未指定，10免检, 20已质检，50需质检)',
  `total_sku` smallint(6) NOT NULL DEFAULT '0' COMMENT 'sku数',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待打印，10200待入库，10300已入库，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `arrival_date` date DEFAULT NULL COMMENT '到货日期',
  `salver_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '发货托数',
  `box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '预期到货箱数',
  `receipt_salver_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '实收托数',
  `receipt_box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际到货箱数',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_payment_mode` tinyint(4) NOT NULL DEFAULT '10' COMMENT '物流支付方式(10:现付,20:到付)',
  `logistics_attachment1` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件1',
  `logistics_attachment2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件2',
  `logistics_attachment3` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件3',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `arrival_date` (`arrival_date`),
  KEY `supplier_number` (`supplier_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单';

-- ----------------------------
-- Table structure for instock_order_bak_20210112
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_bak_20210112`;
CREATE TABLE `instock_order_bak_20210112` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '入库单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000采购，1100调仓，1200配送)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号(采购单、调拨单、加盟商退货单)',
  `supplier_number` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '供应方单号',
  `quality_inspection` tinyint(4) NOT NULL DEFAULT '0' COMMENT '质检(0未指定，10免检, 20已质检，50需质检)',
  `total_sku` smallint(6) NOT NULL DEFAULT '0' COMMENT 'sku数',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待打印，10200待入库，10300已入库，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `arrival_date` date DEFAULT NULL COMMENT '到货日期',
  `salver_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '发货托数',
  `box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '预期到货箱数',
  `receipt_salver_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '实收托数',
  `receipt_box_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际到货箱数',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_attachment1` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件1',
  `logistics_attachment2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件2',
  `logistics_attachment3` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件3',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- ----------------------------
-- Table structure for instock_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_contact`;
CREATE TABLE `instock_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '入库单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1发货人，2联系人)',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单联系人';

-- ----------------------------
-- Table structure for instock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_item`;
CREATE TABLE `instock_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '入库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '入库数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `received_quantity` int(11) DEFAULT '0' COMMENT '已收货数量',
  `unqualified_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '不合格数量',
  `putaway_quantity` int(11) DEFAULT '0' COMMENT '已上架数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单行(大表)';

-- ----------------------------
-- Table structure for instock_order_process_item
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_process_item`;
CREATE TABLE `instock_order_process_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '入库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10:换盒)',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='入库单加工明细';

-- ----------------------------
-- Table structure for instock_order_putaway_item
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_putaway_item`;
CREATE TABLE `instock_order_putaway_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `receiving_item_id` bigint(20) NOT NULL COMMENT '收货行ID',
  `quantity` int(11) NOT NULL COMMENT '上架数量',
  `location_id` int(11) NOT NULL COMMENT '上架库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '上架库位编号',
  PRIMARY KEY (`id`),
  KEY `receiving_item_id` (`receiving_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单上架行(大表)';

-- ----------------------------
-- Table structure for instock_order_receiving_item
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_receiving_item`;
CREATE TABLE `instock_order_receiving_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '入库单ID',
  `item_id` int(11) NOT NULL COMMENT '入库单行ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已收货，1100上架中，1900已上架，2000已取消)',
  `quantity` int(11) NOT NULL COMMENT '收货数量',
  `is_qualified` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否合格(0:否,1:是)',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位编号',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `receiving_date` date NOT NULL COMMENT '收货日期',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单收货行(大表)';

-- ----------------------------
-- Table structure for instock_order_refuse_receive_item
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_refuse_receive_item`;
CREATE TABLE `instock_order_refuse_receive_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '入库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `reason_id` int(11) NOT NULL COMMENT '原因ID',
  `reason` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '原因',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='入库单拒收明细';

-- ----------------------------
-- Table structure for instock_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `instock_order_trace`;
CREATE TABLE `instock_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型(1000系统，2000仓库)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='入库单跟踪';

-- ----------------------------
-- Table structure for insurance_tire
-- ----------------------------
DROP TABLE IF EXISTS `insurance_tire`;
CREATE TABLE `insurance_tire` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `openid` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '微信OPEN ID',
  `name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '被保人姓名',
  `mobile` char(11) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `license_plate_number` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '车牌号',
  `size_type` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '轮胎尺寸规格',
  `position` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '轮胎装车位置',
  `quantity` tinyint(4) NOT NULL DEFAULT '0' COMMENT '轮胎数量',
  `install_date` date NOT NULL COMMENT '安装时间',
  `start_date` date NOT NULL COMMENT '保险开始日期',
  `end_date` date NOT NULL COMMENT '保险结束日期',
  `garage_name` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '修理厂名称',
  `garage_address` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '修理厂地址',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`),
  KEY `mobile` (`mobile`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='轮胎险';

-- ----------------------------
-- Table structure for inventory_plan
-- ----------------------------
DROP TABLE IF EXISTS `inventory_plan`;
CREATE TABLE `inventory_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '盘点计划单号',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000变动盘点，1100仓位盘点，1200全库盘点)',
  `status` smallint(6) NOT NULL COMMENT '状态(10000待录入，10100待审核，10200已完成，20000已取消)',
  `plan_date` date NOT NULL COMMENT '盘点日期',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='盘点计划';

-- ----------------------------
-- Table structure for inventory_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `inventory_plan_item`;
CREATE TABLE `inventory_plan_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL COMMENT '盘点计划ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位编号',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实存数量',
  `inventory_quantity` int(11) DEFAULT NULL COMMENT '盘点数量',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='盘点计划明细';

-- ----------------------------
-- Table structure for inventory_plan_period
-- ----------------------------
DROP TABLE IF EXISTS `inventory_plan_period`;
CREATE TABLE `inventory_plan_period` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `plan_id` int(11) NOT NULL COMMENT '盘点计划ID',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='变动盘点周期';

-- ----------------------------
-- Table structure for inventory_plan_trace
-- ----------------------------
DROP TABLE IF EXISTS `inventory_plan_trace`;
CREATE TABLE `inventory_plan_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plan_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='盘点计划跟踪';

-- ----------------------------
-- Table structure for inventory_warning
-- ----------------------------
DROP TABLE IF EXISTS `inventory_warning`;
CREATE TABLE `inventory_warning` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `lower_limit` int(11) DEFAULT NULL COMMENT '下限',
  `upper_limit` int(11) DEFAULT NULL COMMENT '上限',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`storehouse_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存预警';

-- ----------------------------
-- Table structure for inventory_warning_setting
-- ----------------------------
DROP TABLE IF EXISTS `inventory_warning_setting`;
CREATE TABLE `inventory_warning_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `purchase_cycle` int(11) NOT NULL COMMENT '采购周期',
  `cycle_coefficient` int(11) NOT NULL COMMENT '周期系数',
  `new_distributions` int(11) NOT NULL COMMENT '新加盟商数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`category_id`,`brand_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存预警设置';

-- ----------------------------
-- Table structure for location
-- ----------------------------
DROP TABLE IF EXISTS `location`;
CREATE TABLE `location` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `section_id` int(11) NOT NULL COMMENT '库区ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位编号',
  `type` int(11) NOT NULL COMMENT '库位类型',
  `use` int(11) NOT NULL COMMENT '库位用途',
  `pack_zone_id` int(11) NOT NULL DEFAULT '0' COMMENT '打包区ID',
  `hold` int(11) NOT NULL COMMENT '冻结状态',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态(0正常，1删除)',
  `putaway_order` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '上架顺序',
  `picking_order` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '拣货顺序',
  `max_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '最大数量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`storehouse_id`),
  KEY `section_id` (`section_id`),
  KEY `storehouse_id` (`storehouse_id`,`use`)
) ENGINE=InnoDB AUTO_INCREMENT=163614 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库位';

-- ----------------------------
-- Table structure for logistics
-- ----------------------------
DROP TABLE IF EXISTS `logistics`;
CREATE TABLE `logistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `storehouse_type` tinyint(4) NOT NULL DEFAULT '10' COMMENT '仓库类型(10仓库,20服务中心)',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `level` tinyint(4) NOT NULL DEFAULT '10' COMMENT '等级(10主物流，20辅物流，30备用物流)',
  `orderby` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系电话',
  `contact_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系地址',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=744 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='物流方式';

-- ----------------------------
-- Table structure for logistics_abnormal
-- ----------------------------
DROP TABLE IF EXISTS `logistics_abnormal`;
CREATE TABLE `logistics_abnormal` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `outstock_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待确认，15000已处理，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '员工ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `outstock_id` (`outstock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='物流异常';

-- ----------------------------
-- Table structure for lucky_draw
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw`;
CREATE TABLE `lucky_draw` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `type` tinyint(4) NOT NULL COMMENT '抽奖类型(1:扭蛋机)',
  `start_time` datetime NOT NULL COMMENT '活动开始时间',
  `end_time` datetime NOT NULL COMMENT '活动截止时间',
  `participate_limit_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '每人每日参与次数',
  `winning_limit_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '限制中奖次数',
  `estimate_num` int(11) NOT NULL COMMENT '预计抽奖次数',
  `prizes_num` int(11) NOT NULL COMMENT '奖品数量',
  `prizes_winning_num` int(11) NOT NULL DEFAULT '0' COMMENT '已中奖奖品数量',
  `total_user_num` int(11) NOT NULL DEFAULT '0' COMMENT '抽奖总人数',
  `total_draw_num` int(11) NOT NULL DEFAULT '0' COMMENT '抽奖总次数',
  `drawn_num` int(11) NOT NULL DEFAULT '0' COMMENT '已抽数量',
  `pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图片',
  `description` text COLLATE utf8_bin COMMENT '说明',
  `no_winning_description` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '未中奖说明',
  `status` tinyint(4) NOT NULL COMMENT '状态(40:已启用,60:已禁用)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖活动';

-- ----------------------------
-- Table structure for lucky_draw_prizes
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_prizes`;
CREATE TABLE `lucky_draw_prizes` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `type` tinyint(4) NOT NULL COMMENT '奖品类型(1:实物奖品,2:虚拟奖品)',
  `name` varchar(50) COLLATE utf8_bin NOT NULL COMMENT '奖品名称',
  `num` int(11) NOT NULL COMMENT '数量',
  `winning_num` int(11) NOT NULL DEFAULT '0' COMMENT '已抽中数量',
  `winning_limit_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '个人中奖次数限制',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `lucky_draw_id` (`lucky_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖活动奖品';

-- ----------------------------
-- Table structure for lucky_draw_prizes_order
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_prizes_order`;
CREATE TABLE `lucky_draw_prizes_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `prizes_id` int(11) NOT NULL COMMENT '奖品ID',
  `type` tinyint(4) NOT NULL COMMENT '奖品类型(1:实物奖品,2:虚拟奖品)',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系人姓名',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系人手机号码',
  `contact_address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系人地址',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(60) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待确认,20:待兑换,30:已兑换,60:已作废)',
  `exchange_user_id` int(11) DEFAULT NULL COMMENT '兑换人ID',
  `exchange_time` datetime DEFAULT NULL COMMENT '兑换时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`),
  KEY `lucky_draw_id` (`lucky_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖中奖订单';

-- ----------------------------
-- Table structure for lucky_draw_record
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_record`;
CREATE TABLE `lucky_draw_record` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `draw_status` tinyint(4) NOT NULL COMMENT '抽奖状态(10:未中奖,20:中奖)',
  `prizes_id` int(11) NOT NULL DEFAULT '0' COMMENT '奖品ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `garage_id` (`garage_id`),
  KEY `lucky_draw_id` (`lucky_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖记录';

-- ----------------------------
-- Table structure for lucky_draw_roster
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_roster`;
CREATE TABLE `lucky_draw_roster` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `draw_num` smallint(6) NOT NULL COMMENT '抽奖次数',
  `drawn_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '已抽奖次数',
  `winning_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '中奖次数',
  `no_winning_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '未中奖次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `garage_id` (`garage_id`,`lucky_draw_id`),
  KEY `lucky_draw_id` (`lucky_draw_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖名单';

-- ----------------------------
-- Table structure for lucky_draw_roster_chance
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_roster_chance`;
CREATE TABLE `lucky_draw_roster_chance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `roster_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:促销活动)',
  `related_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  `num` int(11) NOT NULL COMMENT '次数',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:正常,60:已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `related_number` (`related_number`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖名单抽奖机会';

-- ----------------------------
-- Table structure for lucky_draw_roster_draw
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_roster_draw`;
CREATE TABLE `lucky_draw_roster_draw` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `draw_date` date NOT NULL COMMENT '抽奖日期',
  `num` smallint(6) NOT NULL COMMENT '抽奖次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lucky_draw_id` (`lucky_draw_id`,`garage_id`,`draw_date`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖名单抽奖';

-- ----------------------------
-- Table structure for lucky_draw_roster_prizes
-- ----------------------------
DROP TABLE IF EXISTS `lucky_draw_roster_prizes`;
CREATE TABLE `lucky_draw_roster_prizes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `lucky_draw_id` int(11) NOT NULL COMMENT '抽奖活动ID',
  `garage_id` int(11) NOT NULL COMMENT '汽修厂ID',
  `prizes_id` int(11) NOT NULL COMMENT '奖品ID',
  `quantity` smallint(6) NOT NULL COMMENT '数量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `lucky_draw_id` (`lucky_draw_id`,`garage_id`,`prizes_id`),
  KEY `garage_id` (`garage_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='抽奖名单奖品';

-- ----------------------------
-- Table structure for market_new_distribution_plan
-- ----------------------------
DROP TABLE IF EXISTS `market_new_distribution_plan`;
CREATE TABLE `market_new_distribution_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `expect_quantity` int(11) NOT NULL COMMENT '预计新增数量',
  `target_quantity` int(11) NOT NULL COMMENT '目标新增数量',
  `actual_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际新增数量',
  `time` varchar(7) COLLATE utf8_bin NOT NULL COMMENT '日期',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='月度新增门店计划';

-- ----------------------------
-- Table structure for market_new_distribution_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `market_new_distribution_plan_item`;
CREATE TABLE `market_new_distribution_plan_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL COMMENT '计划ID',
  `product_package_id` int(11) NOT NULL COMMENT '产品包ID',
  `expect_quantity` int(11) NOT NULL COMMENT '预计新增数量',
  `target_quantity` int(11) NOT NULL COMMENT '目标新增数量',
  `actual_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际新增数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plan_id` (`plan_id`,`product_package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='月度新增门店计划明细';

-- ----------------------------
-- Table structure for market_new_distribution_plan_log
-- ----------------------------
DROP TABLE IF EXISTS `market_new_distribution_plan_log`;
CREATE TABLE `market_new_distribution_plan_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL COMMENT '计划ID',
  `product_package_id` int(11) NOT NULL COMMENT '产品包ID, 0则为门店新增',
  `new_expect_quantity` int(11) NOT NULL COMMENT '新预计新增数量',
  `old_expect_quantity` int(11) NOT NULL COMMENT '旧预计新增数量',
  `new_target_quantity` int(11) NOT NULL COMMENT '新目标新增数量',
  `old_target_quantity` int(11) NOT NULL COMMENT '旧目标新增数量',
  `new_actual_quantity` int(11) NOT NULL COMMENT '新实际新增数量',
  `old_actual_quantity` int(11) NOT NULL COMMENT '旧实际新增数量',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '员工名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='月度新增门店计划日志';

-- ----------------------------
-- Table structure for market_sale_plan
-- ----------------------------
DROP TABLE IF EXISTS `market_sale_plan`;
CREATE TABLE `market_sale_plan` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `expect_quantity` int(11) NOT NULL COMMENT '预计促销SKU数',
  `expect_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '预计促销描述',
  `target_quantity` int(11) NOT NULL COMMENT '目标促销SKU数',
  `target_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '目标促销描述',
  `actual_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际促销SKU数',
  `actual_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '实际促销描述',
  `time` varchar(7) COLLATE utf8_bin NOT NULL COMMENT '日期',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计划描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='月度促销计划';

-- ----------------------------
-- Table structure for market_sale_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `market_sale_plan_item`;
CREATE TABLE `market_sale_plan_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL COMMENT '计划ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `expect_quantity` int(11) NOT NULL COMMENT '预计促销数量',
  `target_quantity` int(11) NOT NULL COMMENT '目标促销数量',
  `actual_quantity` int(11) NOT NULL COMMENT '实际促销数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plan_id` (`plan_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='月度促销计划明细';

-- ----------------------------
-- Table structure for market_sale_plan_log
-- ----------------------------
DROP TABLE IF EXISTS `market_sale_plan_log`;
CREATE TABLE `market_sale_plan_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `plan_id` int(11) NOT NULL COMMENT '计划ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `new_expect_quantity` int(11) NOT NULL COMMENT '新预计促销数量',
  `old_expect_quantity` int(11) NOT NULL COMMENT '旧预计促销数量',
  `new_target_quantity` int(11) NOT NULL COMMENT '新目标促销数量',
  `old_target_quantity` int(11) NOT NULL COMMENT '旧目标促销数量',
  `new_actual_quantity` int(11) NOT NULL COMMENT '新实际促销数量',
  `old_actual_quantity` int(11) NOT NULL COMMENT '旧实际促销数量',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '员工名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `plan_id` (`plan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='月度促销计划日志';

-- ----------------------------
-- Table structure for number_type
-- ----------------------------
DROP TABLE IF EXISTS `number_type`;
CREATE TABLE `number_type` (
  `id` int(11) NOT NULL COMMENT '编号类型ID',
  `key` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '类型KEY',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '类型名称',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='编号类型(行业码类型)';

-- ----------------------------
-- Table structure for ocgsc_code
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_code`;
CREATE TABLE `ocgsc_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:API 语言支持列表,2:物流服务,3:电池编号,4:产品证书类型,5:国家/地区编码对应,6:尺寸单位,7:重量单位,8:单位,9:产品标签)',
  `code` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `describe` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `status` tinyint(4) NOT NULL COMMENT '状态(50:正常,60:已禁用)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`,`code`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联编码';

-- ----------------------------
-- Table structure for ocgsc_interface_config
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_interface_config`;
CREATE TABLE `ocgsc_interface_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:CDC,2:eSC)',
  `url` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '接口地址',
  `account` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '账号',
  `secret_key` varchar(60) COLLATE utf8mb4_bin NOT NULL COMMENT '秘钥',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='接口地址配置';

-- ----------------------------
-- Table structure for ocgsc_product_change_history
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_product_change_history`;
CREATE TABLE `ocgsc_product_change_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL COMMENT '来源(1:产品变更单)',
  `related_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '相关ID',
  `content` text COLLATE utf8mb4_bin COMMENT '变更内容',
  `change_time` datetime NOT NULL COMMENT '变更时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品变更历史';

-- ----------------------------
-- Table structure for ocgsc_product_guide_price_adjust_history
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_product_guide_price_adjust_history`;
CREATE TABLE `ocgsc_product_guide_price_adjust_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:市场价)',
  `related_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '相关ID',
  `old_price` decimal(10,2) DEFAULT NULL COMMENT '原价格',
  `new_price` decimal(10,2) DEFAULT NULL COMMENT '新价格',
  `adjust_time` datetime NOT NULL COMMENT '调整时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品指导价调价历史';

-- ----------------------------
-- Table structure for ocgsc_remote_request
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_remote_request`;
CREATE TABLE `ocgsc_remote_request` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `serial_number` char(32) COLLATE utf8mb4_bin NOT NULL COMMENT '消息序列号',
  `type` smallint(6) NOT NULL COMMENT '类型',
  `related_id` varchar(60) COLLATE utf8mb4_bin NOT NULL COMMENT '相关ID',
  `params` text COLLATE utf8mb4_bin COMMENT '参数',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待处理,60:失败)',
  `code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '结果码',
  `message` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '结果信息',
  `fail_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '失败次数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `serial_number` (`serial_number`),
  KEY `related_id` (`related_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='远程请求';

-- ----------------------------
-- Table structure for ocgsc_remote_request_result
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_remote_request_result`;
CREATE TABLE `ocgsc_remote_request_result` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `serial_number` char(32) COLLATE utf8mb4_bin NOT NULL COMMENT '消息序列号',
  `type` smallint(6) NOT NULL COMMENT '类型',
  `related_id` varchar(60) COLLATE utf8mb4_bin NOT NULL COMMENT '相关ID',
  `params` text COLLATE utf8mb4_bin COMMENT '参数',
  `operate_type` tinyint(4) NOT NULL COMMENT '操作(10:成功,20:取消)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待处理,50:成功,90:失败)',
  `code` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '结果码',
  `message` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '结果信息',
  `fail_num` tinyint(4) NOT NULL DEFAULT '0' COMMENT '失败次数',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `serial_number` (`serial_number`),
  KEY `related_id` (`related_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='远程请求结果';

-- ----------------------------
-- Table structure for ocgsc_sku
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku`;
CREATE TABLE `ocgsc_sku` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `sku_id` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT 'skuId',
  `sku_code` char(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'sku编号',
  `spu_id` int(11) NOT NULL COMMENT 'spuID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `storehouse_id` int(11) NOT NULL DEFAULT '0' COMMENT '客户仓库ID',
  `advance_ratio_o2t` decimal(6,4) DEFAULT NULL COMMENT '预付比例',
  `logistics_length` decimal(10,2) NOT NULL COMMENT '物流包装：长(cm)',
  `logistics_width` decimal(10,2) NOT NULL COMMENT '物流包装：宽(cm) ',
  `logistics_height` decimal(10,2) NOT NULL COMMENT '物流包装：高(cm) ',
  `logistics_weight` decimal(10,2) NOT NULL COMMENT '物流包装：重量(g) ',
  `package_length` decimal(10,2) DEFAULT NULL COMMENT '长(cm)',
  `package_width` decimal(10,2) DEFAULT NULL COMMENT '宽(cm)',
  `package_height` decimal(10,2) DEFAULT NULL COMMENT '高(cm)',
  `package_weight` decimal(10,2) DEFAULT NULL COMMENT '重量(g)',
  `mpq` int(11) NOT NULL DEFAULT '1' COMMENT '最小包装量',
  `min_order_quantity` int(11) NOT NULL DEFAULT '1' COMMENT '最小起订量',
  `min_sale_quantity` int(11) NOT NULL DEFAULT '1' COMMENT '最小销售单位数量',
  `battery_flag` tinyint(4) NOT NULL COMMENT '是否带电(0:否,1:是)',
  `battery_type` int(11) NOT NULL DEFAULT '0' COMMENT '带电类型',
  `magnetic_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否带磁(0:否,1:是)',
  `gtin` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '全球贸易项目代码',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `sku_id` (`sku_id`),
  UNIQUE KEY `product_id` (`product_id`),
  KEY `spu_id` (`spu_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联sku';

-- ----------------------------
-- Table structure for ocgsc_sku_pic
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_pic`;
CREATE TABLE `ocgsc_sku_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `value` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联sku图片';

-- ----------------------------
-- Table structure for ocgsc_sku_price
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_price`;
CREATE TABLE `ocgsc_sku_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `price` decimal(10,2) NOT NULL COMMENT '价格(元)',
  `new_price` decimal(10,2) DEFAULT NULL COMMENT '新价格(元)',
  `new_price_effect_time` datetime DEFAULT NULL COMMENT '新价格生效时间',
  `lock_status` tinyint(4) NOT NULL COMMENT '锁定状态(30:无,50:锁定中)',
  `min_quantity` int(11) DEFAULT NULL COMMENT '数量下限',
  `new_min_quantity` int(11) DEFAULT NULL COMMENT '新数量下限',
  `max_quantity` int(11) DEFAULT NULL COMMENT '数量上限',
  `new_max_quantity` int(11) DEFAULT NULL COMMENT '新数量上限',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='sku价格';

-- ----------------------------
-- Table structure for ocgsc_sku_price_change_order
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_price_change_order`;
CREATE TABLE `ocgsc_sku_price_change_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(14) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '概要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU',
  `effect_time` datetime DEFAULT NULL COMMENT '生效日期',
  `status` tinyint(4) NOT NULL COMMENT '状态(20:待审核,40:待同步,50:已完成,60:已取消)',
  `success_num` int(11) NOT NULL COMMENT '成功数量',
  `fail_num` int(11) NOT NULL COMMENT '失败数量',
  `synchronize_result` tinyint(4) NOT NULL COMMENT '同步状态(10:未同步,20:部分失败,30:全部失败,40:全部成功)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='sku价格变更单';

-- ----------------------------
-- Table structure for ocgsc_sku_price_change_order_item
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_price_change_order_item`;
CREATE TABLE `ocgsc_sku_price_change_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '变更单ID',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `old_price` decimal(10,2) NOT NULL COMMENT '价格(元)',
  `old_new_price` decimal(10,2) DEFAULT NULL COMMENT '新价格(元)',
  `old_new_price_effect_time` datetime DEFAULT NULL COMMENT '新价格生效时间',
  `new_price` decimal(10,2) NOT NULL COMMENT '新价格(元)',
  `old_min_quantity` int(11) DEFAULT NULL COMMENT '原数量下限',
  `old_new_min_quantity` int(11) DEFAULT NULL COMMENT '原新数量下限',
  `new_min_quantity` int(11) DEFAULT NULL COMMENT '新数量下限',
  `old_max_quantity` int(11) DEFAULT NULL COMMENT '原数量上限',
  `old_new_max_quantity` int(11) DEFAULT NULL COMMENT '原新数量上限',
  `new_max_quantity` int(11) DEFAULT NULL COMMENT '新数量上限',
  `synchronize_status` tinyint(4) NOT NULL COMMENT '同步状态(10:未就绪,20:待同步,50:成功,60:失败)',
  `synchronize_result` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '同步结果',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='sku价格变更单明细';

-- ----------------------------
-- Table structure for ocgsc_sku_price_change_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_price_change_order_trace`;
CREATE TABLE `ocgsc_sku_price_change_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '变更单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL DEFAULT '1000' COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='sku价格变更单明细跟踪';

-- ----------------------------
-- Table structure for ocgsc_sku_price_log
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_price_log`;
CREATE TABLE `ocgsc_sku_price_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `old_price` decimal(10,2) NOT NULL COMMENT '原价格(元)',
  `old_new_price` decimal(10,2) NOT NULL COMMENT '原新价格(元)',
  `old_new_price_effect_time` datetime DEFAULT NULL COMMENT '原新价格生效时间',
  `new_price` decimal(10,2) NOT NULL COMMENT '新价格(元)',
  `old_min_quantity` int(11) DEFAULT NULL COMMENT '原数量下限',
  `old_new_min_quantity` int(11) DEFAULT NULL COMMENT '原新数量下限',
  `new_min_quantity` int(11) DEFAULT NULL COMMENT '新数量下限',
  `old_max_quantity` int(11) DEFAULT NULL COMMENT '原数量上限',
  `old_new_max_quantity` int(11) DEFAULT NULL COMMENT '原新数量上限',
  `new_max_quantity` int(11) DEFAULT NULL COMMENT '新数量上限',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='sku价格日志';

-- ----------------------------
-- Table structure for ocgsc_sku_specification
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_specification`;
CREATE TABLE `ocgsc_sku_specification` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `value` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '值',
  PRIMARY KEY (`id`),
  KEY `sku_id` (`sku_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='sku规格';

-- ----------------------------
-- Table structure for ocgsc_sku_stock_synchronize_order
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_stock_synchronize_order`;
CREATE TABLE `ocgsc_sku_stock_synchronize_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '概要',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待同步,50:已完成)',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='SKU库存同步单';

-- ----------------------------
-- Table structure for ocgsc_sku_stock_synchronize_order_item
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_stock_synchronize_order_item`;
CREATE TABLE `ocgsc_sku_stock_synchronize_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '同步单ID',
  `sku_id` int(11) NOT NULL COMMENT 'skuID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `operate_type` tinyint(4) NOT NULL COMMENT '操作类型(1:覆盖)',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `synchronize_result` tinyint(4) NOT NULL COMMENT '同步结果(10:未同步,20:部分失败,30:全部失败,40:全部成功)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='SKU库存同步单明细';

-- ----------------------------
-- Table structure for ocgsc_sku_stock_synchronize_order_item_stock
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_sku_stock_synchronize_order_item_stock`;
CREATE TABLE `ocgsc_sku_stock_synchronize_order_item_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` bigint(20) NOT NULL COMMENT '同步单明细ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `result` tinyint(4) NOT NULL COMMENT '结果(10:未同步,50:成功,80:失败)',
  `result_msg` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '结果描述',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='SKU库存同步单明细库存';

-- ----------------------------
-- Table structure for ocgsc_spu
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu`;
CREATE TABLE `ocgsc_spu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(14) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `spu_id` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT 'spuId',
  `spu_code` char(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT 'spu编号',
  `name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `category_id` int(11) NOT NULL COMMENT '分类ID',
  `brand_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '品牌',
  `unit_id` int(11) DEFAULT NULL COMMENT '单位ID',
  `produce_model` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '生产型号',
  `hs_code` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '海关编号',
  `min_handling_time` smallint(6) NOT NULL COMMENT '最小交付日期，自然日',
  `max_handling_time` smallint(6) NOT NULL COMMENT '最大交付日期，自然日',
  `handling_mode` tinyint(4) NOT NULL DEFAULT '1' COMMENT '交付模式(5:现货交付,10:生产交付)',
  `credit_term` tinyint(4) NOT NULL DEFAULT '0' COMMENT '账期(1:全款支付,5:30天账期,10:60天账期)',
  `describe` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '描述',
  `detail` varchar(500) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '详情',
  `status` tinyint(4) NOT NULL COMMENT '状态(50:已上架,80:已下架)',
  `lats_synchronize_time` datetime DEFAULT NULL COMMENT '最后一次同步时间',
  `publish_time` datetime NOT NULL COMMENT '刊登时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  UNIQUE KEY `spu_id` (`spu_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联SPU';

-- ----------------------------
-- Table structure for ocgsc_spu_attribute
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_attribute`;
CREATE TABLE `ocgsc_spu_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `spu_id` int(11) NOT NULL COMMENT 'spuID',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `value` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '值',
  `sort` smallint(6) NOT NULL DEFAULT '1000' COMMENT '排序',
  PRIMARY KEY (`id`),
  KEY `spu_id` (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联SPU属性';

-- ----------------------------
-- Table structure for ocgsc_spu_category
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_category`;
CREATE TABLE `ocgsc_spu_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `catalog_name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '目录名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(50:正常,60:已禁用)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='spu分类';

-- ----------------------------
-- Table structure for ocgsc_spu_category_product_category
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_category_product_category`;
CREATE TABLE `ocgsc_spu_category_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `category_id` int(11) NOT NULL COMMENT '橙联产品分类ID',
  `product_category_id` int(11) NOT NULL COMMENT '产品分类ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_category_id` (`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品橙联分类产品分类';

-- ----------------------------
-- Table structure for ocgsc_spu_certification
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_certification`;
CREATE TABLE `ocgsc_spu_certification` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `spu_id` int(11) NOT NULL COMMENT 'spuID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:CE,2:MSDS,3:质量检测报告,4:航运鉴别报告书,5:海运鉴别报告书,6:FDA,7:DOT,8:FCC,100:其他)',
  `attachment` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '附件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `spu_id` (`spu_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='SPU资质信息';

-- ----------------------------
-- Table structure for ocgsc_spu_log
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_log`;
CREATE TABLE `ocgsc_spu_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `spu_id` int(11) NOT NULL COMMENT 'spuID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:上架,10:下架,15:信息修改)',
  `user_type` smallint(6) NOT NULL COMMENT '用户类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `spu_id` (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联SPU日志';

-- ----------------------------
-- Table structure for ocgsc_spu_publish
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_publish`;
CREATE TABLE `ocgsc_spu_publish` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `data` text COLLATE utf8mb4_bin COMMENT '数据',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '创建人名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待刊登,15:刊登中,20:刊登失败,50:已完成)',
  `result` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '结果',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='spu刊登';

-- ----------------------------
-- Table structure for ocgsc_spu_tag
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_tag`;
CREATE TABLE `ocgsc_spu_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `spu_id` int(11) NOT NULL COMMENT 'spuID',
  `tag_id` int(11) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`),
  KEY `spu_id` (`spu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='橙联SPU标签';

-- ----------------------------
-- Table structure for ocgsc_spu_unit_product_unit
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_spu_unit_product_unit`;
CREATE TABLE `ocgsc_spu_unit_product_unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `unit_id` int(11) NOT NULL COMMENT '单位ID',
  `product_unit_id` int(11) NOT NULL COMMENT '产品单位ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_unit_id` (`product_unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品spu单位产品单位';

-- ----------------------------
-- Table structure for ocgsc_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_storehouse`;
CREATE TABLE `ocgsc_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:代发仓,10:前置仓)',
  `status` tinyint(4) NOT NULL COMMENT '状态(50:正常,60:已禁用)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='客户仓库';

-- ----------------------------
-- Table structure for ocgsc_storehouse_delivery_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `ocgsc_storehouse_delivery_storehouse`;
CREATE TABLE `ocgsc_storehouse_delivery_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `storehouse_id` int(11) NOT NULL COMMENT '客户仓库ID',
  `delivery_storehouse_id` int(11) NOT NULL COMMENT '发货仓库ID',
  `priority` tinyint(4) NOT NULL DEFAULT '100' COMMENT '优先级',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`delivery_storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='客户仓库发货仓';

-- ----------------------------
-- Table structure for offline_deduct_method
-- ----------------------------
DROP TABLE IF EXISTS `offline_deduct_method`;
CREATE TABLE `offline_deduct_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '付款方式ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '付款方式名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(1有效，0无效)',
  `account_item_type_id` int(11) NOT NULL COMMENT '账目类型ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下扣款方式';

-- ----------------------------
-- Table structure for offline_deduct_order
-- ----------------------------
DROP TABLE IF EXISTS `offline_deduct_order`;
CREATE TABLE `offline_deduct_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `method_id` int(11) NOT NULL COMMENT '扣款方式',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` tinyint(4) NOT NULL COMMENT '状态(10待审核、20审核通过、30审核不通过)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `voucher_number` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证号',
  `voucher_pic` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证图片路径',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下扣款订单';

-- ----------------------------
-- Table structure for offline_deduct_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `offline_deduct_order_trace`;
CREATE TABLE `offline_deduct_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下扣款订单跟踪';

-- ----------------------------
-- Table structure for offline_payment_method
-- ----------------------------
DROP TABLE IF EXISTS `offline_payment_method`;
CREATE TABLE `offline_payment_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '付款方式ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '付款方式名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `account_item_type_id` int(11) NOT NULL COMMENT '账目类型ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下支付方式';

-- ----------------------------
-- Table structure for offline_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `offline_payment_order`;
CREATE TABLE `offline_payment_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `method_id` int(11) NOT NULL COMMENT '支付方式',
  `sub_method_id` int(11) NOT NULL DEFAULT '0' COMMENT '子支付方式ID',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待审核、1100审核通过、2000审核不通过)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '汇款人姓名',
  `voucher_number` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证号(银行交易号、支票号等)',
  `voucher_pic` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证图片路径',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下支付订单(大表)';

-- ----------------------------
-- Table structure for offline_payment_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `offline_payment_order_trace`;
CREATE TABLE `offline_payment_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下支付订单跟踪(大表)';

-- ----------------------------
-- Table structure for offline_payment_sub_method
-- ----------------------------
DROP TABLE IF EXISTS `offline_payment_sub_method`;
CREATE TABLE `offline_payment_sub_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `method_id` int(11) NOT NULL COMMENT '支付方式ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(10开启，20关闭)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='线下支付子方式';

-- ----------------------------
-- Table structure for old_channel_product_channel_price
-- ----------------------------
DROP TABLE IF EXISTS `old_channel_product_channel_price`;
CREATE TABLE `old_channel_product_channel_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '渠道商等级',
  `price` decimal(8,2) NOT NULL COMMENT '渠道价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`level`)
) ENGINE=InnoDB AUTO_INCREMENT=222047 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='渠道产品价格';

-- ----------------------------
-- Table structure for old_channel_product_channel_price_log
-- ----------------------------
DROP TABLE IF EXISTS `old_channel_product_channel_price_log`;
CREATE TABLE `old_channel_product_channel_price_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `level` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '渠道商等级',
  `old_price` decimal(8,2) DEFAULT NULL COMMENT '原渠道价(元)',
  `new_price` decimal(8,2) NOT NULL COMMENT '新渠道价(元)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=347522 DEFAULT CHARSET=utf8 COMMENT='渠道价价格日志';

-- ----------------------------
-- Table structure for online_payment_method
-- ----------------------------
DROP TABLE IF EXISTS `online_payment_method`;
CREATE TABLE `online_payment_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '支付方式ID',
  `short_name` varchar(16) COLLATE utf8_bin NOT NULL COMMENT '简称',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `account_item_type_id` int(11) NOT NULL COMMENT '账目类型ID',
  `orderby` int(11) NOT NULL COMMENT '排序',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='在线支付方式';

-- ----------------------------
-- Table structure for online_payment_order
-- ----------------------------
DROP TABLE IF EXISTS `online_payment_order`;
CREATE TABLE `online_payment_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `method_id` int(11) NOT NULL COMMENT '支付方式ID',
  `type` smallint(6) NOT NULL COMMENT '业务类型(1000充值，2000补货)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '关联单号',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待支付，1100支付成功，2000支付失败)',
  `create_time` datetime NOT NULL COMMENT '提交时间',
  `return_time` datetime DEFAULT NULL COMMENT '返回时间',
  `return_ip` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网关服务器IP',
  `trade_no` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网关交易号',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注，失败时记录网关返回的信息',
  `business_entity_id` int(11) NOT NULL DEFAULT '0' COMMENT '营业主体ID',
  `success_trade_number` varchar(128) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '成功交易单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `account_id` (`account_id`),
  KEY `create_time` (`create_time`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='在线支付订单(大表)';

-- ----------------------------
-- Table structure for online_payment_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `online_payment_order_trace`;
CREATE TABLE `online_payment_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='在线支付订单跟踪';

-- ----------------------------
-- Table structure for option
-- ----------------------------
DROP TABLE IF EXISTS `option`;
CREATE TABLE `option` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(0负面，1正面)',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `status` tinyint(4) NOT NULL COMMENT '类型(0关闭，1启用)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='评价选项';

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `status` smallint(6) NOT NULL COMMENT '订单状态(11000待付款，13000待受理，15000待收货，19000已完成，20000已取消，21000已作废)',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '下单用户ID',
  `customer_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户名称',
  `customer_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户联系人姓名',
  `customer_address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户收货地址',
  `customer_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户联系电话',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `distribution_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '接单用户ID',
  `distribution_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '加盟商名称',
  `distribution_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '加盟商联系人姓名',
  `distribution_address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '加盟商地址',
  `distribution_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '加盟商联系电话',
  `payment_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '付款状态(0待付款，10已付款)',
  `payment_method` smallint(6) NOT NULL DEFAULT '0' COMMENT '支付方式(10000现金付款，10100其它，11000月结，12000铺货)',
  `payment_method_initial` tinyint(4) NOT NULL DEFAULT '0' COMMENT '付款方式(0待付款，1现付，2货到付款，3POS机付款)',
  `review_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '评价状态(0未评价，1已评价)',
  `quotation_status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '报价状态(0待报价，1已报价)',
  `channel` tinyint(4) NOT NULL DEFAULT '0' COMMENT '开单渠道(0未指定，1服务商系统PC端，2服务商系统APP端，3服务商系统POS机，11快修保PC，12快修保APP)',
  `order_type` smallint(6) NOT NULL DEFAULT '0' COMMENT '订单类型(0:普通,5:活动订单)',
  `related_number` varchar(30) COLLATE utf8_bin DEFAULT '' COMMENT '相关单号',
  `stock_source` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '库存来源',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `order_date` date NOT NULL COMMENT '下单日期',
  `activity_discount` decimal(3,2) DEFAULT NULL COMMENT '活动折扣',
  `order_discount` decimal(8,2) DEFAULT NULL COMMENT '整单优惠金额',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `billing_type` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '开单类型:10销售,20退货',
  `return_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '退货原因(1、开错单;2、修理厂不收货;3、产品质量原因;4、产品在修理厂端未销售;5、订单未送货;6、其他)',
  `other_return_reason` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '其他原因描述',
  `original_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '原始订单号',
  `payment_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '付款单号',
  `related_order_type` tinyint(4) DEFAULT NULL,
  `bargain_total_price` decimal(12,2) NOT NULL COMMENT '成交总价(元)',
  `print_total_price` decimal(12,2) NOT NULL COMMENT '打印总价(元)',
  `garage_total_price` decimal(12,2) NOT NULL COMMENT '修理厂展示总价(元)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `customer_id` (`customer_id`),
  KEY `order_date` (`order_date`,`status`),
  KEY `create_time` (`create_time`,`status`),
  KEY `distribution_id` (`distribution_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单(大表)';

-- ----------------------------
-- Table structure for order_coupon
-- ----------------------------
DROP TABLE IF EXISTS `order_coupon`;
CREATE TABLE `order_coupon` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT 'id',
  `coupon_id` bigint(20) NOT NULL COMMENT '优惠券ID',
  `discount_amount` decimal(12,2) NOT NULL COMMENT '优惠金额',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单优惠券表';

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `product_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品描述',
  `join_unit_price` decimal(8,2) NOT NULL COMMENT '加盟单价(元)',
  `sale_unit_price` decimal(8,2) NOT NULL COMMENT '销售单价(元)',
  `bargain_unit_price` decimal(8,2) NOT NULL COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL COMMENT '成交总价(元)',
  `print_unit_price` decimal(8,2) NOT NULL COMMENT '打印单价(元)',
  `print_total_price` decimal(10,2) NOT NULL COMMENT '打印总价(元)',
  `garage_unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '修理厂单价(元)',
  `garage_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '修理厂总价(元)',
  `note` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`,`distribution_id`,`customer_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=224 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单行(大表)';

-- ----------------------------
-- Table structure for order_item_service_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item_service_item`;
CREATE TABLE `order_item_service_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `service_item_category_id` int(11) NOT NULL COMMENT '项目分类ID',
  `service_item_category_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '项目分类名称',
  `service_item_id` int(11) NOT NULL COMMENT '项目ID',
  `service_item_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '项目名称',
  `service_item_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '项目编号',
  `service_item_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL COMMENT '项目单位',
  `guide_price` decimal(8,2) NOT NULL COMMENT '指导单价(元)',
  `bargain_unit_price` decimal(8,2) NOT NULL COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL COMMENT '成交总价(元)',
  `print_unit_price` decimal(8,2) NOT NULL COMMENT '打印单价(元)',
  `print_total_price` decimal(10,2) NOT NULL COMMENT '打印总价(元)',
  `garage_unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '修理厂展示单价(元)',
  `garage_total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '修理厂展示总价(元)',
  `note` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='服务项目订单行(大表)';

-- ----------------------------
-- Table structure for order_item_third
-- ----------------------------
DROP TABLE IF EXISTS `order_item_third`;
CREATE TABLE `order_item_third` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `join_unit_price` decimal(8,2) DEFAULT NULL COMMENT '加盟单价(元)',
  `sale_unit_price` decimal(8,2) DEFAULT NULL COMMENT '销售单价(元)',
  `bargain_unit_price` decimal(8,2) NOT NULL COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL COMMENT '成交总价(元)',
  `print_unit_price` decimal(8,2) NOT NULL COMMENT '打印单价(元)',
  `print_total_price` decimal(10,2) NOT NULL COMMENT '打印总价(元)',
  `note` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `garage_order_id` (`order_id`),
  KEY `product_id` (`product_id`,`distribution_id`,`customer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='第三方产品订单行(大表)';

-- ----------------------------
-- Table structure for order_trace
-- ----------------------------
DROP TABLE IF EXISTS `order_trace`;
CREATE TABLE `order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=632 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='订单跟踪(大表)';

-- ----------------------------
-- Table structure for outstock_chargeback_order
-- ----------------------------
DROP TABLE IF EXISTS `outstock_chargeback_order`;
CREATE TABLE `outstock_chargeback_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `outstock_order_id` int(11) NOT NULL COMMENT '出库单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待上架,20:已完成)',
  `allocate_task` tinyint(4) NOT NULL COMMENT '任务分配(10:未分配,20:已分配)',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '员工姓名',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库退单表';

-- ----------------------------
-- Table structure for outstock_chargeback_order_item
-- ----------------------------
DROP TABLE IF EXISTS `outstock_chargeback_order_item`;
CREATE TABLE `outstock_chargeback_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '出库退单id',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待上架,10:已上架)',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库退单明细表';

-- ----------------------------
-- Table structure for outstock_chargeback_order_putaway
-- ----------------------------
DROP TABLE IF EXISTS `outstock_chargeback_order_putaway`;
CREATE TABLE `outstock_chargeback_order_putaway` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `item_id` int(11) NOT NULL COMMENT '出库退单明细ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位名称',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库退单上架表';

-- ----------------------------
-- Table structure for outstock_chargeback_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `outstock_chargeback_order_trace`;
CREATE TABLE `outstock_chargeback_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '出库退单表ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库退单表日志';

-- ----------------------------
-- Table structure for outstock_order
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order`;
CREATE TABLE `outstock_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '出库单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000采购，1100调仓，1200配送)',
  `priority` tinyint(4) NOT NULL DEFAULT '10' COMMENT '优先级(1-10)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号(采购退货单、调拨单、加盟商补货单)',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待打印，10100待出库，10200已出库，10300已收货，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `delivery_date` date DEFAULT NULL COMMENT '发货日期',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '1' COMMENT '物流支付方式',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数量',
  `total_quantity` int(11) NOT NULL COMMENT '数量',
  `total_price` decimal(12,4) DEFAULT NULL COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单(大表)';

-- ----------------------------
-- Table structure for outstock_order_allocate_item
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_allocate_item`;
CREATE TABLE `outstock_order_allocate_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `item_id` bigint(20) NOT NULL COMMENT '出库单行ID',
  `quantity` int(11) NOT NULL COMMENT '分配数量',
  `picked_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '已拣货数量',
  `shortage_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '缺货数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位编号',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单分配行(大表)';

-- ----------------------------
-- Table structure for outstock_order_allocate_item_bak_20190726
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_allocate_item_bak_20190726`;
CREATE TABLE `outstock_order_allocate_item_bak_20190726` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `item_id` bigint(20) NOT NULL COMMENT '出库单行ID',
  `quantity` int(11) NOT NULL COMMENT '分配数量',
  `picked_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '已拣货数量',
  `shortage_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '缺货数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '库位编号'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for outstock_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_contact`;
CREATE TABLE `outstock_order_contact` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1收货人)',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '收货地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `outstock_order_contact_name` (`name`),
  KEY `outstock_order_contact_contact_name` (`contact_name`),
  KEY `outstock_order_contact_contact_tel` (`contact_tel`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单收货人(大表)';

-- ----------------------------
-- Table structure for outstock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_item`;
CREATE TABLE `outstock_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(10,4) DEFAULT NULL COMMENT '单价(元)',
  `total_price` decimal(12,4) DEFAULT NULL COMMENT '总价(元)',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际出库数量',
  `shortage_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '缺货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单行(大表)';

-- ----------------------------
-- Table structure for outstock_order_item_bak_20190919
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_item_bak_20190919`;
CREATE TABLE `outstock_order_item_bak_20190919` (
  `id` bigint(20) NOT NULL DEFAULT '0' COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(10,4) DEFAULT NULL COMMENT '单价(元)',
  `total_price` decimal(12,4) DEFAULT NULL COMMENT '总价(元)',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际出库数量',
  `shortage_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '缺货数量'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for outstock_order_pack_box
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_pack_box`;
CREATE TABLE `outstock_order_pack_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '出库单ID',
  `box_id` int(11) NOT NULL COMMENT '箱号ID',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `box_id` (`box_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单装箱表';

-- ----------------------------
-- Table structure for outstock_order_pack_box_sequence
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_pack_box_sequence`;
CREATE TABLE `outstock_order_pack_box_sequence` (
  `order_id` int(11) NOT NULL COMMENT '出库单ID',
  `box_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '箱数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单打包箱数序列表';

-- ----------------------------
-- Table structure for outstock_order_pack_item
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_pack_item`;
CREATE TABLE `outstock_order_pack_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `item_id` bigint(20) NOT NULL COMMENT '出库单行ID',
  `quantity` int(11) NOT NULL COMMENT '装箱数量',
  `box_number` varchar(15) COLLATE utf8_bin NOT NULL COMMENT '箱号',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`),
  KEY `box_number` (`box_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单装箱行(大表)';

-- ----------------------------
-- Table structure for outstock_order_pre_allocate_item
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_pre_allocate_item`;
CREATE TABLE `outstock_order_pre_allocate_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `lock_order_id` bigint(20) NOT NULL COMMENT '锁定单ID',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `lock_order_id` (`lock_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单预分配行(大表)';

-- ----------------------------
-- Table structure for outstock_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `outstock_order_trace`;
CREATE TABLE `outstock_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='出库单跟踪(大表)';

-- ----------------------------
-- Table structure for pack_order
-- ----------------------------
DROP TABLE IF EXISTS `pack_order`;
CREATE TABLE `pack_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '打包单号',
  `outstock_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待打包，11000已打包，20000已取消)',
  `is_review` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否复核（0:否，1:是）',
  `review_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '复核员工ID',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '打包员工ID',
  `box_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '箱数',
  `actual_box_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '实际箱数',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `start_time` datetime DEFAULT NULL COMMENT '开始打包时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `outstock_id` (`outstock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='打包单(大表)';

-- ----------------------------
-- Table structure for pack_order_review_voucher
-- ----------------------------
DROP TABLE IF EXISTS `pack_order_review_voucher`;
CREATE TABLE `pack_order_review_voucher` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '打包单ID',
  `attachment` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '附件',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='打包复核凭证表';

-- ----------------------------
-- Table structure for pack_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `pack_order_trace`;
CREATE TABLE `pack_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='打包单跟踪(大表)';

-- ----------------------------
-- Table structure for pack_platform
-- ----------------------------
DROP TABLE IF EXISTS `pack_platform`;
CREATE TABLE `pack_platform` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `zone_id` int(11) NOT NULL COMMENT '打包区ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `name` varchar(30) NOT NULL COMMENT '打包台编号',
  `describe` varchar(100) NOT NULL COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`name`),
  KEY `zone_id` (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='打包台';

-- ----------------------------
-- Table structure for pack_staging_zone
-- ----------------------------
DROP TABLE IF EXISTS `pack_staging_zone`;
CREATE TABLE `pack_staging_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `zone_id` int(11) NOT NULL COMMENT '打包区ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `name` varchar(30) NOT NULL COMMENT '打包暂存区编号',
  `order_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '单据数量',
  `describe` varchar(100) NOT NULL COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`name`),
  KEY `zone_id` (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='打包暂存区';

-- ----------------------------
-- Table structure for pack_storage
-- ----------------------------
DROP TABLE IF EXISTS `pack_storage`;
CREATE TABLE `pack_storage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `staging_zone_id` int(11) NOT NULL COMMENT '打包暂存区id',
  `outstock_id` int(11) NOT NULL COMMENT '出库单ID',
  `cart_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '车数',
  `pick_status` tinyint(4) NOT NULL COMMENT '拣货状态(10:拣货中,20:已完毕)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `staging_zone_id` (`staging_zone_id`,`outstock_id`),
  KEY `outstock_id` (`outstock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='打包暂存';

-- ----------------------------
-- Table structure for pack_zone
-- ----------------------------
DROP TABLE IF EXISTS `pack_zone`;
CREATE TABLE `pack_zone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `name` varchar(30) NOT NULL COMMENT '打包区编号',
  `priority` smallint(6) NOT NULL COMMENT '优先级',
  `describe` varchar(100) NOT NULL COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='打包区';

-- ----------------------------
-- Table structure for packing_box
-- ----------------------------
DROP TABLE IF EXISTS `packing_box`;
CREATE TABLE `packing_box` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` varchar(15) COLLATE utf8_bin NOT NULL COMMENT '箱号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `sku` smallint(6) NOT NULL COMMENT 'SKU数',
  `quantity` smallint(6) NOT NULL COMMENT '总数量',
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `start_time` datetime DEFAULT NULL COMMENT '打包开始时间',
  `end_time` datetime DEFAULT NULL COMMENT '打包结束时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='包装箱表';

-- ----------------------------
-- Table structure for partner
-- ----------------------------
DROP TABLE IF EXISTS `partner`;
CREATE TABLE `partner` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '详细地址',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系电话',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100冻结，9000已删除)',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`),
  KEY `district_id` (`district_id`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合作伙伴';

-- ----------------------------
-- Table structure for partner_region
-- ----------------------------
DROP TABLE IF EXISTS `partner_region`;
CREATE TABLE `partner_region` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `partner_id` int(11) NOT NULL COMMENT '合作伙伴ID',
  `region_level` tinyint(4) NOT NULL COMMENT '区域级别(1省份、直辖市，2市，3区/县)',
  `region_id` int(11) NOT NULL COMMENT '区域ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `partner_id` (`partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合作伙伴区域';

-- ----------------------------
-- Table structure for partner_section
-- ----------------------------
DROP TABLE IF EXISTS `partner_section`;
CREATE TABLE `partner_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(64) COLLATE utf8mb4_bin NOT NULL COMMENT '片区名称',
  `partner_id` int(11) NOT NULL DEFAULT '0' COMMENT '运营中心ID',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `user_type` smallint(6) NOT NULL DEFAULT '0' COMMENT '创建人类型',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `partner_id` (`partner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='运营中心片区';

-- ----------------------------
-- Table structure for partner_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `partner_storehouse`;
CREATE TABLE `partner_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `partner_id` int(11) NOT NULL COMMENT '合作伙伴ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `store_requisition` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有领用权限(0无，1有)',
  `allocation` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有调拨权限(0无，1有)',
  `arrival` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否有到货权限(0无，1有)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `partner_id` (`partner_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合作伙伴仓库';

-- ----------------------------
-- Table structure for partner_user
-- ----------------------------
DROP TABLE IF EXISTS `partner_user`;
CREATE TABLE `partner_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `partner_id` int(11) NOT NULL COMMENT '合作伙伴ID',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password_hash` char(60) COLLATE utf8_bin NOT NULL COMMENT '登录密码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100冻结，9000已注销)',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `partner_id` (`partner_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='合作伙伴用户';

-- ----------------------------
-- Table structure for parts
-- ----------------------------
DROP TABLE IF EXISTS `parts`;
CREATE TABLE `parts` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `pic` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图片',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2053 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='配件';

-- ----------------------------
-- Table structure for parts_attribute
-- ----------------------------
DROP TABLE IF EXISTS `parts_attribute`;
CREATE TABLE `parts_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `parts_id` int(11) NOT NULL COMMENT '配件ID',
  `specification_id` int(11) NOT NULL COMMENT '属性规格ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `value` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '属性值',
  PRIMARY KEY (`id`),
  KEY `parts_id` (`parts_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4449 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='配件属性';

-- ----------------------------
-- Table structure for parts_car_style
-- ----------------------------
DROP TABLE IF EXISTS `parts_car_style`;
CREATE TABLE `parts_car_style` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `parts_id` int(11) NOT NULL COMMENT '配件ID',
  `car_style_id` int(11) NOT NULL COMMENT '车型ID',
  `ext_condition` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '扩展条件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parts_id` (`parts_id`),
  KEY `car_style_id` (`car_style_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17912 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='配件适配车型';

-- ----------------------------
-- Table structure for parts_number
-- ----------------------------
DROP TABLE IF EXISTS `parts_number`;
CREATE TABLE `parts_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `parts_id` int(11) NOT NULL COMMENT '配件ID',
  `type_id` int(11) NOT NULL COMMENT '类型ID',
  `number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '编号',
  PRIMARY KEY (`id`),
  KEY `parts_id` (`parts_id`),
  KEY `number` (`number`)
) ENGINE=InnoDB AUTO_INCREMENT=7344 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='配件行业码';

-- ----------------------------
-- Table structure for pending_purchase_list
-- ----------------------------
DROP TABLE IF EXISTS `pending_purchase_list`;
CREATE TABLE `pending_purchase_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='待采购清单';

-- ----------------------------
-- Table structure for picc_category
-- ----------------------------
DROP TABLE IF EXISTS `picc_category`;
CREATE TABLE `picc_category` (
  `id` int(11) NOT NULL COMMENT '品类ID',
  `name` varchar(20) NOT NULL COMMENT '品类名称',
  `supplier` varchar(20) NOT NULL COMMENT '供应商',
  `place` varchar(20) NOT NULL COMMENT '产地',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人保产品责任险品类';

-- ----------------------------
-- Table structure for picc_product_category
-- ----------------------------
DROP TABLE IF EXISTS `picc_product_category`;
CREATE TABLE `picc_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `picc_category_id` int(11) NOT NULL COMMENT '人保品类ID',
  `product_category_id` int(11) NOT NULL COMMENT '三头六臂品类ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `picc_category_id` (`picc_category_id`,`product_category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='人保产品责任险品类对应三头六臂品类';

-- ----------------------------
-- Table structure for picking_order
-- ----------------------------
DROP TABLE IF EXISTS `picking_order`;
CREATE TABLE `picking_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '捡货单号',
  `outstock_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待分拣，11000已分拣，20000已取消)',
  `is_allocated_task` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否已分配任务(0:未分配,1:已分配)',
  `allocated_task_time` datetime DEFAULT NULL COMMENT '生成任务时间',
  `print_times` smallint(6) NOT NULL COMMENT '打印次数',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '分拣员工ID',
  `process_version` tinyint(4) NOT NULL DEFAULT '0' COMMENT '流程版本',
  `task_label_print` tinyint(4) NOT NULL DEFAULT '0' COMMENT '任务标签打印',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `outstock_id` (`outstock_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='捡货单(大表)';

-- ----------------------------
-- Table structure for picking_order_item
-- ----------------------------
DROP TABLE IF EXISTS `picking_order_item`;
CREATE TABLE `picking_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '拣货货单id',
  `allocate_item_id` int(11) NOT NULL COMMENT '分配行ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '拣货数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='拣货明细表(大表)';

-- ----------------------------
-- Table structure for picking_order_storage
-- ----------------------------
DROP TABLE IF EXISTS `picking_order_storage`;
CREATE TABLE `picking_order_storage` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '拣货单ID',
  `cart_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '车数',
  `pack_zone_id` int(11) NOT NULL COMMENT '打包区ID',
  `pack_staging_zone_id` int(11) NOT NULL DEFAULT '0' COMMENT '打包暂存区ID',
  `user_id` int(11) NOT NULL COMMENT '拣货员',
  `related_number` varchar(20) NOT NULL DEFAULT '' COMMENT '相关单号',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待指定,30:已存放,70:已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `create_time` (`create_time`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='拣货单产品存放';

-- ----------------------------
-- Table structure for picking_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `picking_order_trace`;
CREATE TABLE `picking_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='捡货单跟踪(大表)';

-- ----------------------------
-- Table structure for pooul
-- ----------------------------
DROP TABLE IF EXISTS `pooul`;
CREATE TABLE `pooul` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `account_type` tinyint(1) unsigned NOT NULL COMMENT '账户类型',
  `merchant_id` varchar(30) NOT NULL COMMENT '商户编号',
  `fund_acc_name` varchar(64) NOT NULL COMMENT '民生子账簿户名',
  `fund_acc` varchar(30) NOT NULL COMMENT '民生子账簿账号',
  `license_type` tinyint(4) NOT NULL COMMENT '营业类型',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `short_name` varchar(64) NOT NULL COMMENT '商户简称',
  `company_name` varchar(64) NOT NULL DEFAULT '' COMMENT '企业名称',
  `identifier` varchar(18) NOT NULL DEFAULT '' COMMENT '统一社会信用代码',
  `status` tinyint(4) NOT NULL COMMENT '状态(1正常)',
  `note` varchar(255) DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `account_id` (`account_id`),
  KEY `merchant_id` (`merchant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='民生分销易帐号';

-- ----------------------------
-- Table structure for pooul_merchants_account
-- ----------------------------
DROP TABLE IF EXISTS `pooul_merchants_account`;
CREATE TABLE `pooul_merchants_account` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `merchant_id` varchar(30) NOT NULL COMMENT '商户编号',
  `fund_acc_name` varchar(64) NOT NULL COMMENT '民生子账簿户名',
  `fund_acc` varchar(30) NOT NULL COMMENT '民生子账簿账号',
  `license_type` tinyint(4) NOT NULL COMMENT '营业类型',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `short_name` varchar(64) NOT NULL COMMENT '商户简称',
  `company_name` varchar(64) NOT NULL DEFAULT '' COMMENT '企业名称',
  `identifier` varchar(18) NOT NULL DEFAULT '' COMMENT '统一社会信用代码',
  `status` tinyint(4) NOT NULL COMMENT '状态(1正常)',
  `extern_authentication_claim` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '外部认证要求(10表示需要认证,20表示不需要)',
  `is_need_authentication` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '是否需要认证(10表示需要,20表示不需要)',
  `note` varchar(255) DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `account_id` int(11) NOT NULL DEFAULT '0' COMMENT '账号ID',
  PRIMARY KEY (`id`),
  KEY `merchant_id` (`merchant_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='服务商民生分销易帐号';

-- ----------------------------
-- Table structure for process_order
-- ----------------------------
DROP TABLE IF EXISTS `process_order`;
CREATE TABLE `process_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:换盒)',
  `order_source` tinyint(4) NOT NULL COMMENT '订单来源(5:质检单)',
  `related_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '相关单号',
  `instock_order_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '入库单号',
  `total_sku` smallint(6) NOT NULL COMMENT 'sku数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待处理,20:部分处理,50:已完成)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `additional_note` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '附加信息',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加工单';

-- ----------------------------
-- Table structure for process_order_item
-- ----------------------------
DROP TABLE IF EXISTS `process_order_item`;
CREATE TABLE `process_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '加工单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `batch_id` int(11) NOT NULL COMMENT '批次ID',
  `batch_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '批次号',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '库位名称',
  `handled_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '已处理数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加工单明细';

-- ----------------------------
-- Table structure for process_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `process_order_trace`;
CREATE TABLE `process_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '加工单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加工单跟踪';

-- ----------------------------
-- Table structure for producer_event
-- ----------------------------
DROP TABLE IF EXISTS `producer_event`;
CREATE TABLE `producer_event` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `queue` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '投递队列',
  `type` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '事件类型',
  `key` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '关键字',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态(0未发送，1已发送)',
  `payload` varchar(1000) COLLATE utf8_bin NOT NULL COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='生产者事件';

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '供应商编号',
  `barcode` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '条码',
  `name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `category_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '品类名称',
  `brand_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '品牌名称',
  `sale_goods` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否销售品(0否，1是)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已入库，1100已上架，2200已停产，2300已下架，9000已删除)',
  `unit_id` int(11) NOT NULL COMMENT '计量单位ID',
  `unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `package_size` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '包装规格',
  `pic` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品图片',
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品描述',
  `abc` char(2) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT 'C' COMMENT 'ABC分类',
  `box_package_specs` smallint(6) NOT NULL DEFAULT '0' COMMENT '箱包装规格',
  `mpq` int(11) NOT NULL DEFAULT '1' COMMENT '最小包装量',
  `parts_id` int(11) NOT NULL DEFAULT '0' COMMENT '配件ID',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定',
  `create_time` datetime NOT NULL COMMENT '入库时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `put_on_shelves_time` datetime DEFAULT NULL COMMENT '上架时间',
  `first_put_on_shelves_time` datetime DEFAULT NULL COMMENT '首次上架时间',
  `pull_off_shelves_time` datetime DEFAULT NULL COMMENT '下架时间',
  `stop_production_time` datetime DEFAULT NULL COMMENT '停产时间',
  `permanent_off_shelves_time` datetime DEFAULT NULL COMMENT '永久下架时间',
  `purchase_limit` int(11) NOT NULL DEFAULT '0' COMMENT '限购数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  KEY `parts_id` (`parts_id`),
  KEY `product_supplier_number` (`supplier_number`),
  KEY `barcode` (`barcode`)
) ENGINE=InnoDB AUTO_INCREMENT=30687 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品';

-- ----------------------------
-- Table structure for product_abc
-- ----------------------------
DROP TABLE IF EXISTS `product_abc`;
CREATE TABLE `product_abc` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `abc` char(2) COLLATE utf8_bin NOT NULL DEFAULT 'C' COMMENT 'ABC分类',
  `create_time` datetime NOT NULL COMMENT '入库时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品ABC分类';

-- ----------------------------
-- Table structure for product_alternate
-- ----------------------------
DROP TABLE IF EXISTS `product_alternate`;
CREATE TABLE `product_alternate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `alternate_id` int(11) NOT NULL COMMENT '替代品ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `alternate_id` (`alternate_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2805 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品替代品';

-- ----------------------------
-- Table structure for product_attribute
-- ----------------------------
DROP TABLE IF EXISTS `product_attribute`;
CREATE TABLE `product_attribute` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '属性ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `specification_id` int(11) NOT NULL COMMENT '属性规格ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '属性值',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68454 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品属性';

-- ----------------------------
-- Table structure for product_attribute_bak_20191211
-- ----------------------------
DROP TABLE IF EXISTS `product_attribute_bak_20191211`;
CREATE TABLE `product_attribute_bak_20191211` (
  `id` int(11) NOT NULL DEFAULT '0' COMMENT '属性ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `specification_id` int(11) NOT NULL COMMENT '属性规格ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `value` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '属性值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for product_car
-- ----------------------------
DROP TABLE IF EXISTS `product_car`;
CREATE TABLE `product_car` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `car_id` int(11) NOT NULL COMMENT '车型ID',
  `note` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `car_id` (`car_id`)
) ENGINE=InnoDB AUTO_INCREMENT=196460 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品适配车型';

-- ----------------------------
-- Table structure for product_car_style
-- ----------------------------
DROP TABLE IF EXISTS `product_car_style`;
CREATE TABLE `product_car_style` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `car_style_id` int(11) NOT NULL COMMENT '车型ID',
  `ext_condition` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '扩展条件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `car_style_id` (`car_style_id`)
) ENGINE=InnoDB AUTO_INCREMENT=68735 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品适配车型';

-- ----------------------------
-- Table structure for product_category
-- ----------------------------
DROP TABLE IF EXISTS `product_category`;
CREATE TABLE `product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品类ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '品类名称',
  `number` char(6) COLLATE utf8_bin NOT NULL COMMENT '品类编号',
  `parent_id` int(11) NOT NULL COMMENT '父品类ID',
  `level` smallint(6) NOT NULL COMMENT '品类级别',
  `status` smallint(6) NOT NULL COMMENT '状态(1000正常，9000已删除)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10120068 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品类';

-- ----------------------------
-- Table structure for product_category_catalog
-- ----------------------------
DROP TABLE IF EXISTS `product_category_catalog`;
CREATE TABLE `product_category_catalog` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `classification_id` int(11) NOT NULL COMMENT '分类ID',
  `parent_id` int(11) NOT NULL COMMENT '父项ID',
  `level` tinyint(4) NOT NULL COMMENT '级别',
  `icon` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '图标',
  `user_id` int(11) NOT NULL COMMENT '创建员工ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10001787 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品类目录';

-- ----------------------------
-- Table structure for product_category_catalog_classification
-- ----------------------------
DROP TABLE IF EXISTS `product_category_catalog_classification`;
CREATE TABLE `product_category_catalog_classification` (
  `id` int(11) NOT NULL COMMENT 'id',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品类目录分类';

-- ----------------------------
-- Table structure for product_category_catalog_item
-- ----------------------------
DROP TABLE IF EXISTS `product_category_catalog_item`;
CREATE TABLE `product_category_catalog_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `catalog_id` int(11) NOT NULL COMMENT '目录id',
  `category_id` int(11) NOT NULL COMMENT '品类id',
  PRIMARY KEY (`id`),
  KEY `catalog_id` (`catalog_id`),
  KEY `category_id` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=335 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品类目录明细';

-- ----------------------------
-- Table structure for product_category_specification
-- ----------------------------
DROP TABLE IF EXISTS `product_category_specification`;
CREATE TABLE `product_category_specification` (
  `category_id` int(11) NOT NULL COMMENT '产品品类ID',
  `specification_id` int(11) NOT NULL COMMENT '属性规格ID',
  PRIMARY KEY (`category_id`,`specification_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品品类属性规格';

-- ----------------------------
-- Table structure for product_change_order
-- ----------------------------
DROP TABLE IF EXISTS `product_change_order`;
CREATE TABLE `product_change_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `summary` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `type` tinyint(4) NOT NULL COMMENT '变更类型(1:产品入库,2:上架,3:停产,4:下架,5:永久下架)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待初审,20:待终审,30:审核通过 50:已取消)',
  `reason` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '原因',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品变更单';

-- ----------------------------
-- Table structure for product_change_order_item
-- ----------------------------
DROP TABLE IF EXISTS `product_change_order_item`;
CREATE TABLE `product_change_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '变更单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `log` text COLLATE utf8_bin NOT NULL COMMENT '日志',
  `data` text COLLATE utf8_bin NOT NULL COMMENT '数据',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品变更单产品明细';

-- ----------------------------
-- Table structure for product_change_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `product_change_order_trace`;
CREATE TABLE `product_change_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '变更单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品变更单日志';

-- ----------------------------
-- Table structure for product_detail
-- ----------------------------
DROP TABLE IF EXISTS `product_detail`;
CREATE TABLE `product_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `content` text COLLATE utf8_bin COMMENT '内容',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19392 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品详情';

-- ----------------------------
-- Table structure for product_number
-- ----------------------------
DROP TABLE IF EXISTS `product_number`;
CREATE TABLE `product_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:OE码,2:工厂编号)',
  `number` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '编号',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品OE号';

-- ----------------------------
-- Table structure for product_number_sequence
-- ----------------------------
DROP TABLE IF EXISTS `product_number_sequence`;
CREATE TABLE `product_number_sequence` (
  `value` int(11) NOT NULL COMMENT '值'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品编号自增序列';

-- ----------------------------
-- Table structure for product_package
-- ----------------------------
DROP TABLE IF EXISTS `product_package`;
CREATE TABLE `product_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品包名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已入库，1100已上架，2000已下架，9000已删除)',
  `create_time` datetime NOT NULL COMMENT '入库时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品包描述',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品包';

-- ----------------------------
-- Table structure for product_package_item
-- ----------------------------
DROP TABLE IF EXISTS `product_package_item`;
CREATE TABLE `product_package_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `package_id` int(11) NOT NULL COMMENT '产品包ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  PRIMARY KEY (`id`),
  UNIQUE KEY `package_id` (`package_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=88698 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品包项';

-- ----------------------------
-- Table structure for product_package_stock_lock_order
-- ----------------------------
DROP TABLE IF EXISTS `product_package_stock_lock_order`;
CREATE TABLE `product_package_stock_lock_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `package_id` int(11) NOT NULL COMMENT '产品包ID',
  `package_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品包名称',
  `package_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品包描述',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `stock_lock_order_id` bigint(20) NOT NULL COMMENT '库存锁定单ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已锁定，1100已使用，2000已解锁)',
  `create_time` datetime NOT NULL COMMENT '锁定时间',
  `status_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `package_id` (`package_id`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `stock_lock_order_id` (`stock_lock_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品包库存锁定单';

-- ----------------------------
-- Table structure for product_packing_box_price
-- ----------------------------
DROP TABLE IF EXISTS `product_packing_box_price`;
CREATE TABLE `product_packing_box_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `price` decimal(8,2) NOT NULL COMMENT '价格(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='包装盒价格';

-- ----------------------------
-- Table structure for product_packing_box_price_log
-- ----------------------------
DROP TABLE IF EXISTS `product_packing_box_price_log`;
CREATE TABLE `product_packing_box_price_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `old_price` decimal(8,2) NOT NULL COMMENT '原价格(元)',
  `new_price` decimal(8,2) NOT NULL COMMENT '新价格(元)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='包装盒价格日志';

-- ----------------------------
-- Table structure for product_performance
-- ----------------------------
DROP TABLE IF EXISTS `product_performance`;
CREATE TABLE `product_performance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品品类',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `score` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '分数',
  `note` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_id` (`storehouse_id`,`category_id`,`product_id`),
  KEY `product_id` (`storehouse_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品绩效';

-- ----------------------------
-- Table structure for product_pic
-- ----------------------------
DROP TABLE IF EXISTS `product_pic`;
CREATE TABLE `product_pic` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `pic` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '图片地址',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品图片';

-- ----------------------------
-- Table structure for product_price
-- ----------------------------
DROP TABLE IF EXISTS `product_price`;
CREATE TABLE `product_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `join_price` decimal(8,2) NOT NULL COMMENT '加盟价(元)',
  `sale_price` decimal(8,2) NOT NULL COMMENT '销售价(元)',
  `market_price` decimal(8,2) NOT NULL COMMENT '市场价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=62922 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品价格';

-- ----------------------------
-- Table structure for product_price_log
-- ----------------------------
DROP TABLE IF EXISTS `product_price_log`;
CREATE TABLE `product_price_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `old_join_price` decimal(8,2) DEFAULT NULL COMMENT '原加盟价格',
  `new_join_price` decimal(8,2) NOT NULL COMMENT '新加盟价格',
  `old_sale_price` decimal(8,2) DEFAULT NULL COMMENT '原销售价格',
  `new_sale_price` decimal(8,2) NOT NULL COMMENT '新销售价格',
  `old_market_price` decimal(8,2) DEFAULT NULL COMMENT '原市场价格',
  `new_market_price` decimal(8,2) NOT NULL COMMENT '新市场价格',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '员工名称',
  `visible` tinyint(4) NOT NULL DEFAULT '1' COMMENT '可见性(0隐藏,1显示)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37237 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品价格日志';

-- ----------------------------
-- Table structure for product_recall
-- ----------------------------
DROP TABLE IF EXISTS `product_recall`;
CREATE TABLE `product_recall` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '召回单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `reason` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '召回原因',
  `receiving_address` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '收货地址',
  `receiver` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '收货人',
  `receiver_tel` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '收货人电话',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `start_date` date NOT NULL COMMENT '有效期-起始',
  `end_date` date NOT NULL COMMENT '有效期-结束',
  `total_num` smallint(6) NOT NULL DEFAULT '0' COMMENT '召回订单数',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '召回总数量',
  `user_id` int(11) NOT NULL COMMENT '创建人',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待审核,10:已审核,15:已结束,20:已取消)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `attachment1` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件1',
  `attachment2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件2',
  `attachment3` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件3',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品召回';

-- ----------------------------
-- Table structure for product_recall_item
-- ----------------------------
DROP TABLE IF EXISTS `product_recall_item`;
CREATE TABLE `product_recall_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `recall_id` int(11) NOT NULL COMMENT '产品召回ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '召回总数量',
  PRIMARY KEY (`id`),
  KEY `recall_id` (`recall_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品召回明细';

-- ----------------------------
-- Table structure for product_recall_item_batch
-- ----------------------------
DROP TABLE IF EXISTS `product_recall_item_batch`;
CREATE TABLE `product_recall_item_batch` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `recall_id` int(11) NOT NULL COMMENT '召回ID',
  `item_id` int(11) NOT NULL COMMENT '产品ID',
  `batch_number` varchar(40) COLLATE utf8mb4_bin NOT NULL COMMENT '批次号',
  `quantity` int(11) NOT NULL COMMENT '数量',
  PRIMARY KEY (`id`),
  KEY `recall_id` (`recall_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='召回产品明细批次';

-- ----------------------------
-- Table structure for product_recall_trace
-- ----------------------------
DROP TABLE IF EXISTS `product_recall_trace`;
CREATE TABLE `product_recall_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `recall_id` int(11) NOT NULL COMMENT '产品召回ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `recall_id` (`recall_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品召回日志';

-- ----------------------------
-- Table structure for product_sales_price_rule
-- ----------------------------
DROP TABLE IF EXISTS `product_sales_price_rule`;
CREATE TABLE `product_sales_price_rule` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(6) COLLATE utf8mb4_bin NOT NULL COMMENT '编号',
  `name` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `lock_status` tinyint(4) NOT NULL COMMENT '锁定状态(30:未锁定,60:已锁定)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '完成时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品售价规则';

-- ----------------------------
-- Table structure for product_sales_price_rule_change_order
-- ----------------------------
DROP TABLE IF EXISTS `product_sales_price_rule_change_order`;
CREATE TABLE `product_sales_price_rule_change_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(14) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `type` tinyint(4) NOT NULL COMMENT '类型(10:新增,20:修改,30:删除)',
  `reason` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '原因',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '摘要',
  `rule_id` int(11) NOT NULL DEFAULT '0' COMMENT '规则ID',
  `rule_number` char(6) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '规则编号',
  `rule_name` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '规则名称',
  `voucher` varchar(300) COLLATE utf8mb4_bin NOT NULL COMMENT '凭证',
  `data` varchar(500) COLLATE utf8mb4_bin NOT NULL COMMENT '变更数据',
  `log` varchar(1000) COLLATE utf8mb4_bin NOT NULL COMMENT '变更日志',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '备注',
  `complete_time` datetime DEFAULT NULL COMMENT '完成时间',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待初审,12:初审不通过,20:待终审,22:终审不通过,50:已完成,60:已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `rule_id` (`rule_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品售价规则变更单';

-- ----------------------------
-- Table structure for product_sales_price_rule_change_order_item
-- ----------------------------
DROP TABLE IF EXISTS `product_sales_price_rule_change_order_item`;
CREATE TABLE `product_sales_price_rule_change_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '变更单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `type` tinyint(4) NOT NULL COMMENT '类型(10:新增,20:修改,30:删除)',
  `old_sale_price` decimal(8,2) DEFAULT NULL COMMENT '原销售价(元)',
  `old_market_price` decimal(8,2) DEFAULT NULL COMMENT '原市场价(元)',
  `new_sale_price` decimal(8,2) DEFAULT NULL COMMENT '新销售价(元)',
  `new_market_price` decimal(8,2) DEFAULT NULL COMMENT '新市场价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品售价规则变更单明细';

-- ----------------------------
-- Table structure for product_sales_price_rule_change_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `product_sales_price_rule_change_order_trace`;
CREATE TABLE `product_sales_price_rule_change_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '变更单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品售价规则变更单跟踪';

-- ----------------------------
-- Table structure for product_sales_price_rule_item
-- ----------------------------
DROP TABLE IF EXISTS `product_sales_price_rule_item`;
CREATE TABLE `product_sales_price_rule_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rule_id` int(11) NOT NULL COMMENT '规则ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `sale_price` decimal(8,2) NOT NULL COMMENT '销售价(元)',
  `market_price` decimal(8,2) NOT NULL COMMENT '市场价(元)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `rule_id` (`rule_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='产品售价规则明细';

-- ----------------------------
-- Table structure for product_supplier
-- ----------------------------
DROP TABLE IF EXISTS `product_supplier`;
CREATE TABLE `product_supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `is_main` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否为主供应商(0否，1是)',
  `purchase_cycle` int(11) NOT NULL DEFAULT '0' COMMENT '采购周期',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`supplier_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48282 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品供应商';

-- ----------------------------
-- Table structure for product_tag
-- ----------------------------
DROP TABLE IF EXISTS `product_tag`;
CREATE TABLE `product_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `tag_id` int(11) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`),
  KEY `tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品标签';

-- ----------------------------
-- Table structure for purchase_abnormal_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_abnormal_order`;
CREATE TABLE `purchase_abnormal_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `quality_inspection_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '质检单号',
  `arrival_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '到货单号',
  `return_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '退货单号',
  `related_order_id` int(11) NOT NULL DEFAULT '0' COMMENT '相关单号ID',
  `storehouse_id` int(11) NOT NULL COMMENT '收货仓库',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '异常数量',
  `reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '质检不合格原因',
  `quality_inspection_time` datetime NOT NULL COMMENT '质检时间',
  `special_purchase_quantity` smallint(6) DEFAULT NULL COMMENT '特采数量',
  `return_quantity` smallint(6) DEFAULT NULL COMMENT '退货数量',
  `unit_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '单价(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待处理, 20:待审核, 30:已审核，40：已撤销)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `attachment` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购异常单';

-- ----------------------------
-- Table structure for purchase_abnormal_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `purchase_abnormal_order_trace`;
CREATE TABLE `purchase_abnormal_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(6) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购异常单日志';

-- ----------------------------
-- Table structure for purchase_acceptance_method
-- ----------------------------
DROP TABLE IF EXISTS `purchase_acceptance_method`;
CREATE TABLE `purchase_acceptance_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `months` smallint(6) NOT NULL COMMENT '间隔月份',
  `date` tinyint(4) NOT NULL COMMENT '固定日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='采购承兑方式';

-- ----------------------------
-- Table structure for purchase_arrival_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_arrival_order`;
CREATE TABLE `purchase_arrival_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型(1:供应商供应,2:特殊采购)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `purchase_order_id` int(11) NOT NULL COMMENT '采购单ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `supplier_number` varchar(40) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '供应方单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(10待确认，20待收货，50部分收货，51已收货，90已取消，91已退单)',
  `reconciliation_status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '对账状态(10:未就绪,20:待对账,30:已对账)',
  `reconciliation_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '对账单号',
  `settlement_method` smallint(6) DEFAULT '0' COMMENT '结算方式(10000现结，11000月结，12000铺货)',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数量',
  `total_quantity` int(11) NOT NULL COMMENT '数量',
  `total_price` decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '总价(元)',
  `deliver_date` date DEFAULT NULL COMMENT '发货日期',
  `arrival_date` date DEFAULT NULL COMMENT '到货日期',
  `salver_quantity` smallint(6) DEFAULT '0' COMMENT '发货托数',
  `box_quantity` smallint(6) DEFAULT NULL COMMENT '箱数',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_attachment1` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件1',
  `logistics_attachment2` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件2',
  `logistics_attachment3` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流附件3',
  `quality_inspection` tinyint(4) NOT NULL COMMENT '质检(10免检, 20已质检，40不质检，50需质检)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `user_id` int(11) NOT NULL COMMENT '创建员工ID',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `receipt_salver_quantity` smallint(6) DEFAULT '0' COMMENT '实收托数',
  `receipt_box_quantity` smallint(6) DEFAULT NULL COMMENT '实收箱数',
  `receipt_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实收数量',
  `receipt_price` decimal(14,4) DEFAULT NULL COMMENT '实收总价(元)',
  `new_process` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否新流程(0:否,1:是)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `stock_in_transit_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '在途库存单号',
  `quality_inspection_report` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '质检报告',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `purchase_order_id` (`purchase_order_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购到货单';

-- ----------------------------
-- Table structure for purchase_arrival_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `purchase_arrival_order_contact`;
CREATE TABLE `purchase_arrival_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '到货单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1供应商联系人，3收货人)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='到货单联系信息';

-- ----------------------------
-- Table structure for purchase_arrival_order_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_arrival_order_item`;
CREATE TABLE `purchase_arrival_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `box_package_specs` smallint(6) NOT NULL DEFAULT '0' COMMENT '箱包装规格',
  `unit_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '单价(元)',
  `total_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '总价(元)',
  `tax_rate` decimal(3,2) NOT NULL DEFAULT '0.00',
  `receipt_quantity` int(11) DEFAULT '0' COMMENT '实收数量',
  `unqualified_quantity` int(11) DEFAULT '0' COMMENT '质检不合格数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购到货单行';

-- ----------------------------
-- Table structure for purchase_arrival_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `purchase_arrival_order_trace`;
CREATE TABLE `purchase_arrival_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型(1000系统，2000仓库)',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `attachment` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购到货单跟踪';

-- ----------------------------
-- Table structure for purchase_demand
-- ----------------------------
DROP TABLE IF EXISTS `purchase_demand`;
CREATE TABLE `purchase_demand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `quantity` int(11) NOT NULL COMMENT '需求数量',
  `in_transit` int(11) NOT NULL COMMENT '在途数量',
  `pending_deliver_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '待发货数量',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`supplier_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购需求';

-- ----------------------------
-- Table structure for purchase_demand_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_demand_item`;
CREATE TABLE `purchase_demand_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:采购, 10:撤销采购，15：收货)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `related_number` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`,`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购需求流水';

-- ----------------------------
-- Table structure for purchase_demand_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_demand_order`;
CREATE TABLE `purchase_demand_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `type` tinyint(4) NOT NULL COMMENT '操作类型(5:采购，10：撤销)',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待审核, 10:已审核，20：已取消)',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_price` decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '总价(元)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `reason` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '原因',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购需求单';

-- ----------------------------
-- Table structure for purchase_demand_order_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_demand_order_item`;
CREATE TABLE `purchase_demand_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '采购需求单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `unit_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '单价(元)',
  `total_price` decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购需求单行';

-- ----------------------------
-- Table structure for purchase_demand_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `purchase_demand_order_trace`;
CREATE TABLE `purchase_demand_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '采购需求单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购需求单日志';

-- ----------------------------
-- Table structure for purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order`;
CREATE TABLE `purchase_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '采购类型(1000日常采购，2000加急采购)',
  `status` smallint(6) NOT NULL COMMENT '状态(10000待确认，11000待审核，12000待采购，13000待发货，14000待收货，15000已收货，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '申请员工ID',
  `buyer_id` int(11) NOT NULL DEFAULT '0' COMMENT '采购员工ID',
  `settlement_method` smallint(6) NOT NULL DEFAULT '0' COMMENT '结算方式(10000现结，11000月结，12000铺货)',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数量',
  `total_quantity` int(11) NOT NULL COMMENT '数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '采购总价(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `receipt_time` datetime DEFAULT NULL COMMENT '收货时间',
  `arrival_date` date DEFAULT NULL COMMENT '到货日期',
  `receipt_price` decimal(12,2) DEFAULT NULL COMMENT '实收总价(元)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购申请单';

-- ----------------------------
-- Table structure for purchase_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_contact`;
CREATE TABLE `purchase_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '申请单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1供货方联系人，2采购人，3收货人)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购申请单联系信息';

-- ----------------------------
-- Table structure for purchase_order_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_item`;
CREATE TABLE `purchase_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '申请单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '采购数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `deliver_quantity` int(11) DEFAULT NULL COMMENT '实际发货数量',
  `receipt_quantity` int(11) DEFAULT NULL COMMENT '实际收货数量',
  `unqualified_quantity` int(11) DEFAULT '0' COMMENT '质检不合格数量',
  `on_way_quantity` int(11) DEFAULT NULL COMMENT '在途数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购申请单行';

-- ----------------------------
-- Table structure for purchase_order_production_schedules
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_production_schedules`;
CREATE TABLE `purchase_order_production_schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `percent` tinyint(4) NOT NULL DEFAULT '0' COMMENT '进度百分比',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购单生产进度';

-- ----------------------------
-- Table structure for purchase_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `purchase_order_trace`;
CREATE TABLE `purchase_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购申请单跟踪';

-- ----------------------------
-- Table structure for purchase_price
-- ----------------------------
DROP TABLE IF EXISTS `purchase_price`;
CREATE TABLE `purchase_price` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应商ID(0:表示全部)',
  `price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '采购价(元)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48711 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品采购价';

-- ----------------------------
-- Table structure for purchase_price_log
-- ----------------------------
DROP TABLE IF EXISTS `purchase_price_log`;
CREATE TABLE `purchase_price_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `supplier_id` int(11) NOT NULL DEFAULT '0' COMMENT '供应商ID',
  `old_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '原采购价',
  `new_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '新采购价',
  `user_id` int(11) NOT NULL COMMENT '修改人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '修改人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品采购价日志';

-- ----------------------------
-- Table structure for purchase_reconciliation_discrepancy_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_reconciliation_discrepancy_order`;
CREATE TABLE `purchase_reconciliation_discrepancy_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:代理发货,2:采购,3:代理退货)',
  `trade_type` tinyint(4) NOT NULL COMMENT '交易类型(1:采购,2:退货)',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `related_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_sku` smallint(6) NOT NULL COMMENT 'SKU数',
  `original_total_price` decimal(12,4) NOT NULL COMMENT '原总价(元)',
  `reconcile_total_price` decimal(12,4) NOT NULL COMMENT '对账总价(元)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品对账差异单';

-- ----------------------------
-- Table structure for purchase_reconciliation_discrepancy_order_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_reconciliation_discrepancy_order_item`;
CREATE TABLE `purchase_reconciliation_discrepancy_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '差价单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `original_unit_price` decimal(10,4) DEFAULT NULL COMMENT '原单价(元)',
  `reconcile_unit_price` decimal(10,4) DEFAULT NULL COMMENT '单价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品对账差异单明细';

-- ----------------------------
-- Table structure for purchase_reconciliation_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_reconciliation_order`;
CREATE TABLE `purchase_reconciliation_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:代理,2:采购)',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `product_total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `product_original_total_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '原总价(元)',
  `product_total_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '现总价(元)',
  `logistics_cost_total_amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '物流总费用(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待初审,20:待终审,30:审核通过)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购对账单';

-- ----------------------------
-- Table structure for purchase_reconciliation_order_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_reconciliation_order_item`;
CREATE TABLE `purchase_reconciliation_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '对账单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `unit_price` decimal(10,4) NOT NULL COMMENT '单价(元)',
  `original_total_price` decimal(10,4) NOT NULL COMMENT '原总价(元)',
  `total_price` decimal(10,4) NOT NULL COMMENT '现总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购对账单明细';

-- ----------------------------
-- Table structure for purchase_reconciliation_order_related_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_reconciliation_order_related_item`;
CREATE TABLE `purchase_reconciliation_order_related_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '采购对账单id',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:代理,2:采购)',
  `related_order_number` varchar(20) NOT NULL COMMENT '相关单号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `related_order_number` (`related_order_number`,`type`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购对账单相关订单';

-- ----------------------------
-- Table structure for purchase_reconciliation_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `purchase_reconciliation_order_trace`;
CREATE TABLE `purchase_reconciliation_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '对账单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购对账单日志';

-- ----------------------------
-- Table structure for purchase_return_order
-- ----------------------------
DROP TABLE IF EXISTS `purchase_return_order`;
CREATE TABLE `purchase_return_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` smallint(6) NOT NULL COMMENT '状态(10000待确认，11000待审核，12000待出库，19000已完成，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT 'SKU数量',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '总金额(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '物流费用(1到付，2包邮)',
  `logistics_cost_amount` decimal(8,2) DEFAULT NULL COMMENT '物流费用金额',
  `box_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '发货箱数',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购退货单';

-- ----------------------------
-- Table structure for purchase_return_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `purchase_return_order_contact`;
CREATE TABLE `purchase_return_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1供应商收货人，2采购人，3发货人)',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购退货单联系信息';

-- ----------------------------
-- Table structure for purchase_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_return_order_item`;
CREATE TABLE `purchase_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '退货数量',
  `reason` smallint(6) NOT NULL COMMENT '退货原因(10000产品质量问题)',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '单价(元)',
  `total_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_id` (`order_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购退货单行';

-- ----------------------------
-- Table structure for purchase_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `purchase_return_order_trace`;
CREATE TABLE `purchase_return_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购退货单跟踪';

-- ----------------------------
-- Table structure for purchase_settlement_method
-- ----------------------------
DROP TABLE IF EXISTS `purchase_settlement_method`;
CREATE TABLE `purchase_settlement_method` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
  `months` smallint(6) NOT NULL COMMENT '间隔月份',
  `date` tinyint(4) NOT NULL COMMENT '固定日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='采购结算方式';

-- ----------------------------
-- Table structure for purchase_volume
-- ----------------------------
DROP TABLE IF EXISTS `purchase_volume`;
CREATE TABLE `purchase_volume` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '采购总数',
  `average_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '平均采购单价(元)',
  `last_average_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '最近平均采购单价(元)',
  `total_price` decimal(18,4) NOT NULL DEFAULT '0.0000' COMMENT '采购总价(元)',
  `last_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '最后一次采购单价(元)',
  `last_order_id` int(11) NOT NULL COMMENT '最后一次采购单ID',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26341 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购量';

-- ----------------------------
-- Table structure for purchase_volume_item
-- ----------------------------
DROP TABLE IF EXISTS `purchase_volume_item`;
CREATE TABLE `purchase_volume_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `order_id` int(11) NOT NULL COMMENT '采购单ID',
  `quantity` int(11) NOT NULL COMMENT '采购数量',
  `unit_price` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '单价(元)',
  `total_price` decimal(16,2) NOT NULL DEFAULT '0.00' COMMENT '采购总价(元)',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='最近采购记录';

-- ----------------------------
-- Table structure for purchaser_product_category
-- ----------------------------
DROP TABLE IF EXISTS `purchaser_product_category`;
CREATE TABLE `purchaser_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '采购人ID',
  `category_id` int(11) NOT NULL COMMENT '产品品类ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='采购人产品品类';

-- ----------------------------
-- Table structure for putaway_order
-- ----------------------------
DROP TABLE IF EXISTS `putaway_order`;
CREATE TABLE `putaway_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:销退,10:加工成品)',
  `reason` tinyint(4) NOT NULL COMMENT '原因(5:合格,10:不合格,15:换包装盒)',
  `order_source` tinyint(4) NOT NULL COMMENT '订单来源(5:质检单,10:加工单)',
  `related_number` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '相关单号',
  `additional_number` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '附加单号',
  `total_sku` smallint(6) NOT NULL COMMENT 'sku数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `summary` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '摘要',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待上架,20:部分上架,50:已完成)',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `additional_note` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '附加信息',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='上架单';

-- ----------------------------
-- Table structure for putaway_order_item
-- ----------------------------
DROP TABLE IF EXISTS `putaway_order_item`;
CREATE TABLE `putaway_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '上架单ID',
  `quality_type` tinyint(4) NOT NULL COMMENT '品质类型(5:合格,10:废品)',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:销退,10:加工成品)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `batch_id` int(11) NOT NULL COMMENT '批次ID',
  `batch_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '批次号',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '库位名称',
  `putawaying_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '上架中数量',
  `putawayed_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '已上架数量',
  `deficiency_quantity` int(11) DEFAULT NULL COMMENT '差异数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='上架单明细';

-- ----------------------------
-- Table structure for putaway_order_putaway_item
-- ----------------------------
DROP TABLE IF EXISTS `putaway_order_putaway_item`;
CREATE TABLE `putaway_order_putaway_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '上架单ID',
  `item_id` int(11) NOT NULL COMMENT '上架单明细ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:销退,10:加工成品)',
  `assign_task_status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '分配任务状态(10:未分配,30:已分配)',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '库位名称',
  `batch_id` int(11) NOT NULL COMMENT '批次ID',
  `batch_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '批次号',
  `quantity` int(11) NOT NULL COMMENT '上架数量',
  `actual_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实际上架数量',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待上架,50:已完成,60:已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='清点单上架明细';

-- ----------------------------
-- Table structure for putaway_order_putaway_item_target
-- ----------------------------
DROP TABLE IF EXISTS `putaway_order_putaway_item_target`;
CREATE TABLE `putaway_order_putaway_item_target` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `item_id` bigint(20) NOT NULL COMMENT '上架明细ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '库位名称',
  `quantity` int(11) NOT NULL COMMENT '上架数量',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='清点单上架明细上架目标';

-- ----------------------------
-- Table structure for putaway_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `putaway_order_trace`;
CREATE TABLE `putaway_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '上架单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `user_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='清点单跟踪';

-- ----------------------------
-- Table structure for quality_inspection_abnormal_order
-- ----------------------------
DROP TABLE IF EXISTS `quality_inspection_abnormal_order`;
CREATE TABLE `quality_inspection_abnormal_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `type` smallint(6) NOT NULL COMMENT '类型(1000:采购, 调拨:1100, 服务商退货:1210, 领用退回:1300)',
  `quality_inspection_order_id` int(11) NOT NULL COMMENT '质检单号',
  `storehouse_id` int(11) NOT NULL COMMENT '收货仓库',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '异常数量',
  `reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '质检不合格原因',
  `location_id` int(11) NOT NULL COMMENT '存放库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '存放库位名称',
  `special_purchase_quantity` smallint(6) DEFAULT NULL COMMENT '特采数量',
  `return_quantity` smallint(6) DEFAULT NULL COMMENT '退货数量',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待指定, 20:待处理, 30:已处理，40：已撤销)',
  `quality_inspection_time` datetime NOT NULL COMMENT '质检时间',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `attachment` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附件',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='质检异常单';

-- ----------------------------
-- Table structure for quality_inspection_abnormal_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `quality_inspection_abnormal_order_trace`;
CREATE TABLE `quality_inspection_abnormal_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(6) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='质检异常单日志';

-- ----------------------------
-- Table structure for quality_inspection_order
-- ----------------------------
DROP TABLE IF EXISTS `quality_inspection_order`;
CREATE TABLE `quality_inspection_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '质检单号',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:采购,10:调拨,15:退货)',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号(入库单等)',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待检验，15000已初检，19000已完成，20000已取消)',
  `use_flag` tinyint(4) NOT NULL DEFAULT '0' COMMENT '使用标识(0未使用，1已使用)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '下单人ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `finish_time` datetime DEFAULT NULL COMMENT '完成时间',
  `additional_note` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '附加信息',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `inspector_id` int(11) NOT NULL DEFAULT '0' COMMENT '检验人ID',
  `conclusion` text COLLATE utf8_bin COMMENT '检验结论',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='质检单(大表)';

-- ----------------------------
-- Table structure for quality_inspection_order_inspect_item
-- ----------------------------
DROP TABLE IF EXISTS `quality_inspection_order_inspect_item`;
CREATE TABLE `quality_inspection_order_inspect_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `item_id` bigint(20) NOT NULL COMMENT '明细ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `result_type` tinyint(4) NOT NULL COMMENT '结果(5:换盒,50:不合格,80:拒收,90:合格)',
  `refuse_reason_id` int(11) NOT NULL DEFAULT '0' COMMENT '拒收原因ID',
  `refuse_reason` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '拒收原因',
  `result_explanation` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '不合格原因',
  `is_qualified` tinyint(4) NOT NULL COMMENT '是否合格(0:否,1:是)',
  `location_id` int(11) NOT NULL DEFAULT '0' COMMENT '上架库位ID',
  `location_name` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '上架库位',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `item_id` (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='质检单行检查明细';

-- ----------------------------
-- Table structure for quality_inspection_order_item
-- ----------------------------
DROP TABLE IF EXISTS `quality_inspection_order_item`;
CREATE TABLE `quality_inspection_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '质检单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '应检数量',
  `qualified_quantity` int(11) DEFAULT NULL COMMENT '质检合格数量',
  `actual_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '实检数量',
  `initial_unqualified_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '初检不合格数量',
  `final_unqualified_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '终检不合格数量',
  `final_unqualified_reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '终检不合格原因',
  `return_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '退回数量',
  `initial_unavailable_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '初检合格但不能上架数量',
  `final_unavailable_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '终检合格但不能上架数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='质检单行(大表)';

-- ----------------------------
-- Table structure for quality_inspection_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `quality_inspection_order_trace`;
CREATE TABLE `quality_inspection_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='质检单跟踪(大表)';

-- ----------------------------
-- Table structure for receiving_counting
-- ----------------------------
DROP TABLE IF EXISTS `receiving_counting`;
CREATE TABLE `receiving_counting` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `instock_order_id` int(11) NOT NULL COMMENT '入库单ID',
  `instock_order_item_id` bigint(20) NOT NULL COMMENT '入库单明细ID',
  `quantity` smallint(6) NOT NULL COMMENT '数量',
  `user_id` int(11) NOT NULL COMMENT '清点人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `instock_order_id` (`instock_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='收货清点表';

-- ----------------------------
-- Table structure for refund_order
-- ----------------------------
DROP TABLE IF EXISTS `refund_order`;
CREATE TABLE `refund_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待审核、1100审核通过、2000审核不通过)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `audit_id` int(11) NOT NULL DEFAULT '0' COMMENT '审核人ID',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '审核意见',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='退款申请单(大表)';

-- ----------------------------
-- Table structure for region
-- ----------------------------
DROP TABLE IF EXISTS `region`;
CREATE TABLE `region` (
  `id` int(11) NOT NULL COMMENT '区域编码',
  `name` varchar(32) COLLATE utf8_bin NOT NULL COMMENT '区域名称',
  `full_name` varchar(100) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '区域全称',
  `level` tinyint(4) NOT NULL COMMENT '区域级别(0国家，1省份、直辖市，2市，3区/县)',
  `parent_id` int(11) NOT NULL COMMENT '上级区域',
  `postal_code` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '邮政编码',
  `area_code` char(3) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '区号',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='区域表';

-- ----------------------------
-- Table structure for reserve_order
-- ----------------------------
DROP TABLE IF EXISTS `reserve_order`;
CREATE TABLE `reserve_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '下单用户ID',
  `customer_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户名称',
  `customer_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户联系人姓名',
  `customer_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户联系电话',
  `customer_address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户收货地址',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `distribution_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '加盟商名称',
  `status` tinyint(4) NOT NULL COMMENT '订单状态(1待报价，2待确认，3待受理，7已完成，8已取消)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `customer_id` (`customer_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='预定单';

-- ----------------------------
-- Table structure for reserve_order_item
-- ----------------------------
DROP TABLE IF EXISTS `reserve_order_item`;
CREATE TABLE `reserve_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` int(20) NOT NULL,
  `distribution_id` int(20) NOT NULL,
  `reserve_order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category_id` int(11) NOT NULL DEFAULT '0' COMMENT '品类ID',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand_id` int(11) NOT NULL DEFAULT '0' COMMENT '品牌ID',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `product_description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品描述',
  `join_unit_price` decimal(8,2) NOT NULL COMMENT '加盟单价(元)',
  `sale_unit_price` decimal(8,2) NOT NULL COMMENT '销售单价(元)',
  `bargain_unit_price` decimal(8,2) NOT NULL COMMENT '成交单价(元)',
  `bargain_total_price` decimal(10,2) NOT NULL COMMENT '成交总价(元)',
  `print_unit_price` decimal(8,2) NOT NULL COMMENT '打印单价(元)',
  `print_total_price` decimal(10,2) NOT NULL COMMENT '打印总价(元)',
  `note` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `reserve_order_id` (`reserve_order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='预定单详情';

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `customer_id` int(11) NOT NULL COMMENT '客户ID',
  `customer_name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '客户名称',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `distribution_name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '加盟商名称',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `order_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `star_level` tinyint(4) NOT NULL COMMENT '星级',
  `content` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '内容',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='评价';

-- ----------------------------
-- Table structure for review_option
-- ----------------------------
DROP TABLE IF EXISTS `review_option`;
CREATE TABLE `review_option` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `review_id` bigint(20) NOT NULL COMMENT '评价ID',
  `option_id` int(11) NOT NULL COMMENT '选项ID',
  PRIMARY KEY (`id`),
  KEY `review_id` (`review_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='评价选项';

-- ----------------------------
-- Table structure for revision_order
-- ----------------------------
DROP TABLE IF EXISTS `revision_order`;
CREATE TABLE `revision_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(14) COLLATE utf8_bin NOT NULL COMMENT '申请单编号',
  `type` tinyint(4) NOT NULL COMMENT '类型(1新增，2修改)',
  `object_type` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '对象类型',
  `object_id` int(11) NOT NULL DEFAULT '0' COMMENT '对象ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待审核，1100审核通过，1200审核不通过，2000已取消)',
  `user_id` int(11) NOT NULL COMMENT '提交员工ID',
  `audit_id` int(11) NOT NULL COMMENT '审核员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `audit_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '审核备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `audit_id` (`audit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修订申请单';

-- ----------------------------
-- Table structure for revision_order_item
-- ----------------------------
DROP TABLE IF EXISTS `revision_order_item`;
CREATE TABLE `revision_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '申请单ID',
  `specification_id` int(11) NOT NULL COMMENT '属性规格ID',
  `old_value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '修改前的值',
  `new_value` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '修改后的值',
  `old_value_name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '修改前的值',
  `new_value_name` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '修改后的值',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修订申请单行';

-- ----------------------------
-- Table structure for revision_order_item_car_style
-- ----------------------------
DROP TABLE IF EXISTS `revision_order_item_car_style`;
CREATE TABLE `revision_order_item_car_style` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '申请单ID',
  `car_style_id` int(11) NOT NULL COMMENT '车型ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1新增，2修改，3删除，4不变)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修订申请单行';

-- ----------------------------
-- Table structure for revision_order_item_number
-- ----------------------------
DROP TABLE IF EXISTS `revision_order_item_number`;
CREATE TABLE `revision_order_item_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '申请单ID',
  `type_id` int(11) NOT NULL COMMENT '编号类型ID',
  `number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `type` tinyint(4) NOT NULL COMMENT '类型(1新增，2修改，3删除，4不变)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='修订申请单行';

-- ----------------------------
-- Table structure for sales_volume
-- ----------------------------
DROP TABLE IF EXISTS `sales_volume`;
CREATE TABLE `sales_volume` (
  `id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '销售数量',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='销量统计';

-- ----------------------------
-- Table structure for sales_volume_report
-- ----------------------------
DROP TABLE IF EXISTS `sales_volume_report`;
CREATE TABLE `sales_volume_report` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1月，2年)',
  `date` char(6) COLLATE utf8_bin NOT NULL COMMENT '年月',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待处理，1100已完成)',
  `total_product` int(11) DEFAULT NULL COMMENT '产品数量',
  `total_quantity` int(11) DEFAULT NULL COMMENT '数量',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '报表生成时间',
  PRIMARY KEY (`id`),
  KEY `date` (`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='销量报表(补货量统计)';

-- ----------------------------
-- Table structure for sales_volume_report_item
-- ----------------------------
DROP TABLE IF EXISTS `sales_volume_report_item`;
CREATE TABLE `sales_volume_report_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `report_id` int(11) NOT NULL COMMENT '报表ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `average_price` decimal(8,2) NOT NULL COMMENT '平均单价(元)',
  `total_price` decimal(12,2) DEFAULT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='销量报表行(补货量统计)';

-- ----------------------------
-- Table structure for salesman
-- ----------------------------
DROP TABLE IF EXISTS `salesman`;
CREATE TABLE `salesman` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号',
  `department` varchar(32) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '部门',
  `position` varchar(64) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '职位',
  `status` tinyint(1) NOT NULL DEFAULT '10' COMMENT '状态(10有效，20停用)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='业务员';

-- ----------------------------
-- Table structure for scrap_product
-- ----------------------------
DROP TABLE IF EXISTS `scrap_product`;
CREATE TABLE `scrap_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `related_number` char(20) NOT NULL COMMENT '相关单号',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `return_order_number` char(20) NOT NULL DEFAULT '' COMMENT '报废退货单单号',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待退货，20：已退货)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `product_id` (`product_id`,`return_order_number`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报废产品';

-- ----------------------------
-- Table structure for scrap_product_attachment
-- ----------------------------
DROP TABLE IF EXISTS `scrap_product_attachment`;
CREATE TABLE `scrap_product_attachment` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `scrap_product_id` int(11) NOT NULL COMMENT '产品退货id',
  `attachment` varchar(100) NOT NULL COMMENT '附件',
  PRIMARY KEY (`id`),
  KEY `scrap_product_id` (`scrap_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报废产品附件';

-- ----------------------------
-- Table structure for scrap_product_item
-- ----------------------------
DROP TABLE IF EXISTS `scrap_product_item`;
CREATE TABLE `scrap_product_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `scrap_product_id` int(11) NOT NULL COMMENT '报废产品id',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `batch_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '批次号',
  `description` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '异常描述',
  `attachment` varchar(1500) COLLATE utf8mb4_bin NOT NULL COMMENT '异常描述',
  PRIMARY KEY (`id`),
  KEY `scrap_product_id` (`scrap_product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='报废产品明细';

-- ----------------------------
-- Table structure for scrap_return_order
-- ----------------------------
DROP TABLE IF EXISTS `scrap_return_order`;
CREATE TABLE `scrap_return_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,4) NOT NULL COMMENT '总金额(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待审核,20:已审核)',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报废退货单';

-- ----------------------------
-- Table structure for scrap_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `scrap_return_order_item`;
CREATE TABLE `scrap_return_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '报废退货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='报废退货明细';

-- ----------------------------
-- Table structure for scrap_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `scrap_return_order_trace`;
CREATE TABLE `scrap_return_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商退货结算单日志';

-- ----------------------------
-- Table structure for section
-- ----------------------------
DROP TABLE IF EXISTS `section`;
CREATE TABLE `section` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '库区编号',
  `description` varchar(60) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述(显示名称)',
  `use` int(11) NOT NULL COMMENT '库区用途',
  `pack_zone_id` int(11) NOT NULL DEFAULT '0' COMMENT '打包区ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`storehouse_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=391 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库区';

-- ----------------------------
-- Table structure for secured_transaction_order
-- ----------------------------
DROP TABLE IF EXISTS `secured_transaction_order`;
CREATE TABLE `secured_transaction_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '订单类型ID',
  `payer_account_id` int(11) NOT NULL COMMENT '付款方账户ID',
  `payee_account_id` int(11) NOT NULL COMMENT '收款方账户ID',
  `account_item_type_id` int(11) NOT NULL COMMENT '账目类型ID',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已付款，1900已收款，2000已退款)',
  `transaction_type_id` int(11) NOT NULL COMMENT '交易类型ID',
  `transaction_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '交易单号',
  `create_time` datetime NOT NULL COMMENT '交易时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '交易明细',
  PRIMARY KEY (`id`),
  KEY `payer_account_id` (`payer_account_id`),
  KEY `payee_account_id` (`payee_account_id`),
  KEY `transaction_number` (`transaction_number`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='担保交易订单(大表)';

-- ----------------------------
-- Table structure for self_product
-- ----------------------------
DROP TABLE IF EXISTS `self_product`;
CREATE TABLE `self_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '产品ID',
  `number` char(20) COLLATE utf8mb4_bin NOT NULL COMMENT '产品编号',
  `supplier_number` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '供应商编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `name` varchar(120) COLLATE utf8mb4_bin NOT NULL COMMENT '产品名称',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID',
  `category_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '品类名称',
  `brand_name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '品牌名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000已入库，1100已上架，2200已停产，2300已下架，9000已删除)',
  `unit` varchar(10) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `package_size` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '包装规格',
  `pic` varchar(120) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品图片',
  `description` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '产品描述',
  `join_price` decimal(8,2) DEFAULT NULL COMMENT '进货价(元)',
  `sale_price` decimal(8,2) DEFAULT NULL COMMENT '销售价(元)',
  `market_price` decimal(8,2) DEFAULT NULL COMMENT '市场价(元)',
  `create_time` datetime NOT NULL COMMENT '入库时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_number` (`supplier_number`),
  KEY `category_id` (`category_id`),
  KEY `brand_id` (`brand_id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='加盟商自营产品';

-- ----------------------------
-- Table structure for self_product_brand
-- ----------------------------
DROP TABLE IF EXISTS `self_product_brand`;
CREATE TABLE `self_product_brand` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '品类ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '品牌名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000正常)',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '品牌描述',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品品牌';

-- ----------------------------
-- Table structure for self_product_category
-- ----------------------------
DROP TABLE IF EXISTS `self_product_category`;
CREATE TABLE `self_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '品类名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000正常)',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品品类';

-- ----------------------------
-- Table structure for self_product_purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `self_product_purchase_order`;
CREATE TABLE `self_product_purchase_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待处理，19000已收货，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '受理员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品进货单(大表)';

-- ----------------------------
-- Table structure for self_product_purchase_order_item
-- ----------------------------
DROP TABLE IF EXISTS `self_product_purchase_order_item`;
CREATE TABLE `self_product_purchase_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品进货单行(大表)';

-- ----------------------------
-- Table structure for self_product_purchase_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `self_product_purchase_order_trace`;
CREATE TABLE `self_product_purchase_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品进货单跟踪(大表)';

-- ----------------------------
-- Table structure for self_product_return_order
-- ----------------------------
DROP TABLE IF EXISTS `self_product_return_order`;
CREATE TABLE `self_product_return_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待处理，19000已退货，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '受理员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_price` decimal(12,2) NOT NULL DEFAULT '0.00' COMMENT '总价(元)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `distribution_id` (`distribution_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品退货单(大表)';

-- ----------------------------
-- Table structure for self_product_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `self_product_return_order_item`;
CREATE TABLE `self_product_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `unit_price` decimal(8,2) NOT NULL COMMENT '单价(元)',
  `total_price` decimal(10,2) NOT NULL COMMENT '总价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品退货单行(大表)';

-- ----------------------------
-- Table structure for self_product_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `self_product_return_order_trace`;
CREATE TABLE `self_product_return_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品退货单跟踪(大表)';

-- ----------------------------
-- Table structure for self_product_stock
-- ----------------------------
DROP TABLE IF EXISTS `self_product_stock`;
CREATE TABLE `self_product_stock` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '库存数量',
  `shelves_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '仓位ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `distribution_id` (`distribution_id`,`product_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品库存(大表)';

-- ----------------------------
-- Table structure for self_product_stock_item
-- ----------------------------
DROP TABLE IF EXISTS `self_product_stock_item`;
CREATE TABLE `self_product_stock_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `distribution_id` int(11) NOT NULL COMMENT '加盟商ID',
  `inout` tinyint(4) NOT NULL COMMENT '出入库(1入库，2出库)',
  `type` smallint(6) NOT NULL COMMENT '类型(1000进货、1010退货、1100销售、1200销售取消、作废、1300销售退货，2000核增、2100核减)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `surplus` int(11) NOT NULL COMMENT '剩余库存',
  `voucher` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '凭证',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `product_id` (`product_id`),
  KEY `create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='加盟商自营产品库存流水(特大表)';

-- ----------------------------
-- Table structure for shipping_order
-- ----------------------------
DROP TABLE IF EXISTS `shipping_order`;
CREATE TABLE `shipping_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '发货单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `outstock_id` bigint(20) NOT NULL COMMENT '出库单ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待发货，11000已发货，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '发货员工ID',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '物流费用(1到付，2包邮)',
  `logistics_cost_amount` decimal(8,2) DEFAULT NULL COMMENT '物流费用金额',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `finish_time` datetime DEFAULT NULL COMMENT '发货时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `outstock_id` (`outstock_id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='发货单(大表)';

-- ----------------------------
-- Table structure for shipping_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `shipping_order_trace`;
CREATE TABLE `shipping_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='发货单跟踪(大表)';

-- ----------------------------
-- Table structure for special_account
-- ----------------------------
DROP TABLE IF EXISTS `special_account`;
CREATE TABLE `special_account` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '账户ID',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '专项款名称',
  `balance` decimal(16,2) NOT NULL COMMENT '余额',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='专项款账户';

-- ----------------------------
-- Table structure for special_account_item
-- ----------------------------
DROP TABLE IF EXISTS `special_account_item`;
CREATE TABLE `special_account_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `special_account_id` int(11) NOT NULL COMMENT '专项款账户ID',
  `account_item_id` bigint(20) NOT NULL COMMENT '账目流水ID',
  `type_id` int(11) NOT NULL COMMENT '类型ID(1000 转入，2000 转出，3000支付，4000冲正)',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `balance` decimal(16,2) NOT NULL COMMENT '余额',
  `transaction_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `special_account_id` (`special_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='专项款账户流水记录';

-- ----------------------------
-- Table structure for special_account_rule
-- ----------------------------
DROP TABLE IF EXISTS `special_account_rule`;
CREATE TABLE `special_account_rule` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `special_account_id` int(11) NOT NULL COMMENT '专项款账户ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `brand_id` int(11) NOT NULL COMMENT '品牌ID，0为所有',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `special_account_id` (`special_account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='专项款账户明细';

-- ----------------------------
-- Table structure for statistics_tracking
-- ----------------------------
DROP TABLE IF EXISTS `statistics_tracking`;
CREATE TABLE `statistics_tracking` (
  `id` int(11) NOT NULL COMMENT 'ID',
  `break_point` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '断点',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='统计跟踪表';

-- ----------------------------
-- Table structure for stock
-- ----------------------------
DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `hold` int(11) NOT NULL COMMENT '冻结状态',
  `quantity` int(11) NOT NULL COMMENT '现有量',
  `allocated` int(11) NOT NULL DEFAULT '0' COMMENT '分配量',
  `moving_in` int(11) NOT NULL DEFAULT '0' COMMENT '待移入量(移动单)',
  `moving_out` int(11) NOT NULL DEFAULT '0' COMMENT '待移出量(移动单)',
  `min` int(11) NOT NULL DEFAULT '0' COMMENT '最小量(仅拣货库位)',
  `max` int(11) NOT NULL DEFAULT '0' COMMENT '最大量(仅拣货库位)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`location_id`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `location_id` (`location_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2545285 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存';

-- ----------------------------
-- Table structure for stock_adjustment_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_adjustment_order`;
CREATE TABLE `stock_adjustment_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000盘点，1100核增核减)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号(盘点计划)',
  `status` smallint(6) NOT NULL COMMENT '订单状态(10000待审核，11000待处理，19000已处理，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `process_time` datetime DEFAULT NULL COMMENT '处理时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存调整单';

-- ----------------------------
-- Table structure for stock_adjustment_order_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_adjustment_order_item`;
CREATE TABLE `stock_adjustment_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '调整单ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '增减数量',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位编号',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `reason` int(11) DEFAULT NULL COMMENT '调整原因',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存调整单行';

-- ----------------------------
-- Table structure for stock_adjustment_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `stock_adjustment_order_trace`;
CREATE TABLE `stock_adjustment_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存调整单跟踪';

-- ----------------------------
-- Table structure for stock_in_transit_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_in_transit_order`;
CREATE TABLE `stock_in_transit_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10采购在途，11调拨在途)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  `status` tinyint(4) NOT NULL COMMENT '订单状态(10在途，11已释放)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存在途单';

-- ----------------------------
-- Table structure for stock_in_transit_order_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_in_transit_order_item`;
CREATE TABLE `stock_in_transit_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存在途单行';

-- ----------------------------
-- Table structure for stock_in_transit_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `stock_in_transit_order_trace`;
CREATE TABLE `stock_in_transit_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存在途单跟踪';

-- ----------------------------
-- Table structure for stock_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_item`;
CREATE TABLE `stock_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `inout` tinyint(4) NOT NULL COMMENT '出入库(1入库，2出库)',
  `type` smallint(6) NOT NULL COMMENT '类型(1000采购入库、1010采购退货、1100调拨入库、1110调拨出库、1200加盟商补货、1210加盟商退货、2000核增、2100核减、3000盘盈、3100盘亏)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '出入库数量',
  `surplus` int(11) NOT NULL COMMENT '剩余库存数量',
  `order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号(入库单、出库单、调整单、移动单)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `location_id` (`location_id`),
  KEY `product_id_2` (`product_id`,`storehouse_id`),
  KEY `create_time_2` (`create_time`,`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存流水(特大表)';

-- ----------------------------
-- Table structure for stock_lock_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_lock_order`;
CREATE TABLE `stock_lock_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000订单占用，1100调拨占用，1200锁定)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号(调拨单、加盟商补货单)',
  `status` smallint(6) NOT NULL COMMENT '订单状态(1000已锁定，1100已解锁)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存锁定单';

-- ----------------------------
-- Table structure for stock_lock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_lock_order_item`;
CREATE TABLE `stock_lock_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '锁定单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存锁定单行(大表)';

-- ----------------------------
-- Table structure for stock_move_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_move_order`;
CREATE TABLE `stock_move_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` smallint(6) NOT NULL COMMENT '订单状态(11000待处理，19000已处理，20000已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `related_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型(1:普通，2:质检异常单)',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存移动单';

-- ----------------------------
-- Table structure for stock_move_order_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_move_order_item`;
CREATE TABLE `stock_move_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '移动单ID',
  `source_location_id` int(11) NOT NULL COMMENT '源库位ID',
  `target_location_id` int(11) NOT NULL COMMENT '目标库位ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '移动数量',
  `delete_source` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否删除源库存记录(0否，1是)',
  `source_location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '源库位编号',
  `target_location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '目标库位编号',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存移动单行';

-- ----------------------------
-- Table structure for stock_move_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `stock_move_order_trace`;
CREATE TABLE `stock_move_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '移动单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存移动单跟踪';

-- ----------------------------
-- Table structure for stock_scrap_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_scrap_order`;
CREATE TABLE `stock_scrap_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(5:待审核,10:已审核,20:已报废,30:已取消)',
  `summary` varchar(120) COLLATE utf8_bin DEFAULT '' COMMENT '产品摘要',
  `user_id` int(11) DEFAULT NULL COMMENT '创建人ID',
  `note` varchar(255) COLLATE utf8_bin DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  `complete_time` datetime DEFAULT NULL COMMENT '处理时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='报废单';

-- ----------------------------
-- Table structure for stock_scrap_order_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_scrap_order_item`;
CREATE TABLE `stock_scrap_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '报废单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位名称',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='报废单明细';

-- ----------------------------
-- Table structure for stock_scrap_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `stock_scrap_order_trace`;
CREATE TABLE `stock_scrap_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '报废单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='报废单日志';

-- ----------------------------
-- Table structure for stock_virtual_order
-- ----------------------------
DROP TABLE IF EXISTS `stock_virtual_order`;
CREATE TABLE `stock_virtual_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(10促销活动)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  `status` tinyint(4) NOT NULL COMMENT '订单状态(10已增加，11已释放)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存虚拟单';

-- ----------------------------
-- Table structure for stock_virtual_order_item
-- ----------------------------
DROP TABLE IF EXISTS `stock_virtual_order_item`;
CREATE TABLE `stock_virtual_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '订单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存虚拟单行';

-- ----------------------------
-- Table structure for stock_virtual_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `stock_virtual_order_trace`;
CREATE TABLE `stock_virtual_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `order_id` bigint(20) NOT NULL COMMENT '订单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='库存虚拟单跟踪';

-- ----------------------------
-- Table structure for store_requisition_order
-- ----------------------------
DROP TABLE IF EXISTS `store_requisition_order`;
CREATE TABLE `store_requisition_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `partner_id` int(11) NOT NULL DEFAULT '0' COMMENT '运营中心ID',
  `status` smallint(6) NOT NULL COMMENT '状态(11000待审核，12000待发货，19000已完成，20000已取消，21000已退单)',
  `user_id` int(11) NOT NULL COMMENT '申请员工ID',
  `receiptor_id` int(11) NOT NULL COMMENT '领用人ID',
  `receiptor_name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '领用人名称',
  `audit_id` int(11) NOT NULL DEFAULT '0' COMMENT '审核员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `use` int(11) NOT NULL COMMENT '用途',
  `stock_lock_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '库存锁定单号',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `deliver_time` datetime DEFAULT NULL COMMENT '发货时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='领用单';

-- ----------------------------
-- Table structure for store_requisition_order_item
-- ----------------------------
DROP TABLE IF EXISTS `store_requisition_order_item`;
CREATE TABLE `store_requisition_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '领用单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '领用数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际发货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='领用单行';

-- ----------------------------
-- Table structure for store_requisition_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `store_requisition_order_trace`;
CREATE TABLE `store_requisition_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '领用单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='领用单跟踪';

-- ----------------------------
-- Table structure for store_return_order
-- ----------------------------
DROP TABLE IF EXISTS `store_return_order`;
CREATE TABLE `store_return_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` smallint(6) NOT NULL COMMENT '状态(11000待受理，13000待收货，19000已完成，20000已取消)',
  `user_id` int(11) NOT NULL COMMENT '申请员工ID',
  `accept_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `use` int(11) NOT NULL COMMENT '用途',
  `total_sku` int(11) NOT NULL COMMENT '总SKU数',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='领用退回单';

-- ----------------------------
-- Table structure for store_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `store_return_order_item`;
CREATE TABLE `store_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '领用退回单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '退回数量',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `actual_quantity` int(11) DEFAULT NULL COMMENT '实际收货数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='领用退回单行';

-- ----------------------------
-- Table structure for store_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `store_return_order_trace`;
CREATE TABLE `store_return_order_trace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL COMMENT '领用退回单ID',
  `status` smallint(6) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='领用退回单跟踪';

-- ----------------------------
-- Table structure for storehouse
-- ----------------------------
DROP TABLE IF EXISTS `storehouse`;
CREATE TABLE `storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `entity_virtual` tinyint(4) NOT NULL COMMENT '实体/虚拟(10:实体仓,20:虚拟仓)',
  `type` tinyint(4) NOT NULL COMMENT '类型(10直营仓，20合资仓，30工厂仓)',
  `level` tinyint(4) NOT NULL DEFAULT '0' COMMENT '级别(0未定义，20区域仓，30省仓，60前置仓)',
  `include_company_assets` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否计入公司资产(0否，1是)',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '地址',
  `lng` decimal(10,7) NOT NULL COMMENT '经度',
  `lat` decimal(10,7) NOT NULL COMMENT '纬度',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，9000已删除)',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `init` smallint(6) NOT NULL DEFAULT '0' COMMENT '初始化标记',
  `stock_limit_amount` decimal(16,2) DEFAULT NULL COMMENT '库存额度',
  `distribution_display` tinyint(3) unsigned NOT NULL DEFAULT '10' COMMENT '服务商是否可见,10:可见，20:不可见',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `name` (`name`),
  KEY `province_id` (`province_id`),
  KEY `city_id` (`city_id`),
  KEY `district_id` (`district_id`),
  KEY `lng` (`lng`),
  KEY `lat` (`lat`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库';

-- ----------------------------
-- Table structure for storehouse_business_reference
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_business_reference`;
CREATE TABLE `storehouse_business_reference` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `source_table` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '源表',
  `source_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '源业务名称',
  `target_table` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '目标表',
  `target_name` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '目标业务名称',
  `reference_value` int(11) NOT NULL COMMENT '引用值',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `reference_value` (`reference_value`,`target_table`,`source_table`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='业务值引用表';

-- ----------------------------
-- Table structure for storehouse_contacter
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_contacter`;
CREATE TABLE `storehouse_contacter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000负责人，1100常用联系人)',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `duties` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '职务',
  `tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `qq` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'QQ',
  `email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Email',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100无效)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=143 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库联系人';

-- ----------------------------
-- Table structure for storehouse_module
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_module`;
CREATE TABLE `storehouse_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模块ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '模块名称',
  `catalog_id` int(11) NOT NULL COMMENT '所属目录ID(0没有归属目录)',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '模块描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21002007 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库模块';

-- ----------------------------
-- Table structure for storehouse_module_catalog
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_module_catalog`;
CREATE TABLE `storehouse_module_catalog` (
  `id` int(11) NOT NULL COMMENT '目录ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '目录名称',
  `parent_id` int(11) NOT NULL COMMENT '父目录ID',
  `level` smallint(6) NOT NULL COMMENT '目录级别',
  `orderby` int(11) NOT NULL COMMENT '目录排序',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库模块目录';

-- ----------------------------
-- Table structure for storehouse_module_route
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_module_route`;
CREATE TABLE `storehouse_module_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  `route` varchar(100) COLLATE utf8_bin NOT NULL COMMENT '模块路由',
  PRIMARY KEY (`id`),
  UNIQUE KEY `route` (`route`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=334 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库模块路由';

-- ----------------------------
-- Table structure for storehouse_order_number_sequence
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_order_number_sequence`;
CREATE TABLE `storehouse_order_number_sequence` (
  `type` char(3) COLLATE utf8_bin NOT NULL COMMENT '业务编号',
  `date` date NOT NULL COMMENT '日期',
  `value` int(11) NOT NULL COMMENT '值',
  PRIMARY KEY (`type`,`date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库订单编号自增序列';

-- ----------------------------
-- Table structure for storehouse_role
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_role`;
CREATE TABLE `storehouse_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '角色名称',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=1005 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库角色';

-- ----------------------------
-- Table structure for storehouse_role_module
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_role_module`;
CREATE TABLE `storehouse_role_module` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `role_id` int(11) NOT NULL COMMENT '角色编号',
  `module_id` int(11) NOT NULL COMMENT '模块编号',
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=466 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库角色模块';

-- ----------------------------
-- Table structure for storehouse_setting
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_setting`;
CREATE TABLE `storehouse_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `code` smallint(6) NOT NULL COMMENT '编号(10010：日最大收货件数)',
  `value` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '值',
  `type` tinyint(4) NOT NULL COMMENT '类型(10整形，20浮点型，30字符串)',
  `description` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库参数表';

-- ----------------------------
-- Table structure for storehouse_setting_outstock_priority
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_setting_outstock_priority`;
CREATE TABLE `storehouse_setting_outstock_priority` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `business_id` smallint(6) NOT NULL COMMENT '业务ID',
  `business_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '业务名称',
  `priority` tinyint(4) NOT NULL DEFAULT '10' COMMENT '优先级',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `business_id` (`business_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库出库优先级设置';

-- ----------------------------
-- Table structure for storehouse_setting_product_category
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_setting_product_category`;
CREATE TABLE `storehouse_setting_product_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `mqq` int(11) NOT NULL DEFAULT '0' COMMENT '最小起订量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库产品品类设置';

-- ----------------------------
-- Table structure for storehouse_setting_product_category_item
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_setting_product_category_item`;
CREATE TABLE `storehouse_setting_product_category_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `setting_id` int(11) NOT NULL COMMENT '设置ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`category_id`),
  KEY `setting_id` (`setting_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库产品品类设置明细';

-- ----------------------------
-- Table structure for storehouse_setting_product_mpq
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_setting_product_mpq`;
CREATE TABLE `storehouse_setting_product_mpq` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `mpq` int(11) NOT NULL DEFAULT '0' COMMENT '最小包装量',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=438 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库产品最小包装量';

-- ----------------------------
-- Table structure for storehouse_setting_product_section
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_setting_product_section`;
CREATE TABLE `storehouse_setting_product_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `category_id` int(11) NOT NULL COMMENT '品类ID',
  `section_id` int(11) NOT NULL COMMENT '库区ID',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`),
  KEY `category_id` (`storehouse_id`,`category_id`),
  KEY `section_id` (`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品库区设置';

-- ----------------------------
-- Table structure for storehouse_stock
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_stock`;
CREATE TABLE `storehouse_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '库存数量',
  `order_occupied` int(11) NOT NULL DEFAULT '0' COMMENT '订单占用库存',
  `preorder_occupied` int(11) NOT NULL DEFAULT '0' COMMENT '预订占用库存',
  `transport_occupied` int(11) NOT NULL DEFAULT '0' COMMENT '调拨占用库存',
  `locked` int(11) NOT NULL DEFAULT '0' COMMENT '锁定库存',
  `purchase_in_transit` int(11) NOT NULL DEFAULT '0' COMMENT '采购在途库存',
  `allocation_in_transit` int(11) NOT NULL DEFAULT '0' COMMENT '调拨在途库存',
  `virtual` int(11) NOT NULL DEFAULT '0' COMMENT '虚拟库存',
  `unsellable` int(11) NOT NULL DEFAULT '0' COMMENT '不可销售库存',
  `purchase_return_occupied` int(11) NOT NULL DEFAULT '0' COMMENT '采购退货占用库存',
  `store_requisition_occupied` int(11) NOT NULL DEFAULT '0' COMMENT '领用占用库存',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`storehouse_id`),
  KEY `storehouse_stock_storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2667770 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库库存';

-- ----------------------------
-- Table structure for storehouse_stock_virtual_item
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_stock_virtual_item`;
CREATE TABLE `storehouse_stock_virtual_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `inout` tinyint(4) NOT NULL COMMENT '出入库(1:入库，-1:出库)',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:初始化,3:成品入库,5:成品出库)',
  `quantity` int(11) NOT NULL COMMENT '出入库数量',
  `surplus` int(11) NOT NULL COMMENT '剩余库存数量',
  `order_number` char(20) NOT NULL DEFAULT '' COMMENT '相关单号',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='仓库虚拟库存流水';

-- ----------------------------
-- Table structure for storehouse_user
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_user`;
CREATE TABLE `storehouse_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password_hash` char(60) COLLATE utf8_bin NOT NULL COMMENT '登录密码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系电话',
  `mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `qq` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'QQ',
  `email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Email',
  `type` tinyint(4) NOT NULL COMMENT '类型(1系统管理员，2普通用户)',
  `discharge_staff` tinyint(4) DEFAULT '0' COMMENT '是否卸货员(0:否,1:是)',
  `receive_staff` tinyint(4) DEFAULT '0' COMMENT '是否收货员(0:否,1:是)',
  `putaway_staff` tinyint(4) DEFAULT '0' COMMENT '是否上架员(0:否,1:是)',
  `pick_staff` tinyint(4) DEFAULT '0' COMMENT '是否拣货员(0:否,1:是)',
  `pack_staff` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否打包员(0:否,1:是)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100待激活，1200冻结，9000已删除)',
  `timeout` smallint(6) NOT NULL COMMENT '登录超时时间',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=597 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库用户';

-- ----------------------------
-- Table structure for storehouse_user_authorized_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_user_authorized_storehouse`;
CREATE TABLE `storehouse_user_authorized_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库用户授权仓库';

-- ----------------------------
-- Table structure for storehouse_user_role
-- ----------------------------
DROP TABLE IF EXISTS `storehouse_user_role`;
CREATE TABLE `storehouse_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_id` (`role_id`,`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1373 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库用户角色';

-- ----------------------------
-- Table structure for sub_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `sub_storehouse`;
CREATE TABLE `sub_storehouse` (
  `id` int(11) NOT NULL COMMENT '主仓ID',
  `storehouse_id` int(11) NOT NULL COMMENT '辅仓ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  KEY `id` (`id`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='辅仓';

-- ----------------------------
-- Table structure for supplier
-- ----------------------------
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '供应商ID',
  `number` char(4) COLLATE utf8_bin NOT NULL COMMENT '编号',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '简称',
  `full_name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '全称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100冻结，9000已删除)',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  `website` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '网站',
  `main_product` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '主营产品',
  `person_in_charge_id` int(11) NOT NULL DEFAULT '0' COMMENT '负责人ID',
  `tax_rate` decimal(3,2) NOT NULL DEFAULT '0.00',
  `reconciliation_method` tinyint(4) NOT NULL DEFAULT '0' COMMENT '对账方式(0:无)',
  `settlement_method` smallint(6) NOT NULL DEFAULT '0' COMMENT '结算方式(0:无)',
  `purchase_rebate` decimal(5,2) DEFAULT NULL COMMENT '采购返利',
  `after_sale_rebate` decimal(5,2) DEFAULT NULL COMMENT '售后返利',
  `other_rebate` varchar(120) COLLATE utf8_bin DEFAULT NULL COMMENT '其它返利',
  `is_signed_contract` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否签订合同(0:否,1:是)',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '锁定',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  `acceptance_method` smallint(6) NOT NULL DEFAULT '0' COMMENT '承兑方式(90,120,150,180)',
  `business_expire_date` date DEFAULT NULL COMMENT '业务操作截止日期',
  `is_bear_logistics_cost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否承担物流费用(0否，1是)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `number` (`number`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=278 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=DYNAMIC COMMENT='供应商';

-- ----------------------------
-- Table structure for supplier_agency_order
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_order`;
CREATE TABLE `supplier_agency_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `related_number` char(20) NOT NULL DEFAULT '' COMMENT '相关单号',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `total_sku` smallint(6) NOT NULL DEFAULT '0' COMMENT 'SKU数量',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `total_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '总价(元)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待发货，30:已发货,60:已取消)',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受理员工ID',
  `logistics_id` int(11) NOT NULL DEFAULT '0' COMMENT '物流方式ID',
  `logistics_number` varchar(80) NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_cost` tinyint(4) NOT NULL DEFAULT '0' COMMENT '支付方式(0:无,1:到付,2:垫付)',
  `logistics_cost_amount` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '物流费用',
  `logistics_name` varchar(30) NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_contact_tel` varchar(90) NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_contact_address` varchar(255) NOT NULL DEFAULT '' COMMENT '物流联系地址',
  `logistics_note` varchar(100) NOT NULL DEFAULT '' COMMENT '物流备注',
  `reconciliation_status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '对账状态(10:未就绪,20:待对账,30:已对账)',
  `reconciliation_order_number` char(20) NOT NULL DEFAULT '' COMMENT '对账单号',
  `attachment` varchar(255) NOT NULL DEFAULT '' COMMENT '附件',
  `box_quantity` smallint(6) NOT NULL DEFAULT '0' COMMENT '箱数',
  `priority` tinyint(4) NOT NULL DEFAULT '10' COMMENT '优先级',
  `stock_lock_order_number` char(20) NOT NULL DEFAULT '' COMMENT '库存锁定单单号',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `delivery_date` date DEFAULT NULL COMMENT '发货日期',
  `create_time` datetime NOT NULL COMMENT '下单时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`),
  KEY `reconciliation_order_number` (`reconciliation_order_number`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商代理发货单';

-- ----------------------------
-- Table structure for supplier_agency_order_consignee
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_order_consignee`;
CREATE TABLE `supplier_agency_order_consignee` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '代理发货单ID',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `contact_name` varchar(20) NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) NOT NULL COMMENT '收货地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商代理发货单收货信息';

-- ----------------------------
-- Table structure for supplier_agency_order_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_order_item`;
CREATE TABLE `supplier_agency_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '代理发货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `box_package_specs` smallint(6) NOT NULL DEFAULT '0' COMMENT '箱包装规格',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `unit_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '单价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商代理发货单明细';

-- ----------------------------
-- Table structure for supplier_agency_order_pre_allocate_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_order_pre_allocate_item`;
CREATE TABLE `supplier_agency_order_pre_allocate_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '代理发货单ID',
  `lock_order_id` bigint(20) NOT NULL COMMENT '锁定单ID',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `lock_order_id` (`lock_order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商代理发货单预分配行';

-- ----------------------------
-- Table structure for supplier_agency_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_order_trace`;
CREATE TABLE `supplier_agency_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` bigint(20) NOT NULL COMMENT '代理发货单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商代理发货单日志';

-- ----------------------------
-- Table structure for supplier_agency_return_order
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_return_order`;
CREATE TABLE `supplier_agency_return_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `related_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  `total_quantity` int(11) NOT NULL COMMENT '总数量',
  `total_sku` smallint(6) NOT NULL COMMENT 'SKU数',
  `total_price` decimal(12,4) NOT NULL COMMENT '总金额(元)',
  `summary` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '产品摘要',
  `reason` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '原因',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待收货,30:已收货,60:已取消)',
  `logistics_name` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流名称',
  `logistics_number` varchar(30) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流单号',
  `logistics_contact_name` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系人',
  `logistics_contact_tel` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流联系电话',
  `logistics_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '物流备注',
  `logistics_attachment` varchar(1000) COLLATE utf8_bin NOT NULL DEFAULT '[]' COMMENT '物流附件',
  `reconciliation_status` tinyint(4) NOT NULL DEFAULT '10' COMMENT '对账状态(10:未就绪,20:待对账,30:已对账)',
  `reconciliation_order_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '对账单号',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '创建人id',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '创建人名称',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商代理退货单';

-- ----------------------------
-- Table structure for supplier_agency_return_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_return_order_contact`;
CREATE TABLE `supplier_agency_return_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '退货单ID',
  `name` varchar(64) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商代理退货单联系人';

-- ----------------------------
-- Table structure for supplier_agency_return_order_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_return_order_item`;
CREATE TABLE `supplier_agency_return_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '退货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` char(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '产品数量',
  `unit_price` decimal(10,4) DEFAULT NULL COMMENT '单价(元)',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商代理退货单明细';

-- ----------------------------
-- Table structure for supplier_agency_return_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `supplier_agency_return_order_trace`;
CREATE TABLE `supplier_agency_return_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '退货单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_type` smallint(6) NOT NULL COMMENT '操作人类型',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '操作人名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商代理退货单日志';

-- ----------------------------
-- Table structure for supplier_contacter
-- ----------------------------
DROP TABLE IF EXISTS `supplier_contacter`;
CREATE TABLE `supplier_contacter` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `type` smallint(6) NOT NULL COMMENT '类型(1000负责人，1100联系人)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100无效)',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `duties` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '职务',
  `tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Email',
  `qq` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'QQ',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=393 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商联系人';

-- ----------------------------
-- Table structure for supplier_deliver_order
-- ----------------------------
DROP TABLE IF EXISTS `supplier_deliver_order`;
CREATE TABLE `supplier_deliver_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` varchar(20) NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `status` tinyint(4) NOT NULL COMMENT '状态(20:待发货, 40:待收货，50：已完成，60：已取消)',
  `settlement_method` smallint(6) NOT NULL DEFAULT '0' COMMENT '结算方式(10000现结，11000月结，12000铺货)',
  `total_quantity` int(11) NOT NULL DEFAULT '0' COMMENT '总数量',
  `total_price` decimal(12,4) NOT NULL DEFAULT '0.0000' COMMENT '总价格(元)',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(20) NOT NULL COMMENT '创建人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商发货单';

-- ----------------------------
-- Table structure for supplier_deliver_order_contact
-- ----------------------------
DROP TABLE IF EXISTS `supplier_deliver_order_contact`;
CREATE TABLE `supplier_deliver_order_contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '供应商发货单ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '名称',
  `contact_name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '联系人姓名',
  `contact_tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `contact_mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `contact_email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系Email',
  `province_id` int(11) NOT NULL COMMENT '省份',
  `city_id` int(11) NOT NULL COMMENT '城市',
  `district_id` int(11) NOT NULL COMMENT '区县',
  `address` varchar(120) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '地址',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商发货单联系信息';

-- ----------------------------
-- Table structure for supplier_deliver_order_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_deliver_order_item`;
CREATE TABLE `supplier_deliver_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '供应商发货单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) COLLATE utf8_bin NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `unit_price` decimal(10,4) NOT NULL DEFAULT '0.0000' COMMENT '单价(元)',
  `tax_rate` decimal(3,2) NOT NULL DEFAULT '0.00' COMMENT '税率',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商发货单明细';

-- ----------------------------
-- Table structure for supplier_deliver_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `supplier_deliver_order_trace`;
CREATE TABLE `supplier_deliver_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '供应商发货单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商发货单日志';

-- ----------------------------
-- Table structure for supplier_fg_instock_order
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_instock_order`;
CREATE TABLE `supplier_fg_instock_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '单号',
  `related_number` char(20) NOT NULL DEFAULT '' COMMENT '相关单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:生产, 2:撤销发货)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待入库, 20:已完成，30：已取消)',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(20) NOT NULL COMMENT '创建人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品入库单';

-- ----------------------------
-- Table structure for supplier_fg_instock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_instock_order_item`;
CREATE TABLE `supplier_fg_instock_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '成品入库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品入库单明细';

-- ----------------------------
-- Table structure for supplier_fg_instock_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_instock_order_trace`;
CREATE TABLE `supplier_fg_instock_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '成品入库单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品入库单日志';

-- ----------------------------
-- Table structure for supplier_fg_outstock_order
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_outstock_order`;
CREATE TABLE `supplier_fg_outstock_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) NOT NULL COMMENT '单号',
  `related_number` char(20) NOT NULL DEFAULT '' COMMENT '相关单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:撤销生产, 2:发货)',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:待出库, 20:已完成，30：已取消)',
  `summary` varchar(120) NOT NULL DEFAULT '' COMMENT '产品摘要',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `user_name` varchar(20) NOT NULL COMMENT '创建人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品出库单';

-- ----------------------------
-- Table structure for supplier_fg_outstock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_outstock_order_item`;
CREATE TABLE `supplier_fg_outstock_order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '成品出库单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `product_number` varchar(20) NOT NULL COMMENT '产品编号',
  `product_supplier_number` varchar(30) NOT NULL COMMENT '产品供应商编号',
  `product_name` varchar(120) NOT NULL COMMENT '产品名称',
  `product_category` varchar(20) NOT NULL COMMENT '产品品类',
  `product_brand` varchar(20) NOT NULL COMMENT '产品品牌',
  `product_unit` varchar(10) NOT NULL DEFAULT '' COMMENT '计量单位',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品出库单明细';

-- ----------------------------
-- Table structure for supplier_fg_outstock_order_trace
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_outstock_order_trace`;
CREATE TABLE `supplier_fg_outstock_order_trace` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `order_id` int(11) NOT NULL COMMENT '成品出库单ID',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `user_id` int(11) NOT NULL COMMENT '操作人ID',
  `user_name` varchar(20) NOT NULL COMMENT '操作人名称',
  `note` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品出库单日志';

-- ----------------------------
-- Table structure for supplier_fg_stock
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_stock`;
CREATE TABLE `supplier_fg_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '库存数量',
  `order_occupied` int(11) NOT NULL DEFAULT '0' COMMENT '订单占用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplier_id` (`supplier_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品库存';

-- ----------------------------
-- Table structure for supplier_fg_stock_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_stock_item`;
CREATE TABLE `supplier_fg_stock_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:生产,2:撤销发货,51:撤销生产,52:发货)',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `inout` tinyint(4) NOT NULL COMMENT '入扣(1入，-1扣)',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `surplus` int(11) NOT NULL COMMENT '剩余库存',
  `related_number` varchar(20) NOT NULL DEFAULT '' COMMENT '相关单号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`,`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商成品库存流水';

-- ----------------------------
-- Table structure for supplier_fg_stock_lock_order
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_stock_lock_order`;
CREATE TABLE `supplier_fg_stock_lock_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '单号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:代理单)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  `status` tinyint(4) NOT NULL COMMENT '状态(10:已锁定,30:已解锁)',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `user_id` int(11) NOT NULL COMMENT '创建人ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商成品库存锁定单';

-- ----------------------------
-- Table structure for supplier_fg_stock_lock_order_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_fg_stock_lock_order_item`;
CREATE TABLE `supplier_fg_stock_lock_order_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `order_id` bigint(20) NOT NULL COMMENT '锁定单ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商成品库存锁定单明细';

-- ----------------------------
-- Table structure for supplier_production_plan_item
-- ----------------------------
DROP TABLE IF EXISTS `supplier_production_plan_item`;
CREATE TABLE `supplier_production_plan_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `productive_date` date NOT NULL COMMENT '生产日期',
  `offline_date` date NOT NULL COMMENT '下线日期',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `supplier_id` (`supplier_id`),
  KEY `product_id` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商生产计划';

-- ----------------------------
-- Table structure for supplier_stock
-- ----------------------------
DROP TABLE IF EXISTS `supplier_stock`;
CREATE TABLE `supplier_stock` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `demand` int(11) NOT NULL COMMENT '需求量',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '库存量',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_id` (`product_id`,`supplier_id`),
  KEY `supplier_id` (`supplier_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商备货';

-- ----------------------------
-- Table structure for supplier_storehouse
-- ----------------------------
DROP TABLE IF EXISTS `supplier_storehouse`;
CREATE TABLE `supplier_storehouse` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '供应商ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `supplier_id` (`supplier_id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商仓库表';

-- ----------------------------
-- Table structure for supplier_user
-- ----------------------------
DROP TABLE IF EXISTS `supplier_user`;
CREATE TABLE `supplier_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `supplier_id` int(11) NOT NULL COMMENT '仓库ID',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password_hash` char(60) COLLATE utf8_bin NOT NULL COMMENT '登录密码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '联系电话',
  `mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `qq` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'QQ',
  `email` varchar(90) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Email',
  `type` tinyint(4) NOT NULL COMMENT '类型(1管理员，2普通用户)',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100待激活，1200冻结，9000已注销)',
  `timeout` smallint(6) NOT NULL COMMENT '登录超时时间',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='供应商用户';

-- ----------------------------
-- Table structure for table_number_sequence
-- ----------------------------
DROP TABLE IF EXISTS `table_number_sequence`;
CREATE TABLE `table_number_sequence` (
  `table_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '表名',
  `type` tinyint(4) NOT NULL COMMENT '类型(5:递增,10:按天,15:按月)',
  `digits` tinyint(4) NOT NULL COMMENT '位数',
  `prefix` varchar(2) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '前缀',
  `last_day` varchar(8) COLLATE utf8mb4_bin NOT NULL COMMENT '最后更新日期',
  `serial_number` int(11) NOT NULL COMMENT '序号',
  `note` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '备注',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='表编号序列';

-- ----------------------------
-- Table structure for tag
-- ----------------------------
DROP TABLE IF EXISTS `tag`;
CREATE TABLE `tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `distribution_id` int(11) NOT NULL DEFAULT '0' COMMENT '加盟商ID',
  `name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '标签名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效、1100无效、9000已删除)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  PRIMARY KEY (`id`),
  KEY `distribution_id` (`distribution_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品标签';

-- ----------------------------
-- Table structure for transaction_type
-- ----------------------------
DROP TABLE IF EXISTS `transaction_type`;
CREATE TABLE `transaction_type` (
  `id` int(11) NOT NULL COMMENT '交易类型ID',
  `name` varchar(60) COLLATE utf8_bin NOT NULL COMMENT '交易类型名称',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100无效)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='交易类型';

-- ----------------------------
-- Table structure for tsy_price_import
-- ----------------------------
DROP TABLE IF EXISTS `tsy_price_import`;
CREATE TABLE `tsy_price_import` (
  `product` varchar(255) DEFAULT NULL,
  `last_purchase_price` decimal(10,4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unit
-- ----------------------------
DROP TABLE IF EXISTS `unit`;
CREATE TABLE `unit` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '单位名称',
  `status` tinyint(4) NOT NULL COMMENT '状态(0禁用，1启用)',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='产品计量单位';

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '用户名',
  `password_hash` char(60) COLLATE utf8_bin NOT NULL COMMENT '登录密码',
  `name` varchar(20) COLLATE utf8_bin NOT NULL COMMENT '姓名',
  `department_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属部门ID',
  `tel` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '固定电话',
  `mobi` varchar(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '手机号码',
  `email` varchar(90) COLLATE utf8_bin NOT NULL COMMENT 'Email',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，1100冻结，8000不可登录，9000已注销)',
  `timeout` smallint(6) NOT NULL COMMENT '登录超时时间',
  `note` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注',
  `note_department` varchar(255) COLLATE utf8_bin NOT NULL COMMENT '所属部门',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `i_username` (`username`),
  KEY `i_create_time` (`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=529 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='后台用户';

-- ----------------------------
-- Table structure for user_section
-- ----------------------------
DROP TABLE IF EXISTS `user_section`;
CREATE TABLE `user_section` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `section_id` int(11) NOT NULL COMMENT '库区ID',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`section_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='用户库区分管表';

-- ----------------------------
-- Table structure for user_task_summary
-- ----------------------------
DROP TABLE IF EXISTS `user_task_summary`;
CREATE TABLE `user_task_summary` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `task_num` int(11) NOT NULL DEFAULT '0' COMMENT '执行中任务数量',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '执行中的数量合计',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `storehouse_id` (`storehouse_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库工作任务汇总';

-- ----------------------------
-- Table structure for wechat_group
-- ----------------------------
DROP TABLE IF EXISTS `wechat_group`;
CREATE TABLE `wechat_group` (
  `id` int(11) NOT NULL COMMENT 'ID（微信端返回ID）',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，9000无效)',
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '分组名称',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '描述',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='微信分组';

-- ----------------------------
-- Table structure for wechat_user
-- ----------------------------
DROP TABLE IF EXISTS `wechat_user`;
CREATE TABLE `wechat_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `openid` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '微信OPEN ID',
  `status` smallint(6) NOT NULL COMMENT '状态(1000有效，9000无效)',
  `nickname` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户昵称',
  `sex` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户的性别，1男性，2女性，0未知',
  `province` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户个人资料填写的省份',
  `city` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '普通用户个人资料填写的城市',
  `country` varchar(30) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '国家',
  `headimgurl` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '用户头像',
  `remark` varchar(255) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '公众号运营者对粉丝的备注',
  `subscribe_time` bigint(20) NOT NULL COMMENT '用户关注时间戳',
  `create_time` datetime NOT NULL COMMENT '添加时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `openid` (`openid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='微信账号';

-- ----------------------------
-- Table structure for withdrawals_order
-- ----------------------------
DROP TABLE IF EXISTS `withdrawals_order`;
CREATE TABLE `withdrawals_order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '订单编号',
  `account_id` int(11) NOT NULL COMMENT '账户ID',
  `amount` decimal(16,2) NOT NULL COMMENT '金额',
  `status` smallint(6) NOT NULL COMMENT '状态(1000待审核、1100审核通过、2000审核不通过)',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `status_time` datetime NOT NULL COMMENT '状态时间',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  `audit_id` int(11) NOT NULL DEFAULT '0' COMMENT '审核人ID',
  `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
  `audit_note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '审核意见',
  PRIMARY KEY (`id`),
  KEY `account_id` (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='提现申请单(大表)';

-- ----------------------------
-- Table structure for work_performance
-- ----------------------------
DROP TABLE IF EXISTS `work_performance`;
CREATE TABLE `work_performance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `score_date` date NOT NULL COMMENT '计分日期',
  `quantity` int(11) NOT NULL DEFAULT '0' COMMENT '数量',
  `score` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '分数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`score_date`),
  KEY `storehouse_id` (`storehouse_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作绩效';

-- ----------------------------
-- Table structure for work_performance_item
-- ----------------------------
DROP TABLE IF EXISTS `work_performance_item`;
CREATE TABLE `work_performance_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `user_id` int(11) NOT NULL COMMENT '员工ID',
  `score_date` date NOT NULL COMMENT '计分日期',
  `work_task_id` int(11) NOT NULL COMMENT '任务明细ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:上架，5:拣货)',
  `product_id` int(11) NOT NULL COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `score` decimal(8,2) NOT NULL DEFAULT '0.00' COMMENT '分数',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `user_id` (`user_id`,`score_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作绩效流水';

-- ----------------------------
-- Table structure for work_task
-- ----------------------------
DROP TABLE IF EXISTS `work_task`;
CREATE TABLE `work_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `work_task_group_id` int(11) NOT NULL COMMENT '工作任务分组ID',
  `number` char(20) COLLATE utf8_bin NOT NULL COMMENT '任务单号',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:上架,10:拣货)',
  `related_number` char(20) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '相关单号',
  `item_id` int(11) NOT NULL DEFAULT '0' COMMENT '相关记录ID',
  `product_id` int(11) NOT NULL DEFAULT '0' COMMENT '产品ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `completed_quantity` int(11) NOT NULL COMMENT '已完成数量',
  `source_location` int(11) NOT NULL DEFAULT '0' COMMENT '来源库位',
  `target_location` int(11) NOT NULL DEFAULT '0' COMMENT '目标库位',
  `description` varchar(200) COLLATE utf8_bin NOT NULL COMMENT '操作描述',
  `status` tinyint(4) NOT NULL COMMENT '状态(1:待执行,5:执行中,10:已完成,20:已取消)',
  `pack_zone_id` int(11) NOT NULL DEFAULT '0' COMMENT '打包区ID',
  `creator_id` int(11) NOT NULL COMMENT '创建人ID',
  `executor_id` int(11) NOT NULL COMMENT '执行人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态更新时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  UNIQUE KEY `number` (`number`),
  KEY `storehouse_id` (`storehouse_id`),
  KEY `item_id` (`item_id`,`type`),
  KEY `related_number` (`related_number`),
  KEY `work_task_group_id` (`work_task_group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库工作任务';

-- ----------------------------
-- Table structure for work_task_group
-- ----------------------------
DROP TABLE IF EXISTS `work_task_group`;
CREATE TABLE `work_task_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `storehouse_id` int(11) NOT NULL COMMENT '仓库ID',
  `type` tinyint(4) NOT NULL COMMENT '类型(1:上架,10:拣货)',
  `task_num` smallint(6) NOT NULL COMMENT '任务数量',
  `task_finish_num` smallint(6) NOT NULL COMMENT '已经完成任务数量(包括已完成，已取消的任务)',
  `total_quantity` int(11) NOT NULL COMMENT '数量总和',
  `status` tinyint(4) NOT NULL COMMENT '状态(1:待执行,5:执行中,10:已完成)',
  `pack_zone_id` int(11) NOT NULL DEFAULT '0' COMMENT '打包区ID',
  `creator_id` int(11) NOT NULL COMMENT '创建人ID',
  `executor_id` int(11) NOT NULL COMMENT '执行人ID',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status_time` datetime DEFAULT NULL COMMENT '状态时间',
  `note` varchar(255) COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `executor_id` (`executor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='仓库工作任务分组表';

-- ----------------------------
-- Table structure for work_task_group_related_number
-- ----------------------------
DROP TABLE IF EXISTS `work_task_group_related_number`;
CREATE TABLE `work_task_group_related_number` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `work_task_group_id` int(11) NOT NULL COMMENT '工作任务分组ID',
  `related_number` char(20) COLLATE utf8_bin NOT NULL COMMENT '相关单号',
  PRIMARY KEY (`id`),
  KEY `work_task_group_id` (`work_task_group_id`),
  KEY `related_number` (`related_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='工作任务分组相关单号';

-- ----------------------------
-- Table structure for work_task_target_item
-- ----------------------------
DROP TABLE IF EXISTS `work_task_target_item`;
CREATE TABLE `work_task_target_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_id` int(11) NOT NULL COMMENT '任务ID',
  `quantity` int(11) NOT NULL COMMENT '数量',
  `location_id` int(11) NOT NULL COMMENT '库位ID',
  `location_name` varchar(30) COLLATE utf8_bin NOT NULL COMMENT '库位名称',
  PRIMARY KEY (`id`),
  KEY `task_id` (`task_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='任务目标明细';

-- ----------------------------
-- View structure for storehouse_stock_summary
-- ----------------------------
DROP VIEW IF EXISTS `storehouse_stock_summary`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `storehouse_stock_summary` AS select `storehouse_stock`.`product_id` AS `product_id`,sum(`storehouse_stock`.`quantity`) AS `quantity`,sum(`storehouse_stock`.`unsellable`) AS `unsellable`,sum(`storehouse_stock`.`order_occupied`) AS `order_occupied`,sum(`storehouse_stock`.`preorder_occupied`) AS `preorder_occupied`,sum(`storehouse_stock`.`transport_occupied`) AS `transport_occupied`,sum(`storehouse_stock`.`purchase_return_occupied`) AS `purchase_return_occupied`,sum(`storehouse_stock`.`store_requisition_occupied`) AS `store_requisition_occupied`,sum(`storehouse_stock`.`locked`) AS `locked`,sum(`storehouse_stock`.`purchase_in_transit`) AS `purchase_in_transit`,sum(`storehouse_stock`.`allocation_in_transit`) AS `allocation_in_transit`,sum(`storehouse_stock`.`virtual`) AS `virtual` from `storehouse_stock` group by `storehouse_stock`.`product_id`;

SET FOREIGN_KEY_CHECKS = 1;
