use nfra_forest_management;

-- select * from nfra where not exists(select * from `event` where `event`.nfra_id = nfra.id);
-- select * from solving as s, emergency as e, process_department as p where s.emergency_id = e.id and s.process_department_id = p.id;

insert into solving (emergency_id, process_department_id) values
(1, 2),
(2, 4),
(2, 5),
(4, 5),
(4, 16), -- 太陽公益團體
(6, 7),
(7, 4),
(8, 17),
(8, 16), 
(9, 19), -- 天苑公益團體
(10, 20);


-- select * from emergency, solving, process_department
-- where emergency.id = solving.emergency_id and solving.process_department_id = process_department.id;

insert into `emergency` values
(1, '2024-02-08', '樹木生病', 0, 13), -- 處女座nfra
(2, '2024-05-13', '發生野火', 0, 13), -- 處女座nfra
(3, '2024-05-03', '發生野火', 0, 15), -- 杜鵑座nfra
(4, '2024-05-05', '發生野火', 0, 7), -- 時鐘座nfra
(5, '2024-03-01', '樹木生病', 0, 8), -- 波江座nfra
(6, '2024-01-03', '非法砍筏', 0, 11), -- 狐狸座nfra 
(7, '2024-01-27', '外來種入侵', 0, 9), -- 貓座nfra
(8, '2024-02-19', '樹木生病', 0, 9), -- 貓座nfra
(9, '2024-04-27', '發生野火', 0, 6), -- 半人馬座nfra 
(10, '2024-01-15', '非法砍筏', 0, 14); -- 小犬座nfra

select * from `event`;

insert into `event` values
('2020-09-01', '2023-09-01', '森林生態環境分析', '研究', 1, 2, 1), -- 半人馬座研究機構 獵戶座森林公園
('2023-10-21', '2024-10-01', '森林種類分析', '研究', 1, 4, 1), -- 仙女座研究機構 獵戶座森林公園
('2010-12-01', '2025-01-01', '種樹復育森林', '復育', 1, 5, 2), -- 獵戶座集團 北冕座森林公園
('2020-02-01', '2030-02-01', '研究森林生態環境', '研究', 1, 7, 3), -- 銀河系聯盟 獅子座森林公園
('2023-02-01', '2025-01-01', '採集樹木樣本', '研究', 2, 7, 3), -- 銀河系聯盟 獅子座森林公園
('2010-01-01', '2029-12-31', '復育森林', '復育', 1, 9, 4), -- 熊座公益團體 仙女座森林公園
('2000-01-01', '2025-01-01', '復育森林', '復育', 1, 9, 5), -- 熊座公益團體 水蛇座森林公園
('2022-01-01', '2024-01-01', '新空間', '砍筏', 1, 10, 6), -- 天鵝座集團 半人馬座森林公園
('2023-03-01', '2024-08-01', '規劃新空間裡的建築物', '規劃', 2, 10, 6), -- 天鵝座集團 半人馬座森林公園
('2024-01-01', '2030-01-01', '森林種類分析', '研究', 1, 20, 10), -- 北落師門公會 大雲座森林公園
('2023-01-01', '2025-01-01', '探索森林地形', '探索', 2, 20, 10), -- 北落師門公會 大雲座森林公園
('2020-01-01', '2025-01-01', '森林生態環境分析', '研究', 1, 17, 10); -- 人馬臂研究所 大雲座森林公園

-- ALTER TABLE `event`
-- ADD CONSTRAINT end_time_check CHECK (end_date > start_date);

-- create table `event`
-- (
-- 	start_date DATE not null,
--     end_date DATE not null,
--     goal varchar(45) not null,
--     event_type varchar(45) not null,
-- 	`number` int not null,
--     process_department_id int not null,
--     nfra_id int not null,
--     foreign key (process_department_id) references process_department(id),
--     foreign key (nfra_id) references nfra(id),
--     primary key (`number`, process_department_id, nfra_id)
-- );

-- select * from process_qualification as pq, process_department as pd where pq.process_department_id = pd.id; 

insert into process_qualification (id, process_department_id, end_date) values
(1, 2, '2030-01-01'),
(2, 4, '2030-01-01'),
(3, 5, '2025-01-01'),
(4, 7, '2035-01-01'),
(5, 9, '2030-01-01'),
(6, 10, '2025-01-01'),
(7, 16, '2040-01-01'),
(8, 17, '2030-01-01'),
(9, 19, '2035-01-01'),
(10, 20, '2040-01-01');

-- select * from process_department as p
-- where not exists(select * from request_process_qualification as r where r.process_department_id = p.id);

insert into review (manage_department_id, request_process_qualification_id, is_passed) values
(1, 1, 0),
(2, 1, 0),
(3, 8, 1),
(3, 6, 0),
(4, 8, 1),
(5, 7, 1),
(5, 6, 0),
(6, 7, 1),
(7, 9, 0),
(8, 9, 1),
(9, 9, 0),
(9, 5, 0),
(10, 6, 1),
(10, 10, 0);

