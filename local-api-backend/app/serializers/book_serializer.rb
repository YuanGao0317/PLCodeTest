class BookSerializer < ActiveModel::Serializer
  attributes :id, :author, :categories, :lastCheckedOut, :lastCheckedOutBy, :publisher, :title, :url
end
