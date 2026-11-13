---@type LazySpec
return {
  {
    "AstroNvim/astrocore",
    ---@type function|AstroCoreOpts
    opts = function(_, opts)
      local jobs = {}
      local script_path = vim.fn.expand "~/.local/bin/gen-ra-config"

      -- Configure AstroCore's Project Rooter to find the root of a non-Cargo project.
      opts.rooter = opts.rooter or {}
      opts.rooter.detector = opts.rooter.detector
        or {
          "lsp",
          { ".git", "_darcs", ".hg", ".bzr", ".svn" },
          { "lua", "MakeFile", "package.json" },
        }
      table.insert(opts.rooter.detector, { "rust-project.json" })

      opts.autocmds = opts.autocmds or {}
      opts.autocmds.ra_non_cargo_projects = {
        {
          event = "FileType",
          pattern = "rust",
          desc = "Generate rust-project.json and watch non-Cargo Rust directories",
          callback = function(args)
            local file_dir = vim.fn.fnamemodify(args.file, ":p:h")

            -- Skip regular Cargo projects
            if #vim.fs.find("Cargo.toml", { path = file_dir, upward = true }) > 0 then return end

            local detected = require("astrocore.rooter").detect(args.buf, false)
            local root = (detected and detected[1] and detected[1].paths[1]) or vim.fn.getcwd()

            -- Don't run the script if root is already loaded
            if jobs[root] then return end

            local job_id = vim.fn.jobstart({ script_path, root }, {
              cwd = root,
              detach = false,
              on_exit = function() jobs[root] = nil end,
            })

            -- Job successfully started
            if job_id > 0 then jobs[root] = job_id end
          end,
        },
      }
    end,
    lazy = false,
  },
}
