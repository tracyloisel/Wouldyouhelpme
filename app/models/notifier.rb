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
    subject "#{comment.user.login} added recently his opinion on the post titled #{comment.post.title}"
    from "#{comment.user.email}"

    _emails = comment.post.comments.collect{|c| c.email}

    _emails << comment.post.email if comment.post.mail_me_comments

    recipients _emails.join(",")

    content_type 'text/html'    
    body :comment => comment, :post => comment.post, :user => comment.user
  end
  
  def new_post(post, recipient_user = nil)
    subject "It may be a scoop : #{post.title}"
    from "www.wouldyouhelp.me@gmail.com"
    content_type 'text/html'
    
    if recipient_user.nil? then
      recipients User.all.collect{|u| u.email}
      body :post => post, :user => nil
    else
      recipients recipient_user.email
      body :post => post, :user => recipient_user
    end
  end
end
