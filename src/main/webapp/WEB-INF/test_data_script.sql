﻿-- noinspection SpellCheckingInspectionForFile

-- noinspection SqlResolveForFile

-- noinspection SqlNoDataSourceInspectionForFile

insert into usr (id, email, password, first_name, last_name, token, created,
                 manager_id, is_active, is_on_landing_page, description)
values (1, 'theking@gmail.com', 'kingthe', 'THE', 'KING', 'jt4RFkGzmaSq',
        '2018-04-11 21:06:00', null, true, false, 'ADMIN'),
       (2, 'voodyallen@gmail.com', 'allenvoody', 'VOODY', 'ALLEN', 'WCl5WhuVC9ej',
        '2014-04-30 08:42:00', null, true, false, 'Vooden Allen'),
       (3, 'jamieward@gmail.com', 'wardjamie', 'JAMIE', 'WARD', '05iQZp4y6CeV',
        '2014-07-30 10:44:00', null, true, false, 'Jamie Wardie'),
       (4, 'jackjones@gmail.com', 'jonesjack', 'JACK', 'JONES', '8N00odJBX3bY',
        '2014-12-26 11:09:00', null, true, true, 'Jacky Jonesy'),
       (5, 'luthermartin@gmail.com', 'martinluther', 'LUTHER', 'MARTIN', 'i158YBo5aRpQ',
        '2015-06-10 11:51:00', null, true, false, 'Martiny Lutherini'),
       (6, 'jakeblake@gmail.com', 'blakejake', 'JAKE', 'BLAKE', 'hHTD00GfhopU',
        '2015-06-27 13:24:00', 2, true, false, 'Jaken Blaken'),
       (7, 'darkclark@gmail.com', 'clarkdark', 'DARK', 'CLARK', 'sN0C2mQ7LJyU',
        '2016-10-30 17:22:00', 3, true, false, 'Darken Clarken'),
       (8, 'wasleyscott@gmail.com', 'scottwasley', 'WASLEY', 'SCOTT', 'q5rcNUMepEPj',
        '2017-10-20 20:04:00', 2, true, false, 'Scottish Wasley'),
       (9, 'johnsmith@gmail.com', 'smithjohn', 'JOHN', 'SMITH', 'gcMg0GR5zf60',
        '2012-12-16 00:12:00', 3, false, false, 'Johnyy Smith'),
       (10, 'emailname10@gmail.com', 'password10', 'firstname10', 'lasttname10', 'lebdhbdpdnfwaysb',
        '2012-08-23 11:43:40', 3, true, false, 'EMPLOYEE'),
       (11, 'emailname11@gmail.com', 'password11', 'firstname11', 'lasttname11', 'xljnhelrddwwutjw',
        '2012-02-29 06:33:02', 3, true, false, 'EMPLOYEE'),
       (12, 'emailname12@gmail.com', 'password12', 'firstname12', 'lasttname12', 'watvxamwrlubwiqr',
        '2012-12-22 08:24:44', 2, true, false, 'EMPLOYEE'),
       (13, 'emailname13@gmail.com', 'password13', 'firstname13', 'lasttname13', 'oyxbzbptehewvfcc',
        '2012-12-15 07:46:58', 2, true, false, 'EMPLOYEE'),
       (14, 'emailname14@gmail.com', 'password14', 'firstname14', 'lasttname14', 'mizpihegcgednboe',
        '2012-04-27 12:11:55', 2, true, false, 'EMPLOYEE'),
       (15, 'emailname15@gmail.com', 'password15', 'firstname15', 'lasttname15', 'marerfevctqnwbvm',
        '2012-10-17 06:00:23', 2, true, false, 'EMPLOYEE'),
       (16, 'emailname16@gmail.com', 'password16', 'firstname16', 'lasttname16', 'xqqyvkinknbrhagg',
        '2012-12-21 11:18:49', 3, true, false, 'EMPLOYEE'),
       (17, 'emailname17@gmail.com', 'password17', 'firstname17', 'lasttname17', 'chzepivksbepbkxm',
        '2012-09-10 04:48:52', 2, true, false, 'EMPLOYEE'),
       (18, 'emailname18@gmail.com', 'password18', 'firstname18', 'lasttname18', 'poqtolssfsvdrfrx',
        '2012-07-11 07:41:18', 2, true, false, 'EMPLOYEE'),
       (19, 'emailname19@gmail.com', 'password19', 'firstname19', 'lasttname19', 'dxpdbglnbstaybbe',
        '2012-12-07 01:39:24', 2, true, false, 'EMPLOYEE'),
       (20, 'emailname20@gmail.com', 'password20', 'firstname20', 'lasttname20', 'qznhzjbufropayvo',
        '2012-03-15 04:21:14', 3, true, false, 'EMPLOYEE'),
       (21, 'emailname21@gmail.com', 'password21', 'firstname21', 'lasttname21', 'rsottnjpjvcxvkzs',
        '2012-09-24 03:36:20', 2, true, false, 'EMPLOYEE'),
       (22, 'emailname22@gmail.com', 'password22', 'firstname22', 'lasttname22', 'ozczwhfmcnnxykja',
        '2012-06-01 01:12:35', 3, true, false, 'EMPLOYEE'),
       (23, 'emailname23@gmail.com', 'password23', 'firstname23', 'lasttname23', 'ehlihksakzczihmh',
        '2012-06-05 05:17:41', 3, true, false, 'EMPLOYEE'),
       (24, 'emailname24@gmail.com', 'password24', 'firstname24', 'lasttname24', 'uyudzfgmkhpaqshp',
        '2012-09-01 03:24:18', 3, true, false, 'EMPLOYEE'),
       (25, 'emailname25@gmail.com', 'password25', 'firstname25', 'lasttname25', 'mpjtpydgvzkubicg',
        '2012-11-09 05:09:46', 2, true, false, 'EMPLOYEE'),
       (26, 'emailname26@gmail.com', 'password26', 'firstname26', 'lasttname26', 'wsnryhjrrzpapbgf',
        '2012-07-11 10:47:14', 2, true, false, 'EMPLOYEE'),
       (27, 'emailname27@gmail.com', 'password27', 'firstname27', 'lasttname27', 'wnmjmhbnuzhatyhi',
        '2012-01-16 02:53:19', 2, true, false, 'EMPLOYEE'),
       (28, 'emailname28@gmail.com', 'password28', 'firstname28', 'lasttname28', 'tlqocwdydonegkip',
        '2012-11-06 09:55:19', 2, true, false, 'EMPLOYEE'),
       (29, 'emailname29@gmail.com', 'password29', 'firstname29', 'lasttname29', 'viklxzfrmraolidk',
        '2012-07-27 01:52:25', 3, true, false, 'EMPLOYEE'),
       (30, 'emailname30@gmail.com', 'password30', 'firstname30', 'lasttname30', 'tyqjtbrgtxxljcuc',
        '2012-02-11 02:59:12', 2, true, false, 'EMPLOYEE'),
       (31, 'emailname31@gmail.com', 'password31', 'firstname31', 'lasttname31', 'stnyuwcvmvtpaklq',
        '2012-02-16 05:47:02', 3, true, false, 'EMPLOYEE'),
       (32, 'emailname32@gmail.com', 'password32', 'firstname32', 'lasttname32', 'hrgkhujnaogbtcpz',
        '2012-03-20 01:12:38', 3, true, false, 'EMPLOYEE'),
       (33, 'emailname33@gmail.com', 'password33', 'firstname33', 'lasttname33', 'awojlgkrryvtfgev',
        '2012-09-26 09:04:37', 3, true, false, 'EMPLOYEE'),
       (34, 'emailname34@gmail.com', 'password34', 'firstname34', 'lasttname34', 'qlhxsnnyiyvhflqd',
        '2012-04-18 11:26:15', 2, true, false, 'EMPLOYEE'),
       (35, 'emailname35@gmail.com', 'password35', 'firstname35', 'lasttname35', 'fwqdivjstsxlgttj',
        '2012-05-23 11:25:31', 3, true, false, 'EMPLOYEE'),
       (36, 'emailname36@gmail.com', 'password36', 'firstname36', 'lasttname36', 'jyghcdfozexsbqts',
        '2012-02-13 01:47:04', 2, true, false, 'EMPLOYEE'),
       (37, 'emailname37@gmail.com', 'password37', 'firstname37', 'lasttname37', 'pzizobhswoazrccu',
        '2012-05-07 06:57:07', 2, true, false, 'EMPLOYEE'),
       (38, 'emailname38@gmail.com', 'password38', 'firstname38', 'lasttname38', 'mxymrdipmuhxyjtm',
        '2012-12-15 08:19:43', 2, true, false, 'EMPLOYEE'),
       (39, 'emailname39@gmail.com', 'password39', 'firstname39', 'lasttname39', 'vdzklurdkrvxjrif',
        '2012-01-05 10:48:40', 3, true, false, 'EMPLOYEE'),
       (40, 'emailname40@gmail.com', 'password40', 'firstname40', 'lasttname40', 'qgryhfbutwaprukx',
        '2012-04-09 10:31:17', 2, true, false, 'EMPLOYEE');

