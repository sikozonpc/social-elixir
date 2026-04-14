defmodule Social.PostsTest do
  use Social.DataCase

  alias Social.Posts

  describe "posts" do
    alias Social.Posts.Post

    import Social.PostsFixtures

    @invalid_attrs %{title: nil, content: nil, read_count: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Posts.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Posts.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{title: "some title", content: "some content", read_count: 42}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.content == "some content"
      assert post.read_count == 42
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{title: "some updated title", content: "some updated content", read_count: 43}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.title == "some updated title"
      assert post.content == "some updated content"
      assert post.read_count == 43
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      assert post == Posts.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end

  describe "comments" do
    alias Social.Posts.Comments

    import Social.PostsFixtures

    @invalid_attrs %{content: nil}

    test "list_comments/0 returns all comments" do
      comments = comments_fixture()
      assert Posts.list_comments() == [comments]
    end

    test "get_comments!/1 returns the comments with given id" do
      comments = comments_fixture()
      assert Posts.get_comments!(comments.id) == comments
    end

    test "create_comments/1 with valid data creates a comments" do
      valid_attrs = %{content: "some content"}

      assert {:ok, %Comments{} = comments} = Posts.create_comments(valid_attrs)
      assert comments.content == "some content"
    end

    test "create_comments/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_comments(@invalid_attrs)
    end

    test "update_comments/2 with valid data updates the comments" do
      comments = comments_fixture()
      update_attrs = %{content: "some updated content"}

      assert {:ok, %Comments{} = comments} = Posts.update_comments(comments, update_attrs)
      assert comments.content == "some updated content"
    end

    test "update_comments/2 with invalid data returns error changeset" do
      comments = comments_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_comments(comments, @invalid_attrs)
      assert comments == Posts.get_comments!(comments.id)
    end

    test "delete_comments/1 deletes the comments" do
      comments = comments_fixture()
      assert {:ok, %Comments{}} = Posts.delete_comments(comments)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_comments!(comments.id) end
    end

    test "change_comments/1 returns a comments changeset" do
      comments = comments_fixture()
      assert %Ecto.Changeset{} = Posts.change_comments(comments)
    end
  end
end
