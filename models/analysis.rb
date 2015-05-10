
class Analysis < ActiveRecord::Base
	belongs_to :pacient
	has_many :metrings
end
