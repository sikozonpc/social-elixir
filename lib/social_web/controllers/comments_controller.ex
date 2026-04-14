defmodule SocialWeb.CommentsController do
  use SocialWeb, :controller

  alias Social.Posts

  action_fallback SocialWeb.FallbackController

  def create(conn, %{"comments" => comments_params, "post_id" => post_id}) do
    post = Posts.get_post!(post_id)

      case Posts.create_comments(post, comments_params) do
        {:ok, _comment} -> conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: ~p"/posts/#{post_id}")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Failed to create comment.")
        |> redirect(to: ~p"/posts/#{post_id}")
    end
  end
end
