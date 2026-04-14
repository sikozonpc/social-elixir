defmodule Social.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Social.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        read_count: 42,
        title: "some title"
      })
      |> Social.Posts.create_post()

    post
  end

  @doc """
  Generate a comments.
  """
  def comments_fixture(attrs \\ %{}) do
    {:ok, comments} =
      attrs
      |> Enum.into(%{
        content: "some content"
      })
      |> Social.Posts.create_comments(post_fixture())

    comments
  end
end
