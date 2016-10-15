# -*- encoding : utf-8 -*-
module PpoLogsHelper
  def reglament_button(ppolog,type_t)
    case(type_t)
      when 'ppoobj'
        link_to tag("img", { :src=>"/images/home.png", :title => "ППО Объект",:alt=>"ППО Объект",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'ppoobj', :cl_id => params[:cl_id]) if ppolog.t1s == 'end'
      when 'sogl'
        link_to tag("img", { :src=>"/images/clipboard.png", :title => "Согласование",:alt=>"Согласование",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'sogl', :cl_id => params[:cl_id]) if ppolog.t2s == 'end' && ppolog.flag1 == 'sogl'
      when 'zakaz'
        link_to tag("img", { :src=>"/images/zakaz.png", :title => "Договор",:alt=>"Договор",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'zakaz', :cl_id => params[:cl_id]) if ppolog.flag1 == 'sogl' && ppolog.t3s == 'end' || ppolog.flag1 != 'sogl' && ppolog.t2s == 'end'
      when 'pay'
        "#{link_to tag("img", { :src=>"/images/dollar.png", :title => "Оплата",:alt=>"Оплата",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'pay', :cl_id => params[:cl_id]) if ppolog.t4s == 'end'} #{link_to tag("img", { :src=>"/images/no-money.gif", :title => "Без оплаты",:alt=>"Без оплаты",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'nopay', :cl_id => params[:cl_id]) if ppolog.t4s == 'end'}".html_safe
      when 'shem'
        link_to tag("img", { :src=>"/images/random.png", :title => "Схема",:alt=>"Схема",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'shem', :cl_id => params[:cl_id]) if ppolog.t5s == 'end' || ppolog.t5s == 'nopay'
      when 'install'
        link_to tag("img", { :src=>"/images/hammer.png", :title => "Инсталляция ВОЛС",:alt=>"Инсталляция ВОЛС",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'install', :cl_id => params[:cl_id]) if ppolog.t6s == 'end'
      when 'install1'
        link_to tag("img", { :src=>"/images/screwdriver.png", :title => "Инсталляция Сервиса",:alt=>"Инсталляция Сервиса",:border=>0},false), edit_ppo_log_path(ppolog,:type_t => 'install1', :cl_id => params[:cl_id]) if ppolog.t6s == 'end'
      when 'akt'
        link_to "АКТ", edit_ppo_log_path(ppolog,:type_t => 'akt', :cl_id => params[:cl_id]) if ppolog.t7s == 'end' || ppolog.t8s == 'end'
      else
        "&nbsp;"
    end
  end
end
