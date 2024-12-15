# note p/ construir o validador customizado por campo como queremos, ele precisa herdar
class FutureDateValidator < ActiveModel::EachValidator
  # o obj Validatable, :date, :value são os parâmetros que o método recebe abaixo
  def validate_each(record, attribute, value) # chama o método validate_each
    if value.present? && value <= Time.zone.now
      message = options[:message] || :future_date # # Usa a mensagem personalizada, ou
      record.errors.add(attribute, message)     # caso contrário, usa a mensagem padrão.
    end           # Adiciona o erro ao registro
  end
end
