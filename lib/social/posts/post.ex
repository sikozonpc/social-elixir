defmodule Social.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :content, :string
    field :read_count, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :read_count])
    |> validate_required([:title, :content])
    |> validate_number(:read_count, greater_than_or_equal_to: 0)
  end
end
