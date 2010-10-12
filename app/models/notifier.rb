class Notifier < ActionMailer::Base
  layout 'notifier'
    
  def validate_email(user)
    subject "WouldYouHelp.Me - Please, could You validate your e-mail address ?"
    from "www.wouldyouhelp.me@gmail.com"
    recipients user.email
    
    content_type 'text/html'    
    body :user => user
  end
  
  def godfather_activate_account(user)
    subject "WouldYouHelp.Me - Do You know this buddy #{user.email} / #{user.login} ?"
    from "www.wouldyouhelp.me@gmail.com"
    recipients user.godfather_email

    content_type 'text/html'
    body :user => user
  end
  
  def account_infos(user)
    subject "WouldYouHelp.Me - Your account profile"
    from "www.wouldyouhelp.me@gmail.com"
    recipients user.email

    content_type 'text/html'
    body :user => user
  end
  
  def account_activated(user)
    subject "We have a good news for You!"
    from "www.wouldyouhelp.me@gmail.com"
    recipients user.email
    
    content_type 'text/html'
    body :user => user
  end
  
  def account_rejected(user)
    subject "Hmm, It is embarrassing..."
    from "www.wouldyouhelp.me@gmail.com"
    recipients user.email
    
    content_type 'text/html'    
    body :user => user
  end
  
  def new_comment(comment)
    subject "#{comment.user.login} says something interesting in the conversation ##{comment.post.id}"
    from "www.wouldyouhelp.me@gmail.com"
    
    _emails = comment.post.comments.collect{|c| c.email}
    
    recipients _emails.join(",")
    
    content_type 'text/html'    
    body :comment => comment, :post => comment.post, :user => comment.user
  end
end