alter sequence usr_seq restart with 19879;


insert into role_r (id, name)
values (1, 'admin'),
       (2, 'manager'),
       (3, 'trainer'),
       (4, 'employee');

alter sequence role_seq restart with 5;


insert into assigned_role (user_id, role_id)
values (1, 1),
       (1, 3),
       (2, 2),
       (2, 4),
       (3, 2),
       (3, 4),
       (4, 3),
       (5, 3),
       (6, 4),
       (7, 4),
       (8, 4),
       (9, 4),
       (10, 4),
       (11, 4),
       (12, 4),
       (13, 4),
       (14, 4),
       (15, 4),
       (16, 4),
       (17, 4),
       (18, 4),
       (19, 4),
       (20, 4),
       (21, 4),
       (22, 4),
       (23, 4),
       (24, 4),
       (25, 4),
       (26, 4),
       (27, 4),
       (28, 4),
       (29, 4),
       (30, 4),
       (31, 4),
       (32, 4),
       (33, 4),
       (34, 4),
       (35, 4),
       (36, 4),
       (37, 4),
       (38, 4),
       (39, 4),
       (40, 4);

insert into level (id, title)
values (1, 'beginner'),
       (2, 'junior'),
       (3, 'middle'),
       (4, 'advanced');

alter sequence level_seq restart with 5;


