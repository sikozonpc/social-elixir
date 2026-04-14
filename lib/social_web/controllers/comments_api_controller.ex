defmodule SocialWeb.CommentsAPIController do
  use SocialWeb, :controller

  alias Social.Posts
  alias Social.Posts.Comments

  action_fallback SocialWeb.FallbackController

  def index(conn, _params) do
    comments = Posts.list_comments()
    render(conn, :index, comments: comments)
  end

  def create(conn, %{"comments" => comments_params, "post_id" => post_id}) do
    post = Posts.get_post!(post_id)

    case Posts.create_comments(post, comments_params) do
      {:ok, %Comments{} = comments} -> conn
      |> put_status(:created)
      |> render(:show, comments: comments)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(:error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    comments = Posts.get_comments!(id)
    render(conn, :show, comments: comments)
  end

  def update(conn, %{"id" => id, "comments" => comments_params}) do
    comments = Posts.get_comments!(id)

    with {:ok, %Comments{} = comments} <- Posts.update_comments(comments, comments_params) do
      render(conn, :show, comments: comments)
    end
  end

  def delete(conn, %{"id" => id}) do
    comments = Posts.get_comments!(id)

    with {:ok, %Comments{}} <- Posts.delete_comments(comments) do
      send_resp(conn, :no_content, "")
    end
  end
end
