defmodule UsersApi.Repo.Migrations.ChangeUserTable do
  use Ecto.Migration

  def change do
    alter table("users") do
      remove :address
    end
  end
end
