defmodule Ifrnmessenger.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :name, :string
    field :photo, :string
    field :registration, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :registration, :email, :photo])
    |> validate_required([:name, :registration, :email, :photo])
  end
end
