module BlogArticlesParamsHelper
  def paragraph_and_heading_params
    [:text, :level]
  end

  def math_and_html_params
    [:html]
  end

  def table_params
    [:withHeadings, { content: [[]] }]
  end

  def list_params
    [:style, { items: [] }]
  end

  def checklist_params
    [items: [:checked, :text]]
  end

  def warning_params
    [:title, :message]
  end

  def code_params
    [:code]
  end

  def link_params
    [:link, { meta: {} }]
  end

  def image_params
    [:caption, :withBackground, :withBorder, :stretched, { file: [:url] }]
  end

  def quote_params
    [:text, :caption, :alignment]
  end
end
