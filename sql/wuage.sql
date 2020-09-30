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

 Date: 30/12/2019 17:29:07
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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '部门' ROW_FORMAT = Compact;

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
) ENGINE = InnoDB AUTO_INCREMENT = 163 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统日志' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES (1, 1, '登入失败', 2130706433, '2019-12-19 10:40:56', '/login', NULL, '{\"loginName\":[\"bb\"],\"password\":[\"123456abc\"],\"captcha\":[\"ce42\"],\"rememberMe\":[\"true\"]}', 'bb', 1, '', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (2, 1, '登入成功', 2130706433, '2019-12-19 10:41:19', '/login', NULL, '{\"loginName\":[\"bb\"],\"password\":[\"123456abc\"],\"captcha\":[\"n5db\"],\"rememberMe\":[\"true\"]}', 'bb', 1, '', '用户登入', 2, 0);
INSERT INTO `sys_log` VALUES (3, 1, '登入成功', 2130706433, '2019-12-19 10:43:27', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456abc\"],\"captcha\":[\"n5db\"],\"rememberMe\":[\"true\"]}', 'aa', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (4, 1, '登入失败', 2130706433, '2019-12-19 10:49:47', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456abc\"],\"captcha\":[\"n5db\"],\"rememberMe\":[\"true\"]}', 'aa', 1, '', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (5, 1, '登入成功', 2130706433, '2019-12-19 10:50:18', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456abc\"],\"captcha\":[\"m53b\"],\"rememberMe\":[\"false\"]}', 'aa', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (6, 1, '登入失败', 2130706433, '2019-12-19 10:59:52', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456abc\"],\"captcha\":[\"m53b\"],\"rememberMe\":[\"false\"]}', 'aa', 1, '', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (7, 1, '登入成功', 2130706433, '2019-12-19 11:00:10', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456abc\"],\"captcha\":[\"465c\"],\"rememberMe\":[\"false\"]}', 'aa', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (8, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2019-12-19 11:00:16', '/system/user', NULL, '{\"loginName\":[\"adfds\"],\"password\":[\"123456abc\"],\"username\":[\"asd\"],\"avatar\":[\"asd\"],\"sex\":[\"0\"],\"email\":[\"666161615@aq.com\"],\"phone\":[\"1656461516\"],\"deptId\":[\"15615\"]}', 'aa', 1, '', '菜单管理', 1, 0);
INSERT INTO `sys_log` VALUES (9, 2, '{\"code\":\"0\",\"msg\":\"success\"}', 2130706433, '2019-12-19 11:00:43', '/system/user', NULL, '{\"loginName\":[\"adfds\"],\"password\":[\"123456abc\"],\"username\":[\"asd\"],\"avatar\":[\"asd\"],\"sex\":[\"0\"],\"email\":[\"666161615@aq.com\"],\"phone\":[\"1656461516\"],\"deptId\":[\"15615\"]}', 'aa', 1, '', '菜单管理', 1, 0);
INSERT INTO `sys_log` VALUES (10, 1, '登入成功', 2130706433, '2019-12-19 11:04:13', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456abc\"],\"captcha\":[\"465c\"],\"rememberMe\":[\"false\"]}', 'aa', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (11, 1, '登入失败', 2130706433, '2019-12-19 11:10:24', '/login', NULL, '{\"loginName\":[\"aa\"],\"password\":[\"123456ab\"],\"captcha\":[\"465c\"],\"rememberMe\":[\"false\"]}', 'aa', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (12, 1, '登入成功', 2130706433, '2019-12-25 15:55:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"7y58\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (13, 1, '登入成功', 2130706433, '2019-12-25 16:01:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"7y58\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (14, 1, '登入成功', 2130706433, '2019-12-25 16:20:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"7y58\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (15, 1, '登入成功', 2130706433, '2019-12-25 16:20:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"7y58\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (16, 1, '登入失败', 2130706433, '2019-12-25 16:33:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123455\"],\"captcha\":[\"asda\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (17, 1, '登入成功', 2130706433, '2019-12-25 16:34:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"6x6p\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (18, 1, '登入失败', 2130706433, '2019-12-25 16:41:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ab\"],\"captcha\":[\"5n32\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (19, 1, '登入成功', 2130706433, '2019-12-25 16:41:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5n32\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (20, 1, '登入成功', 2130706433, '2019-12-25 16:42:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5n32\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (21, 1, '登入成功', 2130706433, '2019-12-25 16:44:21', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"g8cw\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (22, 1, '登入成功', 2130706433, '2019-12-25 16:57:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"4xc8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (23, 1, '登入失败', 2130706433, '2019-12-26 09:15:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456qbc\"],\"captcha\":[\"pnmm\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (24, 1, '登入失败', 2130706433, '2019-12-26 09:15:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456ab\"],\"captcha\":[\"pnmm\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (25, 1, '登入成功', 2130706433, '2019-12-26 09:16:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"pnmm\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (26, 1, '登入成功', 2130706433, '2019-12-26 10:04:29', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"d5aw\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (27, 1, '登入成功', 2130706433, '2019-12-26 10:05:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"77aw\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (28, 1, '登入成功', 2130706433, '2019-12-26 10:05:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"77aw\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (29, 1, '登入成功', 2130706433, '2019-12-26 10:06:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"77aw\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (30, 1, '登入成功', 2130706433, '2019-12-26 10:08:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"u44n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (31, 1, '登入成功', 2130706433, '2019-12-26 10:11:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"u44n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (32, 1, '登入成功', 2130706433, '2019-12-26 10:13:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"7yap\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (33, 1, '登入成功', 2130706433, '2019-12-26 10:19:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"fcn8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (34, 1, '登入成功', 2130706433, '2019-12-26 10:19:46', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"fcn8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (35, 1, '登入成功', 2130706433, '2019-12-26 10:20:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"fcn8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (36, 1, '登入成功', 2130706433, '2019-12-26 10:22:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"fcn8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (37, 1, '登入成功', 2130706433, '2019-12-26 10:24:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"fcn8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (38, 1, '登入成功', 2130706433, '2019-12-26 10:24:56', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"p83n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (39, 1, '登入成功', 2130706433, '2019-12-26 10:25:42', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"p83n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (40, 1, '登入成功', 2130706433, '2019-12-26 10:26:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"p83n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (41, 1, '登入成功', 2130706433, '2019-12-26 10:30:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"3aw4\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (42, 1, '登入成功', 2130706433, '2019-12-26 10:31:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5p4n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (43, 1, '登入成功', 2130706433, '2019-12-26 10:34:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5p4n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (44, 1, '登入成功', 2130706433, '2019-12-26 10:35:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"py53\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (45, 1, '登入成功', 2130706433, '2019-12-26 10:35:39', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"py53\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (46, 1, '登入成功', 2130706433, '2019-12-26 10:35:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"py53\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (47, 1, '登入成功', 2130706433, '2019-12-26 10:36:50', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"6aem\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (48, 1, '登入成功', 2130706433, '2019-12-26 10:39:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"dcmw\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (49, 1, '登入成功', 2130706433, '2019-12-26 10:50:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ce4f\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (50, 1, '登入成功', 2130706433, '2019-12-26 10:53:50', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cx6v\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (51, 1, '登入失败', 2130706433, '2019-12-26 11:00:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (52, 1, '登入成功', 2130706433, '2019-12-26 11:00:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cx6v\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (53, 1, '登入成功', 2130706433, '2019-12-26 11:02:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cx6v\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (54, 1, '登入成功', 2130706433, '2019-12-26 11:08:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cx6v\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (55, 1, '登入成功', 2130706433, '2019-12-26 11:16:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cx6v\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (56, 1, '登入成功', 2130706433, '2019-12-26 11:17:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"e87y\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (57, 1, '登入成功', 2130706433, '2019-12-26 11:18:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"c647\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (58, 1, '登入成功', 2130706433, '2019-12-26 11:26:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"wmd6\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (59, 1, '登入成功', 2130706433, '2019-12-26 11:27:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"n74n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (60, 1, '登入成功', 2130706433, '2019-12-26 11:28:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ydn8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (61, 1, '登入成功', 2130706433, '2019-12-26 11:31:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"e3yp\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (62, 1, '登入成功', 2130706433, '2019-12-26 11:31:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"nf3m\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (63, 1, '登入失败', 2130706433, '2019-12-26 11:33:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"abc123456\"],\"captcha\":[\"4fgf\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (64, 1, '登入成功', 2130706433, '2019-12-26 11:33:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"4fgf\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (65, 1, '登入成功', 2130706433, '2019-12-26 11:34:38', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"784a\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (66, 1, '登入成功', 2130706433, '2019-12-26 11:35:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"n5nx\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (67, 1, '登入成功', 2130706433, '2019-12-26 12:06:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"meng\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (68, 1, '登入成功', 2130706433, '2019-12-26 12:09:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"2gge\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (69, 1, '登入成功', 2130706433, '2019-12-26 12:22:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"e6f7\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (70, 1, '登入成功', 2130706433, '2019-12-26 14:33:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"pa4g\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (71, 1, '登入成功', 2130706433, '2019-12-26 15:13:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"nf38\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (72, 1, '登入成功', 2130706433, '2019-12-26 15:13:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"pn7d\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (73, 1, '登入成功', 2130706433, '2019-12-26 15:22:41', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"g7a8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (74, 1, '登入成功', 2130706433, '2019-12-26 16:17:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ceny\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (75, 1, '登入成功', 2130706433, '2019-12-26 17:06:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"neew\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (76, 1, '登入成功', 2130706433, '2019-12-26 17:07:41', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ea3w\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (77, 1, '登入成功', 2130706433, '2019-12-26 17:09:41', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ea3w\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (78, 1, '登入成功', 2130706433, '2019-12-26 17:10:00', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"n2mn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (79, 1, '登入成功', 2130706433, '2019-12-26 17:10:02', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"n2mn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (80, 1, '登入成功', 2130706433, '2019-12-26 17:13:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"w7da\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (81, 1, '登入成功', 2130706433, '2019-12-26 17:13:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"w7da\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (82, 1, '登入成功', 2130706433, '2019-12-26 17:13:43', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"w7da\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (83, 1, '登入成功', 2130706433, '2019-12-26 17:13:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"w7da\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (84, 1, '登入成功', 2130706433, '2019-12-26 17:13:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"w7da\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (85, 1, '登入成功', 2130706433, '2019-12-26 17:45:59', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"6wyy\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (86, 1, '登入成功', 2130706433, '2019-12-26 17:47:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"2yaw\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (87, 1, '登入成功', 2130706433, '2019-12-27 11:03:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5yb8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (88, 1, '登入成功', 2130706433, '2019-12-27 11:11:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"8275\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (89, 1, '登入成功', 2130706433, '2019-12-27 11:28:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ye27\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (90, 1, '登入成功', 2130706433, '2019-12-27 11:28:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"xaww\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (91, 1, '登入失败', 2130706433, '2019-12-27 11:36:07', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"asdasd\"],\"captcha\":[\"ppxn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (92, 1, '登入失败', 2130706433, '2019-12-27 11:36:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"asdasd\"],\"captcha\":[\"ppxn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (93, 1, '登入失败', 2130706433, '2019-12-27 11:36:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"asdasd\"],\"captcha\":[\"ppxn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (94, 1, '登入失败', 2130706433, '2019-12-27 11:36:21', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"asdasd\"],\"captcha\":[\"ppxn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有1次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (95, 1, '登入失败', 2130706433, '2019-12-27 11:36:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"abc123456\"],\"captcha\":[\"ppxn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '输入密码错误次数超过5次,请在1小时后再登录', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (96, 1, '登入成功', 2130706433, '2019-12-27 11:41:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"ppxn\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (97, 1, '登入成功', 2130706433, '2019-12-27 14:12:41', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"3x45\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (98, 1, '登入成功', 2130706433, '2019-12-27 14:12:54', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"3x45\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (99, 1, '登入成功', 2130706433, '2019-12-27 14:14:30', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5faf\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (100, 1, '登入成功', 2130706433, '2019-12-27 14:14:31', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"5faf\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (101, 1, '登入成功', 2130706433, '2019-12-27 14:18:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"pgn8\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (102, 1, '登入成功', 2130706433, '2019-12-27 15:35:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"8fwg\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (103, 1, '登入成功', 2130706433, '2019-12-27 15:35:13', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"8fwg\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (104, 1, '登入成功', 2130706433, '2019-12-27 15:37:24', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"e5d6\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (105, 1, '登入成功', 2130706433, '2019-12-27 15:37:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"e5d6\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (106, 1, '登入失败', 2130706433, '2019-12-27 15:38:36', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456a\"],\"captcha\":[\"nfpa\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (107, 1, '登入成功', 2130706433, '2019-12-27 15:38:54', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"nfpa\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (108, 1, '登入成功', 2130706433, '2019-12-27 15:38:57', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"nfpa\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (109, 1, '登入成功', 2130706433, '2019-12-27 15:39:08', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cnx3\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (110, 1, '登入成功', 2130706433, '2019-12-27 15:40:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"bb\"],\"password\":[\"123456abc\"],\"captcha\":[\"dw4c\"],\"rememberMe\":[\"false\"]}', 'bb', 1, '', '用户登入', 2, 0);
INSERT INTO `sys_log` VALUES (111, 1, '登入成功', 2130706433, '2019-12-27 15:43:03', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"3e\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (112, 1, '登入成功', 2130706433, '2019-12-27 15:44:40', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"dd\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (113, 1, '登入成功', 2130706433, '2019-12-27 15:46:21', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"cn6n\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (114, 1, '登入成功', 2130706433, '2019-12-27 15:46:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"dm82\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (115, 1, '登入成功', 2130706433, '2019-12-27 15:50:35', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"4\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (116, 1, '登入成功', 2130706433, '2019-12-27 15:54:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"fpfd\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (117, 1, '登入成功', 2130706433, '2019-12-27 15:56:17', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (118, 1, '登入成功', 2130706433, '2019-12-27 15:57:26', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"g5x8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (119, 1, '登入成功', 2130706433, '2019-12-27 15:57:28', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"g5x8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (120, 1, '登入成功', 2130706433, '2019-12-27 15:57:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"g5x8\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (121, 1, '登入成功', 2130706433, '2019-12-27 16:04:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"gffd\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (122, 1, '登入成功', 2130706433, '2019-12-27 16:04:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"gffd\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (123, 1, '登入成功', 2130706433, '2019-12-27 16:04:48', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"p66e\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (124, 1, '登入成功', 2130706433, '2019-12-27 16:14:44', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (125, 1, '登入成功', 2130706433, '2019-12-27 16:30:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"e4y4\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (126, 1, '登入成功', 2130706433, '2019-12-27 16:32:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (127, 1, '登入成功', 2130706433, '2019-12-27 16:34:16', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (128, 1, '登入失败', 2130706433, '2019-12-27 16:35:33', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456\"],\"captcha\":[\"BBYF\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有4次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (129, 1, '登入失败', 2130706433, '2019-12-27 16:35:39', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"ABC123456\"],\"captcha\":[\"BBYF\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有3次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (130, 1, '登入失败', 2130706433, '2019-12-27 16:35:50', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"ABC123456\"],\"captcha\":[\"BBYF\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '密码错误!你还有2次机会，连续输错后账号将被锁定！', '用户登入', NULL, 1);
INSERT INTO `sys_log` VALUES (131, 1, '登入成功', 2130706433, '2019-12-27 16:35:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"BBYF\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (132, 1, '登入成功', 2130706433, '2019-12-27 16:54:09', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (133, 1, '登入成功', 2130706433, '2019-12-27 17:01:25', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (134, 1, '登入成功', 2130706433, '2019-12-27 17:04:39', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (135, 1, '登入成功', 2130706433, '2019-12-27 17:23:04', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (136, 1, '登入成功', 2130706433, '2019-12-27 17:24:53', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (137, 1, '登入成功', 2130706433, '2019-12-27 17:29:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (138, 1, '登入成功', 2130706433, '2019-12-27 17:40:49', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (139, 1, '登入成功', 2130706433, '2019-12-27 17:44:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"true\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (140, 1, '登入成功', 2130706433, '2019-12-30 08:50:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (141, 1, '登入成功', 2130706433, '2019-12-30 08:50:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (142, 1, '登入成功', 2130706433, '2019-12-30 08:51:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (143, 1, '登入成功', 2130706433, '2019-12-30 08:52:41', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (144, 1, '登入成功', 2130706433, '2019-12-30 08:57:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (145, 1, '登入成功', 2130706433, '2019-12-30 08:57:51', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (146, 1, '登入成功', 2130706433, '2019-12-30 09:28:22', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (147, 1, '登入成功', 2130706433, '2019-12-30 09:31:06', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (148, 1, '登入成功', 2130706433, '2019-12-30 09:33:15', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (149, 1, '登入成功', 2130706433, '2019-12-30 09:34:11', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (150, 1, '登入成功', 2130706433, '2019-12-30 09:35:10', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (151, 1, '登入成功', 2130706433, '2019-12-30 09:37:58', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (152, 1, '登入成功', 2130706433, '2019-12-30 09:38:23', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (153, 1, '登入成功', 2130706433, '2019-12-30 09:39:32', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (154, 1, '登入成功', 2130706433, '2019-12-30 09:55:20', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (155, 1, '登入成功', 2130706433, '2019-12-30 09:56:14', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (156, 1, '登入成功', 2130706433, '2019-12-30 10:12:05', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (157, 1, '登入成功', 2130706433, '2019-12-30 14:31:37', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (158, 1, '登入成功', 2130706433, '2019-12-30 14:32:55', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (159, 1, '登入成功', 2130706433, '2019-12-30 14:35:01', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (160, 1, '登入成功', 2130706433, '2019-12-30 15:10:12', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (161, 1, '登入成功', 2130706433, '2019-12-30 16:41:34', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);
INSERT INTO `sys_log` VALUES (162, 1, '登入成功', 2130706433, '2019-12-30 17:11:19', '/wuage/systemUser/login', NULL, '{\"loginName\":[\"admin\"],\"password\":[\"123456abc\"],\"captcha\":[\"\"],\"rememberMe\":[\"false\"]}', 'admin', 1, '', '用户登入', 1, 0);

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
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统菜单' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 1, NULL, NULL, 1, 1, 0, 'admin', '2019-12-19 10:05:44', '0000-00-00 00:00:00', NULL, '', NULL);
INSERT INTO `sys_menu` VALUES (2, '用户管理', 2, NULL, NULL, 1, 1, 1, 'admin', '2019-12-19 10:07:05', '0000-00-00 00:00:00', NULL, 'system:user:view', NULL);
INSERT INTO `sys_menu` VALUES (3, '角色管理', 2, NULL, NULL, 2, 1, 1, 'admin', '2019-12-19 10:08:30', '0000-00-00 00:00:00', NULL, 'system:role:view', NULL);
INSERT INTO `sys_menu` VALUES (4, '菜单管理', 2, NULL, NULL, 3, 1, 1, 'admin', '2019-12-19 10:09:16', '0000-00-00 00:00:00', NULL, 'system:menu:view', NULL);
INSERT INTO `sys_menu` VALUES (5, '部门管理', 2, NULL, NULL, 4, 1, 1, 'admin', '2019-12-19 10:09:46', '0000-00-00 00:00:00', NULL, 'system:dept:view', NULL);
INSERT INTO `sys_menu` VALUES (6, '添加用户', 3, NULL, NULL, 1, 1, 2, 'admin', '2019-12-19 10:13:52', '0000-00-00 00:00:00', NULL, 'system:user:add', NULL);
INSERT INTO `sys_menu` VALUES (7, '删除用户', 3, NULL, NULL, 2, 1, 2, 'admin', '2019-12-19 10:14:48', '0000-00-00 00:00:00', NULL, 'system:user:delete', NULL);
INSERT INTO `sys_menu` VALUES (8, '更新用户', 3, NULL, NULL, 3, 1, 2, 'admin', '2019-12-19 10:15:26', '0000-00-00 00:00:00', NULL, 'system:user:update', NULL);
INSERT INTO `sys_menu` VALUES (9, '添加角色', 3, NULL, NULL, 1, 1, 3, 'admin', '2019-12-19 10:16:52', '0000-00-00 00:00:00', NULL, 'system:role:add', NULL);
INSERT INTO `sys_menu` VALUES (10, '删除角色', 3, NULL, NULL, 2, 1, 3, 'admin', '2019-12-19 10:17:58', '0000-00-00 00:00:00', NULL, 'system:role:delete', NULL);
INSERT INTO `sys_menu` VALUES (11, '更新角色', 3, NULL, NULL, 3, 1, 3, 'admin', '2019-12-19 10:18:23', '0000-00-00 00:00:00', NULL, 'system:role:update', NULL);
INSERT INTO `sys_menu` VALUES (12, '添加菜单', 3, NULL, NULL, 1, 1, 4, 'admin', '2019-12-19 10:19:05', '0000-00-00 00:00:00', NULL, 'system:menu:add', NULL);
INSERT INTO `sys_menu` VALUES (13, '删除菜单', 3, NULL, NULL, 2, 1, 4, 'admin', '2019-12-19 10:21:05', '0000-00-00 00:00:00', NULL, 'system:menu:delete', NULL);
INSERT INTO `sys_menu` VALUES (14, '更新菜单', 3, NULL, NULL, 3, 1, 4, 'admin', '2019-12-19 10:21:09', '0000-00-00 00:00:00', NULL, 'system:menu:update', NULL);
INSERT INTO `sys_menu` VALUES (15, '添加部门', 3, NULL, NULL, 1, 1, 5, 'admin', '2019-12-19 10:21:49', '0000-00-00 00:00:00', NULL, 'system:dept:add', NULL);
INSERT INTO `sys_menu` VALUES (16, '删除部门', 3, NULL, NULL, 2, 1, 5, 'admin', '2019-12-19 10:22:34', '0000-00-00 00:00:00', NULL, 'system:dept:delete', NULL);
INSERT INTO `sys_menu` VALUES (17, '更新部门', 3, NULL, NULL, 3, 1, 5, 'admin', '2019-12-19 11:06:42', '0000-00-00 00:00:00', NULL, 'system:dept:update', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统用户' ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', '03f6e79233f5adda25d7b6f4b9357d81', 'aa', 'asd', 0, '666161615@aq.com', '1656461516', '2019-12-27 11:40:59', '2019-12-13 11:54:51', 0, 'yeepaf9n', 15615, NULL, NULL, '0000-00-00 00:00:00', '', '2019-12-27 11:36:33');
INSERT INTO `sys_user` VALUES (2, 'bb', 'fcf8e2d373fdbfc7171b272b88bc41eb', 'bb', 'asd', 0, '666161615@aq.com', '1656461516', '2019-12-13 12:21:18', '0000-00-00 00:00:00', 0, 'kwrpbwl1', 15615, NULL, NULL, '0000-00-00 00:00:00', '', '0000-00-00 00:00:00');

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
