/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 50731
 Source Host           : localhost:3306
 Source Schema         : wuage

 Target Server Type    : MySQL
 Target Server Version : 50731
 File Encoding         : 65001

 Date: 05/10/2020 14:00:18
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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统参数表' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'MAX_LOGIN_ERROR', '登录密码错误次数', 3);
INSERT INTO `sys_config` VALUES (2, 'FREEZE_HOUR', '冻结时间(h)', 1);
INSERT INTO `sys_config` VALUES (3, 'CAPTCHA_SWITCH', '验证码开关', 0);
INSERT INTO `sys_config` VALUES (4, 'SYSTEM_MODE', '系统模式', 0);
INSERT INTO `sys_config` VALUES (5, 'LOGIN_SWITCH', '登录开关', 1);

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
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_time` timestamp(0) NOT NULL COMMENT '更新时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '更新人',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1, '总公司', 0, '张总阿萨德', '13865488888', '2019-12-31 17:06:07', 'admin', '2020-09-04 15:01:35', '电饭锅后海', '');
INSERT INTO `sys_dept` VALUES (2, '销售部', 1, '张三', '1', '2020-06-23 14:13:50', 'aa', '2020-09-04 08:17:44', 'aa', '');
INSERT INTO `sys_dept` VALUES (5, 'gdfg', 1, 'gfd', 'gdfg', '2020-06-23 14:17:51', 'aa', '0000-00-00 00:00:00', '', '');
INSERT INTO `sys_dept` VALUES (6, 'd\'f\'f\'s\'d', 5, 'd\'f', '东风风神电放费', '2020-06-23 16:11:46', 'aa', '0000-00-00 00:00:00', '', '');
INSERT INTO `sys_dept` VALUES (8, '发过火', 2, '后海', '123123123', '2020-08-24 19:33:52', 'aa', '0000-00-00 00:00:00', '', '');

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
INSERT INTO `sys_dept_role` VALUES (1, 11);
INSERT INTO `sys_dept_role` VALUES (1, 12);
INSERT INTO `sys_dept_role` VALUES (2, 11);
INSERT INTO `sys_dept_role` VALUES (5, 12);
INSERT INTO `sys_dept_role` VALUES (6, 12);
INSERT INTO `sys_dept_role` VALUES (7, 11);
INSERT INTO `sys_dept_role` VALUES (9, 11);

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `log_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '日志di',
  `operator_type` tinyint(4) NULL DEFAULT NULL COMMENT '操作来类型 1登录日志 2 操作日志',
  `result` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作结果 json 数据',
  `ip` bigint(11) NULL DEFAULT NULL COMMENT 'ip',
  `log_time` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '操作时间',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求url',
  `description` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `param` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `operator_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作人',
  `error_msg` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '错误信息',
  `log_title` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '日志标题',
  `operator_id` int(11) NULL DEFAULT NULL COMMENT '操作人id',
  `result_type` tinyint(4) NULL DEFAULT NULL COMMENT '结果类型 0 成功 1 失败',
  `cost_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '花费时间',
  PRIMARY KEY (`log_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 801 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (200, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:46:47', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (201, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:47:53', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (202, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:48:05', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (203, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:48:47', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (204, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:50:10', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (205, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:50:55', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (206, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:51:34', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (207, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:52:08', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (208, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:53:03', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (209, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:53:46', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (210, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:54:23', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (211, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:54:52', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (212, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-01-04 11:56:23', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (213, 1, '登入失败', 2130706433, '2020-01-04 14:22:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (214, 1, '登入成功', 2130706433, '2020-01-04 14:22:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (215, 1, '登入成功', 2130706433, '2020-01-04 17:18:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (216, 1, '登入成功', 2130706433, '2020-01-04 17:30:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (217, 1, '登入成功', 2130706433, '2020-01-06 08:44:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (218, 1, '登入失败', 2130706433, '2020-01-17 15:44:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (219, 1, '登入成功', 2130706433, '2020-01-17 15:44:18', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (220, 1, '登入成功', 2130706433, '2020-01-17 16:33:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"   \"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (221, 1, '登入成功', 2130706433, '2020-01-17 16:34:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (222, 1, '登入成功', 2130706433, '2020-01-17 16:39:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (223, 1, '登入失败', 2130706433, '2020-01-18 08:56:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (224, 1, '登入成功', 2130706433, '2020-01-18 08:57:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (225, 1, '登入成功', 2130706433, '2020-01-18 09:35:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (226, 1, '登入成功', 2130706433, '2020-01-18 10:20:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (227, 1, '登入成功', 2130706433, '2020-01-18 10:22:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (228, 1, '登入成功', 2130706433, '2020-01-18 10:25:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (229, 1, '登入成功', 2130706433, '2020-01-18 10:26:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (230, 1, '登入失败', 2130706433, '2020-01-19 09:16:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (231, 1, '登入成功', 2130706433, '2020-01-19 09:16:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (232, 1, '登入成功', 2130706433, '2020-01-19 15:35:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (233, 1, '登入成功', 2130706433, '2020-01-19 20:32:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (234, 1, '登入失败', 2130706433, '2020-03-09 00:12:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (235, 1, '登入失败', 2130706433, '2020-03-09 00:12:25', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"654321\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (236, 1, '登入失败', 2130706433, '2020-03-09 00:12:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (237, 1, '登入成功', 2130706433, '2020-03-09 00:12:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (238, 1, '登入成功', 2130706433, '2020-03-09 12:49:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (239, 1, '登入成功', 2130706433, '2020-03-10 15:19:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (240, 1, '登入成功', 2130706433, '2020-03-10 16:18:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (241, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 19:02:55', '/wuage/system/menu', NULL, '{\"parentId\":[\"0\"],\"parentName\":[\"无\"],\"menuName\":[\"阿萨德\"],\"type\":[\"1\"],\"icon\":[\"international\"],\"url\":[\"asd\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (242, 1, '登入成功', 2130706433, '2020-03-11 19:03:18', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (243, 1, '登入成功', 2130706433, '2020-03-11 19:03:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (244, 1, '登入失败', 2130706433, '2020-03-11 19:04:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456anc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (245, 1, '登入成功', 2130706433, '2020-03-11 19:04:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (246, 1, '登入成功', 2130706433, '2020-03-11 19:04:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (247, 1, '登入成功', 2130706433, '2020-03-11 19:04:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (248, 1, '登入成功', 2130706433, '2020-03-11 19:04:47', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (249, 1, '登入成功', 2130706433, '2020-03-11 19:08:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (250, 1, '登入成功', 2130706433, '2020-03-11 19:08:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (251, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 19:22:24', '/wuage/system/menu', NULL, '{\"parentId\":[\"0\"],\"parentName\":[\"无\"],\"menuName\":[\"asdas\"],\"type\":[\"1\"],\"icon\":[\"excel\"],\"url\":[\"/dasd\"],\"orderNumber\":[\"2\"],\"status\":[\"1\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (252, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 19:23:38', '/wuage/system/menu/19', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (253, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 19:24:03', '/wuage/system/menu', NULL, '{\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"menuName\":[\"阿萨斯多\"],\"type\":[\"1\"],\"icon\":[\"language\"],\"url\":[\"/dad\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (254, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 19:29:03', '/wuage/system/menu/20', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (255, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 19:29:27', '/wuage/system/menu', NULL, '{\"parentId\":[\"0\"],\"parentName\":[\"无\"],\"menuName\":[\"zxc\"],\"type\":[\"1\"],\"icon\":[\"excel\"],\"url\":[\"/szzxc\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (256, 1, '登入成功', 2130706433, '2020-03-11 19:30:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (257, 1, '登入成功', 2130706433, '2020-03-11 19:35:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (258, 1, '登入成功', 2130706433, '2020-03-11 19:54:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (259, 1, '登入成功', 2130706433, '2020-03-11 19:55:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (260, 1, '登入成功', 2130706433, '2020-03-11 20:00:41', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (261, 1, '登入成功', 2130706433, '2020-03-11 20:51:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (262, 1, '登入成功', 2130706433, '2020-03-11 20:52:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (263, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 21:21:55', '/wuage/system/menu', NULL, '{\"parentId\":[\"21\"],\"parentName\":[\"zxc\"],\"menuName\":[\"用户\"],\"type\":[\"1\"],\"icon\":[\"link\"],\"url\":[\"/dasdas\"],\"orderNumber\":[\"1\"],\"status\":[\"0\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (264, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 21:22:36', '/wuage/system/menu/22', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (265, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 21:23:21', '/wuage/system/menu', NULL, '{\"parentId\":[\"21\"],\"parentName\":[\"zxc\"],\"menuName\":[\"用户\"],\"type\":[\"2\"],\"icon\":[\"lock\"],\"url\":[\"/adsa\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"permission\":[\"system:asd:aa\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (266, 1, '登入成功', 2130706433, '2020-03-11 23:09:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (267, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 23:17:36', '/wuage/system/menu', NULL, '{\"parentId\":[\"0\"],\"parentName\":[\"无\"],\"menuName\":[\"部门\"],\"type\":[\"1\"],\"icon\":[\"dashboard\"],\"url\":[\"/asdasd\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (278, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-11 23:39:01', '/wuage/system/menu', NULL, '{\"parentId\":[\"24\"],\"parentName\":[\"部门\"],\"menuName\":[\"大多数\"],\"type\":[\"3\"],\"url\":[\"\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"permission\":[\"dsd\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (279, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-12 15:47:46', '/wuage/system/menu', NULL, '{\"menuId\":[\"24\"],\"menuName\":[\"部门\"],\"type\":[\"1\"],\"icon\":[\"dashboard\"],\"url\":[\"/asdasd\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"parentId\":[\"0\"],\"creater\":[\"aa\"],\"ctime\":[\"2020-03-12 15:32:25\"],\"updateBy\":[\"\"],\"permission\":[\"\"],\"componentPath\":[\"layout\"],\"hasChildren\":[\"true\"],\"parentName\":[\"无\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (280, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-12 15:48:40', '/wuage/system/menu', NULL, '{\"menuId\":[\"24\"],\"menuName\":[\"部门\"],\"type\":[\"1\"],\"icon\":[\"dashboard\"],\"url\":[\"/asdasd\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"parentId\":[\"0\"],\"creater\":[\"aa\"],\"ctime\":[\"2020-03-12 15:32:25\"],\"updateBy\":[\"aa\"],\"updateTime\":[\"2020-03-12 15:47:46\"],\"permission\":[\"\"],\"componentPath\":[\"layout\"],\"hasChildren\":[\"true\"],\"parentName\":[\"无\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (281, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-03-12 15:50:22', '/wuage/system/menu', NULL, '{\"menuId\":[\"35\"],\"menuName\":[\"大多数\"],\"type\":[\"2\"],\"icon\":[\"language\"],\"url\":[\"/asd\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"parentId\":[\"24\"],\"creater\":[\"aa\"],\"ctime\":[\"2020-03-12 15:32:25\"],\"updateBy\":[\"\"],\"permission\":[\"dsd\"],\"componentPath\":[\"layout\"],\"hasChildren\":[\"false\"],\"parentName\":[\"部门\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (282, 1, '登入失败', 2130706433, '2020-03-12 17:03:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (283, 1, '登入成功', 2130706433, '2020-03-12 17:03:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (284, 1, '登入成功', 2130706433, '2020-03-13 16:07:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (285, 1, '登入失败', 2130706433, '2020-03-30 15:56:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (286, 1, '登入成功', 2130706433, '2020-03-30 15:56:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (287, 1, '登入失败', 2130706433, '2020-06-11 14:34:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"admin123\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (288, 1, '登入成功', 2130706433, '2020-06-11 14:34:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (289, 1, '登入成功', 2130706433, '2020-06-11 15:50:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (290, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-06-11 15:50:45', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (291, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-06-11 15:50:49', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (292, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-06-11 15:50:55', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (293, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-06-11 15:51:00', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (294, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-06-11 15:51:04', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (295, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-11 15:54:48', '/wuage/system/menu/35', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (296, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-11 15:54:51', '/wuage/system/menu/24', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (297, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-11 15:55:37', '/wuage/system/menu/23', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (298, 1, '登入成功', 2130706433, '2020-06-11 23:40:29', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (299, 1, '登入成功', 2130706433, '2020-06-15 13:55:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (300, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-15 14:00:21', '/wuage/system/menu', NULL, '{\"parentId\":[\"6\"],\"parentName\":[\"添加用户\"],\"menuName\":[\"二维\"],\"type\":[\"1\"],\"icon\":[\"qq\"],\"url\":[\"/ddd\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"],\"componentPath\":[\"layout\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (301, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-15 14:00:37', '/wuage/system/menu/22', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (302, 1, '登入成功', 2130706433, '2020-06-17 15:28:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (303, 1, '登入失败', 2130706433, '2020-06-17 16:20:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"12346abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (304, 1, '登入成功', 2130706433, '2020-06-17 16:20:45', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (305, 1, '登入成功', 2130706433, '2020-06-17 17:09:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (306, 1, '登入成功', 2130706433, '2020-06-17 17:09:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (307, 1, '登入失败', 2130706433, '2020-06-20 01:36:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456anc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (308, 1, '登入成功', 2130706433, '2020-06-20 01:36:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (309, 1, '登入失败', 2130706433, '2020-06-20 20:46:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (310, 1, '登入成功', 2130706433, '2020-06-20 20:46:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (311, 1, '登入成功', 2130706433, '2020-06-21 00:59:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (312, 1, '登入成功', 2130706433, '2020-06-22 01:07:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (313, 1, '登入失败', 2130706433, '2020-06-22 16:16:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"12346abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (314, 1, '登入成功', 2130706433, '2020-06-22 16:16:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (315, 1, '登入失败', 2130706433, '2020-06-22 20:19:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (316, 1, '登入成功', 2130706433, '2020-06-22 20:19:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (317, 1, '登入成功', 2130706433, '2020-06-22 20:23:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (318, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-22 20:29:27', '/wuage/system/menu', NULL, '{\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"type\":[\"1\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (319, 1, '登入成功', 2130706433, '2020-06-23 00:55:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (320, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 14:13:50', '/wuage/system/departments', NULL, '{\"deptName\":[\"das\"],\"leader\":[\"dsa\"],\"phone\":[\"dsa\"],\"parentName\":[\"总公司\"],\"deptParentId\":[\"1\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (321, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 14:15:11', '/wuage/system/departments', NULL, '{\"deptName\":[\"das\"],\"leader\":[\"sdsa\"],\"phone\":[\"dsa\"],\"parentName\":[\"das\"],\"deptParentId\":[\"2\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (322, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 14:16:24', '/wuage/system/departments', NULL, '{\"deptName\":[\"fhg\"],\"leader\":[\"hfg\"],\"phone\":[\"hg\"],\"parentName\":[\"das\"],\"deptParentId\":[\"2\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (323, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 14:17:51', '/wuage/system/departments', NULL, '{\"deptName\":[\"gdfg\"],\"leader\":[\"gfd\"],\"phone\":[\"gdfg\"],\"parentName\":[\"总公司\"],\"deptParentId\":[\"1\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (324, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 16:11:46', '/wuage/system/departments', NULL, '{\"deptName\":[\"d\'f\'f\'s\'d\"],\"leader\":[\"d\'f\"],\"phone\":[\"东风风神电放费\"],\"parentName\":[\"gdfg\"],\"deptParentId\":[\"5\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (325, 1, '登入失败', 2130706433, '2020-06-23 20:28:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (326, 1, '登入失败', 2130706433, '2020-06-23 20:28:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132456acb\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (327, 1, '登入成功', 2130706433, '2020-06-23 20:28:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (328, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 20:40:02', '/wuage/system/departments', NULL, '{\"deptName\":[\"sdf\"],\"leader\":[\"反反复复\"],\"phone\":[\"方法\"],\"parentName\":[\"das\"],\"deptParentId\":[\"2\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (329, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 20:40:21', '/wuage/system/departments', NULL, '{\"deptName\":[\"个个\"],\"leader\":[\"个个\"],\"phone\":[\"个个\"],\"parentName\":[\"sdf\"],\"deptParentId\":[\"7\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (330, 1, '登入成功', 2130706433, '2020-06-23 21:12:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (331, 1, '登入成功', 2130706433, '2020-06-23 21:15:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (332, 1, '登入成功', 2130706433, '2020-06-23 21:23:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (333, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 21:24:19', '/wuage/system/departments', NULL, '{\"deptId\":[\"1\"],\"deptName\":[\"总公司\"],\"deptParentId\":[\"0\"],\"leader\":[\"张总阿萨德\"],\"phone\":[\"13865488888\"],\"ctime\":[\"2019-12-31 17:06:07\"],\"creater\":[\"admin\"],\"updateBy\":[\"\"],\"remark\":[\"\"],\"parentName\":[\"无\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (334, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 21:26:07', '/wuage/system/departments', NULL, '{\"deptId\":[\"2\"],\"deptName\":[\"das\"],\"deptParentId\":[\"1\"],\"leader\":[\"非共和国\"],\"phone\":[\"dsa\"],\"ctime\":[\"2020-06-23 14:13:50\"],\"creater\":[\"aa\"],\"updateBy\":[\"\"],\"remark\":[\"\"],\"parentName\":[\"总公司\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (335, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 21:26:33', '/wuage/system/departments', NULL, '{\"deptId\":[\"2\"],\"deptName\":[\"das\"],\"deptParentId\":[\"1\"],\"leader\":[\"福袋\"],\"phone\":[\"dsa\"],\"ctime\":[\"2020-06-23 14:13:50\"],\"creater\":[\"aa\"],\"updateBy\":[\"aa\"],\"remark\":[\"\"],\"parentName\":[\"总公司\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (336, 1, '登入成功', 2130706433, '2020-06-23 21:56:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (337, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:56:39', '/wuage/system/menu/5', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (338, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:56:44', '/wuage/system/menu/5', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (339, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:57:43', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (340, 1, '登入成功', 2130706433, '2020-06-23 21:58:21', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (341, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:58:25', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (342, 1, '登入失败', 2130706433, '2020-06-23 21:58:56', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (343, 1, '登入成功', 2130706433, '2020-06-23 21:59:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (344, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:59:05', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (345, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:59:18', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (346, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 21:59:32', '/wuage/system/menu/5', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (347, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 22:00:57', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (348, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 22:01:49', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (349, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 22:03:20', '/wuage/system/menu/1', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (350, 2, '{\"code\":\"1\",\"msg\":\"该菜单存在子菜单，无法删除!\"}', 2130706433, '2020-06-23 22:03:28', '/wuage/system/menu/4', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (351, 2, '{\"code\":\"1\",\"msg\":\"该部门存在子部门，无法删除!\"}', 2130706433, '2020-06-23 22:04:21', '/wuage/system/departments/1', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (352, 2, '{\"code\":\"1\",\"msg\":\"该部门存在子部门，无法删除!\"}', 2130706433, '2020-06-23 22:04:31', '/wuage/system/departments/1', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (353, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 22:04:38', '/wuage/system/departments/3', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (354, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 22:04:44', '/wuage/system/departments/4', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (355, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-06-23 22:04:49', '/wuage/system/departments/8', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (356, 2, '{\"code\":\"1\",\"msg\":\"该部门存在子部门，无法删除!\"}', 2130706433, '2020-06-23 22:04:56', '/wuage/system/departments/5', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (357, 1, '登入成功', 2130706433, '2020-06-28 13:46:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (358, 1, '登入失败', 2130706433, '2020-07-10 14:14:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"1234566abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (359, 1, '登入成功', 2130706433, '2020-07-10 14:15:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (360, 1, '登入成功', 2130706433, '2020-07-10 15:21:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (361, 1, '登入成功', 2130706433, '2020-07-10 15:22:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (362, 1, '登入失败', 2130706433, '2020-07-10 15:40:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (363, 1, '登入成功', 2130706433, '2020-07-10 15:40:29', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (364, 1, '登入成功', 2130706433, '2020-07-10 17:12:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (365, 1, '登入成功', 2130706433, '2020-07-10 17:13:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (366, 1, '登入成功', 2130706433, '2020-07-10 20:31:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (367, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-07-10 20:32:20', '/wuage/system/menu/21', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (368, 1, '登入失败', 2130706433, '2020-07-10 21:43:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (369, 1, '登入成功', 2130706433, '2020-07-10 21:43:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (370, 1, '登入成功', 2130706433, '2020-07-12 13:01:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (371, 1, '登入成功', 2130706433, '2020-07-17 14:02:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (372, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-07-17 14:22:15', '/wuage/system/menu', NULL, '{\"menuId\":[\"1\"],\"menuName\":[\"系统管理\"],\"type\":[\"1\"],\"icon\":[\"icon\"],\"url\":[\"/system/manage\"],\"orderNumber\":[\"1\"],\"status\":[\"0\"],\"parentId\":[\"0\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"updateBy\":[\"\"],\"permission\":[\"\"],\"componentPath\":[\"layout\"],\"hasChildren\":[\"true\"],\"parentName\":[\"无\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (373, 1, '登入成功', 2130706433, '2020-07-17 14:22:52', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (374, 1, '登入成功', 2130706433, '2020-07-21 15:03:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (375, 1, '登入成功', 2130706433, '2020-07-21 15:33:39', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (376, 1, '登入成功', 2130706433, '2020-07-21 16:41:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (377, 1, '登入失败', 2130706433, '2020-07-22 14:15:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"1234655abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (378, 1, '登入失败', 2130706433, '2020-07-22 14:15:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132465abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (379, 1, '登入成功', 2130706433, '2020-07-22 14:15:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (380, 1, '登入成功', 2130706433, '2020-07-31 21:51:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (381, 1, '登入成功', 2130706433, '2020-08-01 00:00:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (382, 1, '登入失败', 2130706433, '2020-08-01 00:27:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456avc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (383, 1, '登入成功', 2130706433, '2020-08-01 00:27:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (384, 1, '登入成功', 2130706433, '2020-08-01 00:40:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (385, 1, '登入成功', 2130706433, '2020-08-01 00:43:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (386, 1, '登入成功', 2130706433, '2020-08-01 01:03:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (387, 1, '登入成功', 2130706433, '2020-08-05 14:01:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (388, 1, '登入成功', 2130706433, '2020-08-05 14:46:52', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (389, 1, '登入成功', 2130706433, '2020-08-06 00:17:47', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (390, 1, '登入失败', 2130706433, '2020-08-06 00:37:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (391, 1, '登入成功', 2130706433, '2020-08-06 00:37:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (392, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-13 12:00:05', '/wuage/system/menu', NULL, '{\"menuId\":[\"3\"],\"menuName\":[\"角色管理\"],\"type\":[\"2\"],\"icon\":[\"icon\"],\"url\":[\"/role/manage\"],\"orderNumber\":[\"10\"],\"status\":[\"1\"],\"parentId\":[\"1\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"updateBy\":[\"\"],\"permission\":[\"system:role:view\"],\"componentPath\":[\"system/role/role-manage\"],\"hasChildren\":[\"true\"],\"parentName\":[\"系统管理\"],\"traversalOrNot\":[\"true\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (393, 1, '登入成功', 2130706433, '2020-08-13 12:00:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (394, 1, '登入失败', 2130706433, '2020-08-14 10:01:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"1234566abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (395, 1, '登入成功', 2130706433, '2020-08-14 10:01:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (396, 1, '登入成功', 2130706433, '2020-08-14 20:09:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (397, 1, '登入成功', 2130706433, '2020-08-17 00:22:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (398, 1, '登入成功', 2130706433, '2020-08-17 14:09:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (399, 1, '登入成功', 2130706433, '2020-08-17 15:22:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (400, 1, '登入成功', 2130706433, '2020-08-19 14:13:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (401, 1, '登入成功', 2130706433, '2020-08-20 11:59:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (402, 1, '登入成功', 2130706433, '2020-08-20 14:14:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (403, 1, '登入成功', 2130706433, '2020-08-20 14:27:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (404, 1, '登入成功', 2130706433, '2020-08-20 16:29:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (405, 1, '登入成功', 2130706433, '2020-08-20 16:51:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (406, 1, '登入成功', 2130706433, '2020-08-21 11:08:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (407, 1, '登入成功', 2130706433, '2020-08-21 12:01:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (408, 1, '登入成功', 2130706433, '2020-08-21 17:59:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (409, 1, '登入成功', 2130706433, '2020-08-21 18:15:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (410, 1, '登入失败', 2130706433, '2020-08-21 18:27:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"12346abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (411, 1, '登入成功', 2130706433, '2020-08-21 18:27:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (412, 1, '登入失败', 2130706433, '2020-08-21 18:40:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (413, 1, '登入失败', 2130706433, '2020-08-21 18:40:45', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132465ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (414, 1, '登入失败', 2130706433, '2020-08-21 18:40:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (415, 1, '登入失败', 2130706433, '2020-08-21 18:40:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (416, 1, '登入失败', 2130706433, '2020-08-21 18:40:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (417, 1, '登入失败', 2130706433, '2020-08-21 18:41:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (418, 1, '登入成功', 2130706433, '2020-08-21 18:43:18', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (419, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-21 23:50:06', '/wuage/system/departments', NULL, '{\"creater\":[\"aa\"],\"ctime\":[\"2020-06-23 14:13:50\"],\"deptId\":[\"2\"],\"deptName\":[\"大苏打撒打大声道\"],\"deptParentId\":[\"1\"],\"leader\":[\"福袋\"],\"parentName\":[\"总公司\"],\"phone\":[\"dsa\"],\"remark\":[\"\"],\"traversalOrNot\":[\"true\"],\"updateBy\":[\"aa\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (420, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-21 23:50:20', '/wuage/system/departments', NULL, '{\"creater\":[\"aa\"],\"ctime\":[\"2020-06-23 20:40:02\"],\"deptId\":[\"7\"],\"deptName\":[\"毒贩夫妇付付付付付付付\"],\"deptParentId\":[\"2\"],\"leader\":[\"反反复复\"],\"parentName\":[\"大苏打撒打大声道\"],\"phone\":[\"方法\"],\"remark\":[\"\"],\"traversalOrNot\":[\"true\"],\"updateBy\":[\"\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (421, 1, '登入成功', 2130706433, '2020-08-22 12:52:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (422, 1, '登入失败', 2130706433, '2020-08-24 19:02:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"132456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (423, 1, '登入失败', 2130706433, '2020-08-24 19:02:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"12456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (424, 1, '登入成功', 2130706433, '2020-08-24 19:02:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (425, 1, '登入成功', 2130706433, '2020-08-24 19:30:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (426, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-24 19:33:52', '/wuage/system/departments', NULL, '{\"deptName\":[\"发过火\"],\"leader\":[\"后海\"],\"phone\":[\"123123123\"],\"parentName\":[\"大苏打撒打大声道\"],\"deptParentId\":[\"2\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (427, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-24 19:34:04', '/wuage/system/departments', NULL, '{\"deptName\":[\"梵蒂冈\"],\"leader\":[\"个个\"],\"phone\":[\"给个13123\"],\"parentName\":[\"大苏打撒打大声道\"],\"deptParentId\":[\"2\"]}', 'admin', '', '添加部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (428, 1, '登入成功', 2130706433, '2020-08-24 23:03:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (429, 1, '登入成功', 2130706433, '2020-08-25 00:47:56', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (430, 1, '登入成功', 2130706433, '2020-08-25 23:49:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (431, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-25 23:52:00', '/wuage/system/user', NULL, '{}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (432, 1, '登入失败', 2130706433, '2020-08-25 23:56:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"122456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (433, 1, '登入成功', 2130706433, '2020-08-25 23:56:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (434, 1, '登入成功', 2130706433, '2020-08-26 00:06:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (435, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-26 00:07:48', '/wuage/system/user', NULL, '{\"username\":[\"发多少\"],\"loginName\":[\"大萨达\"],\"phone\":[\"123123\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"],\"roles[0]\":[\"1\"],\"roles[1]\":[\"11\"],\"roles[2]\":[\"12\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (436, 2, 'null', 2130706433, '2020-08-26 00:27:24', '/wuage/system/user', NULL, '{\"username\":[\"嘿嘿嘿\"],\"loginName\":[\"发给\"],\"phone\":[\"123143223\"],\"deptId\":[\"9\"],\"roles[0]\":[\"11\"],\"roles[1]\":[\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 1, NULL);
INSERT INTO `sys_log` VALUES (437, 1, '登入成功', 2130706433, '2020-08-26 00:32:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (438, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-26 00:32:23', '/wuage/system/user', NULL, '{\"username\":[\"ff\"],\"loginName\":[\"发生大幅度\"],\"phone\":[\"23124343\"],\"deptId\":[\"8\"],\"roles[0]\":[\"12\"],\"roles[1]\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (439, 1, '登入成功', 2130706433, '2020-08-26 00:33:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (440, 1, '登入成功', 2130706433, '2020-08-26 00:42:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (441, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-26 00:46:17', '/wuage/system/user/7', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (442, 1, '登入成功', 2130706433, '2020-08-26 17:14:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (443, 1, '登入成功', 2130706433, '2020-08-26 17:36:25', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (444, 1, '登入成功', 2130706433, '2020-08-26 17:50:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (445, 1, '登入成功', 2130706433, '2020-08-26 18:05:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (446, 1, '登入成功', 2130706433, '2020-08-26 18:09:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (447, 1, '登入成功', 2130706433, '2020-08-26 18:09:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (448, 1, '登入成功', 2130706433, '2020-08-26 18:11:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (449, 1, '登入成功', 2130706433, '2020-08-26 18:12:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (450, 1, '登入成功', 2130706433, '2020-08-26 18:14:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (451, 1, '登入成功', 2130706433, '2020-08-26 18:16:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (452, 1, '登入成功', 2130706433, '2020-08-26 18:26:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (453, 1, '登入成功', 2130706433, '2020-08-26 18:54:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (454, 1, '登入成功', 2130706433, '2020-08-26 18:57:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (455, 1, '登入成功', 2130706433, '2020-08-26 19:00:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (456, 1, '登入成功', 2130706433, '2020-08-26 19:02:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (457, 1, '登入成功', 2130706433, '2020-08-26 19:04:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (458, 1, '登入成功', 2130706433, '2020-08-26 19:07:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (459, 1, '登入成功', 2130706433, '2020-08-26 19:09:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (460, 1, '登入成功', 2130706433, '2020-08-26 19:12:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (461, 1, '登入成功', 2130706433, '2020-08-26 19:15:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (462, 1, '登入成功', 2130706433, '2020-08-26 19:21:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (463, 1, '登入成功', 2130706433, '2020-08-26 19:24:52', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (464, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-26 19:25:36', '/wuage/system/user/6', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (465, 1, '登入成功', 2130706433, '2020-08-26 19:27:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (466, 1, '登入成功', 2130706433, '2020-08-26 23:12:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (467, 1, '登入成功', 2130706433, '2020-08-26 23:38:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (468, 1, '登入成功', 2130706433, '2020-08-27 00:14:45', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (469, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 00:19:43', '/wuage/system/user', NULL, '{\"username\":[\"gggg\"],\"loginName\":[\"fdggg\"],\"phone\":[\"234234234\"],\"deptId\":[\"6\"],\"roles[0]\":[\"11\"],\"roles[1]\":[\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (470, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 00:26:33', '/wuage/system/user/5', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (471, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 00:26:34', '/wuage/system/user/4', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (472, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 00:26:53', '/wuage/system/user', NULL, '{\"username\":[\"jjj\"],\"loginName\":[\"yjjj\"],\"phone\":[\"213123123\"],\"deptId\":[\"6\"],\"roles[0]\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (473, 1, '登入成功', 2130706433, '2020-08-27 00:28:54', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (474, 2, '{\"code\":\"0\",\"data\":10,\"msg\":\"success\"}', 2130706433, '2020-08-27 00:29:09', '/wuage/system/user', NULL, '{\"username\":[\"ggg\"],\"loginName\":[\"fgggg\"],\"phone\":[\"123123\"],\"deptId\":[\"9\"],\"roles[0]\":[\"11\"],\"roles[1]\":[\"1\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (475, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 00:29:25', '/wuage/system/user/10', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (476, 1, '登入成功', 2130706433, '2020-08-27 00:51:45', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (477, 2, '{\"code\":\"0\",\"data\":11,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:05:00', '/wuage/system/user', NULL, '{\"username\":[\"hgh\"],\"loginName\":[\"ghhh\"],\"phone\":[\"32424\"],\"deptId\":[\"7\"],\"roles[0]\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (478, 2, '{\"code\":\"0\",\"data\":12,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:05:09', '/wuage/system/user', NULL, '{\"username\":[\"ggg\"],\"loginName\":[\"gg\"],\"phone\":[\"324234\"],\"deptId\":[\"8\"],\"roles[0]\":[\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (479, 2, '{\"code\":\"0\",\"data\":13,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:08:37', '/wuage/system/user', NULL, '{\"username\":[\"hhh\"],\"loginName\":[\"hhh\"],\"phone\":[\"324234\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (480, 2, '{\"code\":\"0\",\"data\":14,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:08:48', '/wuage/system/user', NULL, '{\"username\":[\"hhh\"],\"loginName\":[\"hhh\"],\"phone\":[\"324234\"],\"deptId\":[\"8\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (481, 2, '{\"code\":\"0\",\"data\":15,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:08:48', '/wuage/system/user', NULL, '{\"username\":[\"hhh\"],\"loginName\":[\"hhh\"],\"phone\":[\"324234\"],\"deptId\":[\"8\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (482, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 01:09:25', '/wuage/system/user/15', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (483, 2, '{\"code\":\"0\",\"data\":16,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:10:51', '/wuage/system/user', NULL, '{\"username\":[\"fff\"],\"loginName\":[\"dsf\"],\"phone\":[\"123123123\"],\"deptId\":[\"9\"],\"roles[0]\":[\"1\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (484, 1, '登入成功', 2130706433, '2020-08-27 01:13:54', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (485, 1, '登入成功', 2130706433, '2020-08-27 01:37:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (486, 2, '{\"code\":\"0\",\"data\":17,\"msg\":\"success\"}', 2130706433, '2020-08-27 01:49:15', '/wuage/system/user', NULL, '{\"username\":[\"dd\"],\"loginName\":[\"dd\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles[0]\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (487, 1, '登入成功', 2130706433, '2020-08-27 01:49:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (488, 1, '登入成功', 2130706433, '2020-08-27 01:51:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (489, 1, '登入成功', 2130706433, '2020-08-27 01:51:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (490, 1, '登入成功', 2130706433, '2020-08-27 01:57:18', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (491, 1, '登入成功', 2130706433, '2020-08-27 02:08:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (492, 1, '登入成功', 2130706433, '2020-08-27 02:13:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (493, 1, '登入成功', 2130706433, '2020-08-27 02:16:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (494, 1, '登入成功', 2130706433, '2020-08-27 02:19:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (495, 1, '登入成功', 2130706433, '2020-08-27 02:21:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (496, 1, '登入成功', 2130706433, '2020-08-27 02:27:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (497, 1, '登入成功', 2130706433, '2020-08-27 02:30:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (498, 1, '登入成功', 2130706433, '2020-08-27 02:35:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (499, 1, '登入成功', 2130706433, '2020-08-27 02:36:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (500, 1, '登入成功', 2130706433, '2020-08-27 02:37:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (501, 1, '登入成功', 2130706433, '2020-08-27 02:37:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (502, 1, '登入成功', 2130706433, '2020-08-27 16:00:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (503, 1, '登入成功', 2130706433, '2020-08-27 16:00:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (504, 1, '登入成功', 2130706433, '2020-08-27 16:24:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (505, 1, '登入成功', 2130706433, '2020-08-27 16:24:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (506, 1, '登入成功', 2130706433, '2020-08-27 16:25:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (507, 1, '登入成功', 2130706433, '2020-08-27 16:40:52', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (508, 1, '登入成功', 2130706433, '2020-08-27 16:41:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (509, 1, '登入成功', 2130706433, '2020-08-27 16:50:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (510, 1, '登入成功', 2130706433, '2020-08-27 16:52:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (511, 1, '登入成功', 2130706433, '2020-08-27 16:54:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (512, 1, '登入成功', 2130706433, '2020-08-27 16:55:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (513, 1, '登入成功', 2130706433, '2020-08-27 17:10:25', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"dd\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'dd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (514, 1, '登入成功', 2130706433, '2020-08-27 17:21:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (515, 1, '登入成功', 2130706433, '2020-08-27 17:28:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (516, 1, '登入成功', 2130706433, '2020-08-27 17:43:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (517, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:44:10', '/wuage/system/user', NULL, '{}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (518, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:50:45', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"dd\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (519, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:50:45', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"dd\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"0\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (520, 1, '登入成功', 2130706433, '2020-08-27 17:51:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (521, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:51:15', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"dd\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (522, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:52:30', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (523, 2, '{\"code\":\"1\",\"msg\":\"登陆名重复\"}', 2130706433, '2020-08-27 17:54:42', '/wuage/system/user', NULL, '{\"username\":[\"fdf\"],\"loginName\":[\"fdf\"],\"phone\":[\"123123\"],\"deptId\":[\"8\"],\"roles[0]\":[\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (524, 2, '{\"code\":\"0\",\"data\":18,\"msg\":\"success\"}', 2130706433, '2020-08-27 17:55:06', '/wuage/system/user', NULL, '{\"username\":[\"fdf\"],\"loginName\":[\"fdh\"],\"phone\":[\"123123\"],\"deptId\":[\"8\"],\"roles[0]\":[\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (525, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:55:17', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"fdh\"],\"phone\":[\"123123\"],\"deptId\":[\"8\"],\"roles\":[\"12\"],\"locked\":[\"0\"],\"sex\":[\"0\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (526, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 17:55:30', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"fdh\"],\"phone\":[\"435345345\"],\"deptId\":[\"8\"],\"roles\":[\"12\",\"11\"],\"locked\":[\"0\"],\"sex\":[\"0\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (527, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 18:02:54', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"fdhghgh\"],\"phone\":[\"435345345\"],\"deptId\":[\"8\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"0\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (528, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 18:02:59', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"fdhghgh\"],\"phone\":[\"435345345\"],\"deptId\":[\"8\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (529, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 18:03:06', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"fdhghgh\"],\"phone\":[\"213123\"],\"deptId\":[\"8\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (530, 1, '登入成功', 2130706433, '2020-08-27 18:22:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (531, 2, '{\"code\":\"1\",\"msg\":\"该用户是超级管理员无法删除!\"}', 2130706433, '2020-08-27 18:23:59', '/wuage/system/user/1', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (532, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 18:24:29', '/wuage/system/user', NULL, '{\"userId\":[\"1\"],\"username\":[\"aa\"],\"loginName\":[\"admin\"],\"phone\":[\"1656461516\"],\"deptId\":[\"1\"],\"roles\":[\"1\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (533, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 18:27:55', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (534, 1, '登入成功', 2130706433, '2020-08-27 18:39:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (535, 1, '登入成功', 2130706433, '2020-08-27 18:39:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (536, 1, '登入成功', 2130706433, '2020-08-27 18:44:45', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (537, 1, '登入成功', 2130706433, '2020-08-27 18:47:56', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (538, 1, '登入成功', 2130706433, '2020-08-27 18:52:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (539, 1, '登入成功', 2130706433, '2020-08-27 18:53:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (540, 1, '登入成功', 2130706433, '2020-08-27 19:01:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (541, 1, '登入成功', 2130706433, '2020-08-27 19:02:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (542, 1, '登入成功', 2130706433, '2020-08-27 19:02:47', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (543, 1, '登入成功', 2130706433, '2020-08-27 19:04:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (544, 1, '登入成功', 2130706433, '2020-08-27 19:11:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (545, 1, '登入成功', 2130706433, '2020-08-27 19:12:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (546, 1, '登入成功', 2130706433, '2020-08-27 19:15:39', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (547, 1, '登入成功', 2130706433, '2020-08-27 19:20:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (548, 1, '登入失败', 2130706433, '2020-08-27 19:26:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456BX\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (549, 1, '登入失败', 2130706433, '2020-08-27 19:26:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ABC\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (550, 1, '登入成功', 2130706433, '2020-08-27 19:26:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (551, 1, '登入成功', 2130706433, '2020-08-27 19:26:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (552, 1, '登入成功', 2130706433, '2020-08-27 19:34:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (553, 1, '登入成功', 2130706433, '2020-08-27 19:36:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (554, 1, '登入成功', 2130706433, '2020-08-27 19:37:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (555, 1, '登入成功', 2130706433, '2020-08-27 19:37:50', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (556, 1, '登入成功', 2130706433, '2020-08-27 19:39:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (557, 1, '登入成功', 2130706433, '2020-08-27 19:42:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (558, 1, '登入成功', 2130706433, '2020-08-27 19:50:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (559, 1, '登入成功', 2130706433, '2020-08-27 19:50:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (560, 1, '登入成功', 2130706433, '2020-08-27 19:52:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (561, 1, '登入成功', 2130706433, '2020-08-27 19:53:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (562, 1, '登入成功', 2130706433, '2020-08-27 19:55:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (563, 1, '登入成功', 2130706433, '2020-08-27 19:56:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (564, 1, '登入成功', 2130706433, '2020-08-27 19:58:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (565, 1, '登入成功', 2130706433, '2020-08-27 22:00:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (566, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 22:07:43', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"rr\"],\"phone\":[\"213123\"],\"deptId\":[\"8\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (567, 1, '登入失败', 2130706433, '2020-08-27 22:09:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"rrras1\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (568, 1, '登入失败', 2130706433, '2020-08-27 22:09:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"rrras1\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (569, 1, '登入失败', 2130706433, '2020-08-27 22:09:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"rrras1\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (570, 1, '登入失败', 2130706433, '2020-08-27 22:09:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"rrras1\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (571, 1, '登入失败', 2130706433, '2020-08-27 22:09:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"rrras1\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (572, 1, '登入成功', 2130706433, '2020-08-27 22:09:52', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (573, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 22:10:48', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"1\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (574, 1, '登入成功', 2130706433, '2020-08-27 22:15:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (575, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 22:15:45', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (576, 1, '登入成功', 2130706433, '2020-08-27 22:15:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"fdf\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'fdf', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (577, 1, '登入成功', 2130706433, '2020-08-27 22:29:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (578, 1, '登入成功', 2130706433, '2020-08-27 23:22:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (579, 1, '登入成功', 2130706433, '2020-08-27 23:23:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (580, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:30:50', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (581, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:31:15', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (582, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:31:39', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (583, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:31:41', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (584, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:39:32', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"1\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (585, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:39:43', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (586, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:41:54', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"1\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (587, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:42:00', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (588, 1, '登入成功', 2130706433, '2020-08-27 23:43:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (589, 1, '登入失败', 2130706433, '2020-08-27 23:44:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"1dad121e\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (590, 1, '登入失败', 2130706433, '2020-08-27 23:44:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"1dad121e\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (591, 1, '登入失败', 2130706433, '2020-08-27 23:44:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"1dad121e\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (592, 1, '登入失败', 2130706433, '2020-08-27 23:44:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"1dad121e\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (593, 1, '登入失败', 2130706433, '2020-08-27 23:44:25', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"1dad121e\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (594, 1, '登入失败', 2130706433, '2020-08-27 23:44:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (595, 1, '登入成功', 2130706433, '2020-08-27 23:44:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (596, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-27 23:45:14', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"rr\"],\"phone\":[\"213123\"],\"deptId\":[\"8\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (597, 1, '登入成功', 2130706433, '2020-08-27 23:45:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (598, 1, '登入成功', 2130706433, '2020-08-27 23:45:54', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (599, 1, '登入失败', 2130706433, '2020-08-27 23:46:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (600, 1, '登入成功', 2130706433, '2020-08-27 23:46:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (601, 1, '登入成功', 2130706433, '2020-08-27 23:59:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (602, 1, '登入成功', 2130706433, '2020-08-28 00:03:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (603, 1, '登入成功', 2130706433, '2020-08-28 00:05:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (604, 1, '登入成功', 2130706433, '2020-08-28 00:09:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (605, 1, '登入成功', 2130706433, '2020-08-28 00:10:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (606, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:11:26', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (607, 1, '登入成功', 2130706433, '2020-08-28 00:11:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (608, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:11:53', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"rr\"],\"phone\":[\"213123\"],\"deptId\":[\"8\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (609, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:11:56', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (610, 1, '登入失败', 2130706433, '2020-08-28 00:12:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"12312312\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (611, 1, '登入失败', 2130706433, '2020-08-28 00:12:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"12312312\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (612, 1, '登入失败', 2130706433, '2020-08-28 00:12:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"12312312\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (613, 1, '登入失败', 2130706433, '2020-08-28 00:12:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"12312312\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (614, 1, '登入失败', 2130706433, '2020-08-28 00:12:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"12312312\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (615, 1, '登入成功', 2130706433, '2020-08-28 00:12:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (616, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:12:25', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"rr\"],\"phone\":[\"213123\"],\"deptId\":[\"8\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"1\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (617, 1, '登入成功', 2130706433, '2020-08-28 00:20:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (618, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:21:33', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"fdf\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (619, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:21:39', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"d\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (620, 1, '登入成功', 2130706433, '2020-08-28 00:21:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"d\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (621, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:22:14', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"d\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'd', '', '更新用户', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (622, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:22:27', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"d\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'd', '', '更新用户', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (623, 1, '登入成功', 2130706433, '2020-08-28 00:23:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (624, 1, '登入成功', 2130706433, '2020-08-28 00:26:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"d\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (625, 1, '登入成功', 2130706433, '2020-08-28 00:27:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (626, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:28:06', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"d\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (627, 1, '登入成功', 2130706433, '2020-08-28 00:28:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"d\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (628, 1, '登入失败', 2130706433, '2020-08-28 00:43:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"d\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'd', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (629, 1, '登入成功', 2130706433, '2020-08-28 00:43:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"d\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (630, 1, '登入成功', 2130706433, '2020-08-28 00:44:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"d\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'd', '', '用户登入', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (631, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:45:09', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"d\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'd', '', '更新用户', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (632, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 00:45:12', '/wuage/system/user', NULL, '{\"userId\":[\"17\"],\"username\":[\"dd\"],\"loginName\":[\"d\"],\"phone\":[\"12312\"],\"deptId\":[\"7\"],\"roles\":[\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'd', '', '更新用户', 17, 0, NULL);
INSERT INTO `sys_log` VALUES (633, 1, '登入失败', 2130706433, '2020-08-28 00:46:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (634, 1, '登入成功', 2130706433, '2020-08-28 00:46:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (635, 1, '登入成功', 2130706433, '2020-08-28 19:37:21', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (636, 1, '登入成功', 2130706433, '2020-08-28 19:39:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (637, 1, '登入成功', 2130706433, '2020-08-28 19:39:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (638, 1, '登入成功', 2130706433, '2020-08-28 19:44:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (639, 1, '登入成功', 2130706433, '2020-08-28 19:47:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (640, 1, '登入成功', 2130706433, '2020-08-28 19:49:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (641, 1, '登入成功', 2130706433, '2020-08-28 19:49:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (642, 1, '登入失败', 2130706433, '2020-08-28 19:54:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (643, 1, '登入成功', 2130706433, '2020-08-28 19:54:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (644, 1, '登入成功', 2130706433, '2020-08-28 19:54:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (645, 1, '登入成功', 2130706433, '2020-08-28 22:02:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (646, 2, '{\"code\":\"1\",\"msg\":\"该部门存在子部门，无法删除!\"}', 2130706433, '2020-08-28 22:03:30', '/wuage/system/departments/1', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (647, 1, '登入成功', 2130706433, '2020-08-28 22:38:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (648, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 22:39:20', '/wuage/system/departments/7', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (649, 1, '登入成功', 2130706433, '2020-08-28 22:40:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (650, 2, '{\"code\":\"1\",\"msg\":\"仍有用户属于该部门，无法删除！\"}', 2130706433, '2020-08-28 22:40:30', '/wuage/system/departments/9', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (651, 2, '{\"code\":\"1\",\"msg\":\"仍有用户属于该部门，无法删除！\"}', 2130706433, '2020-08-28 22:55:23', '/wuage/system/departments/9', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (652, 2, '{\"code\":\"1\",\"msg\":\"仍有用户属于该部门，无法删除！\"}', 2130706433, '2020-08-28 22:58:34', '/wuage/system/departments/9', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (653, 1, '登入成功', 2130706433, '2020-08-28 22:58:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (654, 2, '{\"code\":\"1\",\"msg\":\"仍有用户属于该部门，无法删除！\"}', 2130706433, '2020-08-28 22:58:55', '/wuage/system/departments/9', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (655, 1, '登入成功', 2130706433, '2020-08-28 22:59:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (656, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-28 22:59:46', '/wuage/system/departments/9', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (657, 1, '登入成功', 2130706433, '2020-08-28 23:48:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (658, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-08-29 00:09:40', '/wuage/system/user', NULL, '{\"userId\":[\"18\"],\"username\":[\"fdf\"],\"loginName\":[\"rr\"],\"phone\":[\"213123\"],\"deptId\":[\"8\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (659, 1, '登入成功', 2130706433, '2020-08-29 00:10:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (660, 1, '登入成功', 2130706433, '2020-08-29 00:12:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (661, 1, '登入成功', 2130706433, '2020-08-29 00:16:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (662, 1, '登入成功', 2130706433, '2020-08-29 00:18:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (663, 1, '登入成功', 2130706433, '2020-08-29 00:19:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (664, 1, '登入失败', 2130706433, '2020-08-29 00:23:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (665, 1, '登入成功', 2130706433, '2020-08-29 00:23:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (666, 1, '登入成功', 2130706433, '2020-08-29 00:39:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (667, 1, '登入成功', 2130706433, '2020-08-29 00:40:52', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (668, 1, '登入成功', 2130706433, '2020-08-29 00:44:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (669, 1, '登入成功', 2130706433, '2020-08-29 00:45:27', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (670, 1, '登入失败', 2130706433, '2020-08-29 00:47:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456avc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (671, 1, '登入成功', 2130706433, '2020-08-29 00:47:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (672, 1, '登入成功', 2130706433, '2020-08-29 00:48:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (673, 1, '登入成功', 2130706433, '2020-08-29 00:49:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (674, 1, '登入成功', 2130706433, '2020-08-29 00:53:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (675, 1, '登入成功', 2130706433, '2020-08-29 00:59:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (676, 1, '登入成功', 2130706433, '2020-08-29 01:01:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (677, 1, '登入成功', 2130706433, '2020-08-29 01:04:39', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (678, 1, '登入成功', 2130706433, '2020-09-02 09:45:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (679, 1, '登入成功', 2130706433, '2020-09-02 10:36:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (680, 1, '登入失败', 2130706433, '2020-09-02 13:07:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (681, 1, '登入成功', 2130706433, '2020-09-02 13:07:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (682, 1, '登入成功', 2130706433, '2020-09-02 13:12:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (683, 1, '登入成功', 2130706433, '2020-09-02 14:34:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (684, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:34:48', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/dept/dept-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"department\"],\"menuId\":[\"5\"],\"menuName\":[\"部门管理\"],\"orderNumber\":[\"4\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:dept:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"\"],\"url\":[\"/dept/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (685, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:35:03', '/wuage/system/menu', NULL, '{\"componentPath\":[\"layout\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-08-27 19:42:37\"],\"hasChildren\":[\"true\"],\"icon\":[\"peoples\"],\"menuId\":[\"1\"],\"menuName\":[\"系统管理\"],\"orderNumber\":[\"1\"],\"parentId\":[\"0\"],\"parentName\":[\"\"],\"permission\":[\"system:manage:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"1\"],\"updateBy\":[\"aa\"],\"url\":[\"/system/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (686, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:35:15', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/dept/dept-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"peoples\"],\"menuId\":[\"5\"],\"menuName\":[\"部门管理\"],\"orderNumber\":[\"4\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:dept:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/dept/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (687, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:38:23', '/wuage/system/menu', NULL, '{\"componentPath\":[\"layout\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-08-27 19:42:37\"],\"hasChildren\":[\"true\"],\"icon\":[\"systemsetting\"],\"menuId\":[\"1\"],\"menuName\":[\"系统管理\"],\"orderNumber\":[\"1\"],\"parentId\":[\"0\"],\"parentName\":[\"\"],\"permission\":[\"system:manage:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"1\"],\"updateBy\":[\"aa\"],\"url\":[\"/system/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (688, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:40:54', '/wuage/system/menu', NULL, '{\"componentPath\":[\"layout\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-08-27 19:42:37\"],\"hasChildren\":[\"true\"],\"icon\":[\"setting\"],\"menuId\":[\"1\"],\"menuName\":[\"系统管理\"],\"orderNumber\":[\"1\"],\"parentId\":[\"0\"],\"parentName\":[\"\"],\"permission\":[\"system:manage:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"1\"],\"updateBy\":[\"aa\"],\"url\":[\"/system/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (689, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:41:43', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/menu/menu-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"component\"],\"menuId\":[\"4\"],\"menuName\":[\"菜单管理\"],\"orderNumber\":[\"3\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:menu:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"\"],\"url\":[\"/menu/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (690, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:43:31', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/dept/dept-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"tree\"],\"menuId\":[\"5\"],\"menuName\":[\"部门管理\"],\"orderNumber\":[\"4\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:dept:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/dept/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (691, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:45:41', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/role/role-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"role\"],\"menuId\":[\"3\"],\"menuName\":[\"角色管理\"],\"orderNumber\":[\"10\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:role:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/role/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (692, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:47:07', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/role/role-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"rolemannager\"],\"menuId\":[\"3\"],\"menuName\":[\"角色管理\"],\"orderNumber\":[\"10\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:role:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/role/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (693, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-02 14:49:48', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/role/role-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"people\"],\"menuId\":[\"3\"],\"menuName\":[\"角色管理\"],\"orderNumber\":[\"10\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:role:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/role/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (694, 1, '登入成功', 2130706433, '2020-09-03 21:06:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (695, 1, '登入成功', 2130706433, '2020-09-03 21:06:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (696, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-03 21:39:00', '/wuage/system/user', NULL, '{\"userId\":[\"1\"],\"username\":[\"aa\"],\"loginName\":[\"admin\"],\"phone\":[\"1656461516\"],\"deptId\":[\"1\"],\"roles\":[\"1\",\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (697, 1, '登入失败', 2130706433, '2020-09-03 22:04:29', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456anc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (698, 1, '登入成功', 2130706433, '2020-09-03 22:04:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (699, 1, '登入成功', 2130706433, '2020-09-03 22:05:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (700, 1, '登入成功', 2130706433, '2020-09-03 22:06:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (701, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-03 22:06:21', '/wuage/system/user', NULL, '{\"userId\":[\"1\"],\"username\":[\"aa\"],\"loginName\":[\"admin\"],\"phone\":[\"1656461516\"],\"deptId\":[\"8\"],\"roles\":[\"1\",\"11\",\"12\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (702, 1, '登入成功', 2130706433, '2020-09-03 22:07:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (703, 1, '登入成功', 2130706433, '2020-09-04 01:06:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (704, 1, '登入成功', 2130706433, '2020-09-04 01:31:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (705, 1, '登入失败', 2130706433, '2020-09-04 02:29:25', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (706, 1, '登入成功', 2130706433, '2020-09-04 02:29:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (707, 1, '登入成功', 2130706433, '2020-09-04 02:30:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (708, 1, '登入成功', 2130706433, '2020-09-04 08:16:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (709, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 08:17:44', '/wuage/system/departments', NULL, '{\"creater\":[\"aa\"],\"ctime\":[\"2020-06-23 14:13:50\"],\"deptId\":[\"2\"],\"deptName\":[\"销售部\"],\"deptParentId\":[\"1\"],\"leader\":[\"张三\"],\"parentName\":[\"总公司\"],\"phone\":[\"1\"],\"remark\":[\"\"],\"traversalOrNot\":[\"true\"],\"updateBy\":[\"aa\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (710, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 08:18:53', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/dept/dept-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"tree\"],\"menuId\":[\"5\"],\"menuName\":[\"部门管理\"],\"orderNumber\":[\"3\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:dept:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/dept/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (711, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 08:19:01', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/menu/menu-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"component\"],\"menuId\":[\"4\"],\"menuName\":[\"菜单管理\"],\"orderNumber\":[\"4\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:menu:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/menu/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (712, 1, '登入成功', 2130706433, '2020-09-04 08:27:50', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (713, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 08:28:51', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/role/role-manage\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-03-12 15:32:24\"],\"hasChildren\":[\"true\"],\"icon\":[\"people\"],\"menuId\":[\"3\"],\"menuName\":[\"角色管理\"],\"orderNumber\":[\"2\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:role:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"aa\"],\"url\":[\"/role/manage\"]}', 'admin', '', '更新菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (714, 1, '登入成功', 2130706433, '2020-09-04 08:32:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (715, 1, '登入成功', 2130706433, '2020-09-04 08:35:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (716, 2, '{\"code\":\"1\",\"msg\":\"该部门存在子部门，无法删除!\"}', 2130706433, '2020-09-04 08:38:47', '/wuage/system/departments/1', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (717, 2, '{\"code\":\"1\",\"msg\":\"该部门存在子部门，无法删除!\"}', 2130706433, '2020-09-04 08:39:09', '/wuage/system/departments/2', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (718, 2, '{\"code\":\"1\",\"msg\":\"仍有用户属于该部门，无法删除！\"}', 2130706433, '2020-09-04 08:39:12', '/wuage/system/departments/8', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (719, 2, '{\"code\":\"1\",\"msg\":\"仍有用户属于该部门，无法删除！\"}', 2130706433, '2020-09-04 08:39:16', '/wuage/system/departments/8', NULL, '{}', 'admin', '', '删除部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (720, 1, '登入成功', 2130706433, '2020-09-04 10:00:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (721, 1, '登入成功', 2130706433, '2020-09-04 11:55:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (722, 1, '登入成功', 2130706433, '2020-09-04 11:58:54', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (723, 1, '登入成功', 2130706433, '2020-09-04 12:01:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (724, 1, '登入成功', 2130706433, '2020-09-04 12:14:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (725, 1, '登入成功', 2130706433, '2020-09-04 12:14:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (726, 1, '登入失败', 2130706433, '2020-09-04 12:32:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (727, 1, '登入失败', 2130706433, '2020-09-04 12:32:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (728, 1, '登入失败', 2130706433, '2020-09-04 12:32:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (729, 1, '登入失败', 2130706433, '2020-09-04 12:33:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (730, 1, '登入失败', 2130706433, '2020-09-04 12:34:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (731, 1, '登入失败', 2130706433, '2020-09-04 12:34:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (732, 1, '登入成功', 2130706433, '2020-09-04 12:36:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '', '用户登入', 18, 0, NULL);
INSERT INTO `sys_log` VALUES (733, 1, '登入失败', 2130706433, '2020-09-04 12:41:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (734, 1, '登入失败', 2130706433, '2020-09-04 12:42:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456+abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (735, 1, '登入失败', 2130706433, '2020-09-04 12:43:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"rr\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'rr', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (736, 1, '登入失败', 2130706433, '2020-09-04 12:44:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (737, 1, '登入失败', 2130706433, '2020-09-04 12:47:50', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (738, 1, '登入失败', 2130706433, '2020-09-04 12:47:56', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (739, 1, '登入失败', 2130706433, '2020-09-04 12:49:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1, NULL);
INSERT INTO `sys_log` VALUES (740, 1, '登入成功', 2130706433, '2020-09-04 12:50:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (741, 1, '登入成功', 2130706433, '2020-09-04 13:01:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (742, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 13:01:11', '/wuage/system/user/18', NULL, '{}', 'admin', '', '删除用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (743, 1, '登入成功', 2130706433, '2020-09-04 13:06:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (744, 1, '登入成功', 2130706433, '2020-09-04 15:01:18', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (745, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:01:35', '/wuage/system/departments', NULL, '{\"creater\":[\"admin\"],\"ctime\":[\"2019-12-31 17:06:07\"],\"deptId\":[\"1\"],\"deptName\":[\"总公司\"],\"deptParentId\":[\"0\"],\"leader\":[\"张总阿萨德\"],\"parentName\":[\"\"],\"phone\":[\"13865488888\"],\"remark\":[\"\"],\"traversalOrNot\":[\"true\"],\"updateBy\":[\"aa\"]}', 'admin', '', '更新部门', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (746, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:02:41', '/wuage/system/user', NULL, '{\"userId\":[\"1\"],\"username\":[\"电饭锅后海\"],\"loginName\":[\"admin\"],\"phone\":[\"13865456541\"],\"deptId\":[\"8\"],\"roles\":[\"1\",\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (747, 1, '登入成功', 2130706433, '2020-09-04 15:22:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (748, 2, '{\"code\":\"1\",\"msg\":\"登陆名重复\"}', 2130706433, '2020-09-04 15:23:31', '/wuage/system/user', NULL, '{\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles[0]\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (749, 2, '{\"code\":\"0\",\"data\":19,\"msg\":\"success\"}', 2130706433, '2020-09-04 15:23:31', '/wuage/system/user', NULL, '{\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles[0]\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '添加用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (750, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:23:48', '/wuage/system/user', NULL, '{\"userId\":[\"19\"],\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (751, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:23:48', '/wuage/system/user', NULL, '{\"userId\":[\"19\"],\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (752, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:23:51', '/wuage/system/user', NULL, '{\"userId\":[\"19\"],\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (753, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:23:51', '/wuage/system/user', NULL, '{\"userId\":[\"19\"],\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (754, 1, '登入成功', 2130706433, '2020-09-04 15:26:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (755, 1, '登入成功', 2130706433, '2020-09-04 15:40:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (756, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 15:41:30', '/wuage/system/user', NULL, '{\"userId\":[\"19\"],\"username\":[\"阿萨德\"],\"loginName\":[\"ff\"],\"phone\":[\"13456785464\"],\"deptId\":[\"6\"],\"roles\":[\"11\"],\"locked\":[\"0\"],\"sex\":[\"1\"],\"remark\":[\"阿斯达撒旦速度撒\"]}', 'admin', '', '更新用户', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (757, 1, '登入成功', 2130706433, '2020-09-04 18:47:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', '', '用户登入', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (758, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 18:48:29', '/wuage/system/menu', NULL, '{\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"type\":[\"1\"],\"orderNumber\":[\"1\"],\"status\":[\"1\"]}', 'admin', '', '添加菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (759, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-09-04 18:48:42', '/wuage/system/menu/18', NULL, '{}', 'admin', '', '删除菜单', 1, 0, NULL);
INSERT INTO `sys_log` VALUES (760, 1, '登入成功', 2130706433, '2020-10-04 09:23:13', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (761, 1, '登入成功', 2130706433, '2020-10-04 15:23:05', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (762, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:38:07', '/wuage/system/menu', NULL, '{\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"menuName\":[\"系统设置\"],\"type\":[\"2\"],\"icon\":[\"setting\"],\"url\":[\"/config\"],\"orderNumber\":[\"5\"],\"status\":[\"1\"],\"permission\":[\"system:config:view\"],\"componentPath\":[\"/sysconfig/sysconfig-manager\"]}', 'admin', '', '添加菜单', 1, 0, '0.1250');
INSERT INTO `sys_log` VALUES (763, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:38:46', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/sysconfig/sysconfig-manager\"],\"creater\":[\"电饭锅后海\"],\"ctime\":[\"2020-10-04 15:38:07\"],\"hasChildren\":[\"false\"],\"icon\":[\"setting\"],\"menuId\":[\"19\"],\"menuName\":[\"系统设置\"],\"orderNumber\":[\"5\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:config:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"0000-00-00 00:00:00\"],\"url\":[\"sysconfig/sysconfig-manager\"]}', 'admin', '', '更新菜单', 1, 0, '0.1420');
INSERT INTO `sys_log` VALUES (764, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:39:05', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/sysconfig/sysconfig-manager\"],\"creater\":[\"电饭锅后海\"],\"ctime\":[\"2020-10-04 15:38:07\"],\"hasChildren\":[\"false\"],\"icon\":[\"setting\"],\"menuId\":[\"19\"],\"menuName\":[\"系统设置\"],\"orderNumber\":[\"5\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:config:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"电饭锅后海\"],\"url\":[\"/sysconfig/sysconfig-manager\"]}', 'admin', '', '更新菜单', 1, 0, '0.0400');
INSERT INTO `sys_log` VALUES (765, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:39:19', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/sysconfig/sysconfig-manag\"],\"creater\":[\"电饭锅后海\"],\"ctime\":[\"2020-10-04 15:38:07\"],\"hasChildren\":[\"false\"],\"icon\":[\"setting\"],\"menuId\":[\"19\"],\"menuName\":[\"系统设置\"],\"orderNumber\":[\"5\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:config:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"电饭锅后海\"],\"url\":[\"/sysconfig/sysconfig-manager\"]}', 'admin', '', '更新菜单', 1, 0, '0.0340');
INSERT INTO `sys_log` VALUES (766, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:39:29', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/sysconfig/sysconfig-manage\"],\"creater\":[\"电饭锅后海\"],\"ctime\":[\"2020-10-04 15:38:07\"],\"hasChildren\":[\"false\"],\"icon\":[\"setting\"],\"menuId\":[\"19\"],\"menuName\":[\"系统设置\"],\"orderNumber\":[\"5\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:config:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"电饭锅后海\"],\"url\":[\"/sysconfig/sysconfig-manager\"]}', 'admin', '', '更新菜单', 1, 0, '0.0440');
INSERT INTO `sys_log` VALUES (767, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:39:48', '/wuage/system/menu', NULL, '{\"componentPath\":[\"system/sysconfig/sysconfig-manage\"],\"creater\":[\"电饭锅后海\"],\"ctime\":[\"2020-10-04 15:38:07\"],\"hasChildren\":[\"false\"],\"icon\":[\"setting\"],\"menuId\":[\"19\"],\"menuName\":[\"系统设置\"],\"orderNumber\":[\"5\"],\"parentId\":[\"1\"],\"parentName\":[\"系统管理\"],\"permission\":[\"system:config:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"2\"],\"updateBy\":[\"电饭锅后海\"],\"url\":[\"/sysconfig/sysconfig-manage\"]}', 'admin', '', '更新菜单', 1, 0, '0.0480');
INSERT INTO `sys_log` VALUES (768, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-04 15:40:27', '/wuage/system/menu', NULL, '{\"componentPath\":[\"layout\"],\"creater\":[\"admin\"],\"ctime\":[\"2020-08-27 19:42:37\"],\"hasChildren\":[\"true\"],\"icon\":[\"list\"],\"menuId\":[\"1\"],\"menuName\":[\"系统管理\"],\"orderNumber\":[\"1\"],\"parentId\":[\"0\"],\"parentName\":[\"\"],\"permission\":[\"system:manage:view\"],\"status\":[\"1\"],\"traversalOrNot\":[\"true\"],\"type\":[\"1\"],\"updateBy\":[\"aa\"],\"url\":[\"/system/manage\"]}', 'admin', '', '更新菜单', 1, 0, '0.0440');
INSERT INTO `sys_log` VALUES (769, 1, '登入成功', 2130706433, '2020-10-04 23:14:43', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (770, 1, '登入成功', 2130706433, '2020-10-05 00:30:19', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (771, 1, '登入成功', 2130706433, '2020-10-05 00:55:36', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (772, 1, '登入成功', 2130706433, '2020-10-05 00:56:13', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (773, 1, '登入成功', 2130706433, '2020-10-05 01:00:01', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (774, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 01:02:16', '/wuage/system/config', NULL, '{}', 'admin', '', '更改系统参数', 1, 0, '129.7340');
INSERT INTO `sys_log` VALUES (775, 1, '登入成功', 2130706433, '2020-10-05 01:03:08', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (776, 1, '登入成功', 2130706433, '2020-10-05 01:04:39', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (777, 1, '登入成功', 2130706433, '2020-10-05 01:06:52', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (778, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 01:07:16', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '11.9430');
INSERT INTO `sys_log` VALUES (779, 1, '登入成功', 2130706433, '2020-10-05 12:27:47', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (780, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 12:31:25', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"0\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0310');
INSERT INTO `sys_log` VALUES (781, 1, '登入成功', 2130706433, '2020-10-05 13:28:02', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (782, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:29:57', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0760');
INSERT INTO `sys_log` VALUES (783, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:30:11', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"4\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0190');
INSERT INTO `sys_log` VALUES (784, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:32:15', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"4\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0210');
INSERT INTO `sys_log` VALUES (785, 1, '登入成功', 2130706433, '2020-10-05 13:33:21', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (786, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:33:28', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0400');
INSERT INTO `sys_log` VALUES (787, 1, '登入成功', 2130706433, '2020-10-05 13:37:00', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (788, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:37:04', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0470');
INSERT INTO `sys_log` VALUES (789, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:37:24', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"0\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0150');
INSERT INTO `sys_log` VALUES (790, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:39:13', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"2\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"4\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0170');
INSERT INTO `sys_log` VALUES (791, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:44:06', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"0\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0120');
INSERT INTO `sys_log` VALUES (792, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:44:11', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0110');
INSERT INTO `sys_log` VALUES (793, 1, '登入成功', 2130706433, '2020-10-05 13:44:45', NULL, NULL, NULL, 'admin', '', NULL, 1, 0, NULL);
INSERT INTO `sys_log` VALUES (794, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:44:53', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"5\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0420');
INSERT INTO `sys_log` VALUES (795, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:45:12', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0170');
INSERT INTO `sys_log` VALUES (796, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:47:03', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"0\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0200');
INSERT INTO `sys_log` VALUES (797, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:47:15', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0150');
INSERT INTO `sys_log` VALUES (798, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:47:18', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"0\"],\"CAPTCHA_SWITCH\":[\"1\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0160');
INSERT INTO `sys_log` VALUES (799, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:47:22', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"0\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0140');
INSERT INTO `sys_log` VALUES (800, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2020-10-05 13:58:09', '/wuage/system/config', NULL, '{\"SYSTEM_MODE\":[\"0\"],\"FREEZE_HOUR\":[\"1\"],\"LOGIN_SWITCH\":[\"1\"],\"CAPTCHA_SWITCH\":[\"0\"],\"MAX_LOGIN_ERROR\":[\"3\"]}', 'admin', '', '更改系统参数', 1, 0, '0.0190');

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
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '更新者',
  `update_time` timestamp(0) NULL DEFAULT NULL COMMENT '更新时间',
  `permission` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '权限字符串',
  `component_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `hasChildren` tinyint(1) NULL DEFAULT 0 COMMENT '是否有子菜单（按钮不算）',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 1, 'list', '/system/manage', 1, 1, 0, 'admin', '2020-08-27 19:42:37', '电饭锅后海', '2020-10-04 15:40:27', 'system:manage:view', 'layout', 1);
