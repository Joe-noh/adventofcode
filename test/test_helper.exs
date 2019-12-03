ExUnit.start()

defmodule TestHelpers do
  def puts(result, %{case: module, describe: part}) do
    IO.puts "#{module}.#{part} => #{result}"
  end
end
