class VolleyMailer < ActionMailer::Base
default from: "support@volleystats.com"
  
  def send_email(name, email, content, category)
    @name = name
    @email = email    
    @body = content
    @category = category
    mail(to: "volleystatsbg@gmail.com", subject: "Question/Feedback")

end
end