module BlogPostsHelper

  def render_method(template, locals)
    ActionController::Base.new.render_to_string partial: template, locals: locals
  end

end
