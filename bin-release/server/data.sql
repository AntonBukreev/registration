create table users
	(
		user_id 	 int unsigned not null auto_increment primary key,
		user_login   text character set UTF8 not null,
		KEY index_login(user_login(20)),
		user_pass    text character set UTF8 not null,
		user_email   text character set UTF8 not null,
		user_first   text character set UTF8 not null,
		user_second  text character set UTF8 not null,
		user_year    int unsigned,
		user_city    text character set UTF8 not null,
		user_comment text character set UTF8 not null
		
	);
	
	
	
	


