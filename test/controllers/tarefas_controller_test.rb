require 'test_helper'

class TarefasControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/usuarios/sign_in'
    sign_in usuarios(:usuario_001)
    post usuario_session_url
  end

  def create_tarefa
    return @tarefa = Tarefa.create(
                        nome: "Tarefa 1", 
                        inicio: DateTime.now,
                        status: "em_andamento", 
                        usuario_id: controller.current_usuario.id)
  end

  test "tarefas_index" do
    get tarefas_url
    assert_response :success
  end

  test "tarefas_show" do
    get tarefas_path(Tarefa.first)
    assert_response :success
  end


  test "tarefas_create" do
    @tarefa = Tarefa.new(
      nome: "Tarefa 1", 
      inicio: DateTime.now,
      status: "em_andamento", 
      usuario_id: controller.current_usuario.id)
    assert @tarefa.save
  end

  test "tarefas_update" do
    @tarefa = create_tarefa
    assert @tarefa.update_attributes(nome: "Tarefa 2")
  end

  test "tarefa_cancelada" do
    @tarefa = create_tarefa

    assert_not @tarefa.update_attributes(status: "cancelada", termino: DateTime.now)
    assert @tarefa.update_attributes(status: "cancelada", termino: DateTime.now, motivo_cancelamento: "motivo x")
  end

  test "tarefa_concluida" do
    @tarefa = create_tarefa

    assert_not @tarefa.update_attributes(status: "concluida")
    assert @tarefa.update_attributes(status: "concluida", termino: DateTime.now)
  end

end
