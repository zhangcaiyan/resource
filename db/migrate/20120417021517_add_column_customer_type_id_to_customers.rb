class AddColumnCustomerTypeIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :customer_type_id, :integer
  end
end
