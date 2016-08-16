class AddRequestToTransaction < ActiveRecord::Migration
  def change
    add_reference :transactions, :request, index: true, foreign_key: true
  end
end
