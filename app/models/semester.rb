class Semester < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :candidature
  validates :year, presence: true
  validates :parity, presence: true, inclusion: {in: 0..1}
  #FIXME for some reason the line below does not work properly, it gives false positives.
  #validates :open, presence: true
  #validates :active, presence: true

  def parity_as_s
    parity == 0 ? "Ímpar" : "Par"
  end

  def last_month
    parity == 0 ? 11 : 6
  end

  def parity_as_i
    parity+1
  end

  def open_as_s
    open ? "Aberto" : "Fechado"
  end

  def state_as_s
    if open and active
      "Aberto para inscrições"
    elsif active
      "Ativo"
    elsif open
      "Inválido"
    else
      "Fechado"
    end
  end

  def period_as_s
    year.to_s + "/" + parity_as_i.to_s
  end

  def as_s
    "#{parity+1}º semestre de #{year}"
  end

  def current?
    self == Semester.current
  end

  def open_frequency_period which
    update(frequency_period: frequency_period | (1 << which))
  end

  def close_frequency_period which
    update(frequency_period: frequency_period &= ~(1 << which))
  end

  def frequency_open? which
    (frequency_period & (1 << which)) != 0
  end

  def self.all_open
    Semester.where(open: true).all
  end

  def self.all_active
    Semester.where(active: true).all
  end

  def self.current
    all_active.last
  end
end
