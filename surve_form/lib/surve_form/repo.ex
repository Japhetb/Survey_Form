defmodule SurveForm.Repo do
  use Ecto.Repo,
    otp_app: :surve_form,
    adapter: Ecto.Adapters.Postgres
end
