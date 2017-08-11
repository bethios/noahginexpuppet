require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) {Post.create!(title: 'test about post', body: 'test about post body', category: 1)}

  describe "attributes" do
    it "has title, body and category attributes" do
      expect(post).to have_attributes(title: "test about post", body: "test about post body", category: 1)
    end
  end
end
