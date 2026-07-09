BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "branch_location" (
	"id"	integer NOT NULL,
	"address"	varchar(50) NOT NULL,
	"location"	varchar(30) NOT NULL,
	"postal_code"	varchar(20) NOT NULL,
	"district_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("district_id") REFERENCES "district"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "category" (
	"id"	integer NOT NULL,
	"category"	varchar(20) NOT NULL,
	"description"	text NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "district" (
	"id"	integer NOT NULL,
	"district"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "insure_policy" (
	"id"	integer NOT NULL,
	"provider_name"	varchar(30) NOT NULL,
	"policy_no"	varchar(50) NOT NULL,
	"start_date"	date NOT NULL,
	"end_date"	date NOT NULL,
	"coverage_detail"	varchar(150) NOT NULL,
	"machinery_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("machinery_id") REFERENCES "machinery"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "login_customer_model" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"phone"	bigint NOT NULL,
	"Address"	text NOT NULL,
	"CreatedAt"	datetime NOT NULL,
	"UpdatedAt"	datetime NOT NULL,
	"Login_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("Login_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "machinery" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL,
	"model"	varchar(100) NOT NULL,
	"year"	varchar(20) NOT NULL,
	"specific"	varchar(150) NOT NULL,
	"base_price_day"	integer NOT NULL,
	"created_at"	date NOT NULL,
	"gst"	varchar(20) NOT NULL,
	"img_url1"	varchar(100) NOT NULL,
	"img_url2"	varchar(100) NOT NULL,
	"branch_id"	bigint NOT NULL,
	"category_id"	bigint NOT NULL,
	"status"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("branch_id") REFERENCES "branch_location"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("category_id") REFERENCES "category"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "maintenance_logs" (
	"id"	integer NOT NULL,
	"descr"	varchar(150) NOT NULL,
	"service_date"	date NOT NULL,
	"cost"	integer NOT NULL,
	"next_due_date"	date NOT NULL,
	"machinery_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("machinery_id") REFERENCES "machinery"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "rental_booking" (
	"id"	integer NOT NULL,
	"start_date"	date NOT NULL,
	"end_date"	date NOT NULL,
	"status"	varchar(20) NOT NULL,
	"total_price"	integer NOT NULL,
	"created_at"	datetime NOT NULL,
	"customer_id"	integer NOT NULL,
	"machinery_id"	bigint NOT NULL,
	"payment_status"	varchar(20) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("customer_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("machinery_id") REFERENCES "machinery"("id") DEFERRABLE INITIALLY DEFERRED
);
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,3,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,3,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,3,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,3,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,2,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,2,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,2,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,2,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_category_model','Can add category_model');
INSERT INTO "auth_permission" VALUES (26,7,'change_category_model','Can change category_model');
INSERT INTO "auth_permission" VALUES (27,7,'delete_category_model','Can delete category_model');
INSERT INTO "auth_permission" VALUES (28,7,'view_category_model','Can view category_model');
INSERT INTO "auth_permission" VALUES (29,8,'add_district_model','Can add district_model');
INSERT INTO "auth_permission" VALUES (30,8,'change_district_model','Can change district_model');
INSERT INTO "auth_permission" VALUES (31,8,'delete_district_model','Can delete district_model');
INSERT INTO "auth_permission" VALUES (32,8,'view_district_model','Can view district_model');
INSERT INTO "auth_permission" VALUES (33,10,'add_insure_policy_model','Can add insure_policy_model');
INSERT INTO "auth_permission" VALUES (34,10,'change_insure_policy_model','Can change insure_policy_model');
INSERT INTO "auth_permission" VALUES (35,10,'delete_insure_policy_model','Can delete insure_policy_model');
INSERT INTO "auth_permission" VALUES (36,10,'view_insure_policy_model','Can view insure_policy_model');
INSERT INTO "auth_permission" VALUES (37,9,'add_branch_location_model','Can add branch_location_model');
INSERT INTO "auth_permission" VALUES (38,9,'change_branch_location_model','Can change branch_location_model');
INSERT INTO "auth_permission" VALUES (39,9,'delete_branch_location_model','Can delete branch_location_model');
INSERT INTO "auth_permission" VALUES (40,9,'view_branch_location_model','Can view branch_location_model');
INSERT INTO "auth_permission" VALUES (41,12,'add_maintenance_log_model','Can add maintenance_log_model');
INSERT INTO "auth_permission" VALUES (42,12,'change_maintenance_log_model','Can change maintenance_log_model');
INSERT INTO "auth_permission" VALUES (43,12,'delete_maintenance_log_model','Can delete maintenance_log_model');
INSERT INTO "auth_permission" VALUES (44,12,'view_maintenance_log_model','Can view maintenance_log_model');
INSERT INTO "auth_permission" VALUES (45,11,'add_machinery_model','Can add machinery_model');
INSERT INTO "auth_permission" VALUES (46,11,'change_machinery_model','Can change machinery_model');
INSERT INTO "auth_permission" VALUES (47,11,'delete_machinery_model','Can delete machinery_model');
INSERT INTO "auth_permission" VALUES (48,11,'view_machinery_model','Can view machinery_model');
INSERT INTO "auth_permission" VALUES (49,13,'add_customer_model','Can add customer_model');
INSERT INTO "auth_permission" VALUES (50,13,'change_customer_model','Can change customer_model');
INSERT INTO "auth_permission" VALUES (51,13,'delete_customer_model','Can delete customer_model');
INSERT INTO "auth_permission" VALUES (52,13,'view_customer_model','Can view customer_model');
INSERT INTO "auth_permission" VALUES (53,14,'add_rental_booking_model','Can add rental_booking_model');
INSERT INTO "auth_permission" VALUES (54,14,'change_rental_booking_model','Can change rental_booking_model');
INSERT INTO "auth_permission" VALUES (55,14,'delete_rental_booking_model','Can delete rental_booking_model');
INSERT INTO "auth_permission" VALUES (56,14,'view_rental_booking_model','Can view rental_booking_model');
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$1200000$4UeDstY5xG3xOL3grSP0nG$79NLKZ9yyDz2MmeXzV2hi6KIeiCGNdmXuMftW+crhcs=',NULL,0,'adith','','',0,1,'2026-05-14 06:17:50.631677','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$1200000$XBmLVXNQLnBDnr7kjQYfhq$/qPHps0xpRJj3k+qS1SCmyZTt2JdB93ybawG3D5WDLs=','2026-05-30 05:10:42.706560',1,'adith123','','adithe84@gmail.com',1,1,'2026-05-30 04:42:02.941412','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$1200000$HR7qk3yuniq0tfYF1cxnfF$WxZOKbMDqFkO8RRi8nOZ15yKpAiu8pNEF9BQQ2nsh5w=','2026-07-02 04:35:52.452617',1,'admin','','',0,1,'2026-05-30 04:54:28.653560','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$1200000$lKBVgyWAE9delSkvP1YzEg$SAgp6M7YxRLwg7IJF2R4al3/HXakH3+QvVefckozP2E=','2026-07-02 05:54:46.754964',0,'user','','',0,1,'2026-07-02 03:12:37.328755','');
INSERT INTO "branch_location" VALUES (2,'NH Bypass Road, Edappally, Kochi','Edappally','682024',4);
INSERT INTO "branch_location" VALUES (3,'Near Railway Station, Punkunnam, Thrissur','Punkunnam','680002',5);
INSERT INTO "branch_location" VALUES (4,'InfoPark Road, Kakkanad, Kochi','Kakkanad','682030',4);
INSERT INTO "branch_location" VALUES (5,'Bank Junction, Aluva, Ernakulam','Aluva','683101',4);
INSERT INTO "branch_location" VALUES (6,'KSRTC Road, Irinjalakuda, Thrissur','Irinjalakuda','680121',5);
INSERT INTO "branch_location" VALUES (7,'MC Road, Ettumanoor, Kottayam','Ettumanoor','686631',10);
INSERT INTO "branch_location" VALUES (8,'College Road, Pala, Kottayam','Pala','686575',10);
INSERT INTO "branch_location" VALUES (9,'Main Road, Cherthala, Alappuzha','Cherthala','688524',9);
INSERT INTO "branch_location" VALUES (10,'Bus Stand Road, Ottapalam, Palakkad','Ottapalam','679101',12);
INSERT INTO "branch_location" VALUES (11,'Main Bazaar Road, Chittur, Palakkad','Chittur','678101',12);
INSERT INTO "branch_location" VALUES (12,'National Highway Road, Thalassery, Kannur','Thalassery','670101',15);
INSERT INTO "branch_location" VALUES (13,'Beach Road, Koyilandy, Kozhikode','Koyilandy','673305',2);
INSERT INTO "branch_location" VALUES (14,'Jubilee Road, Perinthalmanna, Malappuram','Perinthalmanna','679322',13);
INSERT INTO "branch_location" VALUES (15,'Market Road, Thodupuzha, Idukki','Thodupuzha','685584',11);
INSERT INTO "branch_location" VALUES (16,'Technopark Main Road, Kazhakkoottam, TVM','Kazhakkoottam','695582',6);
INSERT INTO "category" VALUES (3,'Tractor','Powerful tractor suitable for ploughing and hauling heavy loads in large farms.');
INSERT INTO "category" VALUES (4,'Harvester','Advanced harvesting machine ideal for paddy and wheat harvesting.');
INSERT INTO "category" VALUES (5,'Tiller','Soil preparation machine used for loosening and mixing soil before planting.');
INSERT INTO "category" VALUES (6,'Transplanter','Automated equipment used for transplanting seedlings into agricultural fields.');
INSERT INTO "category" VALUES (7,'Plough','Farming implement used for turning and preparing soil for cultivation.');
INSERT INTO "category" VALUES (8,'Reaper','Crop cutting machine used during harvesting seasons for fast and efficient cutting.');
INSERT INTO "category" VALUES (9,'Seeder','Equipment designed for accurate seed placement and uniform sowing in fields.');
INSERT INTO "category" VALUES (10,'Irrigation Equipment','Machinery used for supplying and distributing water to agricultural lands.');
INSERT INTO "category" VALUES (11,'Sprayer','Agricultural spraying machine used for pesticides, herbicides, and fertilizers.');
INSERT INTO "category" VALUES (12,'Excavator','Heavy machinery used for digging, trenching, and land clearing operations.');
INSERT INTO "category" VALUES (13,'Excavator','Heavy machinery used for digging, trenching, and land clearing operations.');
INSERT INTO "category" VALUES (14,'Climber','Specialized equipment used for climbing coconut and arecanut trees safely.');
INSERT INTO "category" VALUES (15,'Cutter','Agricultural machine designed for cutting crops like sugarcane and grass.');
INSERT INTO "category" VALUES (16,'Spreader','Equipment used for evenly spreading fertilizers, seeds, or compost materials.');
INSERT INTO "category" VALUES (17,'Trailer','Transport equipment used for carrying crops, fertilizers, and farm materials.');
INSERT INTO "category" VALUES (18,'Dairy Equipment','Machinery used in dairy farms for milk extraction and processing activities.');
INSERT INTO "district" VALUES (2,'Kozhikode');
INSERT INTO "district" VALUES (4,'Ernamkulam');
INSERT INTO "district" VALUES (5,'Thrissur');
INSERT INTO "district" VALUES (6,'Thiruvananthapuram');
INSERT INTO "district" VALUES (7,'Kollam');
INSERT INTO "district" VALUES (8,'Pathanamthitta');
INSERT INTO "district" VALUES (9,'Alappuzha');
INSERT INTO "district" VALUES (10,'Kottayam');
INSERT INTO "district" VALUES (11,'Idukki');
INSERT INTO "district" VALUES (12,'Palakkad');
INSERT INTO "district" VALUES (13,'Malappuram');
INSERT INTO "district" VALUES (14,'Wayanad');
INSERT INTO "district" VALUES (15,'Kannur');
INSERT INTO "district" VALUES (16,'Kasaragod');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','group');
INSERT INTO "django_content_type" VALUES (3,'auth','permission');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'adminpanel','category_model');
INSERT INTO "django_content_type" VALUES (8,'adminpanel','district_model');
INSERT INTO "django_content_type" VALUES (9,'adminpanel','branch_location_model');
INSERT INTO "django_content_type" VALUES (10,'adminpanel','insure_policy_model');
INSERT INTO "django_content_type" VALUES (11,'adminpanel','machinery_model');
INSERT INTO "django_content_type" VALUES (12,'adminpanel','maintenance_log_model');
INSERT INTO "django_content_type" VALUES (13,'login','customer_model');
INSERT INTO "django_content_type" VALUES (14,'adminpanel','rental_booking_model');
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2026-05-07 06:03:30.181733');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2026-05-07 06:03:30.185074');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2026-05-07 06:03:30.187232');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2026-05-07 06:03:30.190228');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2026-05-07 06:03:30.191918');
INSERT INTO "django_migrations" VALUES (6,'adminpanel','0001_initial','2026-05-07 06:03:30.192559');
INSERT INTO "django_migrations" VALUES (7,'contenttypes','0002_remove_content_type_name','2026-05-07 06:03:30.196340');
INSERT INTO "django_migrations" VALUES (8,'auth','0002_alter_permission_name_max_length','2026-05-07 06:03:30.199621');
INSERT INTO "django_migrations" VALUES (9,'auth','0003_alter_user_email_max_length','2026-05-07 06:03:30.202167');
INSERT INTO "django_migrations" VALUES (10,'auth','0004_alter_user_username_opts','2026-05-07 06:03:30.203564');
INSERT INTO "django_migrations" VALUES (11,'auth','0005_alter_user_last_login_null','2026-05-07 06:03:30.205697');
INSERT INTO "django_migrations" VALUES (12,'auth','0006_require_contenttypes_0002','2026-05-07 06:03:30.205979');
INSERT INTO "django_migrations" VALUES (13,'auth','0007_alter_validators_add_error_messages','2026-05-07 06:03:30.207403');
INSERT INTO "django_migrations" VALUES (14,'auth','0008_alter_user_username_max_length','2026-05-07 06:03:30.209717');
INSERT INTO "django_migrations" VALUES (15,'auth','0009_alter_user_last_name_max_length','2026-05-07 06:03:30.212030');
INSERT INTO "django_migrations" VALUES (16,'auth','0010_alter_group_name_max_length','2026-05-07 06:03:30.214086');
INSERT INTO "django_migrations" VALUES (17,'auth','0011_update_proxy_permissions','2026-05-07 06:03:30.215720');
INSERT INTO "django_migrations" VALUES (18,'auth','0012_alter_user_first_name_max_length','2026-05-07 06:03:30.217791');
INSERT INTO "django_migrations" VALUES (19,'sessions','0001_initial','2026-05-07 06:03:30.218642');
INSERT INTO "django_migrations" VALUES (20,'adminpanel','0002_district_model','2026-05-12 05:23:09.878993');
INSERT INTO "django_migrations" VALUES (21,'adminpanel','0003_branch_location_model_machinery_model_and_more','2026-05-14 01:36:00.889166');
INSERT INTO "django_migrations" VALUES (22,'login','0001_initial','2026-05-14 05:58:11.940946');
INSERT INTO "django_migrations" VALUES (23,'adminpanel','0004_rental_booking_model','2026-06-26 07:30:15.238778');
INSERT INTO "django_migrations" VALUES (24,'adminpanel','0005_update_machinery_status_choices','2026-06-26 07:35:13.748920');
INSERT INTO "django_migrations" VALUES (25,'adminpanel','0006_booking_payment_status','2026-07-02 02:54:11.840027');
INSERT INTO "django_session" VALUES ('c59l9vpgiqe27646vgeeu3sd49mssli0','.eJxVjEEOwiAQRe_C2pChgMO4dO8ZmgFGqRpISrsy3l2bdKHb_977LzXyupRx7TKPU1YnZdXhd4ucHlI3kO9cb02nVpd5inpT9E67vrQsz_Pu_h0U7uVbO28hUSSfPHuIYgwYloFInGHmI4WEAOGKEDGiJcjoUZB44ODQJPX-AM8aN0E:1wVki4:rfrFqrSQE0ULsR7c-ZGKWw5vSXNviuAjjQ3D7FGjlOY','2026-06-20 06:40:44.472314');
INSERT INTO "django_session" VALUES ('o9k752vdb6oi42qr7gz3si552fnfoujb','.eJxVjEEOwiAQRe_C2pChgMO4dO8ZmgFGqRpISrsy3l2bdKHb_977LzXyupRx7TKPU1YnZdXhd4ucHlI3kO9cb02nVpd5inpT9E67vrQsz_Pu_h0U7uVbO28hUSSfPHuIYgwYloFInGHmI4WEAOGKEDGiJcjoUZB44ODQJPX-AM8aN0E:1wZN98:nq_RxrhV0OzQeBelDSRr0GzKhVwgEF41EiPrSvojlNA','2026-06-30 06:19:38.268659');
INSERT INTO "django_session" VALUES ('jdwlrhfad33hce2nicd10xpqdz35rx7j','.eJxVjMsOwiAQRf-FtSE8SqEu3fsNZIYZpGogKe3K-O_apAvd3nPOfYkI21ri1nmJM4mzGMTpd0NID647oDvUW5Op1XWZUe6KPGiX10b8vBzu30GBXr61QhvID9k41oaUdynbyYMK4JxOGQFAG6cDeGampDz50eRpDMgMzqJ4fwDrcjiN:1wfANq:eC5ZoN-NduBeqhw9UpQsE0FWvm88TkOs3ZutAuLruVs','2026-07-16 05:54:46.756146');
INSERT INTO "insure_policy" VALUES (2,'New India Assurance','789396457821007','2026-07-02','2027-07-01','Liability',2);
INSERT INTO "login_customer_model" VALUES (1,'test','test2@gmail.com',1111111111,'7RF5+472
Tondayad NH66, Four square Building ,2nd & 3 rd floors,Near star care hospital
Kozhikode Bypass
Thondayad','2026-05-14 06:17:50.810976','2026-05-14 06:17:50.810983',1);
INSERT INTO "login_customer_model" VALUES (2,'test3','test3@gmail.com',1234567890,'test','2026-05-30 04:54:28.836567','2026-05-30 04:54:28.836573',3);
INSERT INTO "login_customer_model" VALUES (3,'user','user@gmail.com',1234567890,'users address','2026-07-02 03:12:37.527392','2026-07-02 03:12:37.527398',4);
INSERT INTO "machinery" VALUES (2,'Mahindra Tractor 575','575 DI XP Plus','2023','47 HP diesel engine, power steering, 6 forward gears, hydraulic lifting capacity 1600 kg',2500,'2026-07-02','5','https://i.pinimg.com/736x/fe/46/61/fe46615fa5e544ff91837db84aaac9e7.jpg','https://i.pinimg.com/736x/99/5b/df/995bdfbb5d5628ba876ea0be51d82016.jpg',2,3,'available');
INSERT INTO "machinery" VALUES (3,'John Deere Harvester','JD-H900','2022','6-row harvesting system, AC cabin, GPS support',8500,'2026-07-02','18','https://i.pinimg.com/1200x/f7/bd/24/f7bd24cf05a798f7d4c298343da198ba.jpg','https://i.pinimg.com/1200x/cf/5b/1e/cf5b1e7c5ed07d2abf61973df9ddd5e5.jpg',3,4,'available');
INSERT INTO "machinery" VALUES (4,'Kubota Power Tiller','KT-120','2024','12 HP engine, rotary blades, adjustable handle',1800,'2026-07-02','12','https://i.pinimg.com/1200x/1a/1a/d6/1a1ad6bd6a5e49fceff8433c841fda4d.jpg','https://i.pinimg.com/736x/5f/11/64/5f11645acf8978a61c454ef5f8b981e7.jpg',7,5,'booked');
INSERT INTO "machinery" VALUES (5,'Swaraj Tractor 744','744 FE','2021','50 HP engine, dual clutch, oil immersed brakes',2300,'2026-07-02','18','https://i.pinimg.com/736x/af/eb/04/afeb04b00ad5b370ae2296f69fffc6dc.jpg','https://i.pinimg.com/736x/c6/c5/d1/c6c5d1a360294842a412394e53a042dd.jpg',5,3,'available');
INSERT INTO "machinery" VALUES (6,'Rice Transplanter Pro','RTP-8','2023','8-row automatic transplanting system',4200,'2026-07-02','18','https://i.pinimg.com/736x/27/9d/58/279d58d6cfc11174d0b9b46c19496d10.jpg','https://i.pinimg.com/736x/72/5a/67/725a674742b480a1fb3dcf76f3bf3894.jpg',9,6,'maintenance');
INSERT INTO "machinery" VALUES (7,'Sonalika Mini Tractor','MM18','2022','Compact body, 18 HP engine for garden farming',1900,'2026-07-02','18','https://i.pinimg.com/1200x/f4/d1/23/f4d1239fb41aa1e9290826bc927ef3a3.jpg','https://i.pinimg.com/1200x/87/ec/2c/87ec2ccceec1f0fade51bbbfb5cfbe5b.jpg',10,3,'available');
INSERT INTO "machinery" VALUES (8,'Disc Plough Heavy Duty','DP-HD22','2024','3-disc plough system with heavy steel frame',1200,'2026-07-02','12','https://i.pinimg.com/1200x/71/9b/de/719bdeeb4c9718e6cec8338bc27d0141.jpg','https://i.pinimg.com/1200x/46/8a/ad/468aad5a13a1e02733ea29f9c3cf9769.jpg',4,7,'available');
INSERT INTO "maintenance_logs" VALUES (2,'Engine oil change and hydraulic system inspection','2026-07-23',4500,'2026-08-23',2);
INSERT INTO "rental_booking" VALUES (1,'2026-07-03','2026-07-09','approved',17500,'2026-07-02 04:46:58.753744',4,2,'unpaid');
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "branch_location_district_id_6e08a224" ON "branch_location" (
	"district_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "insure_policy_machinery_id_3638ca4a" ON "insure_policy" (
	"machinery_id"
);
CREATE INDEX IF NOT EXISTS "machinery_branch_id_d3766272" ON "machinery" (
	"branch_id"
);
CREATE INDEX IF NOT EXISTS "machinery_category_id_486adf6e" ON "machinery" (
	"category_id"
);
CREATE INDEX IF NOT EXISTS "maintenance_logs_machinery_id_a968ad63" ON "maintenance_logs" (
	"machinery_id"
);
CREATE INDEX IF NOT EXISTS "rental_booking_customer_id_8f5e4464" ON "rental_booking" (
	"customer_id"
);
CREATE INDEX IF NOT EXISTS "rental_booking_machinery_id_d2f85810" ON "rental_booking" (
	"machinery_id"
);
COMMIT;
