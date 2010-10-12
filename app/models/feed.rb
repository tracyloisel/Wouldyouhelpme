class Feed < ActiveRecord::Base
  belongs_to  :user
  
  KIND_NEW_ACCOUNT      = 1
  KIND_NEW_POST         = 2
  KIND_UPDATE_POST      = 3
  KIND_DESTROY_POST     = 4
  
  KIND_NEW_COMMENT      = 5
  KIND_UPDATE_COMMENT   = 6
  KIND_DESTROY_COMMENT  = 7
  
  KIND_UPDATE_ACCOUNT   = 8
  
  KIND_NEW_FILE         = 9
  KIND_DESTROY_FILE     = 10
  
  KIND_ARCHIVE_POST     = 11
  
  KIND_UPDATE_STATUS    = 12
  
  KIND_SORT_POSTS       = 14
  
  def instanciate_object
    begin
      case self.kind
      when KIND_NEW_ACCOUNT, KIND_UPDATE_ACCOUNT, KIND_UPDATE_STATUS, KIND_SORT_POSTS
        @user = User.find self.object_id
      when KIND_NEW_POST, KIND_UPDATE_POST, KIND_DESTROY_POST, KIND_ARCHIVE_POST
        @post = Post.find self.object_id
      when KIND_NEW_COMMENT, KIND_UPDATE_COMMENT, KIND_DESTROY_COMMENT
        @comment = Comment.find self.object_id
      when KIND_NEW_FILE, KIND_DESTROY_FILE
        @asset = Asset.find self.object_id
      end
    rescue
      nil
    end
  end
  
  def message
    if self.instanciate_object then
      
      case self.kind
      when KIND_NEW_ACCOUNT
        "#{@user.name} just signed up. Send #{@user.gender_pronom} a cheers at #{@user.email} :-)"
      when KIND_UPDATE_ACCOUNT
        "Hey psst... #{@user.login} has update #{@user.gender_pronom} profile at #{@user.updated_at.strftime('%Hh:%Mm:%Ss')}. Have a look at #{@user.profile_url} !"
      when KIND_UPDATE_STATUS
        "#{@user.status}, #{@user.gender} said."
      when KIND_SORT_POSTS
        "#{@user.login} sort posts at #{self.created_at.strftime('%Hh:%Mm:%Ss')}"
      when KIND_NEW_POST
        "#{@post.user.login} add a new post titled #{@post.title}. Never miss the news."
      when KIND_UPDATE_POST
        "#{@post.user.login} updated his post titled #{@post.title} at #{@post.updated_at.strftime('%Hh:%Mm:%Ss')}. Do you vote for the changement ?"
      when KIND_DESTROY_POST
        "Hmm, that's embarrassing... #{@post.user.login} destroyed his post titled #{@post.title}."
      when KIND_ARCHIVE_POST
        "Conversations around the post titled #{@post.title} are now closed since the post has been archived by #{self.user.login}"
      when KIND_NEW_COMMENT
        "#{@comment.user.login} add a new comment and warm conversations around the post titled #{@comment.post.title}!"
      when KIND_UPDATE_COMMENT
        "#{@comment.user.login} updated #{@comment.user.gender_pronom} comment at #{@comment.updated_at.strftime('%Hh:%Mm:%Ss')} for the post titled #{@comment.post.title}!"
      when KIND_DESTROY_COMMENT
        "Hmm, it's embarrassing... #{@comment.user.login} destroyed his comment on the post titled #{@comment.post.title}."
      when KIND_NEW_FILE
        "Yeah ! One new file to download thanks to #{@asset.user.login} : << #{@asset.post.content} >>"
      when KIND_DESTROY_FILE
        "Ouch ! #{@asset.user.login} has destroyed the file #{@asset.gender_subject} uploaded the day #{@asset.created_at.strftime('%d/%m/%Y')} : << #{@asset.post.content} >>"
      end
    end
  end
  
  def self.create_comment(comment)
    _feed = Feed.create(:user_id => comment.user_id, :kind => KIND_NEW_COMMENT, :object_id => comment.id)
  end
  
  def self.update_comment(comment)
    _feed = Feed.create(:user_id => comment.user_id, :kind => KIND_UPDATE_COMMENT, :object_id => comment.id)
  end
  
  def self.destroy_comment(comment)
    _feed = Feed.create(:user_id => comment.user_id, :kind => KIND_DESTROY_COMMENT, :object_id => comment.id)
  end
  
  def self.create_post(post)
    _feed = Feed.create(:user_id => post.user_id, :kind => KIND_NEW_POST, :object_id => post.id)
  end
  
  def self.update_post(post)
    _feed = Feed.create(:user_id => post.user_id, :kind => KIND_UPDATE_POST, :object_id => post.id)
  end
  
  def self.destroy_post(post)
    _feed = Feed.create(:user_id => post.user_id, :kind => KIND_DESTROY_POST, :object_id => post.id)
  end

  def self.archive_post(post)
    _feed = Feed.create(:user_id => post.user_id, :kind => KIND_ARCHIVE_POST, :object_id => post.id)
  end
  
  def self.sort_posts(user)
    _feed = Feed.create(:user_id => user.id, :kind => KIND_SORT_POSTS, :object_id => user.id)
  end
  
  def self.create_asset(asset)
    _feed = Feed.create(:user_id => asset.user_id, :kind => KIND_NEW_FILE, :object_id => asset.id)
  end
    
  def self.destroy_asset(asset)
    _feed = Feed.create(:user_id => asset.user_id, :kind => KIND_DESTROY_FILE, :object_id => asset.id)
  end
  
  def self.create_user(user)
    _feed = Feed.create(:user_id => user.id, :kind => KIND_NEW_ACCOUNT, :object_id => user.id)
  end
  
  def self.update_user(user)
    _feed = Feed.create(:user_id => user.id, :kind => KIND_UPDATE_ACCOUNT, :object_id => user.id)    
  end
  
  def self.update_status(user)
    _feed = Feed.create(:user_id => user.id, :kind => KIND_UPDATE_STATUS, :object_id => user.id)
  end
end