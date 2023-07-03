require 'rails_helper'

RSpec.describe Page, type: :model do
  it "has a valid factory" do
    page = create(:page)
    expect(page.title.presence).to be_truthy
  end

  it "creates a slug" do
    page = create(:page, title: "New page for Test")
    expect(page.slug).to eq("new-page-for-test")
    page.update(title: "new tItLe for PAGE")
    expect(page.slug).to eq("new-title-for-page")
  end

  it "is a tree of ordered pages" do
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