insert into course_status (id, name, description)
values (1, 'planned', 'The registration has not started yet'),
       (2, 'registration', 'The registrion is open. No schedule yet'),
       (3, 'scheduled', 'Registration is closed. Schedule is formed. The lessons have not started yet'),
       (4, 'ongoing', 'The lessons have started'),
       (5, 'ended', 'The lessons have ended');

alter sequence course_status_seq restart with 6;


insert into course (id, name, level, course_status_id, user_id,
                    start_date, end_date, is_on_landing_page,
                    image_url, description)
values (1, 'Java Beginner Course', 1, 2, 4, '2019-08-29', '2019-12-05', true,
        'https://udemyimages-a.akamaihd.net/course/480x270/184574_7227.jpg',
        'Java Programming Course For Complete Beginners'),
       (2, 'Java Standart Edition', 2, 3, 4, '2019-07-23', '2019-10-25', true,
        'https://i.udemycdn.com/course/480x270/1777758_d2db_3.jpg',
        'Java Standart Edition For Middle Java Developers'),
       (3, 'Java Senior', 4, 4, 5, '2019-02-28', '2019-08-14', false,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'Java Programming Course For Advanced Java Developers'),
       (4, 'C# Beginner Course', 1, 2, 4, '2019-08-29', '2019-12-05', true,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'C# Programming Course For Complete Beginners'),
       (5, 'C# Standard Edition', 2, 3, 4, '2019-07-23', '2019-10-25', true,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'C# Standard Edition For Middle C# Developers'),
       (6, 'C# Senior', 4, 4, 5, '2019-02-28', '2019-08-14', false,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'C# Programming Course For Advanced C# Developers'),
       (7, 'C++ Beginner Course', 1, 2, 4, '2019-08-29', '2019-12-05', true,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'C++ Programming Course For Complete Beginners'),
       (8, 'C++ Standard Edition', 2, 3, 4, '2019-07-23', '2019-10-25', true,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'C++ Standard Edition For Middle C# Developers'),
       (9, 'C++ Senior', 4, 4, 5, '2019-02-28', '2019-08-14', false,
        'https://cdn-images-1.medium.com/max/1200/1*5T57bx4OS6o6lPe1ryU9oQ.png',
        'C++ Programming Course For Advanced C# Developers');

