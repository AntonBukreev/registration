package states.registration
{
	import flash.geom.Orientation3D;
	
	import mx.validators.StringValidator;
	import mx.validators.ValidationResult;
	
	public class PassValidator extends StringValidator
	{
		public var original:String ="";
		
		public function PassValidator()
		{
			super();
		}
		
		override protected function doValidation(value:Object):Array
		{
			var results:Array = super.doValidation(value);
			
			// Return if there are errors
			// or if the required property is set to false and length is 0.
			var val:String = value ? String(value) : "";
			if (results.length > 0 || ((val.length == 0) && !required))
				return results;
			else
				return validatePass(this, value, null);
		}
		
		
		public function validatePass(validator:StringValidator,
											  value:Object,
											  baseField:String = null):Array
		{
			var results:Array = [];
			
			if (original != value)
			{
				results.push(new ValidationResult(true, baseField, "NotMatch", "Введенное значение не соответствует паролю"));
			}
			return results;
			
		}
	}
}