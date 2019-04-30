# frozen_string_literal: true

class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_for(current_user)
  end

  def self.notify(user, type, message)
    NotificationsChannel.broadcast_to(user, type: type, message: message)
  end

  def self.notify_error(user, message)
    self.notify(user, :error, message)
  end

  def self.notify_success(user, message)
    self.notify(user, :success, message)
  end
end