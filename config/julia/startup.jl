using Revise
using OhMyREPL
enable_autocomplete_brackets(false)
if VERSION >= v"1.11.0-0"
  atreplinit() do repl
      repl.options.hint_tab_completes = false
  end
end
