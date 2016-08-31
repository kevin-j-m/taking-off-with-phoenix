defmodule Workshop.User do
  use Workshop.Web, :model

  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps
  end

  #Module attribute - compiled into module
  #not exposed/exported
  @allowed_params ~w(name email password password_confirmation)a

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @allowed_params)
    |> validate_required(@allowed_params)
    |> update_change(:email, &String.downcase/1)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_confirmation(:password, message: "must match password")
    |> hash_password()
    # |> update_change(:email, fn email -> String.downcase(email) end)
  end

  defp hash_password(%{changes: %{password: password}, valid?: true} = changeset) do
    put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp hash_password(changeset), do: changeset
end
