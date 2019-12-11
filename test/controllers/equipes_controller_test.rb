require 'test_helper'

class EquipesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def sign_up_colaborador 
    get '/usuarios/sign_in'
    sign_in usuarios(:usuario_001)
    post usuario_session_url
  end

   def sign_up_gestor
    get '/usuarios/sign_in'
    sign_in usuarios(:usuario_002)
    post usuario_session_url
  end

  def create_equipe(current_usuario)
    return @equipe = Equipe.create(
                        nome: "Equipe 1", 
                        id_gestor: current_usuario.id)
  end

  test "criar_equipe_usuario_colaborador" do
    sign_up_colaborador
    @equipe = Equipe.new(
      nome: "Equipe 1", 
      id_gestor: controller.current_usuario.id)

    assert_not @equipe.save
  end

  test "criar_equipe_usuario_gestor" do
    sign_up_gestor
    @equipe = Equipe.new(
      nome: "Equipe 1", 
      id_gestor: controller.current_usuario.id)

    assert @equipe.save
  end

  test "adicionar_membro" do
    sign_up_gestor
    @equipe = create_equipe(controller.current_usuario)

    usuario_id = usuarios(:usuario_001).id
    @usuario = Usuario.find(usuario_id)

    assert_not_nil @usuario

    @equipe.usuarios << @usuario

    assert_includes(@equipe.usuarios, @usuario)     
  end

  test "remover_membro" do
    sign_up_gestor
    @equipe = create_equipe(controller.current_usuario)
    usuario_id = usuarios(:usuario_001).id
    @usuario = Usuario.find(usuario_id)
    @equipe.usuarios << @usuario
    
    assert @equipe.usuarios.delete(@usuario)

  end

end
