# frozen_string_literal: true

class AddResourceIdToStaffs < ActiveRecord::Migration
  def change
    add_column :staffs, :resource_id, :integer
    add_column :staffs, :resource_type, :string

    add_index :staffs, [:resource_id, :resource_type]
  end
end
