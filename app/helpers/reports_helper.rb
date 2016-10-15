# -*- encoding : utf-8 -*-
module ReportsHelper

  def authorize
    logger.debug "########## request.parameters[action]="+request.parameters["action"].inspect
    if !@staff_login.admin?
      case request.parameters["action"]
        when /index|new|create|services/
           true
        when /show|edit|update|destroy/
            true
        when /profitlistrep|typeconnect/
          if  @staff_login.gr_names == ["Отдел продаж ЦД"] || @staff_login.gr_names == ["Отдел продаж ДТ"]
            redirect_to clients_path, flash: { error: "Недостаточно прав" }
            false
          else
            true
          end
      end
    else
      true
    end
  end

  

  def newclient_week_collect
    [["эту неделю","/reports/newclient?dec_week=0",0],["прошлую неделю","/reports/newclient?dec_week=1",1]]
  end

  def last_comment(idtask)
    comm = Comment.where(idtask: idtask).select("text")[0]
    comm.nil? ? "" : comm.text[0..10]<<"..."
  end

  def list_phone_type_array
    ["обычный","серебряный","золотой","платиновый"]
  end
end
