Rails.application.routes.draw do
	devise_for :usuarios, controllers: { sessions: 'usuarios/sessions' }
  
  controller :usuarios do
    get '/usuarios/listar_para_autocomplete' => :listar_para_autocomplete
  end
  resources :usuarios

  controller :tarefas do 
    get "tarefas/nova_tarefa" => :nova_tarefa, as: :nova_tarefa
    get "tarefas/cancelar_tarefa/:id" => :cancelar_tarefa, as: :cancelar_tarefa
    get "tarefas/concluir_tarefa/:id" => :concluir_tarefa, as: :concluir_tarefa
  end
  resources :tarefas

  controller :equipes do 
    get "equipes/nova_equipe" => :nova_equipe, as: :nova_equipe
    post "equipes/adicionar_membro" => :adicionar_membro, as: :adicionar_membro
    post "equipes/remover_membro" => :remover_membro, as: :remover_membro
  end
  resources :equipes

  root to: 'tarefas#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end