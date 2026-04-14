defmodule SocialWeb.PostController do
  use SocialWeb, :controller

  alias Social.Posts
  alias Social.Posts.Post
  alias Social.Posts.Comments
  import Phoenix.Component

  action_fallback SocialWeb.FallbackController

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    render(conn, :new, form: to_form(changeset))
  end

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: ~p"/posts/#{post}")

      {:error, changeset} ->
        render(conn, :new, form: to_form(changeset))
    end
  end

  def show(conn, %{"id" => id}) do
    case Posts.get_post(id, [:comments]) do
      %Post{} = post ->
        changeset = Posts.change_comments(%Comments{post: post})

        render(
        conn,
         :show,
         post: post,
         form: to_form(changeset))
      nil ->
        conn
        |> put_flash(:error, "Post not found.")
        |> redirect(to: ~p"/")
    end
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
      render(conn, :show, post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
