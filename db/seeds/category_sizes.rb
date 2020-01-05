require "csv"

CSV.foreach('db/category_sizes.csv', headers: true) do |row|
  CategorySize.create(
    category_id: row['category_id'],
    size_id: row['size_id'],
  )
end
