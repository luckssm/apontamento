class CreateTarefas < ActiveRecord::Migration[5.2]
  def change
    create_table :tarefas do |t|

      t.string :nome
      t.datetime :inicio
      t.datetime :termino
      t.integer :status, limit: 2
      t.string :motivo_cancelamento
      t.bigint :usuario_id
      
      t.timestamps
    end
  end
end
