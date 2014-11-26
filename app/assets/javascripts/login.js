function login () {
	 var password = $("#password").val();
	 var email = $("#email").val();
	 $.ajax({
		  type: "POST",
		  url: "create",
      beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		  data: {scout:{ email:email, password:password }},
		  success: function() {
		  	window.location.pathname = "/login";
        },
        error: function() {
        	console.log("NOPE");
        }
		})
}