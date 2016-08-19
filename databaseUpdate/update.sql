
-- vote
CREATE TABLE `vote` (
  `vote_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '投票ID',
  `vote_name` varchar(100) DEFAULT NULL COMMENT '投票名',
  `image` varchar(50) DEFAULT NULL COMMENT '图片',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时間',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时間',
  `vote_status` int(11) DEFAULT NULL COMMENT '0:未开始,1:进行中,2:已结束',
  `vote_index` int(11) DEFAULT NULL,
  PRIMARY KEY (`vote_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `vote_item` (
  `item_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vote_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `image` varchar(100) DEFAULT NULL,
  `describe` varchar(200) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  `votes` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

CREATE TABLE `vote_limit` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `vote_id` int(11) DEFAULT NULL,
  `limit_type` varchar(5) DEFAULT NULL COMMENT 'H,D,W,M',
  `limit_vote` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `vote_range` (
  `vote_id` int(11) DEFAULT NULL COMMENT 'vote_id',
  `range_type` int(11) DEFAULT NULL COMMENT '0:所有人, 1:赛事参赛者, 2:俱乐部成员, 3:个人用户',
  `circle_id` int(11) DEFAULT NULL COMMENT '0,competition_id,club_id,user_id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `vote_result` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `vote_id` int(11) DEFAULT NULL,
  `create_time` int(11) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- event
DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
  `event_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_name` varchar(100) DEFAULT NULL,
  `club_id` int(11) DEFAULT NULL,
  `start_time` timestamp NULL DEFAULT NULL COMMENT '活动开始时間',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '活动结束时間',
  `register_start_time` timestamp NULL DEFAULT NULL COMMENT '开始报名时間',
  `register_end_time` timestamp NULL DEFAULT NULL COMMENT '结束报名时間',
  `organizer_id` int(11) DEFAULT NULL,
  `event_address` varchar(200) DEFAULT NULL COMMENT '活动地址',
  `min_people` int(11) DEFAULT '0' COMMENT '0:unlimit',
  `max_people` int(11) DEFAULT '0' COMMENT '0:unlimit',
  `fee` decimal(10,3) DEFAULT '0.000' COMMENT '0:unlimit',
  `image` varchar(100) DEFAULT NULL,
  `event_status` int(11) DEFAULT NULL COMMENT '0:审核中, 1:审核通过,2:审核失败, 3:终止',
  `view_guests` int(11) DEFAULT NULL COMMENT '发起活动 - 谁可以看「参加的人」;  0:public,1:part, 2:private',
  `form_item` varchar(200) DEFAULT NULL COMMENT 'item 以 逗号分隔',
  `event_detail` text,
  `event_notice` text,
  PRIMARY KEY (`event_id`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8;

CREATE TABLE `event_form_item` (
  `item_code` varchar(100) DEFAULT NULL COMMENT '报名信息编号',
  `item_name` varchar(100) DEFAULT NULL COMMENT '报名信息',
  `is_default` int(11) DEFAULT '0' COMMENT '1:default, 0:not default ',
  `language` varchar(5) DEFAULT 'zh' COMMENT '语言',
  `index` int(11) DEFAULT NULL COMMENT '排序'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `event_reason` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `reason_type` varchar(100) DEFAULT NULL COMMENT 'REVIEW_FAIL , TERMINAL',
  `reason` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `event_registration` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL,
  `my_status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




INSERT INTO `event_form_item` (`item_code`, `item_name`, `is_default`, `language`, `index`)
VALUES
	('name', '姓名', 1, 'zh', 1),
	('nickname', '昵称', 1, 'zh', 2),
	('mobile', '手机', 1, 'zh', 3),
	('email', '邮箱', 0, 'zh', 4),
	('qq', 'QQ', 0, 'zh', 5),
	('wechat', '微信', 0, 'zh', 6),
	('company', '公司', 0, 'zh', 7),
	('address', '地址', 0, 'zh', 8),
	('position', '职位', 0, 'zh', 9);




INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`)
VALUES
	(X'72656D696E6465725F636C7562', X'E5B08AE695ACE79A84E794A8E688B72CE682A8E58F82E58AA0E79A84E4BFB1E4B990E983A8E5B086E59CA83234E5B08FE697B6E5908EE8A7A3E695A3EFBC8CE58E9FE59BA0EFBC9AE4BFB1E4B990E983A8E7ADB9E5A487E5A4B1E8B4A5E38082', X'646174615F616C696173', X'7A68'),
	(X'6566666563746976655F7765656B73', X'36', X'646174615F616C696173', X'7A68'),
	(X'6566666563746976655F64617973', X'33', X'646174615F616C696173', X'7A68'),
	(X'31303834', X'E68EA8E98081E5A4B1E8B4A5EFBC8CE58E9FE59BA0EFBC9AE6AF8FE4B8AAE794A8E688B7E4B880E5A4A9E58FAAE883BDE68EA8E98081E4B889E69DA1E8B584E8AEAFEFBC8CE4B880E591A8E58FAAE883BDE68EA8E98081E585ADE69DA1E8B584E8AEAF', X'72657475726E5F696E666F', X'7A68'),
	(X'31303835', X'E8B584E8AEAFE6A087E9A298E4B88DE883BDE4B8BAE7A9BA', X'72657475726E5F696E666F', X'7A68'),
	(X'6576656E74', X'6576656E74', X'726F6F74', X'7A68'),
	(X'6576656E745F627574746F6E', X'627574746F6E5F636F6E74656E74', X'6576656E74', X'7A68'),
	(X'66696E697368', X'E5B7B2E7BB93E69D9F', X'6576656E745F627574746F6E', X'7A68'),
	(X'636C75625F69645F6E756C6C', X'E4BFB1E4B990E983A8E7BC96E58FB7E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'73746172745F74696D655F6E756C6C', X'E6B4BBE58AA8E5BC80E5A78BE697B6E997B4E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'656E645F74696D655F6E756C6C', X'E6B4BBE58AA8E7BB93E69D9FE697B6E997B4E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'72656769737465725F73746172745F6E756C6C', X'E6B4BBE58AA8E68AA5E5908DE5BC80E5A78BE697B6E997B4E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'72656769737465725F656E645F6E756C6C', X'E6B4BBE58AA8E68AA5E5908DE7BB93E69D9FE697B6E997B4E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'74696D655F6572726F72', X'E8BE93E585A5E697B6E99693E69C89E8AFAF', X'6576656E74', X'7A68'),
	(X'6576656E745F616464726573735F6E756C6C', X'E6B4BBE58AA8E59CB0E59D80E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'666F726D5F6974656D5F6E756C6C', X'E68AA5E5908DE4BFA1E681AFE4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'6F7267616E697A65725F6A6F696E5F6E756C6C', X'E7BB84E7BB87E88085E58F82E58AA0E6B4BBE58AA8E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'6576656E745F6E616D655F6E756C6C', X'E6B4BBE58AA8E5908DE4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'6D695F707573685F686561646572', X'687474703A2F2F7A7377682E687A627576692E636F6D', X'646174615F616C696173', X'7A68'),
	(X'766965775F6775657374735F6E756C6C', X'E58F82E58AA0E79A84E4BABAE58FAFE8A68BE4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'6F7267616E697A65725F69645F6E756C6C', X'E7BB84E7BB87E88085E4B8BAE7A9BA', X'6576656E74', X'7A68'),
	(X'61626F7274', X'E4B8ADE6ADA2', X'6576656E745F627574746F6E', X'7A68'),
	(X'72656769737465726564', X'E5B7B2E68AA5E5908D', X'6576656E745F627574746F6E', X'7A68'),
	(X'73746F705F7265676973746572', X'E68AA5E5908DE688AAE6ADA2', X'6576656E745F627574746F6E', X'7A68'),
	(X'66756C6C', X'E68AA5E5908DE4BABAE695B0E5B7B2E6BBBF', X'6576656E745F627574746F6E', X'7A68'),
	(X'695F77616E6E615F6A6F696E', X'E68891E8A681E58F82E58AA0', X'6576656E745F627574746F6E', X'7A68'),
	(X'70726570617265', X'E9A284E783ADE4B8AD', X'6576656E745F627574746F6E', X'7A68'),
	(X'756E6465725F726576696577', X'E5AEA1E6A0B8E4B8AD', X'6576656E745F627574746F6E', X'7A68'),
	(X'6661696C5F726576696577', X'E5AEA1E6A0B8E69CAAE9809AE8BF87', X'6576656E745F627574746F6E', X'7A68'),
	(X'6E6F5F617574686F726974795F726576696577', X'E682A8E697A0E69D83E99990E5AEA1E6A0B8E69CACE6B4BBE58AA8', X'6576656E74', X'7A68'),
	(X'7265766965775F6661696C', X'E5AEA1E6A0B8E5A4B1E8B4A5', X'6576656E74', X'7A68'),
	(X'6E6F745F6F776E5F636C7562', X'E682A8E4B88DE5B19EE4BA8EE8AFA5E4BFB1E4B990E983A8', X'6576656E74', X'7A68'),
	(X'72656769737465725F6661696C', X'E68AA5E5908DE5A4B1E8B4A5', X'6576656E74', X'7A68'),
	(X'766F7465', X'E68A95E7A5A8', X'726F6F74', X'7A68'),
	(X'766F74655F6661696C', X'E68A95E7A5A8E5A4B1E8B4A5', X'766F7465', X'7A68'),
	(X'6E6F5F617574686F72697479', X'E682A8E697A0E69D83E99990E68A95E7A5A8', X'766F7465', X'7A68'),
	(X'6C696D6974', X'74727565', X'766F7465', X'7A68'),
	(X'7765656B5F6C696D6974', X'35', X'766F7465', X'7A68'),
	(X'6461795F6C696D6974', X'32', X'766F7465', X'7A68'),
	(X'746F6461795F75705F746F5F6C696D6974', X'E4BB8AE697A5E68A95E7A5A8E5B7B2E8BEBEE4B88AE99990', X'766F7465', X'7A68'),
	(X'7765656B5F75705F746F5F6C696D6974', X'E69CACE591A8E68A95E7A5A8E5B7B2E8BEBEE4B88AE99990', X'766F7465', X'7A68'),
	(X'756E72656769737465725F6661696C', X'E6B4BBE58AA8E58F96E6B688E68AA5E5908DE5A4B1E8B4A5', X'6576656E74', X'7A68'),
	(X'7265766965775F6576656E745F74727565', X'E5B08AE695ACE79A84E794A8E688B7EFBC8CE682A8E794B3E8AFB7E79A84E6B4BBE58AA822', X'6576656E74', X'7A68'),
	(X'6576656E745F747275655F6D657373616765', X'222CE5B7B2E5AEA1E6A0B8E9809AE8BF87E4BA86E38082', X'6576656E74', X'7A68'),
	(X'7265766965775F6576656E745F6661696C', X'E5B08AE695ACE79A84E794A8E688B7EFBC8CE5BE88E68AB1E6AD89EFBC8CE682A8E794B3E8AFB7E79A84E6B4BBE58AA822', X'6576656E74', X'7A68'),
	(X'6576656E745F6661696C5F6D657373616765', X'222CE69CAAE9809AE8BF87E5AEA1E6A0B8EFBC8CE58E9FE59BA0EFBC9A', X'6576656E74', X'7A68'),
	(X'70696348656164', X'2F7069632E68746D6C733F703D', X'646174615F616C696173', X'7A68'),
	(X'6576656E745F656E756D', X'6576656E745F656E756D', X'6576656E74', X'7A68'),
	(X'554E4445525F524556494557', X'E5AEA1E6A0B8E69CAAE9809AE8BF87', X'6576656E745F656E756D', X'7A68'),
	(X'4E4F524D414C', X'E6ADA3E5B8B8', X'6576656E745F656E756D', X'7A68'),
	(X'4F564552', X'E4B8ADE6ADA2', X'6576656E745F656E756D', X'7A68'),
	(X'554E4445525F524556494557', X'E5AEA1E6A0B8E4B8AD', X'6576656E745F656E756D', X'7A68'),
	(X'434C55425F4D414E41474552', X'E4BFB1E4B990E983A8E7AEA1E79086E59198', X'6576656E745F656E756D', X'7A68'),
	(X'4556454E545F4F5247414E495A4552', X'E6B4BBE58AA8E7BB84E7BB87E88085', X'6576656E745F656E756D', X'7A68'),
	(X'4556454E545F4D454D424552', X'E6B4BBE58AA8E58F82E58AA0E88085', X'6576656E745F656E756D', X'7A68'),
	(X'4E4F545F4A4F494E5F434C5542', X'E69CAAE58AA0E585A5E4BFB1E4B990E983A8', X'6576656E745F656E756D', X'7A68'),
	(X'434C55425F4D454D424552', X'E4BFB1E4B990E983A8E68890E59198', X'6576656E745F656E756D', X'7A68');


insert into user_profile (user_id,item_code,item_value)
select
  user_id
  ,'name' as item_code
  ,user_real_name  as item_value
 from user_info
where   user_real_name is not null
union all
select
  user_id
  ,'mobile'
  ,phone
 from user_info
 where   phone is not null
union all
select
  user_id
  ,'nickname'
  ,nickname
 from user_info
where   nickname is not null
union all
select
  user_id
  ,'email'
  ,mail_address
 from user_info
where   mail_address is not null  ;




DROP TABLE IF EXISTS `event_user_profile`;
CREATE TABLE `event_user_profile` (
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `item_value` varchar(300) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_delete` int(11) DEFAULT '0',
  PRIMARY KEY (`event_id`,`user_id`,`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `user_profile`;
CREATE TABLE `user_profile` (
  `user_id` int(11) NOT NULL,
  `item_code` varchar(100) NOT NULL,
  `item_value` varchar(300) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_delete` int(11) DEFAULT '0',
  PRIMARY KEY (`user_id`,`item_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `event_image`;
CREATE TABLE `event_image` (
  `id` int(11) NOT NULL,
  `image` varchar(100) DEFAULT NULL,
  `index` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_button', 'button_content', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('finish', '已结束', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('club_id_null', '俱乐部编号为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('start_time_null', '活动开始时间为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('end_time_null', '活动结束时间为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('register_start_null', '活动报名开始时间为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('register_end_null', '活动报名结束时间为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('time_error', '输入时間有误', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_address_null', '活动地址为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('form_item_null', '报名信息为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('organizer_join_null', '组织者参加活动为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_name_null', '活动名为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('mi_push_header', 'http://zswh.hzbuvi.com', 'data_alias', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('view_guests_null', '参加的人可見为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('organizer_id_null', '组织者为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('abort', '中止', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('registered', '已报名', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('stop_register', '报名截止', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('full', '报名人数已滿', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('i_wanna_join', '我要参加', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('prepare', '预热中', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('under_review', '审核中', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('fail_review', '审核未通过', 'event_button', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('no_authority_review', '您无权限审核本活动', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('review_fail', '审核失败', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('not_own_club', '您不属于该俱乐部', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('register_fail', '报名失败', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('vote', '投票', 'root', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('vote_fail', '投票失败', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('no_authority', '您无权限投票', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('limit', 'true', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('week_limit', '5', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('day_limit', '2', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('today_up_to_limit', '今日投票已达上限', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('week_up_to_limit', '本周投票已达上限', 'vote', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('unregister_fail', '活动取消报名失败', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('review_event_true', '尊敬的用户，您申请的活动\"', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_true_message', '\",已审核通过了。', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('review_event_fail', '尊敬的用户，很抱歉，您申请的活动\"', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_fail_message', '\",未通过审核，原因：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('picHead', '/pic.htmls?p=', 'data_alias', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_enum', 'event_enum', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('UNDER_REVIEW', '审核未通过', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('NORMAL', '正常', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('OVER', '中止', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('UNDER_REVIEW', '审核中', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('CLUB_MANAGER', '俱乐部管理员', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('EVENT_ORGANIZER', '活动组织者', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('EVENT_MEMBER', '活动参加者', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('NOT_JOIN_CLUB', '未加入俱乐部', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('CLUB_MEMBER', '俱乐部成员', 'event_enum', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('abort_event', '删除活动', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('abort_fail', '活动中止失败', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('1086', '活动中不能退出', 'return_info', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('unregister_success', '取消报名成功', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('abort_success', '活动中止成功', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_review_success', '审核操作成功', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('image_null', '封面图片不能为空', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('join_event', '尊敬的用户，', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('join_event_message', '已加入该活动：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('unregister_event', '尊敬的用户，', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('unregister_event_m', '已退出该活动：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('abort_event', '尊敬的用户，很抱歉，您参加的活动：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('abort_event_message', ',已中止。原因：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('create_event', '尊敬的用户，', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('create_event_message', '发起了新活动，请及时审核：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_ongoing', '进行中', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_end', '已结束', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('event_start', '开始', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('delete_member', '对不起，您不再是', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('delete_member_m', '的一员了。原因：', 'event', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('1087', '您已不属于该俱乐部了', 'return_info', 'zh');
INSERT INTO `dictionary` (`code`, `value`, `p_code`, `language`) VALUES ('1088', '中止理由不能为空', 'return_info', 'zh');



DROP TABLE IF EXISTS `push_record`;
CREATE TABLE `push_record` (
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '当前日期',
  `type` varchar(2) DEFAULT NULL COMMENT '消息类型'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