alter sequence course_seq restart with 5;


insert into problem_status (id, title, description)
values (1, 'draft', 'The employee created request but the request is not submitted.'),
       (2, 'open', 'The employee submitted the request. The system displays notification regarding new request.'),
       (3, 'in progress',
        'The admin starts to answer to employee�s response. The system saves intermediate status of the answer.'),
       (4, 'answered', 'The employee marked request as answered. The admin cannot type anything in this request.'),
       (5, 'reopened', 'The employee reopened the request.');

alter sequence problem_status_seq restart with 6;


insert into absence_reason (id, title)
values (1, 'No reason'),
       (2, 'Sick'),
       (3, 'Business trip'),
       (4, 'Project activities');

alter sequence absence_reason_seq restart with 5;


insert into attendance_status (id, title)
values (1, 'present'),
       (2, 'absent'),
       (3, 'late');

alter sequence attendance_status_seq restart with 5;


insert into grup (id, course_id, title)
values (1, 3, 'Java Seniors'),
       (2, 4, 'C# Beginner'),
       (3, 7, 'C++ Beginner'),
       (4, 6, 'C# Seniors'),
       (5, 2, 'Java Standard'),
       (6, 1, 'Java Beginner');

alter sequence grup_seq restart with 2;


insert into usr_group (user_id, group_id, is_attending, course_id)
values (2, 1, true, 3),
       (2, 5, true, 2),
       (2, 6, true, 1),
       (6, 3, true, 7),
       (6, 4, true, 6),
       (6, 6, true, 1),
       (7, 1, true, 3),
       (7, 4, true, 6),
       (7, 5, true, 2),
       (7, 6, true, 1),
       (10, 4, true, 6),
       (11, 4, true, 6),
       (12, 5, true, 2),
       (13, 1, true, 3),
       (14, 5, true, 2),
       (15, 2, true, 4),
       (16, 3, true, 7),
       (17, 5, true, 2),
       (18, 6, true, 1),
       (19, 4, true, 6),
       (20, 2, true, 4),
       (21, 4, true, 6),
       (22, 2, true, 4),
       (23, 1, true, 3),
       (24, 3, true, 7),
       (25, 2, true, 4),
       (26, 1, true, 3),
       (27, 3, true, 7),
       (28, 3, true, 7),
       (29, 2, true, 4),
       (30, 4, true, 6),
       (31, 4, true, 6),
       (32, 3, true, 7),
       (33, 6, true, 1),
       (34, 4, true, 6),
       (35, 2, true, 4),
       (36, 5, true, 2),
       (37, 3, true, 7),
       (38, 5, true, 2),
       (39, 4, true, 6),
       (40, 6, false, 1);


