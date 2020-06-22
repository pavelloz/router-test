module Mutations
  module Product
    class Create < Mutations::AuthorisedMutation
      graphql_name 'CreateProduct'

      argument :name, String, required: true
      argument :category_id, String, required: false
      argument :description, String, required: false
      argument :price, Float, required: true
      argument :stock, Integer, required: true

      field :errors, [String], null: true
      field :product, Types::ProductType, null: true

      def resolve(params)
        authorise_user

        product = Products::Persistence.new(current_account).create(params)
        {
          errors: product.errors.full_messages,
          product: product
        }
      end
    end
  end
end
