defmodule Bonfire.Composer.ChannelCase do
  @moduledoc """
  This module defines the test case to be used by
  channel tests.

  Such tests rely on `Phoenix.ChannelTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use MyApp.Web.ChannelCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate

  import Bonfire.Composer.Integration

  using do
    quote do
      # Import conveniences for testing with channels
      import Phoenix.ChannelTest
      import Bonfire.Composer.ChannelCase

      # The default endpoint for testing
      @endpoint Bonfire.Common.Config.get!(:endpoint_module)
    end
  end

  setup tags do

    :ok = Ecto.Adapters.SQL.Sandbox.checkout(repo())

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(repo(), {:shared, self()})
    end

    :ok
  end
end
