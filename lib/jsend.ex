defmodule JSend do
  @moduledoc """
  JSend API response structure.

  Read the specification at [omniti-labs/jsend](https://github.com/omniti-labs/jsend).
  """

  @type t :: %__MODULE__{
          code: String.t() | integer() | nil,
          data: map(),
          status: String.t(),
          message: String.t() | nil
        }

  @enforce_keys [:status]
  defstruct status: nil, data: %{}, message: nil, code: nil

  @success "success"
  @fail "fail"
  @error "error"

  @doc ~S"""
  Constructs a success response.

  ## Examples

      iex> JSend.success()
      %JSend{status: "success", data: %{}, code: nil, message: nil}

      iex> JSend.success(%{id: 1})
      %JSend{status: "success", data: %{id: 1}, code: nil, message: nil}
  """
  @spec success(map()) :: t()
  def success(data \\ %{}) do
    new(@success, data)
  end

  @doc ~S"""
  Constructs a failure response.

  ## Examples

      iex> JSend.fail()
      %JSend{status: "fail", data: %{}, code: nil, message: nil}

      iex> JSend.fail(%{name: "too short"})
      %JSend{status: "fail", data: %{name: "too short"}, code: nil, message: nil}
  """
  @spec fail(map()) :: t()
  def fail(data \\ %{}) do
    new(@fail, data)
  end

  @doc ~S"""
  Constructs an error response.

  ## Examples

      iex> JSend.error("Internal server error")
      %JSend{status: "error", data: %{}, code: nil, message: "Internal server error"}

      iex> JSend.error("Internal server error", 500)
      %JSend{status: "error", data: %{}, code: 500, message: "Internal server error"}

      iex> JSend.error("Internal server error", 500, %{request: :econnrefused})
      %JSend{
        status: "error", 
        data: %{request: :econnrefused}, 
        code: 500, 
        message: "Internal server error"
      }
  """
  @spec error(String.t(), String.t() | integer() | nil, map()) :: t()
  def error(message, code \\ nil, data \\ %{}) do
    %__MODULE__{status: @error, code: code, message: message, data: data}
  end

  @spec new(String.t(), map()) :: t()
  defp new(status, data) do
    %__MODULE__{status: status, data: data}
  end
end

case Code.ensure_compiled(JSON.Encoder) do
  {:module, module} ->
    defimpl module, for: JSend do
      def encode(struct, encoder) do
        map =
          Map.from_struct(struct)
          |> Enum.reject(fn {_, v} -> v == nil end)
          |> Enum.into(%{})

        :elixir_json.encode_map(map, encoder)
      end
    end

  {:error, reason} ->
    :ok
end

case Code.ensure_compiled(Jason.Encoder) do
  {:module, module} ->
    defimpl module, for: JSend do
      def encode(struct, opts) do
        map =
          Map.from_struct(struct)
          |> Enum.reject(fn {_, v} -> v == nil end)
          |> Enum.into(%{})

        Jason.Encode.map(map, opts)
      end
    end

  {:error, reason} ->
    :ok
end
