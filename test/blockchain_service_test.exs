defmodule BlockchainServiceTest do
  use ExUnit.Case
  doctest BlockchainService

  test "greets the world" do
    assert BlockchainService.hello() == :world
  end
end
