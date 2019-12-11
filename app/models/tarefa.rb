class Tarefa < ApplicationRecord
  enum status: [:a_fazer, :em_andamento, :concluida, :cancelada]

  STATUS_ORDERS = [0, 1, 2]

  scope :order_by_status, -> {
    order_by = ['CASE']
    STATUS_ORDERS.each_with_index do |status, index|
      order_by << "WHEN status=#{status} THEN #{index}"
    end
    order_by << 'END'
    order(order_by.join(' '))
  }

  validates :inicio, :nome, presence: true
  validates :motivo_cancelamento, :termino, presence: true, if: :cancelada?
  validates :termino, presence: true, if: :concluida?
  validate :termino_tarefa

  belongs_to :usuario

  def termino_tarefa
    unless self.termino.blank?
      if self.termino.to_date < self.inicio.to_date
        errors.add(:base, "Término da tarefa deve ser posterior ao Início.")
      end
    end
  end

  def status_to_s
    return "" if self.status.blank?
    return Tarefa.human_attribute_name("statuses.#{status}")
  end

  def termino_to_s
    return "Tarefa em andamento" if self.termino.blank?
    return self.termino.strftime("%d/%m/%Y às %H:%M")
  end

  def finalizada?
    return true if self.concluida? or self.cancelada?
    return false
  end

  def inicio_to_s
    return self.inicio.strftime("%d/%m/%Y às %H:%M") unless self.inicio.blank?
  end
end
