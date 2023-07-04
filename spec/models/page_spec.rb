require 'rails_helper'

RSpec.describe Page, type: :model do
  it "when has a valid factory" do
    page = create(:page)
    expect(page.title.presence).to be_truthy
  end

  describe "slugs" do
    it "when creates a slug" do
      page = create(:page, title: "New page for Test")
      expect(page.slug).to match("new-page-for-test")
      page.update(title: "new tItLe for PAGE")
      expect(page.slug).to match("new-title-for-page")
    end

    it "when page is untitled" do
      page = create(:page, title: nil)
      expect(page.slug.presence).to be_truthy
    end
  end

  it "when tree of ordered pages" do
    page_1 = create(:page, title: "Page 1")
    expect(page_1.position).to eq(1)
    page_2 = create(:page, title: "Page 2")
    expect(page_2.position).to eq(2)
    page_3 = create(:page, title: "Page 3")
    expect(page_3.position).to eq(3)

    page_1_1 = create(:page, title: "Page 1.1", parent: page_1)
    expect(page_1_1.position).to eq(1)
    page_1_2 = create(:page, title: "Page 1.2", parent: page_1)
    expect(page_1_2.position).to eq(2)
    page_3_1 = create(:page, title: "Page 3.1", parent: page_3)
    expect(page_3_1.position).to eq(1)
  end
end
