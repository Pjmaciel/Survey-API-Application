FactoryBot.define do
  factory :question do
    association :survey
    question_text { 'Qual é a sua cor favorita?' }
    question_type { 'multiple_choice' }

    # Cria 3 opções por padrão após criar a pergunta
    after(:create) do |question|
      create_list(:option, 3, question: question) # Ajuste o número aqui se necessário
    end
  end
end