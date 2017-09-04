json.partial! 'partial/paginate_meta', object: @resources
json.items @resources do |user|
 json.(user, :id, :email)
end