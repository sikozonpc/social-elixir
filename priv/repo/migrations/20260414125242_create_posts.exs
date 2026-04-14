defmodule Social.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :string
      add :read_count, :integer, default: 0

      timestamps(type: :utc_datetime)
    end
  end
end
