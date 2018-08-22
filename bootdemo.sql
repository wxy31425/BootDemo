/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50717
 Source Host           : localhost:3306
 Source Schema         : bootdemo

 Target Server Type    : MySQL
 Target Server Version : 50717
 File Encoding         : 65001

 Date: 16/08/2018 18:39:49
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_log`;
CREATE TABLE `tb_log`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remote_addr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `http_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `request_uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `class_method` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `params` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `response` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `session_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `use_time` bigint(20) NULL DEFAULT NULL,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `exception` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 334 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_log
-- ----------------------------
INSERT INTO `tb_log` VALUES (301, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'hghghhg', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'EF40A055D16A494647EE6949AA475697', 'Windows-Chrome-67.0.3396.62', 0, '2018-08-16 15:15:13', NULL);
INSERT INTO `tb_log` VALUES (302, 'Ajax请求', '用户登录', '127.0.0.1', 'POST', 'http://localhost/admin/login', 'admin', 'com.boot.demo.controller.LoginController.loginMain', '[\"org.apache.shiro.web.servlet.ShiroHttpServletRequest@dda53f2\"]', '{\"data\":{\"url\":\"index\"},\"success\":true,\"message\":\"登录成功\"}', 'F9BAA665927B8B679787BB760C4C57B1', 'Windows-Chrome-67.0.3396.62', 109, '2018-08-16 15:18:52', NULL);
INSERT INTO `tb_log` VALUES (303, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'F9BAA665927B8B679787BB760C4C57B1', 'Windows-Chrome-67.0.3396.62', 4, '2018-08-16 15:18:55', NULL);
INSERT INTO `tb_log` VALUES (304, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'F9BAA665927B8B679787BB760C4C57B1', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:19:30', NULL);
INSERT INTO `tb_log` VALUES (305, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'F9BAA665927B8B679787BB760C4C57B1', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:19:58', NULL);
INSERT INTO `tb_log` VALUES (306, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'F9BAA665927B8B679787BB760C4C57B1', 'Windows-Chrome-67.0.3396.62', 0, '2018-08-16 15:20:14', NULL);
INSERT INTO `tb_log` VALUES (307, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'F9BAA665927B8B679787BB760C4C57B1', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:21:09', NULL);
INSERT INTO `tb_log` VALUES (308, 'Ajax请求', '用户登录', '127.0.0.1', 'POST', 'http://localhost/admin/login', 'admin', 'com.boot.demo.controller.LoginController.loginMain', '[\"org.apache.shiro.web.servlet.ShiroHttpServletRequest@3d79b2cf\"]', '{\"data\":{\"url\":\"index\"},\"success\":true,\"message\":\"登录成功\"}', 'BF55B8DF7DC6C94EB40BC754E7E2E5B4', 'Windows-Chrome-67.0.3396.62', 113, '2018-08-16 15:28:52', NULL);
INSERT INTO `tb_log` VALUES (309, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'BF55B8DF7DC6C94EB40BC754E7E2E5B4', 'Windows-Chrome-67.0.3396.62', 4, '2018-08-16 15:28:55', NULL);
INSERT INTO `tb_log` VALUES (310, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'BF55B8DF7DC6C94EB40BC754E7E2E5B4', 'Windows-Chrome-67.0.3396.62', 0, '2018-08-16 15:29:29', NULL);
INSERT INTO `tb_log` VALUES (311, 'Ajax请求', '用户登录', '127.0.0.1', 'POST', 'http://localhost/admin/login', 'admin', 'com.boot.demo.controller.LoginController.loginMain', '[\"org.apache.shiro.web.servlet.ShiroHttpServletRequest@32a78d94\"]', '{\"data\":{\"url\":\"index\"},\"success\":true,\"message\":\"登录成功\"}', 'A349DB42445A46252D27E61B22454450', 'Windows-Chrome-67.0.3396.62', 110, '2018-08-16 15:34:14', NULL);
INSERT INTO `tb_log` VALUES (312, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'A349DB42445A46252D27E61B22454450', 'Windows-Chrome-67.0.3396.62', 4, '2018-08-16 15:34:17', NULL);
INSERT INTO `tb_log` VALUES (313, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'A349DB42445A46252D27E61B22454450', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:35:31', NULL);
INSERT INTO `tb_log` VALUES (314, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'A349DB42445A46252D27E61B22454450', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:35:46', NULL);
INSERT INTO `tb_log` VALUES (315, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'A349DB42445A46252D27E61B22454450', 'Windows-Chrome-67.0.3396.62', 0, '2018-08-16 15:38:05', NULL);
INSERT INTO `tb_log` VALUES (316, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'A349DB42445A46252D27E61B22454450', 'Windows-Chrome-67.0.3396.62', 11, '2018-08-16 15:41:21', NULL);
INSERT INTO `tb_log` VALUES (317, 'Ajax请求', '用户登录', '127.0.0.1', 'POST', 'http://localhost/admin/login', 'admin', 'com.boot.demo.controller.LoginController.loginMain', '[\"org.apache.shiro.web.servlet.ShiroHttpServletRequest@120b8b81\"]', '{\"data\":{\"url\":\"index\"},\"success\":true,\"message\":\"登录成功\"}', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 108, '2018-08-16 15:43:44', NULL);
INSERT INTO `tb_log` VALUES (318, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 4, '2018-08-16 15:43:47', NULL);
INSERT INTO `tb_log` VALUES (319, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 17, '2018-08-16 15:44:11', NULL);
INSERT INTO `tb_log` VALUES (320, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 9, '2018-08-16 15:49:52', NULL);
INSERT INTO `tb_log` VALUES (321, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:50:04', NULL);
INSERT INTO `tb_log` VALUES (322, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:53:45', NULL);
INSERT INTO `tb_log` VALUES (323, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 0, '2018-08-16 15:55:04', NULL);
INSERT INTO `tb_log` VALUES (324, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 0, '2018-08-16 15:55:24', NULL);
INSERT INTO `tb_log` VALUES (325, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:56:41', NULL);
INSERT INTO `tb_log` VALUES (326, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 1, '2018-08-16 15:57:00', NULL);
INSERT INTO `tb_log` VALUES (327, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Windows-Chrome-67.0.3396.62', 0, '2018-08-16 15:58:16', NULL);
INSERT INTO `tb_log` VALUES (328, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 1, '2018-08-16 16:00:39', NULL);
INSERT INTO `tb_log` VALUES (329, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 0, '2018-08-16 16:00:53', NULL);
INSERT INTO `tb_log` VALUES (330, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 0, '2018-08-16 16:03:22', NULL);
INSERT INTO `tb_log` VALUES (331, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 1, '2018-08-16 16:03:33', NULL);
INSERT INTO `tb_log` VALUES (332, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 0, '2018-08-16 16:06:19', NULL);
INSERT INTO `tb_log` VALUES (333, '普通请求', '跳转系统日志页面', '127.0.0.1', 'GET', 'http://localhost/admin/log/list', 'admin', 'com.boot.demo.controller.system.LogController.list', '[]', '\"system/log/list\"', 'DE7A09D464695BCE89FA6CCBB2BF524D', 'Android-Chrome-67.0.3396.62', 0, '2018-08-16 16:06:28', NULL);

-- ----------------------------
-- Table structure for tb_resource
-- ----------------------------
DROP TABLE IF EXISTS `tb_resource`;
CREATE TABLE `tb_resource`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `is_hide` int(11) NULL DEFAULT NULL,
  `level` int(11) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sort` int(11) NULL DEFAULT NULL,
  `source_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` int(11) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `pid` bigint(20) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_resource
-- ----------------------------
INSERT INTO `tb_resource` VALUES (1, '2018-08-06 10:33:51', 'xtgl', 'fa fa fa-cog', 0, 1, '系统管理', 1, '#', 0, '2018-08-06 10:34:29', '#', 0);
INSERT INTO `tb_resource` VALUES (2, '2018-08-06 10:34:39', 'glugl', 'fa fa-user', 0, 2, '管理员管理', 1, 'system:user:list', 1, '2018-08-06 10:35:09', '/admin/user/list', 1);
INSERT INTO `tb_resource` VALUES (3, '2018-08-07 17:40:48', 'glutj', 'fa fa-plus', 0, 3, '管理员添加', 1, 'system:user:add', 2, '2018-08-07 17:44:55', '/admin/user/add', 2);
INSERT INTO `tb_resource` VALUES (4, '2018-08-07 17:45:24', 'glubj', 'fa fa-edit', 0, 3, '管理员编辑', 2, 'system:user:edit', 2, '2018-08-14 10:04:11', '/admin/user/edit', 2);
INSERT INTO `tb_resource` VALUES (5, '2018-08-07 17:47:31', 'glysc', 'fa fa-remove', 0, 3, '管理员删除', 3, 'system:user:delete', 2, '2018-08-07 17:48:45', '/admin/user/delete', 2);
INSERT INTO `tb_resource` VALUES (6, '2018-08-09 14:42:48', 'glyplsc', 'fa fa-remove', 0, 3, '管理员批量删除', 4, 'system:user:deleteBatch', 2, '2018-08-14 15:54:18', '/admin/user/deleteBatch', 2);
INSERT INTO `tb_resource` VALUES (7, '2018-08-09 14:51:06', 'jsgl', 'fa fa-paw', 0, 2, '角色管理', 2, 'system:role:list', 1, '2018-08-09 14:53:15', '/admin/role/list', 1);
INSERT INTO `tb_resource` VALUES (8, '2018-08-09 16:05:30', 'jstj', 'fa fa-plus', 0, 3, '角色添加', 1, 'system:role:add', 2, '2018-08-09 16:06:20', '/admin/role/add', 7);
INSERT INTO `tb_resource` VALUES (9, '2018-08-09 16:07:19', 'jsbj', 'fa fa-edit', 0, 3, '角色编辑', 2, 'system:role:edit', 2, '2018-08-14 15:57:26', '/admin/role/edit', 7);
INSERT INTO `tb_resource` VALUES (10, '2018-08-09 16:08:37', 'jssc', 'fa fa-remove', 0, 3, '角色删除', 3, 'system:role:delete', 2, '2018-08-09 16:09:57', '/admin/role/delete', 7);
INSERT INTO `tb_resource` VALUES (11, '2018-08-10 09:32:01', 'qufp', 'fa fa-arrows', 0, 3, '权限分配', 4, 'system:role:grant', 2, '2018-08-10 09:34:26', '/admin/role/grant', 7);
INSERT INTO `tb_resource` VALUES (12, '2018-08-13 13:52:06', 'jsplsc', 'fa fa-remove', 0, 3, '角色批量删除', 5, 'system:role:deleteBatch', 2, '2018-08-13 13:53:06', '/admin/role/deleteBatch', 7);
INSERT INTO `tb_resource` VALUES (13, '2018-08-13 14:06:15', 'cdgl', 'fa fa-th-list', 0, 2, '菜单管理', 3, 'system:resource:list', 1, '2018-08-14 15:16:29', '/admin/resource/list', 1);
INSERT INTO `tb_resource` VALUES (14, '2018-08-13 15:11:42', 'tjxj', 'fa fa-plus', 0, 3, '添加下级', 1, 'system:resource:add', 2, '2018-08-13 15:13:05', '/admin/resource/add', 13);
INSERT INTO `tb_resource` VALUES (15, '2018-08-13 15:13:28', 'cdbj', 'fa fa-edit', 0, 3, '菜单编辑', 2, 'system:resource:edit', 2, '2018-08-14 16:19:57', '/admin/resource/edit', 13);
INSERT INTO `tb_resource` VALUES (16, '2018-08-13 15:15:02', 'cdsc', 'fa fa-remove', 0, 3, '菜单删除', 3, 'system:resource:delete', 2, '2018-08-13 15:16:09', '/admin/resource/delete', 13);
INSERT INTO `tb_resource` VALUES (17, '2018-08-14 15:49:12', 'tjgml', 'fa fa-plus', 0, 3, '添加根目录', 4, 'system:resource:add', 2, '2018-08-14 15:51:14', '/admin/resource/add', 13);
INSERT INTO `tb_resource` VALUES (18, '2018-08-15 15:03:04', 'rzgl', 'fa fa-warning', 0, 2, '日志管理', 4, 'system:log:list', 1, '2018-08-15 15:03:04', '/admin/log/list', 1);
INSERT INTO `tb_resource` VALUES (19, '2018-08-15 15:46:14', 'rzsc', 'fa fa-remove', 0, 3, '日志删除', 1, 'system:log:delete', 2, '2018-08-15 15:48:30', '/admin/log/delete', 18);
INSERT INTO `tb_resource` VALUES (20, '2018-08-15 15:56:59', 'rzplsc', 'fa fa-remove', 0, 3, '日志批量删除', 2, 'system:log:deleteBatch', 2, '2018-08-15 15:57:54', '/admin/log/deleteBatch', 18);

-- ----------------------------
-- Table structure for tb_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_role`;
CREATE TABLE `tb_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `role_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` int(11) NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role
-- ----------------------------
INSERT INTO `tb_role` VALUES (1, '2017-01-09 17:25:30', '超级管理员', 'administrator', 'administrator', 0, '2017-01-09 17:26:25');
INSERT INTO `tb_role` VALUES (2, '2018-08-08 11:44:59', 'dffd', 'df', 'df', 0, '2018-08-08 11:45:15');
INSERT INTO `tb_role` VALUES (4, '2018-08-09 16:52:45', 'dfgdfgd', '导购员', 'eeee', 0, '2018-08-15 14:00:44');

-- ----------------------------
-- Table structure for tb_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `tb_role_resource`;
CREATE TABLE `tb_role_resource`  (
  `role_id` int(11) NOT NULL,
  `resource_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`, `resource_id`) USING BTREE,
  INDEX `FK868kc8iic48ilv5npa80ut6qo`(`resource_id`) USING BTREE,
  CONSTRAINT `FK7ffc7h6obqxflhj1aq1mk20jk` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK868kc8iic48ilv5npa80ut6qo` FOREIGN KEY (`resource_id`) REFERENCES `tb_resource` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_role_resource
-- ----------------------------
INSERT INTO `tb_role_resource` VALUES (1, 1);
INSERT INTO `tb_role_resource` VALUES (1, 2);
INSERT INTO `tb_role_resource` VALUES (1, 3);
INSERT INTO `tb_role_resource` VALUES (2, 3);
INSERT INTO `tb_role_resource` VALUES (1, 4);
INSERT INTO `tb_role_resource` VALUES (2, 4);
INSERT INTO `tb_role_resource` VALUES (1, 5);
INSERT INTO `tb_role_resource` VALUES (2, 5);
INSERT INTO `tb_role_resource` VALUES (1, 6);
INSERT INTO `tb_role_resource` VALUES (1, 7);
INSERT INTO `tb_role_resource` VALUES (1, 8);
INSERT INTO `tb_role_resource` VALUES (1, 9);
INSERT INTO `tb_role_resource` VALUES (1, 10);
INSERT INTO `tb_role_resource` VALUES (1, 11);
INSERT INTO `tb_role_resource` VALUES (1, 12);
INSERT INTO `tb_role_resource` VALUES (1, 13);
INSERT INTO `tb_role_resource` VALUES (1, 14);
INSERT INTO `tb_role_resource` VALUES (1, 15);
INSERT INTO `tb_role_resource` VALUES (1, 16);
INSERT INTO `tb_role_resource` VALUES (1, 17);
INSERT INTO `tb_role_resource` VALUES (1, 18);
INSERT INTO `tb_role_resource` VALUES (1, 19);
INSERT INTO `tb_role_resource` VALUES (1, 20);

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `create_time` datetime(0) NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `locked` int(11) NULL DEFAULT NULL,
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `telephone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `update_time` datetime(0) NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES (1, '2017-01-09 17:26:41', '1394417729@qq.com', 0, 'admin', 'UUKHSDDI5KPA43A8VL06V0TU2', '15923930000', '2018-08-09 14:41:52', 'admin', NULL);
INSERT INTO `tb_user` VALUES (7, '2018-08-08 17:58:07', 'camel96991@163.com', 0, 'dsf3好久', '3931MUEQD1939MQMLM4AISPVNE', '15526523698', '2018-08-15 09:48:21', 'hghghhg', NULL);
INSERT INTO `tb_user` VALUES (8, '2018-08-15 09:49:10', 'eww@163.com', 0, 'xfsfds', 'CGOAGODUE9UP1TB5PCBI17IT2', '13333321212', '2018-08-15 09:49:10', 'vbnvbn', NULL);

-- ----------------------------
-- Table structure for tb_user_role
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_role`;
CREATE TABLE `tb_user_role`  (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE,
  INDEX `FKea2ootw6b6bb0xt3ptl28bymv`(`role_id`) USING BTREE,
  CONSTRAINT `FK7vn3h53d0tqdimm8cp45gc0kl` FOREIGN KEY (`user_id`) REFERENCES `tb_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FKea2ootw6b6bb0xt3ptl28bymv` FOREIGN KEY (`role_id`) REFERENCES `tb_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_user_role
-- ----------------------------
INSERT INTO `tb_user_role` VALUES (1, 1);
INSERT INTO `tb_user_role` VALUES (7, 1);
INSERT INTO `tb_user_role` VALUES (7, 2);
INSERT INTO `tb_user_role` VALUES (8, 2);
INSERT INTO `tb_user_role` VALUES (8, 4);

SET FOREIGN_KEY_CHECKS = 1;
