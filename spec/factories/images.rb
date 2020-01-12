FactoryBot.define do
  factory :image  do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'public/images/test_image.jpg')) }
  end
end