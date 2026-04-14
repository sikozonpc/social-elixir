defmodule Social.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Social.Repo

  alias Social.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    from(p in Post,
      left_join: c in assoc(p, :comments),
      group_by: p.id,
      select_merge: %{comments_count: count(c.id)}
    )
    |> Repo.all()
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id), do: Repo.get!(Post, id)

  def get_post(id, preload \\ []),
    do: Repo.one(from p in Post, where: p.id == ^id, preload: ^preload)

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs) do
    %Post{comments_count: 0}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end

  alias Social.Posts.Comments

  @doc """
  Returns the list of comments.

  ## Examples

      iex> list_comments()
      [%Comments{}, ...]

  """
  def list_comments do
    Repo.all(Comments)
  end

  @doc """
  Gets a single comments.

  Raises `Ecto.NoResultsError` if the Comments does not exist.

  ## Examples

      iex> get_comments!(123)
      %Comments{}

      iex> get_comments!(456)
      ** (Ecto.NoResultsError)

  """
  def get_comments!(id), do: Repo.get!(Comments, id)

  @doc """
  Creates a comments.

  ## Examples

      iex> create_comments(%{field: value})
      {:ok, %Comments{}}

      iex> create_comments(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comments(%Post{} = post, attrs) do
    post
    |> Ecto.build_assoc(:comments)
    |> Comments.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a comments.

  ## Examples

      iex> update_comments(comments, %{field: new_value})
      {:ok, %Comments{}}

      iex> update_comments(comments, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_comments(%Comments{} = comments, attrs) do
    comments
    |> Comments.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a comments.

  ## Examples

      iex> delete_comments(comments)
      {:ok, %Comments{}}

      iex> delete_comments(comments)
      {:error, %Ecto.Changeset{}}

  """
  def delete_comments(%Comments{} = comments) do
    Repo.delete(comments)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking comments changes.

  ## Examples

      iex> change_comments(comments)
      %Ecto.Changeset{data: %Comments{}}

  """
  def change_comments(%Comments{} = comments, attrs \\ %{}) do
    Comments.changeset(comments, attrs)
  end
end
