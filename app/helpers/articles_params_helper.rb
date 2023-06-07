module ArticlesParamsHelper
  def all_arrays_in_params
    [{ items: [] },
     #  { meta: {} },
     { content: [[]] }]
  end

  def checklist_params
    [items: [:checked, :text]]
  end

  def code_params
    [:code]
  end

  def image_params
    [:caption, :withBackground, :withBorder, :stretched, { file: [:url] }]
  end

  def inline_image_params
    [:caption, :withBackground, :withBorder, :stretched, :url, { usplash: [:author, :profileLink] }]
  end

  def link_params
    # [:link]
  end

  def list_params
    [:style]
  end

  def math_and_html_params
    [:html]
  end

  def paragraph_and_heading_params
    [:text, :level]
  end

  def quote_params
    [:text, :caption, :alignment]
  end

  def table_params
    [:withHeadings]
  end

  def warning_params
    [:title, :message]
  end
end
