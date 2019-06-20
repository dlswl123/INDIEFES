drop table play_list;

drop table good_log;

drop table like_log;

drop table strm_pay_log;

drop table pay_log;

drop table bank_cate;

drop table bank_account;

drop table team_member;

drop table indie_team;

drop table music_info;

drop table art_info;

drop table user_info;

drop table account_grade;

drop table board_info;

drop table reply_info;

drop table board_file;

drop table board_cate;


drop sequence seq_art;

drop sequence seq_music;

drop sequence seq_team;

drop sequence seq_member;

drop sequence seq_bank;

drop sequence seq_board;

drop sequence seq_reply;



create table account_grade(
user_level	number	primary key,
level_info	varchar2(20)	not null
);


create table user_info(
    user_id	varchar2(50)	primary key,
    user_pw	varchar2(50)	not null,
    user_nick	varchar2(20)	not null,
    user_name	varchar2(20)	not null,
    user_email	varchar2(50)	not null,
    user_birth	date	not null,
    user_gender	varchar2(5)	check (user_gender in('F','M','E')),
    reg_date	date	default sysdate,
    point	number	default 0,
    user_level	number	default 4 references account_grade(user_level),
    auto_login	varchar2(5)	default 'X' check (auto_login in('X','O')),
    reg_indie	varchar2(5)	default 'X' check (reg_indie in('X','O')),
    deleted	varchar2(5)	default 'X' check (deleted in('X','O'))
);

create table indie_team(
    team_number	number	primary key,
    art_team	varchar2(20)	not null
);

create table team_member(
    member_number	number	primary key,
    team_number	number	references indie_team(team_number),
    user_id	varchar2(50)	references user_info(user_id),
    team_level	number	default 0
);

create table art_info(
    art_number	number	primary key,
    art_genre	varchar2(50),
    user_id	varchar2(50)	references user_info(user_id),
    team_number	number	references indie_team(team_number),
    art_title	varchar2(100)	not null,
    art_cover	varchar2(100),
    art_pr	varchar2(1000),
    reg_art	date	default sysdate,
    liked_count	number	default 0,
    good_count	number	default 0,
    upload_check	number	default 0
);

create table music_info(
    art_number	number	references art_info(art_number),
    music_number	number	primary key,
    track_number	number	default 0 not null,
    music_title	varchar2(100)	not null,
    heard_count	number	default 0,
    price	number	default 100,
    pay_count	number	default 0,
    upload_check	number	default 0,
    file_path	varchar2(100)	not null
);
                                           
create table music_lyrics(
    music_number	number	references music_info(music_number),
    lyrics	varchar2(4000)
);

create table bank_cate(
    bank_index	number	primary key,
    bank_name	varchar2(10)	not null
);



create table bank_account(
    bank_number	number	primary key,
    team_number	number	references indie_team(team_number),
    bank_cate	number	references bank_cate(bank_index),
    account_num	varchar2(50)	not null,
    account_name	varchar2(20)	not null
);

create table pay_log(
    user_id	varchar2(50)	references user_info(user_id),
    music_number	number	references music_info(music_number),
    price	number,
    pay_date	date	default sysdate,
    exp_date	date	
);

create table strm_pay_log(
    user_id	varchar2(50)	references user_info(user_id),
    price	number,
    pay_date	date	default sysdate,
    exp_date	date	
);

create table like_log(
    user_id	varchar2(50)	references user_info(user_id),
    art_number	number	references art_info(art_number),
    like_date	date	default sysdate
);

create table good_log(
    user_id	varchar2(50)	references user_info(user_id),
    art_number	number	references art_info(art_number),
    good_date	date	default sysdate
);

create table play_list(
    user_id	varchar2(50)	references user_info(user_id),
    music_number	number	references music_info(music_number),
    play_index	number	default 0
);

create table board_cate(
    board_cate_number	number	primary key,
    board_cate_name	varchar2(50)	not null
);

create table board_info(
    board_number	number	primary key,
    board_cate_number	number	references board_cate(board_cate_number),
    subject	varchar2(100)	not null,
    user_id	varchar2(50)	references user_info(user_id),
    content	varchar2(1000),
    reg_date	date	default sysdate,
    lately_date	date,	
    view_count	number	default 0,
    like_count	number	default 0,
    reply_count	number	default 0,
    file_path	varchar2(100)	
);

create table reply_info(
    reply_number	number	primary key,
    board_number	number	references board_info(board_number),
    user_id	varchar2(50)	references user_info(user_id),
    content	varchar2(500)	not null,
    reg_date	date	default sysdate,
    late_date	date,	
    like_count	number	default 0
);

create table board_file(
    board_number	number	references board_info(board_number),
    file_path	varchar2(100)	primary key
);




create sequence seq_art;

create sequence seq_music;

create sequence seq_team;

create sequence seq_member;

create sequence seq_bank;

create sequence seq_board;

create sequence seq_reply;



insert into account_grade values (0, 'admin');
insert into account_grade values (1, 'staff');
insert into account_grade values (2, 'indie');
insert into account_grade values (3, 'common');

insert into bank_cate values (10, '국민');
insert into bank_cate values (20, '기업');
insert into bank_cate values (30, '농협');
insert into bank_cate values (40, '신한');
insert into bank_cate values (50, '하나');

insert into board_cate values (10, '자유');
insert into board_cate values (20, '토론');
insert into board_cate values (30, '추천');

insert into user_info values ('admin', '1234', '관리자', '오성', 'admin@email.com', '1991-01-01', 'F', sysdate, 0, 0, 'X', 'X', 'X');
insert into user_info values ('dlswl', '1234', '스태프인지', '오인지', 'dlswl@email.com', '1992-01-01', 'F', sysdate, 0, 1, 'X', 'X', 'X');
insert into user_info values ('guswjd', '1234', '스태프현정', '김현정', 'guswjd@email.com', '1991-01-01', 'F', sysdate, 0, 1, 'X', 'X', 'X');
insert into user_info values ('xotjd', '1234', '스태프태성', '정태성', 'xotjd@email.com', '1987-01-01', 'M', sysdate, 0, 1, 'X', 'X', 'X');
insert into user_info values ('rkdtlr', '1234', '스태프강식', '윤강식', 'rkdtlr@email.com', '1988-01-01', 'M', sysdate, 0, 1, 'X', 'X', 'X');
insert into user_info values ('wndls', '1234', '스태프주인', '박주인', 'wndls@email.com', '1983-01-01', 'M', sysdate, 0, 1, 'X', 'X', 'X');
insert into user_info values ('indie1', '1234', '첫인디', '인디이름1', 'indie1@email.com', '1990-01-01', 'F', sysdate, 0, 2, 'X', 'O', 'X');
insert into user_info values ('indie2', '1234', '두인디', '인디이름2', 'indie2@email.com', '1989-10-01', 'M', sysdate, 0, 2, 'X', 'O', 'X');
insert into user_info values ('user1', '1234', '유저1', '유저이름1', 'user1@email.com', '1981-11-10', 'F', sysdate, 0, 3, 'X', 'X', 'X');
insert into user_info values ('user2', '1234', '유저2', '유저이름2', 'user2@email.com', '2010-01-01', 'M', sysdate, 0, 3, 'X', 'X', 'X');
