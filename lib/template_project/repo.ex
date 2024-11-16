defmodule TemplateProject.Repo do
  use Ecto.Repo,
    otp_app: :template_project,
    adapter: Ecto.Adapters.Postgres
end
