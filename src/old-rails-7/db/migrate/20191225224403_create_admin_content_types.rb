class CreateAdminContentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :admin_content_types do |t|
      t.string :name
      t.integer :ordering

      t.timestamps
    end
  end
end
