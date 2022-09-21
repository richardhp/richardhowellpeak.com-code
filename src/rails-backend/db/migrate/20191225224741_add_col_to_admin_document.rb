class AddColToAdminDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :admin_documents, :content, :jsonb
    add_column :admin_documents, :description, :string
    add_column :admin_documents, :blurb, :string
  end
end
