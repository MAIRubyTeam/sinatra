
class Pacient < ActiveRecord::Base
	has_and_belongs_to_many :doctors
	has_many :analysiss
end
