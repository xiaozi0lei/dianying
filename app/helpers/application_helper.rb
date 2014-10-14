module ApplicationHelper

class PygmentsHTML < Redcarpet::Render::HTML
  def block_code code, language
    Pygments.highlight(code, :lexer => language)
  end
end

#  class CodeRayify < Redcarpet::Render::HTML
#    def block_code(code, language)
#      #CodeRay.scan(code, language).div
#      CodeRay.scan(code, language).div(:line_numbers => :table)
#    end
#  end

  def markdown(text)
#    coderayified = CodeRayify.new(:filter_html => true,:hard_wrap => true)
    coderayified = PygmentsHTML.new(
      with_toc_data: true,
      hard_wrap: true
    )
#    coderayified = Redcarpet::Render::HTML.new(:filter_html => true,:hard_wrap => true)
    options = {
      :no_intra_emphasis => true,
      :tables => true,
      :fenced_code_blocks => true,
      :autolink => true,
      :strikethrough => true,
      :lax_spacing => true,
      :superscript => true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end

end
