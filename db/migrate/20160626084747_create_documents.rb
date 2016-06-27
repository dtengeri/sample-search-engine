class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.text :body
    end
  end
end
