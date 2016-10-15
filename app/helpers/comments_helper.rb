# -*- encoding : utf-8 -*-
module CommentsHelper
  include TasksHelper
  def comment_parser(client,task,comment)
    str = case params[:action]
          when "create"
            "Создал комментарий "
          when "update"
            "Обновил комментарий "
          else
            ""
          end
    str + " для клиента "+client.name+", "+task.name+", в задаче: "+task_type_hash[task.type_t]+", "+comment
  end

end
