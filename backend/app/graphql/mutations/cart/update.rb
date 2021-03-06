module Mutations
  module Cart
    class Update < Mutations::BaseMutation
      graphql_name 'UpdateCart'

      argument :cart_id, String, required: false
      argument :product_id, String, required: true
      argument :quantity, Float, required: true

      field :errors, [String], null: true
      field :cart, Types::CartType, null: true

      def resolve(params)
        cart_info = { account: current_account, customer: current_user.customer, cart_id: params.delete(:cart_id) }
        cart = Carts::Persistence.new(cart_info).update(params)
        {
          errors: cart.errors.full_messages,
          cart: cart
        }
      end
    end
  end
end
