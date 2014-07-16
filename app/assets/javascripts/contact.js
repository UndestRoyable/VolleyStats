

$(document).ready(function(){
 $.validator.setDefaults({
submitHandler: function(form) {
    $.ajax({
		  type: "POST",
		  url: "email.php",
		  data: { 'val':$(".myfirstform").serializeJSON() }
		}).done(function(data) {
		alert(data);
		   
		});
  }

});
$(".myfirstform").validate(
{rules:
{name:"required",
email:{required:true,email:true},
website:{required:false,url:true},
cate:"required",
msg:{required:true, maxlength:300
}},
errorClass:"error",
highlight: function(label) {
    $(label).closest('.form-group').removeClass('has-success').addClass('has-error');
  },

success: function(label) {
    label
      .text('Seems Perfect!').addClass('valid')
	  .closest('.form-group').addClass('has-success');
      
  }
}
  
);

});


 
        $(window).on('load', function () {

            $('.selectpicker').selectpicker({
                'selectedText': 'cat'
            });

            // $('.selectpicker').selectpicker('hide');
        });



