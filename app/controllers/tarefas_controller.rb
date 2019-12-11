class TarefasController < ApplicationController

  before_action :authenticate_usuario!
  before_action :set_tarefa, only: [:cancelar_tarefa, :show, :update, :concluir_tarefa]


  def index
    @tarefas = Tarefa.where(usuario_id: current_usuario.id).order_by_status.order('tarefas.inicio ASC')
  end

  def new
  end

  def show
    respond_to do |format|
      format.js
    end
  end

  def create
    parameters = tarefa_params
    parameters[:usuario_id] = current_usuario.id
    @tarefa = Tarefa.create(parameters)
    if @tarefa.errors.any?
      flash[:warning] = @tarefa.errors.full_messages.map(&:inspect).join(', ')
    else
      flash[:success] = "Tarefa criada com sucesso!"
    end
    redirect_to tarefas_path
  end

  def update
    if @tarefa.update_attributes(tarefa_params)
      flash[:success] = "Tarefa salva!"
    else
      flash[:warning] = @tarefa.errors.full_messages.map(&:inspect).join(', ')
    end
    redirect_to tarefas_path
  end

  def nova_tarefa
    respond_to do |format|
      format.html
      format.js
    end
  end

  def cancelar_tarefa
    respond_to do |format|
      format.html
      format.js
    end
  end

  def concluir_tarefa
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def tarefa_params 
      params.require(:tarefa).permit(:nome, :inicio, :termino, :motivo_cancelamento, :status)
    end

    def set_tarefa
      @tarefa = Tarefa.find(params[:id])
    end
end
