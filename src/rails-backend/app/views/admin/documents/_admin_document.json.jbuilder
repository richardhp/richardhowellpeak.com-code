json.extract! admin_document, :id, :title, :description, :blurb, :content, :created_at, :updated_at
json.url admin_document_url(admin_document, format: :json)
