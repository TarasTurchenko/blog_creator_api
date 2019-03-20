# frozen_string_literal: true

# == Schema Information
#
# Table name: images
#
#  id   :bigint(8)        not null, primary key
#  file :string
#

class Image < ApplicationRecord
  mount_uploader :file, ImageUploader
end