-- create table review
-- (
-- 	manage_department_id int not null,
--     request_process_qualification_id int not null,
--     is_passed boolean default(0),
--     foreign key (manage_department_id) references manage_department(id),
--     foreign key (request_process_qualification_id) references request_process_qualification(id),
--     primary key (manage_department_id, request_process_qualification_id)
-- );

-- select * from request_process_qualification;

insert into request_process_qualification values
(1, 14, '2024-5-12'), -- 彗星公益團體
(2, 13, '2024-4-28'), -- 星塵研究所
(3, 8, '2024-5-7'), -- 大犬座公益團體
(4, 12, '2024-4-30'), -- 黑洞聯盟
(5, 1, '2024-5-1'), -- 北極星公會
(6, 15, '2024-4-10'), -- 星雲公會
(7, 3, '2024-4-1'), -- 黃道公會
(8, 6, '2024-4-2'), -- 天琴座集團
(9, 18,'2024-5-11'), -- 英仙臂聯盟
(10, 11,'2024-4-20'); -- 流星雨協會

insert into process_department values
(1, "北極星公會", "黃道縣SQ4區"),
(2, "半人馬座研究機構", "武仙縣SQ1區"),
(3, "黃道公會", "黃道縣NQ3區"),
(4, "仙女座研究機構", "英仙縣NQ2區"),
(5, '獵戶座集團', "獵戶縣NQ3區"), 
(6, '天琴座集團', "武仙縣SQ2區"), 
(7, '銀河系聯盟', "銀河縣NQ1區"), 
(8, '大犬座公益團體', '獵戶縣SQ2區'), 
(9, '熊座公益團體', '大熊縣NQ2區'), 
(10, '天鵝座集團', '武仙縣NQ4區'),
(11, '流星雨協會', '熱羅姆·拉朗德縣NQ1區'), 
(12, '黑洞聯盟', '銀河縣SQ1區'), 
(13, '星塵研究所', '奧古斯丁·羅耶縣SQ4區'), 
(14, '彗星公益團體', '熱羅姆·拉朗德縣NQ3區'), 
(15, '星雲公會', '奧古斯丁·羅耶縣NQ2區'), 
(16, '太陽公益團體', '黃道縣NQ1區'),
(17, '人馬臂研究所', '銀河縣SQ3區'),
(18, '英仙臂聯盟', '銀河縣NQ4區'),
(19, '天苑公益團體', '拉卡伊SQ1區'),
(20, '北落師門公會', '幻之水SQ4區');


-- select * from manage_department;

insert into manage_department values
(1, "獵戶分署", "獵戶縣NQ2區"), 
(2, "大熊分署", "大熊縣SQ3區"),
(3, "黃道分署", "黃道縣NQ2區"),
(4, "英仙分署", "英仙縣NQ4區"),
(5, "拜耳分署", "拜耳縣SQ2"),
(6, "武仙分署", "武仙縣SQ4區"),
(7, "拉卡伊分署", "拉卡伊縣SQ2區"),
(8, "幻之水分署", "幻之水縣SQ2區"),
(9, "熱羅姆·拉朗德分署", "熱羅姆·拉朗德縣NQ2區"),
(10, "奧古斯丁·羅耶分署", "奧古斯丁·羅耶縣NQ2區");

-- select * from manage_department, nfra, `event`
-- where manage_department.id = nfra.manage_department_id and nfra.id = `event`.nfra_id;

insert nfra_address (address, nfra_id) values
("獵戶縣NQ1區", 1),
("大熊縣NQ3區", 2), 
("黃道縣NQ2區", 3), 
("英仙縣NQ1區", 4),
("拜耳縣SQ1區", 5),
("武仙縣SQ3區", 6),
("拉卡伊縣SQ1區", 7),
("幻之水縣SQ1區", 8),
("熱羅姆·拉朗德縣NQ1區", 9),
("奧古斯丁·羅耶縣NQ1區", 10),
("武仙縣NQ4區", 11),
("英仙縣NQ4區", 12),
("黃道縣SQ3區", 13), 
("獵戶縣NQ2區", 14),
("拜耳縣SQ4區", 15);

-- update nfra_address
-- set address='奧古斯丁·羅耶縣NQ1區'
-- where nfra_id = '10';

insert nfra (area, id, name, manage_department_id) values
(594, 1, "獵戶座", 1), (183, 14, "小犬座", 1), -- 獵戶 NQ1 / NQ2
(178, 2, "北冕座	", 2),  -- 大熊 NQ3
(946, 3, "獅子座", 3), (1294, 13, "處女座", 3), -- 黃道 NQ2 / SQ3
(722, 4, "仙女座", 4), (1120, 12, "飛馬座", 4),  -- 英仙 NQ1 / NQ4
(243, 5, "水蛇座", 5), (294, 15, "杜鵑座", 5), -- 拜耳 SQ1 / SQ4
(1060, 6, "半人馬座", 6), (268, 11, "狐狸座", 6), 武仙 SQ3 / NQ4
(248, 7, "時鐘座", 7), -- 拉卡伊 SQ1
(1137, 8, "波江座", 8), -- 幻之水 SQ1
(1000, 9, "貓座", 9), -- 熱羅姆·拉朗德
(2000, 10, "大雲座", 10); -- 奧古斯丁·羅耶

