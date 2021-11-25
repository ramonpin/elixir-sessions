defmodule Ship do
  @moduledoc """
  This the solution to advent_of_code_2020 day 9 
  """

  defstruct [:x, :y, :dir]

  def new(), do: %Ship{x: 0, y: 0, dir: 0}

  def north(%Ship{y: y} = ship, steps),
    do: %{ship | y: y + steps}

  def south(%Ship{y: y} = ship, steps),
    do: %{ship | y: y - steps}

  def east(%Ship{x: x} = ship, steps),
    do: %{ship | x: x + steps}

  def west(%Ship{x: x} = ship, steps),
    do: %{ship | x: x - steps}

  def left(%Ship{dir: dir} = ship, angle),
    do: %{ship | dir: rem(360 + dir + angle, 360)}

  def right(%Ship{dir: dir} = ship, angle),
    do: %{ship | dir: rem(360 + dir - angle, 360)}

  def forward(%Ship{x: x, y: y, dir: dir} = ship, steps) do
    new_x = x + :math.cos(radians(dir)) * steps
    new_y = y + :math.sin(radians(dir)) * steps

    %{ship | x: Float.round(new_x), y: Float.round(new_y)}
  end

  def distance(%Ship{x: x, y: y}),
    do: Float.round(abs(x) + abs(y))

  def describe(%Ship{x: x, y: y, dir: dir} = ship) do
    IO.puts("The ship is facing #{dir}º at #{x_description(x)}, #{y_description(y)}")
    IO.puts("Current distance from Manhattan is #{Ship.distance(ship)}")
  end

  defp x_description(x) do
    if x >= 0 do
      "east #{x}"
    else
      "west #{abs(x)}"
    end
  end

  defp y_description(y) do
    if y >= 0 do
      "north #{y}"
    else
      "south #{abs(y)}"
    end
  end

  defp radians(degrees),
    do: degrees * :math.pi / 180
end

defmodule ShipControl do

  def run(instructions, ship) when is_binary(instructions) do 
    instructions
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> run(ship)
  end

  def run(instructions, ship) when is_list(instructions) do
    Enum.reduce(
      instructions,
      ship,
      fn instruction, ship -> execute(instruction, ship) end
    )
  end

  def execute("N" <> n, ship),
    do: Ship.north(ship, number(n))

  def execute("S" <> n, ship),
    do: Ship.south(ship, number(n))

  def execute("E" <> n, ship),
    do: Ship.east(ship, number(n))

  def execute("W" <> n, ship),
    do: Ship.west(ship, number(n))

  def execute("L" <> n, ship),
    do: Ship.left(ship, number(n))

  def execute("R" <> n, ship),
    do: Ship.right(ship, number(n))

  def execute("F" <> n, ship),
    do: Ship.forward(ship, number(n))

  defp number(string),
    do: elem(Integer.parse(string), 0)
end


"ship.data"
|> File.stream!()
|> Enum.map(&String.trim/1)
|> ShipControl.run(Ship.new())
|> Ship.describe()
