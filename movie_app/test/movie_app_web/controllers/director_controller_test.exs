defmodule MovieAppWeb.DirectorControllerTest do
  use MovieAppWeb.ConnCase

  import MovieApp.MoviesFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  describe "index" do
    test "lists all directors", %{conn: conn} do
      conn = get(conn, ~p"/directors")
      assert html_response(conn, 200) =~ "Listing Directors"
    end
  end

  describe "new director" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/directors/new")
      assert html_response(conn, 200) =~ "New Director"
    end
  end

  describe "create director" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/directors", director: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/directors/#{id}"

      conn = get(conn, ~p"/directors/#{id}")
      assert html_response(conn, 200) =~ "Director #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/directors", director: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Director"
    end
  end

  describe "edit director" do
    setup [:create_director]

    test "renders form for editing chosen director", %{conn: conn, director: director} do
      conn = get(conn, ~p"/directors/#{director}/edit")
      assert html_response(conn, 200) =~ "Edit Director"
    end
  end

  describe "update director" do
    setup [:create_director]

    test "redirects when data is valid", %{conn: conn, director: director} do
      conn = put(conn, ~p"/directors/#{director}", director: @update_attrs)
      assert redirected_to(conn) == ~p"/directors/#{director}"

      conn = get(conn, ~p"/directors/#{director}")
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, director: director} do
      conn = put(conn, ~p"/directors/#{director}", director: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Director"
    end
  end

  describe "delete director" do
    setup [:create_director]

    test "deletes chosen director", %{conn: conn, director: director} do
      conn = delete(conn, ~p"/directors/#{director}")
      assert redirected_to(conn) == ~p"/directors"

      assert_error_sent 404, fn ->
        get(conn, ~p"/directors/#{director}")
      end
    end
  end

  defp create_director(_) do
    director = director_fixture()
    %{director: director}
  end
end
