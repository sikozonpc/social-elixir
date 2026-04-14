defmodule SocialWeb.CommentsControllerTest do
  use SocialWeb.ConnCase

  import Social.PostsFixtures
  alias Social.Posts.Comments

  @create_attrs %{
    content: "some content"
  }
  @update_attrs %{
    content: "some updated content"
  }
  @invalid_attrs %{content: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all comments", %{conn: conn} do
      conn = get(conn, ~p"/api/comments")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create comments" do
    test "renders comments when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/comments", comments: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/comments/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/comments", comments: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update comments" do
    setup [:create_comments]

    test "renders comments when data is valid", %{conn: conn, comments: %Comments{id: id} = comments} do
      conn = put(conn, ~p"/api/comments/#{comments}", comments: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/comments/#{id}")

      assert %{
               "id" => ^id,
               "content" => "some updated content"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, comments: comments} do
      conn = put(conn, ~p"/api/comments/#{comments}", comments: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete comments" do
    setup [:create_comments]

    test "deletes chosen comments", %{conn: conn, comments: comments} do
      conn = delete(conn, ~p"/api/comments/#{comments}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/comments/#{comments}")
      end
    end
  end

  defp create_comments(_) do
    comments = comments_fixture()

    %{comments: comments}
  end
end
