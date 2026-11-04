  return {
      "jpalardy/vim-slime",
      init = function()
            vim.g.slime_no_mappings = 1
      end,
      config = function()
            vim.g.slime_target = 'tmux'
            local socket_name = vim.api.nvim_eval('get(split($TMUX, ","), 0)')
            vim.g.slime_default_config = {
              socket_name = socket_name,
              target_pane = '{top-left}',
            }

            -- Target the pane running julia in this window, by pane id, so the
            -- layout can be rearranged freely. Falls back to the top-left pane.
            local function refresh_target()
                  local out = vim.fn.system({ "tmux", "list-panes", "-t", vim.env.TMUX_PANE or "",
                        "-F", "#{pane_id} #{pane_current_command}" })
                  local target = '{top-left}'
                  for id, cmd in out:gmatch("(%%%d+) (%S+)") do
                        if cmd:match("^julia") then
                              target = id
                              break
                        end
                  end
                  vim.b.slime_config = { socket_name = socket_name, target_pane = target }
            end

            local function send(plug)
                  return function()
                        refresh_target()
                        return plug
                  end
            end
            vim.keymap.set("x", "<C-c><C-c>", send("<Plug>SlimeRegionSend"), { expr = true, remap = true })
            vim.keymap.set("n", "<C-c><C-c>", send("<Plug>SlimeParagraphSend"), { expr = true, remap = true })
            vim.keymap.set("n", "<C-c>v", "<Plug>SlimeConfig", { remap = true })
      end
  }
