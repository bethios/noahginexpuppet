require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:project) {Project.create!(title: 'test about post', image: 'ron.png', category: 1)}
  photo = Rails.root.join("app/assets/images/ron.png").open


  describe "attributes" do
    it "has title, image and category attributes" do
      expect(project).to have_attributes(title: "test about post", image: photo, category: 1)
    end
  end
end
