defmodule SocialWeb.PostAPIController do
  use SocialWeb, :controller

  alias Social.Posts
  alias Social.Posts.Post

  action_fallback SocialWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :index, posts: posts)
  end

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
      render(conn, :show, post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post(id, [:comments])
    render(conn, :show, post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{} = _post} <- Posts.update_post(post, post_params) do
      render(conn, :show, post: Posts.get_post(id, [:comments]))
    else
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    case Posts.delete_post(post) do
      {:ok, %Post{}} -> conn |> send_resp(:no_content, "")
      {:error, changeset} -> conn
      |> put_status(:unprocessable_entity)
      |> render(:error, changeset: changeset)
    end
  end
end
