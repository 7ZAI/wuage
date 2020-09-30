/*
 Navicat Premium Data Transfer

 Source Server         : 127.0.0.1
 Source Server Type    : MySQL
 Source Server Version : 50635
 Source Host           : 127.0.0.1:3306
 Source Schema         : wuage

 Target Server Type    : MySQL
 Target Server Version : 50635
 File Encoding         : 65001

 Date: 19/01/2020 17:26:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数id',
  `config_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数代码',
  `name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '参数名称',
  `config_value` int(11) NULL DEFAULT 0 COMMENT '参数值',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统参数表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'MAX_LOGIN_ERROR', '登录密码错误次数', 5);
INSERT INTO `sys_config` VALUES (2, 'FREEZE_HOUR', '冻结时间(h)', 1);
INSERT INTO `sys_config` VALUES (3, 'CAPTCHA_SWITCH', '验证码开关', 0);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `dept_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `dept_parent_id` int(11) NULL DEFAULT NULL COMMENT '父部门id',
  `leader` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门领导',
  `phone` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门电话',
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新人',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '总公司', 0, '张总', '13865488888', '2019-12-31 17:06:07', 'admin', '0000-00-00 00:00:00', '', '');

-- ----------------------------
-- Table structure for sys_dept_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept_role`;
CREATE TABLE `sys_dept_role`  (
  `dept_id` int(11) NOT NULL COMMENT '部门id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`dept_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dept_role
-- ----------------------------
INSERT INTO `sys_dept_role` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志di',
  `operator_type` tinyint(4) NULL DEFAULT NULL COMMENT '操作来类型 1登录日志 2 操作日志',
  `result` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作结果 json 数据',
  `ip` bigint(11) NULL DEFAULT NULL COMMENT 'ip',
  `log_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '操作时间',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求url',
  `description` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `param` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `operator_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `log_type` tinyint(4) NULL DEFAULT NULL COMMENT '日志类型 1后台系统 2前台系统',
  `error_msg` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误信息',
  `log_title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志标题',
  `operator_id` int(11) NULL DEFAULT NULL COMMENT '操作人id',
  `result_type` tinyint(4) NULL DEFAULT NULL COMMENT '结果类型 0 成功 1 失败',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 233 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (200, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:46:47', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (201, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:47:53', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (202, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:48:05', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (203, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:48:47', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (204, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:50:10', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (205, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:50:55', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (206, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:51:34', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (207, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:52:08', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (208, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:53:03', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (209, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:53:46', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (210, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:54:23', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (211, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:54:52', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (212, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:56:23', '/wuage/system/user/1', NULL, '{}', 'admin', 1, '', '删除用户', 1, 0);
INSERT INTO `sys_log` VALUES (213, 1, '登入失败', 2130706433, '2020-01-04 14:22:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (214, 1, '登入成功', 2130706433, '2020-01-04 14:22:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (215, 1, '登入成功', 2130706433, '2020-01-04 17:18:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (216, 1, '登入成功', 2130706433, '2020-01-04 17:30:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (217, 1, '登入成功', 2130706433, '2020-01-06 08:44:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (218, 1, '登入失败', 2130706433, '2020-01-17 15:44:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (219, 1, '登入成功', 2130706433, '2020-01-17 15:44:18', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (220, 1, '登入成功', 2130706433, '2020-01-17 16:33:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"   \"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (221, 1, '登入成功', 2130706433, '2020-01-17 16:34:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (222, 1, '登入成功', 2130706433, '2020-01-17 16:39:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (223, 1, '登入失败', 2130706433, '2020-01-18 08:56:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (224, 1, '登入成功', 2130706433, '2020-01-18 08:57:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (225, 1, '登入成功', 2130706433, '2020-01-18 09:35:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (226, 1, '登入成功', 2130706433, '2020-01-18 10:20:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (227, 1, '登入成功', 2130706433, '2020-01-18 10:22:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (228, 1, '登入成功', 2130706433, '2020-01-18 10:25:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (229, 1, '登入成功', 2130706433, '2020-01-18 10:26:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (230, 1, '登入失败', 2130706433, '2020-01-19 09:16:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (231, 1, '登入成功', 2130706433, '2020-01-19 09:16:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (232, 1, '登入成功', 2130706433, '2020-01-19 15:35:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menu_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单名称',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '菜单类型',
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '菜单地址',
  `order_number` int(11) NULL DEFAULT NULL COMMENT '排序序号',
  `status` tinyint(4) NULL DEFAULT NULL COMMENT '状态',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父菜单id',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新者',
  `update_time` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新时间',
  `permission` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '权限字符串',
  `component_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `hasChildren` tinyint(1) NULL DEFAULT 0 COMMENT '是否有子菜单（按钮不算）',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 1, 'icon', '/system/manage', 1, 1, 0, 'admin', '2020-01-18 10:02:43', '0000-00-00 00:00:00', NULL, '', 'layout', 1);
INSERT INTO `sys_menu` VALUES (2, '用户管理', 2, 'user', '/user/manage', 1, 1, 1, 'admin', '2020-01-19 10:14:43', '0000-00-00 00:00:00', NULL, 'system:user:view', 'system/user/index', 1);
INSERT INTO `sys_menu` VALUES (3, '角色管理', 2, 'icon', '/role/manage', 2, 1, 1, 'admin', '2020-01-19 10:14:45', '0000-00-00 00:00:00', NULL, 'system:role:view', 'system/role/role-manage', 1);
INSERT INTO `sys_menu` VALUES (4, '菜单管理', 2, 'icon', '/menu/manage', 3, 1, 1, 'admin', '2020-01-19 10:14:48', '0000-00-00 00:00:00', NULL, 'system:menu:view', 'system/menu/menu-manage', 1);
INSERT INTO `sys_menu` VALUES (5, '部门管理', 2, 'icon', '/dept/manage', 4, 1, 1, 'admin', '2020-01-19 10:14:51', '0000-00-00 00:00:00', NULL, 'system:dept:view', 'system/dept/dept-manage', 1);
INSERT INTO `sys_menu` VALUES (6, '添加用户', 3, NULL, NULL, 1, 1, 2, 'admin', '2020-01-18 10:03:53', '0000-00-00 00:00:00', NULL, 'system:user:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (7, '删除用户', 3, NULL, NULL, 2, 1, 2, 'admin', '2020-01-18 10:03:55', '0000-00-00 00:00:00', NULL, 'system:user:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (8, '更新用户', 3, NULL, NULL, 3, 1, 2, 'admin', '2020-01-18 10:03:56', '0000-00-00 00:00:00', NULL, 'system:user:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (9, '添加角色', 3, NULL, NULL, 1, 1, 3, 'admin', '2020-01-18 10:03:59', '0000-00-00 00:00:00', NULL, 'system:role:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (10, '删除角色', 3, NULL, NULL, 2, 1, 3, 'admin', '2020-01-18 10:04:01', '0000-00-00 00:00:00', NULL, 'system:role:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (11, '更新角色', 3, NULL, NULL, 3, 1, 3, 'admin', '2020-01-18 10:04:03', '0000-00-00 00:00:00', NULL, 'system:role:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (12, '添加菜单', 3, NULL, NULL, 1, 1, 4, 'admin', '2020-01-18 10:04:04', '0000-00-00 00:00:00', NULL, 'system:menu:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (13, '删除菜单', 3, NULL, NULL, 2, 1, 4, 'admin', '2020-01-18 10:04:06', '0000-00-00 00:00:00', NULL, 'system:menu:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (14, '更新菜单', 3, NULL, NULL, 3, 1, 4, 'admin', '2020-01-18 10:04:08', '0000-00-00 00:00:00', NULL, 'system:menu:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (15, '添加部门', 3, NULL, NULL, 1, 1, 5, 'admin', '2020-01-18 10:04:10', '0000-00-00 00:00:00', NULL, 'system:dept:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (16, '删除部门', 3, NULL, NULL, 2, 1, 5, 'admin', '2020-01-18 10:04:12', '0000-00-00 00:00:00', NULL, 'system:dept:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (17, '更新部门', 3, NULL, NULL, 3, 1, 5, 'admin', '2020-01-18 10:04:16', '0000-00-00 00:00:00', NULL, 'system:dept:update', NULL, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `parent_id` int(11) NULL DEFAULT NULL COMMENT '父角色id',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `role_code` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '角色代码',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 0, 'admin', '2019-12-19 11:19:32', NULL, '0000-00-00 00:00:00', '', 'SUPER_ADMIN');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色菜单关系表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (1, 1);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `login_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '登录名',
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `username` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '头像',
  `sex` tinyint(4) NULL DEFAULT 3 COMMENT '性别 1男 2女 3不确定',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `last_login_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '上次登录时间',
  `locked` tinyint(4) NULL DEFAULT 0 COMMENT '锁定状态 0 未锁定 1 管理员锁定 2 输错密码锁定',
  `salt` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐值',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '部门id',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `lock_time` timestamp(0) NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '锁定时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '03f6e79233f5adda25d7b6f4b9357d81', 'aa', 'asd', 0, '666161615@aq.com', '1656461516', '2019-12-31 16:50:23', '2019-12-13 11:54:51', 0, 'yeepaf9n', 1, NULL, NULL, '0000-00-00 00:00:00', '', '2019-12-27 11:36:33');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);

SET FOREIGN_KEY_CHECKS = 1;
