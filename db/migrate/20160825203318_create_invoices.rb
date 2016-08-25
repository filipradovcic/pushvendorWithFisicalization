class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|

      t.decimal :amount, :precision => 8, :scale => 2
      t.decimal :authorization_number
      t.text :payment_type
      t.text :comments
      t.text :uuid
      t.text :unique_identifier

      t.integer :sale_id


      t.timestamps
    end
  end
end
