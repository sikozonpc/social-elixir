defmodule SocialWeb.PostAPIJSON do
  alias Social.Posts.Post
  alias SocialWeb.CommentsJSON

  @doc """
  Renders a list of posts.
  """
  def index(%{posts: posts}) do
    %{data: for(post <- posts, do: data(post))}
  end

  @doc """
  Renders a single post.
  """
  def show(%{post: post}) do
    %{data: data(post)}
  end

  defp data(%Post{} = post) do
    %{
      id: post.id,
      title: post.title,
      content: post.content,
      read_count: post.read_count,
      comments_count: post.comments_count,
      comments: CommentsJSON.index(%{comments: post.comments})
    }
  end
end
