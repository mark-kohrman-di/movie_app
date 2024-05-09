defmodule MovieApp.DirectorHTML do
  use MovieApp, :html

  embed_templates "director_html/*"

  @doc """
  Renders a director form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def director_form(assigns)
end
