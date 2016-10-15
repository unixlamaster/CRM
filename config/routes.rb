CRMRor::Application.routes.draw do
  get "passwd/newpasswd"

  put "passwd/updatepasswd"

  resources :statistics

  resources :client_posts


  resources :cl_comments


  resources :ppo_logs

  resources :mng_logs


  resources :gid2names


  resources :maps


  resources :zakazis


  resources :ttmsfiles


  resources :ttmscomments


  resources :ttms

  get 'tasks/change/:id' => 'tasks#change', as: 'task_change'
#  get 'tasks/change/:id(.:format)', to: 'tasks#change', as: 'task_change'
#  match 'tasks/change/' => 'tasks#change'
  resources :tasks

  get 'services/stop/:id' => 'services#stop_service', as: 'stop_service'
#  get 'services/stop/:id(.:format)', to: 'services#stop_service', as: 'stop_service'
  get 'services/start/:id' => 'services#start_service', as: 'start_service'
  get 'services/ping/:id' => 'services#ping_service', as: 'ping_service'
  get 'services/destroy/:id(.:format)', to: 'services#destroy_service', as: 'destroy_service'
  get 'services/remove_speed/:id(.:format)', to: 'services#remove_speed', as: 'remove_speed'
  get 'services/set_speed/:id(.:format)', to: 'services#set_speed', as: 'set_speed'
  resources :services


  resources :ports


  resources :erpfiles


  resources :devices


  resources :comments
 
  get 'main/' => 'reports#index'
  get 'reports/pporep/' => 'reports#pporep'
  get 'reports/wifipporep/' => 'reports#wifipporep'
  get 'reports/installrep/' => 'reports#installrep'
  get 'reports/newclient/' => 'reports#newclient'
  get 'reports/newzakaz/' => 'reports#newzakaz'
  get 'reports/services/' => 'reports#services'
  get 'reports/ttms/' => 'reports#ttms'
  get 'reports/genrep/' => 'reports#genrep'
  get 'reports/ttmsrep/' => 'reports#ttmsrep'
  get 'reports/spec_ttmsrep/' => 'reports#spec_ttmsrep'
  get 'reports/dogimrep/' => 'reports#dogimrep'
  get 'reports/profitlistrep/' => 'reports#profitlistrep'
  get 'reports/freephones/' => 'reports#freephones'
  get 'reports/typeconnect/' => 'reports#typeconnect'
  get 'reports/rastorgenie/' => 'reports#rastorgenie'
  get 'reports/wifiweek/' => 'reports#wifiweek'
  get 'reports/closeakt/' => 'reports#closeakt'
  get 'reports/dhcp_update/' => 'reports#dhcp_update'
  resources :reports



  get 'clients/list/' => 'clients#index'
  get 'clients/exists/' => 'clients#list_exists'
  get 'client/:id/tasks' => 'clients#tasks', as: 'client_tasks'
#  get 'client/:id/tasks(.:format)', to: 'clients#tasks', as: 'client_tasks'
  get 'client/:id/client_notification' => 'clients#client_notification'
  resources :clients

#  root to: "maps#index"
  root to: "clients#index"

end
