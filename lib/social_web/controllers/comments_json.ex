defmodule SocialWeb.CommentsJSON do
  alias Social.Posts.Comments

  @doc """
  Renders a list of comments.
  """
  def index(%{comments: comments}) do
    %{data: for(comments <- comments, do: data(comments))}
  end

  @doc """
  Renders a single comments.
  """
  def show(%{comments: comments}) do
    %{data: data(comments)}
  end

  defp data(%Comments{} = comments) do
    %{
      id: comments.id,
      content: comments.content
    }
  end
end
