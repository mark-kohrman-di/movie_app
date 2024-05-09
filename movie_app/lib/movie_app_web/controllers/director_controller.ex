defmodule MovieApp.DirectorController do
  use MovieApp, :controller

  alias MovieApp.Movies
  alias MovieApp.Movies.Director

  def index(conn, _params) do
    directors = Movies.list_directors()
    render(conn, :index, directors: directors)
  end

  def new(conn, _params) do
    changeset = Movies.change_director(%Director{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"director" => director_params}) do
    case Movies.create_director(director_params) do
      {:ok, director} ->
        conn
        |> put_flash(:info, "Director created successfully.")
        |> redirect(to: ~p"/directors/#{director}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    director = Movies.get_director!(id)
    render(conn, :show, director: director)
  end

  def edit(conn, %{"id" => id}) do
    director = Movies.get_director!(id)
    changeset = Movies.change_director(director)
    render(conn, :edit, director: director, changeset: changeset)
  end

  def update(conn, %{"id" => id, "director" => director_params}) do
    director = Movies.get_director!(id)

    case Movies.update_director(director, director_params) do
      {:ok, director} ->
        conn
        |> put_flash(:info, "Director updated successfully.")
        |> redirect(to: ~p"/directors/#{director}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, director: director, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    director = Movies.get_director!(id)
    {:ok, _director} = Movies.delete_director(director)

    conn
    |> put_flash(:info, "Director deleted successfully.")
    |> redirect(to: ~p"/directors")
  end
end
