/*
 Navicat Premium Data Transfer

 Source Server         : MySql
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : localhost:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 17/04/2018 15:14:43
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_group_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_permission
-- ----------------------------
DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_permission
-- ----------------------------
BEGIN;
INSERT INTO `auth_permission` VALUES (1, 'Can add log entry', 1, 'add_logentry');
INSERT INTO `auth_permission` VALUES (2, 'Can change log entry', 1, 'change_logentry');
INSERT INTO `auth_permission` VALUES (3, 'Can delete log entry', 1, 'delete_logentry');
INSERT INTO `auth_permission` VALUES (4, 'Can add permission', 2, 'add_permission');
INSERT INTO `auth_permission` VALUES (5, 'Can change permission', 2, 'change_permission');
INSERT INTO `auth_permission` VALUES (6, 'Can delete permission', 2, 'delete_permission');
INSERT INTO `auth_permission` VALUES (7, 'Can add group', 3, 'add_group');
INSERT INTO `auth_permission` VALUES (8, 'Can change group', 3, 'change_group');
INSERT INTO `auth_permission` VALUES (9, 'Can delete group', 3, 'delete_group');
INSERT INTO `auth_permission` VALUES (10, 'Can add user', 4, 'add_user');
INSERT INTO `auth_permission` VALUES (11, 'Can change user', 4, 'change_user');
INSERT INTO `auth_permission` VALUES (12, 'Can delete user', 4, 'delete_user');
INSERT INTO `auth_permission` VALUES (13, 'Can add content type', 5, 'add_contenttype');
INSERT INTO `auth_permission` VALUES (14, 'Can change content type', 5, 'change_contenttype');
INSERT INTO `auth_permission` VALUES (15, 'Can delete content type', 5, 'delete_contenttype');
INSERT INTO `auth_permission` VALUES (16, 'Can add session', 6, 'add_session');
INSERT INTO `auth_permission` VALUES (17, 'Can change session', 6, 'change_session');
INSERT INTO `auth_permission` VALUES (18, 'Can delete session', 6, 'delete_session');
INSERT INTO `auth_permission` VALUES (19, 'Can add author', 7, 'add_author');
INSERT INTO `auth_permission` VALUES (20, 'Can change author', 7, 'change_author');
INSERT INTO `auth_permission` VALUES (21, 'Can delete author', 7, 'delete_author');
INSERT INTO `auth_permission` VALUES (22, 'Can add blog', 8, 'add_blog');
INSERT INTO `auth_permission` VALUES (23, 'Can change blog', 8, 'change_blog');
INSERT INTO `auth_permission` VALUES (24, 'Can delete blog', 8, 'delete_blog');
INSERT INTO `auth_permission` VALUES (25, 'Can add user', 9, 'add_user');
INSERT INTO `auth_permission` VALUES (26, 'Can change user', 9, 'change_user');
INSERT INTO `auth_permission` VALUES (27, 'Can delete user', 9, 'delete_user');
COMMIT;

-- ----------------------------
-- Table structure for auth_user
-- ----------------------------
DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of auth_user
-- ----------------------------
BEGIN;
INSERT INTO `auth_user` VALUES (3, 'pbkdf2_sha256$100000$00W06xxo1XY7$SfPtv4kaCB7HgT928X/qrjqArh74LXooYlC5zC1r2zM=', '2018-04-17 07:10:00.051727', 0, 'admin', '', '', '', 0, 1, '2018-04-17 06:51:19.382357');
COMMIT;

-- ----------------------------
-- Table structure for auth_user_groups
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for auth_user_user_permissions
-- ----------------------------
DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for blog_author
-- ----------------------------
DROP TABLE IF EXISTS `blog_author`;
CREATE TABLE `blog_author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_author
-- ----------------------------
BEGIN;
INSERT INTO `blog_author` VALUES (1, '张三', 18);
INSERT INTO `blog_author` VALUES (2, '李四', 20);
COMMIT;

-- ----------------------------
-- Table structure for blog_blog
-- ----------------------------
DROP TABLE IF EXISTS `blog_blog`;
CREATE TABLE `blog_blog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` longtext NOT NULL,
  `counter` int(11) NOT NULL,
  `pubDate` date NOT NULL,
  `author_id` int(11) NOT NULL,
  `subTitle` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blog_blog_author_id_8791af69_fk_blog_author_id` (`author_id`),
  CONSTRAINT `blog_blog_author_id_8791af69_fk_blog_author_id` FOREIGN KEY (`author_id`) REFERENCES `blog_author` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_blog
-- ----------------------------
BEGIN;
INSERT INTO `blog_blog` VALUES (1, '测试数据', '我决定了放假啊发送快的放假啊开始卡设a打飞机看', 32, '2018-04-09', 1, 'abc');
INSERT INTO `blog_blog` VALUES (2, '标题图', '哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈', 12, '2018-04-10', 2, NULL);
INSERT INTO `blog_blog` VALUES (6, '123', '123345', 3, '2018-04-12', 1, 'None');
INSERT INTO `blog_blog` VALUES (8, '今日头条', '就发开始的卡惊世毒妃卡静安寺看发动机阿克萨减肥的卡世纪东方卡世纪东方奥斯卡的反击啊卡时代峻峰卡打飞机奥斯卡的放假阿萨德付款就奥斯卡的反击啊卡视角待反馈卡时代峻峰阿萨德付款及阿萨德付款阿斯蒂芬', 4, '2018-04-12', 2, NULL);
INSERT INTO `blog_blog` VALUES (11, '习近平：这是中国的“第二次革命”', '这是一个特殊的年份，\r\n\r\n在中国改革开放40周年之际，\r\n\r\n在经济全球化面临前所未有挑战之时，\r\n\r\n博鳌亚洲论坛2018年年会，\r\n\r\n在“万泉河水清又清”的优美乐曲中开幕了。\r\n\r\n数千名来自海内外的嘉宾们，\r\n\r\n带着某种疑问和期待来到博鳌。 ', 3, '2018-04-12', 1, NULL);
INSERT INTO `blog_blog` VALUES (12, '外交部：中国扩大开放举措与中美贸易冲突无关', '央视网消息：各界都十分关注习近平主席昨天在博鳌亚洲论坛2018年年会开幕式上宣布的中方进一步扩大开放的重大举措。有外媒认为，中方这些举措涵盖汽车、知识产权等领域，与此前美方表达关切的一些领域重合。中国外交部发言人耿爽在今天（11日）的例行记者会上表示，中方宣布扩大开放的有关重大举措与当前中美贸易冲突无关，这是中国根据自己的需要，按照自己的时间表、路线图自主开放的重大行动。\r\n\r\n　　外交部发言人 耿爽：我可以明确告诉你，中方宣布扩大开放的有关重大举措与当前中美贸易冲突无关。了解中国政府运作的人都知道，出台这么多重大决策必定要反复酝酿、深思熟虑、周密安排，不可能短时间内作出决定。\r\n\r\n　　耿爽表示，中方一直强调坚持对外开放的基本国策，坚持打开国门搞建设。中国开放的大门不会关闭，只会越开越大！这是中方一以贯之的立场。去年的十九大报告和今年的政府工作报告均对下一步对外开放工作做出了规划和部署。\r\n\r\n　　 外交部发言人 耿爽：此次中方出台这些举措正是落实十九大报告和政府工作报告的重要步骤，是中国根据自己的需要，按照自己的时间表、路线图自主开放的重大行动。中国扩大开放不受外界干扰，外界也干扰不了。（央视记者 申杨）', 9, '2018-04-12', 2, NULL);
INSERT INTO `blog_blog` VALUES (13, '阿尔及利亚一军机坠毁 死亡人数升至257人', '海外网4月11日电据阿尔及利亚民间电视台消息，阿尔及利亚一军机坠毁，已致257人死亡。\r\n\r\n此前据俄罗斯卫星通讯社消息，当地时间4月11日上午8点，一架阿尔及利亚军机在离开基地后不久便坠毁，当地媒体称，该事故发生在该国首都南部约50公里的地方。\r\n\r\n据称，该军机是一架伊尔78型运输机，机上当时有100多名军事人员。\r\n\r\n坠机现场浓烟滚滚，火光冲天，飞机已经完全断裂，地方当局已部署130名民防部队成员，14辆救护车和10辆卡车前往现场，大量穿着制服的救援人员在坠毁地点附近展开救援。\r\n\r\n2014年2月11日，阿尔及利亚一架C-130“大力神”军用运输机坠毁，事造成77人死亡。（海外网 杨佳）', 0, '2018-04-12', 1, NULL);
INSERT INTO `blog_blog` VALUES (14, '在美中国女博士跳金门大桥自杀 校方公布调查结果', '原标题：美犹他大学中国女留学生自杀校方公布调查结果\r\n\r\n中新网4月12日电据美国侨报网综合报道，在美国犹他大学攻读物理与天文学系的中国留学生唐晓琳的非正常死亡，在她的学校、尤其是在中国留学生群体中，掀起一股质疑浪潮。如今，学校给出了最终的调查报告，结果让人唏嘘不已。\r\n\r\n据报道，唐晓琳2017年10月被证实在旧金山金门大桥跳桥自杀。唐晓琳的去世引起质疑声潮，犹他大学去年宣布对此事进行独立法律调查。本月，犹他大学公布了最终的调查报告，停止了学校物理系的研究生招生，并进行了一系列的人事变动。\r\n\r\n一些犹他大学的学生认为，唐晓琳的死可能与“导师对她施加了过大压力”有关。\r\n\r\n从已知的唐晓琳经历来看，她度过了漫长的读书生涯。2004年进入北京大学就读空间物理专业，2008年本科毕业后去往美国犹他大学读研究生。随后在犹他大学的生物物理专业读博士，做的方向还是难度相当高的病毒RNA(项目)。”\r\n\r\n从学校公布的最终调查报告可以得出：\r\n\r\n唐晓琳的学习课程被推迟，毕业似乎遥遥无期。\r\n\r\n学生们经常超出预期的工作量，这是一个严酷的博士项目。学生经常需要在深夜和周末，在紧张的实验室环境中进行研究。\r\n\r\n犹他大学物理与天文学系内部不和谐，实验室成员会因物质和资源方面的使用分配而争论，导致分裂。\r\n\r\n该系没有为学生提供足够的指导，唐晓琳学业遭到拖延。\r\n\r\n学校没有对学生签证提供保证，导致唐晓琳的学生签证中途失效。\r\n\r\n而类似唐晓琳的悲剧，接连在很多国内外研究生、博士生，尤其是科研工作者身上发生。\r\n\r\n调查人员建议学校从新生入学起就加强对国际学生的关切，并聘请具有国际背景和讲其母语的辅导员。\r\n\r\n学校的国际部应该考虑为新入学的国际学生制定计划，指派同系的学长学姐为他们提供指导，国际学生也应该结伴，保证学校有人知晓其学术和大学生活。\r\n\r\n犹他大学在公布了这份报告后，同时发表声明，宣布物理与天文学系在2018至2019学年不再接受新的研究生，以后是否继续仍待定。数学教授特拉帕(Peter Trapa)将接替现任系主任伯曼利(Ben Bromley)。\r\n\r\n\r\n在犹他大学的官网上，还有公布一段中文文字：\r\n\r\n关于物理与天文学院在读博士唐晓琳事件声明\r\n\r\n犹他大学与许多其他的大学一样，为学生提供了心理健康与危机干预的服务，也将努力探寻更多可以帮助学生面对转折的方式。而且，我校研究生院长David Kieda已经发起了校园的相关管理变革及对各研究生进行年度评估的课程监督机制。研究生导师将会就“如何识别具体风险因素”及“如何有效帮助有学术或个人困难的学生”接受相关方面的培训。David Kieda也要求各个系的研究生导师提高对帮助学生顺利完成学业、学生心理辅导等相关方面的关注程度。\r\n\r\n报道指出，逝者已逝，然而其他留学生应该借此来让自己的内心更加强大，放松心情，多和家人朋友校方沟通，预防类似悲剧再度发生。', 5, '2018-04-12', 1, NULL);
INSERT INTO `blog_blog` VALUES (15, '女员工请姨妈假被要求\"验明正身\":去厕所脱衣检查', '1818黄金眼4月11日消息，小周反映说，她在杭州九堡一家培训机构上班，公司拖欠薪水，还会故意刁难，比如说，女生比较特别的那些日子。\r\n\r\n薪酬不按时发，大家有了情绪？\r\n\r\n小周：“就突然对我发难，说你这个姨妈假，我要检查一下，你是不是真的来了大姨妈，要让我去公司的厕所，脱衣服检查。”\r\n\r\n', 3, '2018-04-12', 2, NULL);
INSERT INTO `blog_blog` VALUES (16, '新闻标题-今晨沪平凉路 大巴班车转弯不慎轧死骑车女子', '【新民晚报·新民网】今天（12日）清晨6时50分许，杨浦区平凉路宁国路路口发生一起大巴撞击自行车的事故，骑车女子被轧在车轮下，经急救人员确认，骑车女子已当场死亡。', 28, '2018-04-12', 2, '今晨沪平凉路 大巴班车转弯不慎轧死骑车女子');
INSERT INTO `blog_blog` VALUES (17, '我是标题', '戴假发开发阿卡索的快放假啊是卡时代峻峰卡视角卡视角发卡视角待反馈奥斯卡级阿克苏放假按时看得见风卡世纪东方卡视角东方卡接收到开发加咖啡\r\n\r\n阿克苏打飞机卡世纪东方阿萨德飞机加上快递费就按时看得见风卡萨丁分卡时代峰峻1', 20, '2018-04-13', 2, '我是子标题');
INSERT INTO `blog_blog` VALUES (18, '123', '123', 0, '2018-04-17', 2, '123');
INSERT INTO `blog_blog` VALUES (19, '123', '123', 0, '2018-04-17', 2, '123');
COMMIT;

-- ----------------------------
-- Table structure for blog_user
-- ----------------------------
DROP TABLE IF EXISTS `blog_user`;
CREATE TABLE `blog_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(150) NOT NULL,
  `password` varchar(128) NOT NULL,
  `date_joined` date NOT NULL,
  `email` varchar(254) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` date DEFAULT NULL,
  `last_name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of blog_user
-- ----------------------------
BEGIN;
INSERT INTO `blog_user` VALUES (1, 'admin', '123456', '2018-04-17', 'admin@blog.com', '王', 1, 1, 1, '2018-04-17', '校长');
COMMIT;

-- ----------------------------
-- Table structure for django_admin_log
-- ----------------------------
DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for django_content_type
-- ----------------------------
DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_content_type
-- ----------------------------
BEGIN;
INSERT INTO `django_content_type` VALUES (1, 'admin', 'logentry');
INSERT INTO `django_content_type` VALUES (3, 'auth', 'group');
INSERT INTO `django_content_type` VALUES (2, 'auth', 'permission');
INSERT INTO `django_content_type` VALUES (4, 'auth', 'user');
INSERT INTO `django_content_type` VALUES (7, 'blog', 'author');
INSERT INTO `django_content_type` VALUES (8, 'blog', 'blog');
INSERT INTO `django_content_type` VALUES (9, 'blog', 'user');
INSERT INTO `django_content_type` VALUES (5, 'contenttypes', 'contenttype');
INSERT INTO `django_content_type` VALUES (6, 'sessions', 'session');
COMMIT;

-- ----------------------------
-- Table structure for django_migrations
-- ----------------------------
DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_migrations
-- ----------------------------
BEGIN;
INSERT INTO `django_migrations` VALUES (1, 'contenttypes', '0001_initial', '2018-04-09 09:44:44.479820');
INSERT INTO `django_migrations` VALUES (2, 'auth', '0001_initial', '2018-04-09 09:44:45.254004');
INSERT INTO `django_migrations` VALUES (3, 'admin', '0001_initial', '2018-04-09 09:44:45.423317');
INSERT INTO `django_migrations` VALUES (4, 'admin', '0002_logentry_remove_auto_add', '2018-04-09 09:44:45.438520');
INSERT INTO `django_migrations` VALUES (5, 'contenttypes', '0002_remove_content_type_name', '2018-04-09 09:44:45.579689');
INSERT INTO `django_migrations` VALUES (6, 'auth', '0002_alter_permission_name_max_length', '2018-04-09 09:44:45.651707');
INSERT INTO `django_migrations` VALUES (7, 'auth', '0003_alter_user_email_max_length', '2018-04-09 09:44:45.715951');
INSERT INTO `django_migrations` VALUES (8, 'auth', '0004_alter_user_username_opts', '2018-04-09 09:44:45.733428');
INSERT INTO `django_migrations` VALUES (9, 'auth', '0005_alter_user_last_login_null', '2018-04-09 09:44:45.786674');
INSERT INTO `django_migrations` VALUES (10, 'auth', '0006_require_contenttypes_0002', '2018-04-09 09:44:45.792095');
INSERT INTO `django_migrations` VALUES (11, 'auth', '0007_alter_validators_add_error_messages', '2018-04-09 09:44:45.805616');
INSERT INTO `django_migrations` VALUES (12, 'auth', '0008_alter_user_username_max_length', '2018-04-09 09:44:45.962765');
INSERT INTO `django_migrations` VALUES (13, 'auth', '0009_alter_user_last_name_max_length', '2018-04-09 09:44:46.020310');
INSERT INTO `django_migrations` VALUES (14, 'blog', '0001_initial', '2018-04-09 09:44:46.135665');
INSERT INTO `django_migrations` VALUES (15, 'sessions', '0001_initial', '2018-04-09 09:44:46.328757');
INSERT INTO `django_migrations` VALUES (16, 'blog', '0002_blog_subtitle', '2018-04-12 06:56:07.649572');
INSERT INTO `django_migrations` VALUES (17, 'blog', '0003_auto_20180416_0145', '2018-04-16 01:46:12.940863');
INSERT INTO `django_migrations` VALUES (18, 'blog', '0004_auto_20180416_1021', '2018-04-16 10:21:44.438285');
INSERT INTO `django_migrations` VALUES (19, 'blog', '0005_auto_20180416_1127', '2018-04-16 11:28:03.241465');
COMMIT;

-- ----------------------------
-- Table structure for django_session
-- ----------------------------
DROP TABLE IF EXISTS `django_session`;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of django_session
-- ----------------------------
BEGIN;
INSERT INTO `django_session` VALUES ('1pd0oudkse0ywrmfle7ru657mox1awe3', 'ZWE4NGVjNzA5Y2QyN2RiNTljMDA3NmJjNjdhYWUzNDc3YTU4NjBkZDp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YzBhYzIzMWZmOTY4Zjk1ZDUxNzE5ZDY1ZjAyZjM3MTBjYTQ0YjViIn0=', '2018-05-01 07:01:14.021317');
INSERT INTO `django_session` VALUES ('bsglgy6gzqh5nrvi0x638m8braq9nxev', 'ZWE4NGVjNzA5Y2QyN2RiNTljMDA3NmJjNjdhYWUzNDc3YTU4NjBkZDp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI2YzBhYzIzMWZmOTY4Zjk1ZDUxNzE5ZDY1ZjAyZjM3MTBjYTQ0YjViIn0=', '2018-05-01 07:10:00.056701');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
