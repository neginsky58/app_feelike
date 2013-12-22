class Notifications < ActiveRecord::Base
  attr_accessible :is_read, :is_sent, :ue_id, :user_id,:ref_user_id,:notification_status_id

  def self.getNotifications(user_id,page) 
  	userObject= User.getFullUserData(user_id)
    fullname =  userObject[:fname] + " , " + userObject[:lname]
    items = Array.new
    data = self.where({is_sent:true}).order("notifications.is_read desc,notifications.created_at desc").page(page).per(APP_CONFIG["Max_Page"])
    data.each do |item|
      message = ""
      notification_object = NotificationsStatus.where({:id=> item.notification_status_id}).first
      if notification_object.is_feelike 
        message = I18n.t("errors.messages.notifications.feelike") % [fullname]
      end
      if notification_object.is_following 
        message = I18n.t("errors.messages.notifications.following") % [fullname]
      end
      if notification_object.is_ue_following 
        message = I18n.t("errors.messages.notifications.ue_following") % [fullname]
      end
      if notification_object.is_ue_p 
        message = I18n.t("errors.messages.notifications.ue_p") % [fullname]
      end
      items.push({
        message: message,
        user_id: item.user_id,
        ref_user_id: item.ref_user_id,
        ue_id: item.ue_id,
        status: notification_object.id
      })
    end
    #reset the notification that will not be seen
    self.where({is_sent:true,is_read:false}).each do |item|
      item.is_read = true
      item.save
    end

    itemsObject = {
      items: items,
      total: data.num_pages
    }
    itemsObject
  end

  def self.createNotification(user_id,ref_user_id,ue_id,notification_status)
    userObject= User.getFullUserData(user_id)
    ref_userObject = User.getFullUserData(ref_user_id) unless ref_user_id.nil? || ref_user_id.to_i == 0
    userDataObject =  UsersSettings.byUser(user_id).first
    ref_userDataObject =  UsersSettings.byUser(ref_user_id).first
    notificationObject =Notifications.new({is_sent: false ,is_read: false, ue_id: ue_id , user_id:user_id,notification_status_id:notification_status,ref_user_id:ref_user_id})
    notificationObject.save
    totalCount = Notifications.where({is_sent: false , user_id:user_id}).size
    puts " ========================="
    puts " ========================="
    puts " ========================="
    puts " Dear User %s a New Push Sent to Token %s And Has Total of notifiction , %d" % [userObject[:fname] + " , " + userObject[:lname], userDataObject.mobile_token,totalCount]
    puts " ========================="
    puts " ========================="
    puts " ========================="
    #self.push_total(totalCount, userObject,ref_userObject, userDataObject,notification_status)
    self.send_status(totalCount,userObject,ref_userObject,ref_userDataObject,userDataObject,notification_status)
    notificationObject.is_sent = true
    notificationObject.save #its notification been  sent!
  end
  private 
  def self.send_status( total ,userObject,ref_userObject,ref_userDataObject,userDataObject,notification_status) 
    #fullname = userObject[:fname] + " , " + userObject[:lname]
    notification_object = NotificationsStatus.where({:id=> notification_status}).first
    #self.locate_send_email(userObject,ref_userObject,ref_userDataObject,userDataObject,notification_object)
    self.locate_send_push(total,userObject,ref_userObject,ref_userDataObject,userDataObject,notification_object)
  end

  def self.locate_send_email(userObject,ref_userObject,ref_userDataObject,userDataObject,notification_object) 
    if notification_object.is_feelike 
      if userDataObject.feelings_status == 2 || userDataObject.feelings_status == 4
        self.send_feelike_mail(ref_userObject[:email], ref_userObject[:fname] + " , " + ref_userObject[:lname]) unless !userDataObject.feelings_status
      end
    end
    if notification_object.is_following 
      if userDataObject.follows_status == 2 || userDataObject.follows_status == 4
        self.send_following_mail(ref_userObject[:email], ref_userObject[:fname] + " , " + ref_userObject[:lname], ref_userObject[:fname] + " , " + ref_userObject[:lname]) unless !userDataObject.follows_status
      end
    end
    if notification_object.is_ue_following 
      if userDataObject.experience_status == 2 || userDataObject.experience_status == 4
        self.send_ue_experience_mail(ref_userObject[:email], ref_userObject[:fname] + " , " + ref_userObject[:lname], ref_userObject[:fname] + " , " + ref_userObject[:lname]) unless !userDataObject.experience_status
      end
    end
    if notification_object.is_ue_p 
      if userDataObject.experience_p_status == 2 || userDataObject.experience_p_status == 4
        self.send_ue_p_mail(ref_userObject[:email], userObject[:fname] + " , " + userObject[:lname], ref_userObject[:fname] + " , " + ref_userObject[:lname]) unless !userDataObject.experience_p_status
      end
    end
  end

  def self.locate_send_push(total ,userObject,ref_userObject,ref_userDataObject,userDataObject,notification_object) 
    message = ""
    token = ref_userDataObject.mobile_token
    is_quiet = false
    fullname =  ref_userObject[:fname] + " , " + ref_userObject[:lname]
    if notification_object.is_feelike 
      message = I18n.t("errors.messages.notifications.feelike") % [fullname]
      is_quiet = true unless userDataObject.feelings_status == 2 || userDataObject.feelings_status == 4
    end
    if notification_object.is_following 
      message = I18n.t("errors.messages.notifications.following") % [fullname]
      is_quiet = true unless userDataObject.follows_status == 2 || userDataObject.follows_status == 4
    end
    if notification_object.is_ue_following 
      message = I18n.t("errors.messages.notifications.ue_following") % [fullname]
      is_quiet = true unless userDataObject.is_feelings_email == 2 || userDataObject.is_feelings_email == 4
    end
    if notification_object.is_ue_p 
      message = I18n.t("errors.messages.notifications.ue_p") % [fullname]
      is_quiet = true unless userDataObject.is_feelings_email == 2 || userDataObject.is_feelings_email == 4
    end
    self.send_push(ref_userObject,total , message , token,is_quiet)
  end

  def self.send_push(userDataObject,total,message,token,is_quiet)
    notification_object = {
      app: 'feelike_applciation',
      device: token,
      alert: '',
      sound: false,
      badge: total,
      expiry: 1.day.to_i, 
      attributes_for_device: {key: 'MSG'}
    }
    unless is_quiet
      notification_object[:sound] = 'notifsound.mp3'
      notification_object[:alert] = message
    end
    Push::MessageApns.create(notification_object)
  end

  def self.send_feelike_mail(email , fullname)
    Api::V1::Mailer::NotificationMailer.deliver_feelike(email , fullname).deliver
    #return if request.xhr?
  end

  def self.send_following_mail(email , fullname, byfullname)
    Api::V1::Mailer::NotificationMailer.deliver_fowllowing(email , fullname, byfullname).deliver
    #return if request.xhr?
  end        
  def self.send_experience_mail(email , fullname)
    Api::V1::Mailer::NotificationMailer.deliver_experience(email , fullname).deliver
    #return if request.xhr?
  end

  def self.send_ue_p_mail(email , fullname, byfullname)
    Api::V1::Mailer::NotificationMailer.deliver_ue_p(email , fullname, byfullname).deliver
    #return if request.xhr?
  end
end
