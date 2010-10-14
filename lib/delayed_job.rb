module DelayedJob
  class NotificationsNewAccount < Struct.new(:user_id)
    def perform
      @user = User.find user_id
      
      if @user then
        Notifier.deliver_validate_email(@user)
        Notifier.deliver_godfather_activate_account(@user)
        Notifier.deliver_account_infos(@user)
      end
    end
  end
  
  class NotifyAccountInfos < Struct.new(:user_id)
    def perform
      @user = User.find user_id
      Notifier.deliver_account_infos(@user) if @user
    end
  end
  
  class MailNewComment < Struct.new(:comment_id)
    def perform
      @comment = Comment.find(comment_id)
      Notifier.deliver_new_comment(@comment) if @comment
    end
  end

  class NotifyPost < Struct.new(:post_id)
    def perform
      @post = Post.find(post_id)
      
      User.all.each { |user| Notifier.deliver_new_post(@post, user) } if @post
    end
  end
end
