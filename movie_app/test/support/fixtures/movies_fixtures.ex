defmodule MovieApp.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MovieApp.Movies` context.
  """

  @doc """
  Generate a director.
  """
  def director_fixture(attrs \\ %{}) do
    {:ok, director} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MovieApp.Movies.create_director()

    director
  end
end
