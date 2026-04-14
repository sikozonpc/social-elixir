defmodule SocialWeb.CommentsAPIController do
  use SocialWeb, :controller

  alias Social.Posts
  alias Social.Posts.Comments

  action_fallback SocialWeb.FallbackController

  def index(conn, _params) do
    comments = Posts.list_comments()
    render(conn, :index, comments: comments)
  end

  def create(conn, %{"comments" => comments_params}) do
    with {:ok, %Comments{} = comments} <- Posts.create_comments(comments_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/comments/#{comments}")
      |> render(:show, comments: comments)
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
