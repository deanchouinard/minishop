defmodule TestRand do
  @on_load :reseed_generator

  def random(number) do
    :random.uniform(number)
  end
    
  def reseed_generator do
    # :random.seed(:os.timestamp())
    IO.puts "rseed generator"
    :random.seed(:erlang.phash2([:erlang.node()]),
                :erlang.monotonic_time(),
                :erlang.unique_integer())
    :ok
  end
end

for x <- 1..10 do
  IO.puts TestRand.random(10000)
end

