class CreateEquipes < ActiveRecord::Migration[5.2]
  def change
    create_table :equipes do |t|
      t.string :nome
      t.bigint :id_gestor
      t.timestamps
    end

    create_table :equipes_usuarios, id: false do |t|
      t.belongs_to :equipe
      t.belongs_to :usuario
    end
  end
end