INSERT INTO `sys_menu` VALUES (2, '用户管理', 2, 'user', '/user/manage', 1, 1, 1, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:user:view', 'system/user/index', 1);
INSERT INTO `sys_menu` VALUES (3, '角色管理', 2, 'people', '/role/manage', 2, 1, 1, 'admin', '2020-03-12 15:32:24', 'aa', '2020-09-04 08:28:51', 'system:role:view', 'system/role/role-manage', 1);
INSERT INTO `sys_menu` VALUES (4, '菜单管理', 2, 'component', '/menu/manage', 4, 1, 1, 'admin', '2020-03-12 15:32:24', 'aa', '2020-09-04 08:19:01', 'system:menu:view', 'system/menu/menu-manage', 1);
INSERT INTO `sys_menu` VALUES (5, '部门管理', 2, 'tree', '/dept/manage', 3, 1, 1, 'admin', '2020-03-12 15:32:24', 'aa', '2020-09-04 08:18:53', 'system:dept:view', 'system/dept/dept-manage', 1);
INSERT INTO `sys_menu` VALUES (6, '添加用户', 3, NULL, NULL, 1, 1, 2, 'admin', '2020-06-15 14:00:37', '', '0000-00-00 00:00:00', 'system:user:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (7, '删除用户', 3, NULL, NULL, 2, 1, 2, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:user:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (8, '更新用户', 3, NULL, NULL, 3, 1, 2, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:user:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (9, '添加角色', 3, NULL, NULL, 1, 1, 3, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:role:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (10, '删除角色', 3, NULL, NULL, 2, 1, 3, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:role:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (11, '更新角色', 3, NULL, NULL, 3, 1, 3, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:role:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (12, '添加菜单', 3, NULL, NULL, 1, 1, 4, 'admin', '2020-03-12 15:32:24', '', '0000-00-00 00:00:00', 'system:menu:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (13, '删除菜单', 3, NULL, NULL, 2, 1, 4, 'admin', '2020-03-12 15:32:25', '', '0000-00-00 00:00:00', 'system:menu:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (14, '更新菜单', 3, NULL, NULL, 3, 1, 4, 'admin', '2020-03-12 15:32:25', '', '0000-00-00 00:00:00', 'system:menu:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (15, '添加部门', 3, NULL, NULL, 1, 1, 5, 'admin', '2020-03-12 15:32:25', '', '0000-00-00 00:00:00', 'system:dept:add', NULL, 0);
INSERT INTO `sys_menu` VALUES (16, '删除部门', 3, NULL, NULL, 2, 1, 5, 'admin', '2020-03-12 15:32:25', '', '0000-00-00 00:00:00', 'system:dept:delete', NULL, 0);
INSERT INTO `sys_menu` VALUES (17, '更新部门', 3, NULL, NULL, 3, 1, 5, 'admin', '2020-03-12 15:32:25', '', '0000-00-00 00:00:00', 'system:dept:update', NULL, 0);
INSERT INTO `sys_menu` VALUES (19, '系统设置', 2, 'setting', '/sysconfig/sysconfig-manage', 5, 1, 1, '电饭锅后海', '2020-10-04 15:38:07', '电饭锅后海', '2020-10-04 15:39:48', 'system:config:view', 'system/sysconfig/sysconfig-manage', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '角色id',
  `role_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` timestamp(0) NOT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '角色状态',
  `role_code` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '角色代码',
  `data_range` int(8) NOT NULL COMMENT '角色数据范围',
  `role_type` tinyint(2) NULL DEFAULT 0 COMMENT '角色类型',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统角色' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', NULL, '2020-08-22 01:33:18', 'admin', '2020-08-20 16:21:51', '', 1, 'SUPER_ADMIN', 4, 1);
INSERT INTO `sys_role` VALUES (11, '撒地方的', 'admin', '2020-08-29 00:09:18', 'admin', '2020-08-28 00:27:55', '', 1, 'GH', 2, 0);

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
INSERT INTO `sys_role_menu` VALUES (5, 3);
INSERT INTO `sys_role_menu` VALUES (5, 9);
INSERT INTO `sys_role_menu` VALUES (5, 10);
INSERT INTO `sys_role_menu` VALUES (5, 11);
INSERT INTO `sys_role_menu` VALUES (11, 1);
INSERT INTO `sys_role_menu` VALUES (11, 2);
INSERT INTO `sys_role_menu` VALUES (11, 3);
INSERT INTO `sys_role_menu` VALUES (11, 6);
INSERT INTO `sys_role_menu` VALUES (11, 8);
INSERT INTO `sys_role_menu` VALUES (11, 9);
INSERT INTO `sys_role_menu` VALUES (11, 10);
INSERT INTO `sys_role_menu` VALUES (11, 11);

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
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话',
  `ctime` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `last_login_time` timestamp(0) NOT NULL COMMENT '上次登录时间',
  `locked` tinyint(4) NULL DEFAULT 0 COMMENT '锁定状态 0 未锁定 1 管理员锁定 2 输错密码锁定',
  `salt` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '加密盐值',
  `dept_id` int(11) NULL DEFAULT NULL COMMENT '部门id',
  `creater` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `update_by` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '更新者',
  `update_time` timestamp(0) NOT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '备注',
  `lock_time` timestamp(0) NOT NULL COMMENT '锁定时间',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '81a6fe53c832c695957174c0d6fe5037', '电饭锅后海', 'asd', 1, '13865456541', '2020-09-04 15:02:39', '2019-12-13 11:54:51', 0, 'yeepaf9n', 8, NULL, 'admin', '2020-09-04 15:02:40', NULL, '2020-09-04 12:42:07');
INSERT INTO `sys_user` VALUES (17, 'd', 'b40ac74c2303da4f7457b537dcace57c', 'dd', NULL, 1, '12312', '2020-08-28 00:45:11', '0000-00-00 00:00:00', 0, '9sdrb2al', 7, 'aa', 'd', '2020-08-28 00:45:12', '', '0000-00-00 00:00:00');
INSERT INTO `sys_user` VALUES (19, 'ff', '0691b54d428a70fd4549a446b57622f4', '阿萨德', NULL, 1, '13456785464', '2020-09-04 15:41:29', '0000-00-00 00:00:00', 0, 'avur5128', 6, '电饭锅后海', 'admin', '2020-09-04 15:41:30', '阿斯达撒旦速度撒', '0000-00-00 00:00:00');

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
INSERT INTO `sys_user_role` VALUES (1, 11);
INSERT INTO `sys_user_role` VALUES (17, 11);
INSERT INTO `sys_user_role` VALUES (17, 12);
INSERT INTO `sys_user_role` VALUES (19, 11);

-- ----------------------------
-- Function structure for selectChildByParentId
-- ----------------------------
DROP FUNCTION IF EXISTS `selectChildByParentId`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `selectChildByParentId`(`parent_id` bigint) RETURNS varchar(4000) CHARSET utf8
BEGIN
# 定义一个变量用来返回结果
DECLARE finalVar VARCHAR(2000);
# 定义一个临时变量
DECLARE tempVar VARCHAR(2000);

# 设置默认值
SET finalVar='$';
# 转换入参类型
SET tempVar = CAST(parent_id AS CHAR);

# 循环体，如果当前的临时变量中没有值，为空的情况下跳出循环，也就是说没有子节点了
WHILE tempVar IS NOT NULL DO

# 将得到的子节点保存到变量中
SET finalVar= CONCAT(finalVar,',',tempVar);
# 根据父Id查询所有的子节点
SELECT GROUP_CONCAT(t.dept_id) INTO tempVar FROM sys_dept t WHERE FIND_IN_SET(t.dept_parent_id,tempVar)>0;

# 结束循环
END WHILE;
# 返回结果,得到的是包含入参以及下面的所有子节点
RETURN finalVar;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for selectParentByChildId
-- ----------------------------
DROP FUNCTION IF EXISTS `selectParentByChildId`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `selectParentByChildId`(`son_id` bigint) RETURNS varchar(4000) CHARSET utf8
BEGIN
# 定义一个变量用来返回结果
DECLARE finalVar VARCHAR(2000);
# 定义一个临时变量
DECLARE tempVar BIGINT;

# 设置默认值
SET finalVar='$';
# 转换入参类型
SET tempVar =son_id;


# 循环体，如果当前的父节点为0，那么说明已经查询完毕了
WHILE tempVar <> 0 DO

# 将得到的子节点保存到变量中
SET finalVar= CONCAT(finalVar,',',tempVar);
# 根据子Id查询父Id
SELECT t.dept_parent_id INTO tempVar FROM sys_dept t WHERE t.dept_id=tempVar;

# 结束循环
END WHILE;
# 返回结果,得到的是包含入参以及下面的所有子节点
RETURN finalVar;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
