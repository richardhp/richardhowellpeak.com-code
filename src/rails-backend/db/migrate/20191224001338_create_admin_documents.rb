class CreateAdminDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_documents do |t|
      t.string :title

      t.timestamps
    end
  end
end
