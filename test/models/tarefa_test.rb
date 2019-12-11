require 'test_helper'

class TarefaTest < ActiveSupport::TestCase
  test "tarefa_validacoes" do
    tarefa = Tarefa.new
    assert_not tarefa.save
  end

end
