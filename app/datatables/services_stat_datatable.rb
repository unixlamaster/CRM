class ServicesStatDatatable 
  delegate :params, :h, :link_to, :request, :tag, to: :@view
  include Rails.application.routes.url_helpers

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: ServiceStatView.count,
      iTotalDisplayRecords: all_rows.count,
#      iTotalDisplayRecords: all_rows.total_entries,
      aaData: data
    }
  end

private

  def data
    all_rows.map do |row|
      [
        row.week,
        link_to(row.s1s, service_path(id:row.s1_id)),
        link_to(row.s2s, service_path(id:row.s2_id)),
        link_to(row.s3s, service_path(id:row.s3_id)),
        link_to(row.s4s, service_path(id:row.s4_id)),
        link_to(row.s5s, service_path(id:row.s5_id)),
        link_to(row.s6s, service_path(id:row.s6_id)),
        link_to(tag("img", { :src => "/images/button_edit.gif", :alt => "Edit", :border=>0, :title=>"Edit"}, false), edit_device_path(row)) +
        link_to(tag("img", { :src => "/images/button_drop.gif", :alt => "Del", :border=>0, :title=>"Del"}, false), row, method: :delete, data: { confirm: 'Are you sure?' })
      ]
    end
  end

  def all_rows
    @all_rows ||= fetch_rows
  end

  def fetch_rows
    rows = Device.order("#{sort_column} #{sort_direction}")
#    rows = rows.page(page).per_page(per_page)
    if params[:sSearch].present?
      rows = rows.where("nic like :search OR ip like :search OR locat like :search OR version like :search OR type like :search OR hw_ver like :search", search: "%#{params[:sSearch]}%")
    end
    rows
  end

  

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 20
  end

  def sort_column
    columns = %w[nic locat ip type mac hw_ver bootstrap version upgrade_date]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
