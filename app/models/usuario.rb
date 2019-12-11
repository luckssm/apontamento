class Usuario < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :tarefas
  has_and_belongs_to_many :equipes

  GESTOR           = 1
  COLABORADOR      = 2

  def gestor?
    self.tipo == GESTOR
  end

  def colaborador?
    self.tipo == COLABORADOR
  end

  def self.usuarios_disponiveis_adicao_equipe(equipe_id)
    @equipe = Equipe.find(equipe_id)
    @usuarios_na_equipe = @equipe.usuarios.pluck(:id)
    Usuario.all.where.not(id: @usuarios_na_equipe).map{ |usuario| [usuario.nome, usuario.id] }
  end

  
end
