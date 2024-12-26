defmodule JSendTest do
  use ExUnit.Case, async: true
  doctest JSend

  describe "success" do
    test "encodes with Jason" do
      data = %{id: 1, name: "Some name"}
      {:ok, res} = JSend.success(data) |> Jason.encode()

      assert res == "{\"data\":{\"id\":1,\"name\":\"Some name\"},\"status\":\"success\"}"
    end

    test "encodes with JSON" do
      data = %{id: 1, name: "Some name"}
      res = data |> JSend.success() |> JSON.encode!()

      assert res == "{\"data\":{\"id\":1,\"name\":\"Some name\"},\"status\":\"success\"}"
    end
  end

  describe "fail" do
    test "encodes with Jason" do
      data = %{msg: "Something went wrong"}
      {:ok, res} = JSend.fail(data) |> Jason.encode()

      assert res == "{\"data\":{\"msg\":\"Something went wrong\"},\"status\":\"fail\"}"
    end

    test "encodes with JSON" do
      data = %{msg: "Something went wrong"}
      result = data |> JSend.fail() |> JSON.encode!()
      assert result == "{\"data\":{\"msg\":\"Something went wrong\"},\"status\":\"fail\"}"
    end
  end

  describe "error" do
    test "encodes with Jason" do
      data = %{msg: "There was a server error"}
      {:ok, res} = "INTERNAL SERVER ERROR" |> JSend.error(500, data) |> Jason.encode()

      assert res ==
               "{\"code\":500,\"data\":{\"msg\":\"There was a server error\"},\"message\":\"INTERNAL SERVER ERROR\",\"status\":\"error\"}"
    end

    test "encodes with JSON" do
      data = %{msg: "There was a server error"}
      result = "INTERNAL SERVER ERROR" |> JSend.error(500, data) |> JSON.encode!()

      assert result ==
               "{\"code\":500,\"data\":{\"msg\":\"There was a server error\"},\"message\":\"INTERNAL SERVER ERROR\",\"status\":\"error\"}"
    end
  end
end
