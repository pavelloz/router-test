import { ValidationModel } from "./validation";
import { Taxes } from "../database/taxes";

function TaxModel(tax = {}) {
  const constraints = {
    name: {
      presence: true,
      type: "string",
      length: {
        minimum: 1,
        message: "Please enter a name."
      }
    },
    active: {
      presence: true,
      type: "boolean"
    },
    percentage: {
      presence: false,
      type: "number"
    },
    amount: {
      presence: false,
      type: "number"
    },
    startAt: {
      presence: true
    },
    endAt: {
      presence: false
    },
    minimumPrice: {
      presence: false,
      type: "number"
    },
    customerId: {
      presence: false,
      type: "string"
    },
    categoryId: {
      presence: false,
      type: "string"
    },
    productId: {
      presence: false,
      type: "string"
    }
  };

  const validation = ValidationModel(tax, constraints);
  const fields = validation.fields();

  function add(graphqlClient) {
    return Taxes(graphqlClient).add(validValues());
  }

  function edit(graphqlClient, taxId) {
    return Taxes(graphqlClient).edit({
      ...validValues(),
      id: taxId
    });
  }

  function find(graphqlClient, params) {
    return Taxes(graphqlClient).find(params);
  }

  function findOne(graphqlClient, discountId) {
    return Taxes(graphqlClient).findOne(discountId);
  }

  function remove(graphqlClient, discountId) {
    return Taxes(graphqlClient).remove(discountId);
  }

  function valid() {
    return validation.valid(fields);
  }

  function validValues() {
    return validation.validValues(fields);
  }

  return Object.freeze({
    add,
    edit,
    fields,
    find,
    findOne,
    remove,
    valid,
    validValues
  });
}

export { TaxModel };
