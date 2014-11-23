function login () {
	 var password = $("#password").val();
	 var email = $("#email").val();
	 $.ajax({
		  type: "POST",
		  url: "create",
		  data: {scout:{ email:email, password:password }},
		  success: function() {
		  	window.location.pathname = "/login";
        },
        error: function() {
        	console.log("NOPE");
        }
		})
}
;
