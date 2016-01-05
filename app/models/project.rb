class Project < ActiveRecord::Base
	has_many :data
	belongs_to :user
end
