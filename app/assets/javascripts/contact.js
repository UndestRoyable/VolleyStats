function sendMail (){
  $.ajax({
      type: "POST",
      url: "/email",
      data: { name:$("#name").val(), email:$("#email").val(),body:$("#body").val(), category:$("#category").val() }
    }).done(function(data) {
    alert(data);
       
    });
}

    function submitMail (){
      sendMail();
      alert ("Вашето съобщение е изпратено! ")

  }
    



      /*$(".myfirstform").validate(
  {rules:
  {name:"required",
  email:{required:true,email:true},
  category:"required",
  body:{required:true, maxlength:300
  }},
  errorClass:"error",
  highlight: function(label) {
      $(label).closest('.form-group').removeClass('has-success').addClass('has-error');
    },

  success: function(label) {
      sendMail();
      alert ("Sent!")
    }
  }
    
  )*/

 
        



