module PagesHelper
  def render_pages_with_subpages(pages)
    return if pages.blank?

    content_tag(:ul, class: "pl-5") do
      pages.each do |page|
        concat(content_tag(
                 :li,
                 link_to(page.title, project_page_path(@project, page),
                         class: "flex justify-between font-medium text-sm hover:bg-gray-100 rounded-md p-1 pl-3  #{'bg-light-accent text-accent hover:bg-light-accent' if current_page?(project_page_path(@project, page))}"), class: "mb-1 text-text"))
        concat(render_pages_with_subpages(page.pages))
      end
    end
  end

  def extract_editor_content(content)
    parsed_content = JSON.parse(content)
    html = parsed_content["blocks"].map do |block|
      case block["type"]
      when "paragraph"
        "<p>#{block["data"]["text"]}</p>"
      end
    end
    html.join.html_safe
  end
end
