class AddPolymorphRefToResponse < ActiveRecord::Migration
  def change
    add_reference :responses, :user_input, polymorphic: true, index: true
  end
end
