class Equipe < ApplicationRecord
  has_and_belongs_to_many :usuarios

  validates :nome, :id_gestor, presence: true
  validate :gestor_valido

  def gestor_valido
    unless self.id_gestor.blank?
      @gestor = Usuario.find(self.id_gestor)
      if @gestor.blank?
        errors.add(:base, "Usuário inexistente.")
      elsif !@gestor.gestor?
        errors.add(:base, "Você não possui permissão para realizar essa tarefa.")
      end
    end
  end

  def gestor
    return Usuario.find(self.id_gestor)
  end

  def membros
    gestor = self.gestor
    return self.usuarios.where("id != #{gestor.id}")
  end
end
