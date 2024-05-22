defmodule UsersApi.Repo.Migrations.AlterUserTable do
  use Ecto.Migration

  def change do
    alter table("users") do
      add :password, :string
      remove :role, :address
    end
  end
end
