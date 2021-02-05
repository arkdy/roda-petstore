require_relative "spec_helper"

describe "Petsore" do
  path "/pets" do
    get "Returns all pets" do
      tags "Pets"
      description "Returns all pets from the system that the user has access to"
      operationId "findPets"
      produces "application/json"
      parameter name: :tags,
                description: "tags to filter by",
                in: :query,
                required: false,
                style: "form",
                schema: {
                  type: "array",
                  items: {
                    type: "string"
                  }
                }
      parameter name: :limit,
                description: "maximum number of results to return",
                in: :query,
                required: false,
                schema: {
                  type: "integer",
                  format: "int32"
                }

      let(:tags) { ["dog", "cat"] }

      response "200", "pet response" do
        schema type: "array", items: {"$ref" => "#/components/schemas/Pet"}
        run_test!
      end
    end

    post "Created new pet" do
      tags "Pets"
      description "Creates a new pet in the store. Duplicates are allowed"
      operationId "addPet"
      consumes "application/json"
      produces "application/json"
      parameter name: :new_pet,
                description: "Pet to add to the store",
                in: :body,
                required: true,
                schema: {
                  "$ref": "#/components/schemas/NewPet"
                }

      response "200", "pet response" do
        let(:new_pet) { {name: "Elephant", tag: "other"}.to_json }
        schema "$ref" => "#/components/schemas/Pet"
        run_test!
      end
    end
  end

  path "/pets/{id}" do
    get "Returns a pet" do
      tags "Pets"
      description "Returns a pet based on a single ID"
      operationId "find pet by id"
      produces "application/json"
      parameter name: :id,
                description: "ID of pet to fetch",
                in: :path,
                required: true,
                schema: {
                  type: "integer",
                  format: "int64"
                }

      response "200", "pet response" do
        let(:id) { 1 }
        schema "$ref" => "#/components/schemas/Pet"
        run_test!
      end
    end
  end
end
