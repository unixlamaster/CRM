class Comment < ActiveRecord::Base
  self.table_name = "comment"
  attr_accessible :idcomment, :groupid, :idtask, :text, :time, :userid
  belongs_to :task, :foreign_key => 'idtask'

#  belongs_to :from_user, :foreign_key => 'userid', class_name: "Auth"

  belongs_to :auth, :foreign_key => 'userid'
  after_create :email_task_mesg
  
  protected
  def email_task_mesg
	comments = Comment.where(idtask: Task.where(cl_id: self.task.cl_id, point_group: self.task.point_group, zapros_gid: self.task.zapros_gid).collect(&:idtask)).order("time desc")
    Mailer.email_task_mesg(self.auth,self.task.client,self.task,Comment.where(idtask: self.idtask).order("time desc")).deliver
  end
    
end
