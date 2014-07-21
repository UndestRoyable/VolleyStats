function login (argument) {
	 var password = $("#password").val();
	 var email = $("#email").val();
	 $.ajax({
		  type: "POST",
		  url: "create",
		  data: {email:email, password:password}
		}).done(function(data) {
		
		   
		});
}