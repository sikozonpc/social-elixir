defmodule SocialWeb.PostAPIController do
  use SocialWeb, :controller

  alias Social.Posts
  alias Social.Posts.Post

  action_fallback SocialWeb.FallbackController

  def create(conn, %{"post" => post_params}) do
    with {:ok, %Post{} = post} <- Posts.create_post(post_params) do
      render(conn, :show, post: post)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, :show, post: post)
  end
end
