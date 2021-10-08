# github-repos.exs
Mix.install([
  {:jason, ">= 1.0.0"},
  {:httpoison, "~> 1.8"}
])

defmodule GithubRepos do
  def load(username) do
    "https://api.github.com/users/#{username}/repos"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Enum.reject(fn %{"fork" => fork} -> fork end)
    |> do_some_calc()
    |> Jason.encode!()
  end

  defp do_some_calc(data) do
    data
    |> Enum.map(&Map.take(&1, ~w[full_name fork pushed_at]))
  end
end

"ramonpin"
|> GithubRepos.load()
|> Enum.each(&IO.puts(inspect(&1)))
