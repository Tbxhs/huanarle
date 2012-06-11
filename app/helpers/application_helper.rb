# coding: utf-8
module ApplicationHelper
  def nav_tab_tag(*links)
    li_tag = links.collect do |link|
      %Q(<li><a class="tab #{link[0] == url_for || link[2] == 'checked' ? 'checked' : nil}" href="#{link[0]}">#{link[1]}</a></li>)
    end.join
    content_tag 'div', :class => 'nav_tabs' do
      raw("<ul>#{li_tag}</ul>")
    end
  end
end
