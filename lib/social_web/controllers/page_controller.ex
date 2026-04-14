defmodule SocialWeb.PageController do
  use SocialWeb, :controller
  alias Social.Posts

  def home(conn, _params) do
    posts = Posts.list_posts()
    render(conn, :home, posts: posts)
  end
end
