require 'rails_helper'

RSpec.describe Page, type: :model do
  it 'has a valid factory' do
    page = build(:page)
    expect(page.title.presence).to be_truthy
  end

  describe 'belonging to project' do
    it 'belongs to project' do
      page = build(:page)
      expect(page.project_id.presence).to be_truthy
    end

    it 'should not save without project' do
      page = build(:page, project_id: nil)
      expect(page.save).to be_falsey
    end
  end
  
  describe 'slugs' do
    
  end

  # describe "slugs" do
  #   # Rewrite to let
  #   page = create(:page, title: "New page for Test")
  #   it "when creates a slug" do
  #     expect(page.slug).to match("new-page-for-test")
  #     page.update(title: "new tItLe for PAGE")
  #     expect(page.slug).to match("new-title-for-page")
  #   end

  #   it "when page is untitled" do
  #     page = create(:page, title: nil)
  #     expect(page.slug.presence).to be_truthy
  #   end
  # end

  # it "when tree of ordered pages" do
  #   page_1 = create(:page, title: "Page 1")
  #   expect(page_1.position).to eq(1)
  #   page_2 = create(:page, title: "Page 2")
  #   expect(page_2.position).to eq(2)
  #   page_3 = create(:page, title: "Page 3")
  #   expect(page_3.position).to eq(3)

  #   page_1_1 = create(:page, title: "Page 1.1", parent: page_1)
  #   expect(page_1_1.position).to eq(1)
  #   page_1_2 = create(:page, title: "Page 1.2", parent: page_1)
  #   expect(page_1_2.position).to eq(2)
  #   page_3_1 = create(:page, title: "Page 3.1", parent: page_3)
  #   expect(page_3_1.position).to eq(1)
  # end
end
