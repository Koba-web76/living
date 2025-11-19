# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Tag.create([
  { name: '勉強・仕事' },
  { name: '自炊' },
  { name: '学生向け' },
  { name: '社会人向け' },
  { name: '新商品' },
  { name: '冬' },
  { name: '夏' },
  { name: '秋' },
  { name: '春' }
])
