defmodule MovieApp.MoviesTest do
  use MovieApp.DataCase

  alias MovieApp.Movies

  describe "directors" do
    alias MovieApp.Movies.Director

    import MovieApp.MoviesFixtures

    @invalid_attrs %{name: nil}

    test "list_directors/0 returns all directors" do
      director = director_fixture()
      assert Movies.list_directors() == [director]
    end

    test "get_director!/1 returns the director with given id" do
      director = director_fixture()
      assert Movies.get_director!(director.id) == director
    end

    test "create_director/1 with valid data creates a director" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Director{} = director} = Movies.create_director(valid_attrs)
      assert director.name == "some name"
    end

    test "create_director/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movies.create_director(@invalid_attrs)
    end

    test "update_director/2 with valid data updates the director" do
      director = director_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Director{} = director} = Movies.update_director(director, update_attrs)
      assert director.name == "some updated name"
    end

    test "update_director/2 with invalid data returns error changeset" do
      director = director_fixture()
      assert {:error, %Ecto.Changeset{}} = Movies.update_director(director, @invalid_attrs)
      assert director == Movies.get_director!(director.id)
    end

    test "delete_director/1 deletes the director" do
      director = director_fixture()
      assert {:ok, %Director{}} = Movies.delete_director(director)
      assert_raise Ecto.NoResultsError, fn -> Movies.get_director!(director.id) end
    end

    test "change_director/1 returns a director changeset" do
      director = director_fixture()
      assert %Ecto.Changeset{} = Movies.change_director(director)
    end
  end
end
