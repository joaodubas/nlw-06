defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "when all param are valid returns a valid changeset" do
      params = %{name: "Joe Doe", email: "joe.doe@anywhere.com", password: "aLongEnough"}

      changeset = User.changeset(params)

      assert %{
               valid?: true,
               changes: %{name: "Joe Doe", email: "joe.doe@anywhere.com", password: "aLongEnough"},
               errors: []
             } = changeset
    end

    test "when one of the params is invalid returns an invalid changeset" do
      params = %{name: "J", email: "j", password: "j"}

      changeset = User.changeset(params)

      assert %{valid?: false} = changeset

      assert %{
               name: ["should be at least 2 character(s)"],
               email: ["has invalid format"],
               password: ["should be at least 6 character(s)"]
             } == errors_on(changeset)
    end
  end
end
