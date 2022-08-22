/* 口座情報 */
drop table if exists t_account;
create table account(
 id serial primary key Not Null
,number varchar(6) Not Null
,apply_date date Not Null
,payment_method varchar(1)
,bank_code varchar(4)
,bank_branch_code varchar(3)
,bank_account_type varchar(1)
,bank_account_number varchar(7)
,bank_account_name text
,delete_flag varchar(1) default '0' Not Null
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table t_account is '口座情報';
comment on column t_account.id is 'レコードID	AUTO_INCREMENT';
comment on column t_account.number is '番号';
comment on column t_account.apply_date is '適用日';
comment on column t_account.payment_method is '支払方式（0：現金　1：振込）';
comment on column t_account.bank_code is '銀行コード';
comment on column t_account.bank_branch_code is '支店コード';
comment on column t_account.bank_account_type is '口座種別（0：普通　1：当座　2：通知　3：別段）';
comment on column t_account.bank_account_number is '口座番号';
comment on column t_account.bank_account_name is '口座名義';
comment on column t_account.delete_flag is '削除フラグ';
comment on column t_account.insert_datetime is '登録日時';
comment on column t_account.update_datetime is '更新日時';
comment on column t_account.insert_user is '作成者';
comment on column t_account.update_user is '更新者';

drop index if exists t_account_Idx1;
create unique index t_account_Idx1 on t_account (number,apply_date);

/* 退職手当 */
drop table if exists t_retirement_allowance;
create table  t_retirement_allowance(
 id serial primary key Not Null
,number varchar(6)
,retirement_date date
,history_number integer
,retirement_allowance money
,import_datetime timestamp(6) without time zone
,import_user text
,delete_flag varchar(1) default '0'
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table t_retirement_allowance is '退職手当';
comment on column t_retirement_allowance.id is 'レコードID	AUTO_INCREMENT';
comment on column t_retirement_allowance.number is '番号';
comment on column t_retirement_allowance.retirement_date is '退職日';
comment on column t_retirement_allowance.history_number is '履歴番号';
comment on column t_retirement_allowance.retirement_allowance is '退職手当額';
comment on column t_retirement_allowance.import_datetime is '取込日時';
comment on column t_retirement_allowance.import_user is '取込実施者';
comment on column t_retirement_allowance.delete_flag is '削除フラグ';
comment on column t_retirement_allowance.insert_datetime is '登録日時';
comment on column t_retirement_allowance.update_datetime is '更新日時';
comment on column t_retirement_allowance.insert_user is '作成者';
comment on column t_retirement_allowance.update_user is '更新者';

drop index if exists t_retirement_allowance_Idx1;
create unique index t_retirement_allowance_Idx1 on t_retirement_allowance (number,retirement_date);

/* 期末手当率マスタ */
drop table if exists m_bonus_rates;
create table bonus_rates(
 id serial primary key Not Null
,target_year smallint
,termend_rate6 numeric(6, 5)
,termend_rate12 numeric(6, 5)
,diligence_date6 numeric(6, 5)
,diligence_date12 numeric(6, 5)
,delete_flag varchar(1) default '0' Not Null
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table m_bonus_rates is '期末手当率マスタ';
comment on column m_bonus_rates.id is 'レコードID	AUTO_INCREMENT';
comment on column m_bonus_rates.target_year is '対象年';
comment on column m_bonus_rates.termend_rate6 is '期末率6月';
comment on column m_bonus_rates.termend_rate12 is '期末率12月';
comment on column m_bonus_rates.diligence_date6 is '勤勉率6月';
comment on column m_bonus_rates.diligence_date12 is '勤勉率12月';
comment on column m_bonus_rates.delete_flag is '削除フラグ';
comment on column m_bonus_rates.insert_datetime is '登録日時';
comment on column m_bonus_rates.update_datetime is '更新日時';
comment on column m_bonus_rates.insert_user is '作成者';
comment on column m_bonus_rates.update_user is '更新者';

drop index if exists m_bonus_rates_Idx1;
create unique index m_bonus_rates_Idx1 on m_bonus_rates (target_year);

/* その他メンバー情報 */
drop table if exists t_other_member;
create table t_other_member(
 id serial primary key Not Null
,number varchar(6)
,lastname text
,firstname text
,lastname_kana text
,firstname_kana text
,birthday date
,sex varchar(1)
,contact text
,die_flag varchar(1)
,delete_flag varchar(1) default '0' Not Null
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table t_other_member is 'その他メンバー情報';
comment on column t_other_member.id is 'レコードID	AUTO_INCREMENT';
comment on column t_other_member.number is '番号';
comment on column t_other_member.lastname is '姓';
comment on column t_other_member.firstname is '名';
comment on column t_other_member.lastname_kana is 'カナ姓';
comment on column t_other_member.firstname_kana is 'カナ名';
comment on column t_other_member.birthday is '生年月日';
comment on column t_other_member.sex is '性別	0:男 1:女';
comment on column t_other_member.contact is '連絡先等';
comment on column t_other_member.die_flag is '死亡フラグ';
comment on column t_other_member.delete_flag is '削除フラグ';
comment on column t_other_member.insert_datetime is '登録日時';
comment on column t_other_member.update_datetime is '更新日時';
comment on column t_other_member.insert_user is '作成者';
comment on column t_other_member.update_user is '更新者';

drop index if exists t_other_member_Idx1;
create unique index t_other_member_Idx1 on t_other_member (number);

/* 月額変動 */
drop table if exists t_monthly_change;
create table t_monthly_change(
 id serial primary key Not Null
,closing_id integer Not Null
,closing_day date
,number varchar(6)
,birthday date
,current_change_date date
,payment_3before money
,payment_2before money
,payment_1before money
,current_health_basis money
,current_pension_basis money
,current_pension_fund_basis money
,salary_change_type integer
,salary_change_amount money
,salary_change_date date
,change_history_id integer
,delete_flag varchar(1) default '0' Not Null
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table t_monthly_change is '月額変動';
comment on column t_monthly_change.id is 'レコードID	AUTO_INCREMENT';
comment on column t_monthly_change.closing_id is '締めID	';
comment on column t_monthly_change.closing_day is '締め作業日';
comment on column t_monthly_change.number is '番号';
comment on column t_monthly_change.birthday is '生年月日';
comment on column t_monthly_change.current_change_date is '現改定日';
comment on column t_monthly_change.payment_3before is '3ヶ月前支給額';
comment on column t_monthly_change.payment_2before is '2ヶ月前支給額';
comment on column t_monthly_change.payment_1before is '1ヶ月前支給額';
comment on column t_monthly_change.current_health_basis is '現在健康保険標準月額';
comment on column t_monthly_change.current_pension_basis is '現在厚生年金標準月額';
comment on column t_monthly_change.current_pension_fund_basis is '現在厚生年金基金標準月額';
comment on column t_monthly_change.salary_change_type is '昇(降)給区分';
comment on column t_monthly_change.salary_change_amount is '昇(降)給金額';
comment on column t_monthly_change.salary_change_date is '昇(降)給年月日';
comment on column t_monthly_change.change_history_id is '異動履歴ID';
comment on column t_monthly_change.delete_flag is '削除フラグ';
comment on column t_monthly_change.insert_datetime is '登録日時';
comment on column t_monthly_change.update_datetime is '更新日時';
comment on column t_monthly_change.insert_user is '作成者';
comment on column t_monthly_change.update_user is '更新者';

drop index if exists t_monthly_change_Idx1;
create unique index t_monthly_change_Idx1 on t_monthly_change (change_history_id);

/* 市区町村マスタ */
drop table if exists m_municipality;
create table m_municipality(
 id serial primary key Not Null
,city_code varchar(5)
,validate_flag varchar(1)
,pref text
,pref_kana text
,municipality text
,municipality_kana text
,search1 text
,search2 text
,delete_flag varchar(1) default '0' Not Null
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table m_municipality is '市区町村マスタ';
comment on column m_municipality.id is 'レコードID	AUTO_INCREMENT';
comment on column m_municipality.city_code is '市区町村コード';
comment on column m_municipality.validate_flag is '有効フラグ';
comment on column m_municipality.pref is '都道府県';
comment on column m_municipality.pref_kana is '都道府県カナ';
comment on column m_municipality.municipality is '市区町村';
comment on column m_municipality.municipality_kana is '市区町村カナ';
comment on column m_municipality.search1 is '検索1';
comment on column m_municipality.search2 is '検索2';
comment on column m_municipality.delete_flag is '削除フラグ';
comment on column m_municipality.insert_datetime is '登録日時';
comment on column m_municipality.update_datetime is '更新日時';
comment on column m_municipality.insert_user is '作成者';
comment on column m_municipality.update_user is '更新者';

drop index if exists m_municipality_Idx1;
create unique index m_municipality_Idx1 on m_municipality (city_code);

/* メンバー情報 */
drop table if exists t_member;
create table t_member(
 id serial primary key Not Null
,number varchar(6) Not Null
,seq integer
,party_name varchar(20)
,lastname text
,firstname text
,lastname_kana text
,firstname_kana text
,birthday date
,sex varchar(1)
,start_date date
,end_date date
,inner_line_number varchar(10)
,show_full_address_flag varchar(1)
,die_flag varchar(1)
,seizure_amount money
,delete_flag varchar(1) default '0' Not Null
,insert_datetime timestamp(6) without time zone default now() Not Null
,update_datetime timestamp(6) without time zone default now() Not Null
,insert_user text Not Null
,update_user text Not Null
);

comment on table t_member is 'メンバー情報';
comment on column t_member.id is 'レコードID	AUTO_INCREMENT';
comment on column t_member.number is '番号';
comment on column t_member.seq is 'SEQ';
comment on column t_member.party_name is 'パーティー名';
comment on column t_member.lastname is '姓';
comment on column t_member.firstname is '名';
comment on column t_member.lastname_kana is 'カナ姓';
comment on column t_member.firstname_kana is 'カナ名';
comment on column t_member.birthday is '生年月日';
comment on column t_member.sex is '性別	0:男　1:女';
comment on column t_member.start_date is '開始日';
comment on column t_member.end_date is '退職日';
comment on column t_member.inner_line_number is '内線番号';
comment on column t_member.show_full_address_flag is '住所完全表記フラグ	0:Off　1:On';
comment on column t_member.die_flag is '死亡フラグ	0:Off　1:On';
comment on column t_member.seizure_amount is '差押金額';
comment on column t_member.delete_flag is '削除フラグ';
comment on column t_member.insert_datetime is '登録日時';
comment on column t_member.update_datetime is '更新日時';
comment on column t_member.insert_user is '作成者';
comment on column t_member.update_user is '更新者';

drop index if exists information_Idx1;
create unique index information_Idx1 on t_member (number);