insert into lesson (id, group_id, topic, trainer_id, time_date, is_archived, is_canceled, duration, PERFORMED)
values (1,     1,	'Generics',  4,	'2012-05-29 15:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',               true),
       (2,     1,	'Java EE',  5,	'2012-05-26 15:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',               true),
       (3,     1,	'Interfaces',  5,	'2019-05-02 03:25:00.000000',	false,	true,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (4,     1,	'Classes',  4,	'2019-05-10 16:10:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',               true),
       (5,     1,	'lessonTopic1',  1,	'2012-06-19 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (6,     1,	'lessonTopic2',  1,	'2012-06-19 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (7,     1,	'lessonTopic3',  1,	'2012-06-19 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (8,     2,	'lessonTopic4',  4,	'2012-08-13 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (9,     2,	'lessonTopic5',  4,	'2012-08-13 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (10,   	2,	'lessonTopic6',  4,	'2012-08-13 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (11,   	3,	'lessonTopic7',  5,	'2012-08-23 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (12,   	3,	'lessonTopic8',  5,	'2012-08-23 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (13,   	3,	'lessonTopic9',  5,	'2012-08-23 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (14,   	4,	'lessonTopic10',  5,	'2012-06-14 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (15,   	4,	'lessonTopic11',  5,	'2012-06-14 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (16,   	4,	'lessonTopic12',  5,	'2012-06-14 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (17,   	5,	'lessonTopic13',  1,	'2012-08-09 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (18,   	5,	'lessonTopic14',  1,	'2012-08-09 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (19,   	5,	'lessonTopic15',  1,	'2012-08-09 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (20,   	6,	'lessonTopic16',  4,	'2012-08-16 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (21,   	6,	'lessonTopic17',  4,	'2012-08-16 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (22,   	6,	'lessonTopic18',  4,	'2012-08-16 00:00:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (23,   	1,	'Multithreading',  4,	'2019-05-15 05:10:00.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (24,   	1,	'Classes new!!',  5,	'2019-05-31 08:11:00.000000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (25,   	1,	'Generics advanced',  1,	'2019-05-31 16:30:41.760000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',   true),
       (26,   	1,	'test',  4,	'2019-05-16 14:07:43.690000',	true,   true,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',                   true),
       (27,   	1,	'""',  1,	'2019-05-06 11:57:46.930000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',                   true),
       (28,   	1,	'""',  1,	'2019-05-11 12:40:36.050000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',                   true),
       (29,   	1,	'hjhjkhjkhjkghjk',  1,	'2019-05-11 12:42:29.430000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',       true),
       (30,   	1,	'new one',  1,	'2019-05-11 12:45:36.270000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',               true),
       (31,   	1,	'dfdfdfd',  1,	'2019-05-11 12:51:14.680000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',               true),
       (32,   	6,	'Basics',  5,	'2019-05-13 12:49:15.250000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',               true),
       (33,   	4,	'Basics of C#',  5,	'2019-05-13 13:11:18.100000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (34,   	1,	'new lesson',  1,	'2019-05-15 03:43:59.380000',	true,   false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',           true),
       (35,   	1,	'new',  4,	'2019-05-19 18:34:15.000000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',                   true),
       (36,   	3,	'Intro to Data types', 5,	'2019-05-20 07:05:19.290000',	false,	false,	'0 years 0 mons 0 days 1 hours 0 mins 0.00 secs',   true);



alter sequence lesson_seq restart with 120;


/*
1(2,7,13,23,26) lessons(1,2,5,6,7)
2(15,20,22,25,29,35) lessons(3,4,8,9,10)
3(6,16,24,27,28,32,37) lessons(11,12,13)
4(6,7,10,11,19,21,30,31,34,39) lessons(14,15,16)
5(2,7,12,14,17,36,38) lessons(17,18,19)
6(6,7,18,33,40) lessons(20,21,22)
*/

insert into attendance (lesson_id, user_id, reason_id, status_id)
values (1, 2, null, 3),
       (1, 7, 2, 2),
       (1, 13, 1, 2),
       (1, 23, null, 1),
       (1, 26, null, 1),
       (2, 2, null, 3),
       (2, 7, null, 1),
       (2, 13, null, 3),
       (2, 23, null, 1),
       (2, 26, null, 3),
       (3, 15, null, 3),
       (3, 20, null, 1),
       (3, 22, null, 1),
       (3, 25, null, 1),
       (3, 29, null, 1),
       (3, 35, null, 1),
       (4, 15, null, 1),
       (4, 20, 2, 2),
       (4, 22, null, 3),
       (4, 25, 4, 2),
       (4, 29, null, 1),
       (4, 35, null, 1),
       (5, 2, 2, 2),
       (5, 7, 2, 2),
       (5, 13, null, 1),
       (5, 23, null, 1),
       (5, 26, null, 3),
       (6, 2, null, 1),
       (6, 7, 1, 2),
       (6, 13, null, 1),
       (6, 23, null, 1),
       (6, 26, 3, 2),
       (7, 2, null, 3),
       (7, 7, null, 3),
       (7, 13, 2, 2),
       (7, 23, null, 3),
       (7, 26, null, 1),
       (8, 15, null, 3),
       (8, 20, null, 1),
       (8, 22, null, 3),
       (8, 25, null, 1),
       (8, 29, 2, 2),
       (8, 35, 1, 2),
       (9, 15, null, 3),
       (9, 20, 3, 2),
       (9, 22, 1, 2),
       (9, 25, null, 1),
       (9, 29, null, 3),
       (9, 35, null, 1),
       (10, 15, null, 1),
       (10, 20, null, 3),
       (10, 22, 1, 2),
       (10, 25, null, 3),
       (10, 29, null, 3),
       (10, 35, null, 3),
       (11, 6, null, 1),
       (11, 16, 2, 2),
       (11, 24, null, 1),
       (11, 27, 1, 2),
       (11, 28, null, 3),
       (11, 32, null, 1),
       (11, 37, null, 1),
       (12, 6, 3, 2),
       (12, 16, 4, 2),
       (12, 24, null, 3),
       (12, 27, null, 3),
       (12, 28, 3, 2),
       (12, 32, 4, 2),
       (12, 37, null, 1),
       (13, 6, 3, 2),
       (13, 16, null, 1),
       (13, 24, null, 3),
       (13, 27, 3, 2),
       (13, 28, 3, 2),
       (13, 32, 4, 2),
       (13, 37, null, 3),
       (14, 6, 1, 2),
       (14, 7, null, 1),
       (14, 10, null, 3),
       (14, 11, 1, 2),
       (14, 19, 1, 2),
       (14, 21, null, 1),
       (14, 30, null, 3),
       (14, 31, 4, 2),
       (14, 34, 4, 2),
       (14, 39, null, 1),
       (15, 6, null, 1),
       (15, 7, 3, 2),
       (15, 10, null, 3),
       (15, 11, null, 3),
       (15, 19, null, 3),
       (15, 21, null, 1),
       (15, 30, 4, 2),
       (15, 31, 2, 2),
       (15, 34, null, 1),
       (15, 39, null, 1),
       (16, 6, null, 3),
       (16, 7, null, 1),
       (16, 10, null, 3),
       (16, 11, null, 3),
       (16, 19, null, 1),
       (16, 21, null, 3),
       (16, 30, null, 1),
       (16, 31, 2, 2),
       (16, 34, null, 1),
       (16, 39, 2, 2),
       (17, 2, null, 1),
       (17, 7, null, 3),
       (17, 12, 3, 2),
       (17, 14, null, 3),
       (17, 17, null, 1),
       (17, 36, 4, 2),
       (17, 38, null, 3),
       (18, 2, 4, 2),
       (18, 7, null, 3),
       (18, 12, 1, 2),
       (18, 14, 3, 2),
       (18, 17, 4, 2),
       (18, 36, null, 1),
       (18, 38, 3, 2),
       (19, 2, null, 1),
       (19, 7, null, 1),
       (19, 12, 2, 2),
       (19, 14, null, 1),
       (19, 17, null, 1),
       (19, 36, 4, 2),
       (19, 38, null, 1),
       (20, 6, null, 3),
       (20, 7, 2, 2),
       (20, 18, 4, 2),
       (20, 33, null, 1),
       (20, 40, null, 3),
       (21, 6, null, 3),
       (21, 7, null, 3),
       (21, 18, null, 1),
       (21, 33, null, 1),
       (21, 40, 1, 2),
       (22, 6, null, 3),
       (22, 7, null, 3),
       (22, 18, null, 1),
       (22, 33, 1, 2),
       (22, 40, null, 1);


insert into suitability (id, title, priority)
values (1, 'perfect', 3),
       (2, 'suitable', 2),
       (3, 'normal', 3);

alter sequence suitability_seq restart with 5;

insert into attachment (id, url, description, name, trainer_id)
values (1, '//url', 'description', 'attachment-name', 5);

insert into lesson_attachment (lesson_id, attachment_id)
values (1, 1),
       (1, 2),
       (1, 3);

INSERT INTO problem (user_id, title, problem_status_id, description, chat_id, date_time)
values (11, 'Problem!', 2, 'trouble', null, '2019-05-17 06:00:23'),
       (12, 'Problems', 3, 'FIXME', null, '2019-05-17 07:00:23'),
       (13, 'Problema', 1, 'fixit', null, '2019-05-17 08:00:23');


update lesson
set is_archived = false;
update lesson
set is_canceled = false;
update lesson
set duration = '1h';
commit;
