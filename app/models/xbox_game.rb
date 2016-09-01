class XboxGame < ActiveRecord::Base
  belongs_to :user
  has_many :achievements, dependent: :destroy
end
