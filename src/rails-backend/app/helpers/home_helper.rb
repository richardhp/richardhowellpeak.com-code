module HomeHelper
  def social_icon(url, icon)
    link_to url, target: :_blank do 
      tag.i class: "xl:text-8xl md:text-5xl sm:text-xl fa-brands #{icon}"
    end
  end

  def section_card(url, title, blurb)
    tag.div class: "px-5" do
      tag.div(
        tag.a(title,  href: url), 
        class: "py-5 text-center bg-slate-100"
      ) + 
      tag.div(blurb, class: "py-5")
    end
  end
end