defmodule Pepicrft.OpenGraph do
  use GenServer

  def start_link() do
    paths_to_watch = ["priv/posts/*.md"]
    IO.puts(paths_to_watch)
    GenServer.start_link(__MODULE__, dirs: paths_to_watch, name: :open_graph_image_generator)
  end

  def init(args) do
    {:ok, watcher_pid} = FileSystem.start_link(args)
    FileSystem.subscribe(watcher_pid)
    {:ok, %{watcher_pid: watcher_pid}}
  end

  def handle_info(
        {:file_event, watcher_pid, {path, _events}},
        %{watcher_pid: watcher_pid} = state
      ) do
    IO.puts("File changed: #{path}")
    {:noreply, state}
  end

  def handle_info({:file_event, watcher_pid, :stop}, %{watcher_pid: watcher_pid} = state) do
    {:noreply, state}
  end
end
