package vo
{
	public class UserVO
	{
		public var id:String;
		
		public var login:String;
		public var pass:String;
		public var firstName:String;
		public var secondName:String;
		public var email:String;
		public var city:String;
		public var year:String;
		public var comment:String;
		
		public function UserVO(data:Object)
		{
			this.id = data.user_id;
			this.login = data.user_login;
			this.pass = data.user_pass;
			this.firstName = data.user_first;
			this.secondName = data.user_second;
			this.email = data.user_email;
			this.city = data.user_city;
			this.year = data.user_year;
			this.comment = data.user_comment;
		}
		
		
		
	}
}