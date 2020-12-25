defmodule BlockchainService do
  @moduledoc """
  Documentation for `BlockchainService`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> BlockchainService.hello()
      :world

  """
  def main(args \\ []) do
    :timer.sleep(:infinity)
  end

  def newchain(data) do
    blockchain = data["blockchain"]
    message = data["message"]
    chain = Task.async(BlockchainService, :sendRequest, [blockchain, message, "new"])
    chain
  end

  def addblock(data) do
    blockchain = data["blockchain"]
    message = data["message"]
    chain = Task.async(BlockchainService, :sendRequest, [blockchain, message, "add"])
    chain
  end

  def sendRequest(blockchain, message, command) do
    data = Poison.encode!(%{"blockchain" => blockchain, "message" => message})
    IO.puts data
    response = HTTPotion.post "http://192.168.49.2:50010/" <> command, [body: data, timeout: 14_000]
    response = if isGood(response) == :nil do
      HTTPotion.post "http://192.168.49.2:50010/" <> command, [body: data, timeout: 14_000]
    else
      response
    end
    {result, _} = response.body
    result
  end

  def isGood(%HTTPotion.ErrorResponse{}) do
    :nil
  end

  def isGood(%HTTPotion.Response{status_code: 200}) do
    :ok
  end

  def hello do
    :world
  end
end
