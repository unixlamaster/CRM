# -*- encoding : utf-8 -*-
module ApplicationHelper

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
logger.debug puts "sort_column=#{sort_column} sort_direction=#{sort_direction}"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def sortable(column, title = nil,search = {})
    logger.debug search
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}.update(search), {:class => css_class}
  end

  def datalist_addr
    res= "<datalist id=addr>\n"
    ["Ростов-на-Дону","Батайск"].each do |city|
      f=File.open("street_list_#{city}.txt")
      f.each { |str|  res << "<option value='" << city << ", " << str.chomp << "'>\n" }
      f.close
    end
    res << "</datalist>\n"
  end

  def find_client_id
    case(request.fullpath)
      when /\/zakazi/
      when /\/task/
      when /\/services/
      when /\/ttms/
    end
  end

  def login2sname(login)
    res = Auth.where("user=?",login).first
    res.nil? ? "" : res.surname
  end
  
  def datalist_managers
    res= "<datalist id=managers>\n"
    Client.select("manager").group("manager").order("manager").each do |mng|
      res << "<option value='" << mng.manager << "'>\n"
    end
    res << "</datalist>\n"
  end

  def generate_csv(ar_all,options = {})
    CSV.generate(options) do |csv|
      # csv << column_names
      ar_all.each do |product|
        csv << product.attributes.values
      end
    end
  end
end
