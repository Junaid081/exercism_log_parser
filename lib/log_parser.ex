defmodule LogParser do
  def valid_line?(line) do
    String.match?(line, ~r/^(\[ERROR\]|\[WARNING\]|\[INFO\]|\[DEBUG\])+/)
end

  def split_line(line) do
    Regex.split(~r/<([~\*=-])*>/, line)
  end

  def remove_artifacts(line) do
    Regex.replace(~r/(end-of-line)[0-9]+/i, line, "")
  end

  def tag_with_user_name(line) do
    if String.match?(line, ~r/User/) do
      name = case Regex.run(~r/User[\s\t]+([[:graph:]]*)[\s\t]*/iu, line) do
            nil -> line
            list -> List.last(list)
            end
        "[USER] #{name} " <> line
      else
        line
    end
  end
end
