defmodule Social.Posts.Comments do
  use Ecto.Schema
  import Ecto.Changeset
  alias Social.Posts.Post

  schema "comments" do
    field :content, :string
    belongs_to :post, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comments, attrs) do
    comments
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
