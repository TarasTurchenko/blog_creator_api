# frozen_string_literal: true
# == Schema Information
#
# Table name: elements
#
#  id           :bigint(8)        not null, primary key
#  attrs        :jsonb
#  position     :integer          not null
#  size         :integer          not null
#  type         :string
#  container_id :integer          not null
#
# Indexes
#
#  index_elements_on_container_id  (container_id)
#

class Element
  class Image < Element
    def default_block_attrs
      {
        src: Constants::Images::PLACEHOLDER,
        alt: 'Placeholder image'
      }
    end
  end
end
