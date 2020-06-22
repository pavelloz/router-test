module Mutations
  module Language
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateLanguage'

      argument :id, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :language, Types::LanguageType, null: true

      def resolve(params)
        language = Languages::Persistence.new(current_account).update(params)

        {
          errors: language.errors.full_messages,
          language: language
        }
      end
    end
  end
end
