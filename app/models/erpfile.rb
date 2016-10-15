class Erpfile < ActiveRecord::Base
  self.table_name = "file"
  attr_accessible :groupid, :idfile, :idtask, :name, :status, :time, :userid
  belongs_to :auth, :foreign_key => 'userid'

 def save_file(file,task,staff_login)
    logger.debug "+++ #{file.inspect}\n"
    logger.debug "--- #{staff_login.id}\n"
    logger.debug "=== #{task}\n"
    logger.debug "=== #{Time.now.getlocal}\n"
    name =  file.original_filename
    directory = "task_uploads/#{task}"
   # create the file path
    Dir.mkdir(directory) unless FileTest.directory?(directory)
    logger.debug "+++ #{name}\n"
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }
    write_attribute(:name, name)
    write_attribute(:idtask, task)
    write_attribute(:status, "new")
    write_attribute(:userid, staff_login.id)
    write_attribute(:time, Time.now.getlocal)
    write_attribute(:groupid, staff_login.groupid)
    save
  end
end
