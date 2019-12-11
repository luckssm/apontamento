class EquipesController < ApplicationController

  before_action :set_equipe, only: [:show]
  
  def new
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def create
    parameters = equipe_params
    parameters[:id_gestor] = current_usuario.id
    equipe = Equipe.create(parameters)
    unless equipe.errors.any?
      current_usuario.equipes << equipe
      flash[:success] = "Equipe criada com sucesso!"
    else
      flash[:warning] = equipe.errors.full_messages.map(&:inspect).join(', ')
    end
    redirect_to tarefas_path
  end

  def nova_equipe
    respond_to do |format|
      format.js
    end
  end

  def adicionar_membro
    equipe = params[:equipe_id]
    @equipe = Equipe.find(equipe)
    unless params[:usuario_id].blank?
      usuario_id = params[:usuario_id]
      @usuario = Usuario.find(usuario_id)

      @equipe.usuarios << @usuario
    end
    respond_to do |format|
      format.js
    end
  end

  def remover_membro
    equipe = params[:equipe_id]
    unless params[:usuario_id].blank?
      usuario_id = params[:usuario_id]
      @usuario = Usuario.find(usuario_id)
      @equipe = Equipe.find(equipe)

      @equipe.usuarios.delete(@usuario)
    end

    respond_to do |format|
      format.js
    end
  end

  private
    def equipe_params 
      params.require(:equipe).permit(:nome)
    end

    def set_equipe
      @equipe = Equipe.find(params[:id])
    end

end
