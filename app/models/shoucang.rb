class Shoucang < ActiveRecord::Base
  belongs_to :user
  belongs_to :transaction

  validates_presence_of :user_id, :transaction_id
end
