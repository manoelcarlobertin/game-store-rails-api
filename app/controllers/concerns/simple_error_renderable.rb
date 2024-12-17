module SimpleErrorRenderable
  extend ActiveSupport::Concern

  included do
    class_attribute :simple_error_partial

    # Aqui vem a parte interessante, estamos declarando o *render_error* com a mesma assinatura
    # do que já existe em **ApiController**, porém aqui ele vai renderizar a partial
    # que está na variável *simple_error_partial* e enviando pra ela as variáveis locais:
    # *fields* e *message*.
    def render_error(message: nil, fields: nil, status: :unprocessable_entity)
      render partial: self.class.simple_error_partial,
             locals: { message: message, fields: fields }, status: status
    end
  end
end
