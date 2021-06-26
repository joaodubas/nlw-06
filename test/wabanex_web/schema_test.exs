defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.{User, Users}

  describe "users queries" do
    test "when a valid id is given returns the user", %{conn: conn} do
      params = %{name: "Joe Doe", email: "joe.doe@anywhere.com", password: "aLongEnough"}

      {:ok, %User{id: user_id}} = Users.Create.call(params)

      query = """
        query TestGetUser($id: UUID4!) {
          getUser(id: $id) {
            id
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query, variables: %{"id" => user_id}})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{"id" => user_id, "name" => "Joe Doe", "email" => "joe.doe@anywhere.com"}
        }
      }

      assert expected_response == response
    end
  end

  describe "user mutations" do
    test "when all params are valid creates an user", %{conn: conn} do
      mutation = """
        mutation TestCreateUser($input: CreateUserInput!) {
          createUser(input: $input) {
            name
            email
          }
        }
      """

      input = %{
        "input" => %{
          "name" => "Joe Doe",
          "email" => "joe.doe@nowhere.com",
          "password" => "aLongEnough"
        }
      }

      response =
        conn
        |> post("/api/graphql", %{query: mutation, variables: input})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{"createUser" => %{"name" => "Joe Doe", "email" => "joe.doe@nowhere.com"}}
      }

      assert expected_response == response
    end
  end
end
