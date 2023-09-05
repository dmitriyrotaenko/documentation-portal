module PagesHelper
  def render_pages_with_subpages(pages)
    return if pages.blank?
    # TODO: move to partial
    content_tag(:ul, class: "pl-5") do
      pages.each do |page|
        concat(content_tag(
                 :li,
                 link_to(display_page_title(page), project_page_path(@project, page),
                         class: "flex justify-between text-sm hover:bg-gray-100 rounded-md p-1 pl-3  #{'bg-light-accent text-accent hover:bg-light-accent' if request.path.include?(page.slug)}"), class: "mb-1 text-text"))
        concat(render_pages_with_subpages(page.subpages))
      end
    end
  end
  # TODO: move to model/decorator?
  def display_page_title(page)
    page.title.blank? ? "<i>Untitled</i>".html_safe : page.title
  end
end
