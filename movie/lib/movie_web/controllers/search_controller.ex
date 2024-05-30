defmodule MovieWeb.SearchController do
  use MovieWeb, :controller

  def index(conn, _params) do

    render(conn, :index)
  end
end
