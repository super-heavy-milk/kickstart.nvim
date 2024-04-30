-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Show a couple lines above and below the cursor when jumping around
vim.o.scrolloff = 5

-- https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6
vim.o.termguicolors = true

-- below lines make the background inherit the terminal background
-- vim.cmd('hi Normal ctermbg=none')
-- vim.cmd('highlight NonText ctermbg=none')
-- vim.cmd('hi Normal guibg=none')

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        config = true
      },

      -- Paired with the LSP above
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        opts = {} -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  {
    'folke/which-key.nvim',
    opts = {}
  },

  -- copilot (see https://github.com/folke/dot/commit/7fbe9130ab631a8b1851c6a6a5242212a2b256e7)
  -- {
  --   "zbirenbaum/copilot.lua",
  --   enabled = true,
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  --   -- opts = {
  --   --   suggestion = { enabled = false },
  --   --   panel = { enabled = false },
  --   -- },
  -- },
  --
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
          { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
          { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
          { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },

  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  -- {
  --   'projekt0n/github-nvim-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('github-theme').setup({
  --       -- ...
  --     })
  --
  --     vim.cmd('colorscheme github_dark_high_contrast')
  --   end,
  -- },

  {
    'briones-gabriel/darcula-solid.nvim',
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    dependencies = {
      'rktjmp/lush.nvim'
    },
    config = function()
      vim.cmd('colorscheme darcula-solid')
      -- below lines make the background inherit the terminal background
      vim.cmd('hi Normal ctermbg=none')
      vim.cmd('highlight NonText ctermbg=none')
      vim.cmd('hi Normal guibg=none')
    end,
  },

  -- {
  --   "phha/zenburn.nvim",
  --   config = function()
  --     require('zenburn').setup()
  --     vim.cmd.colorscheme 'zenburn'
  --     -- vim.cmd('hi Normal ctermbg=none')
  --     -- vim.cmd('highlight NonText ctermbg=none')
  --     -- vim.cmd('hi Normal guibg=none')
  --   end,
  -- },

  -- {
  --   'rose-pine/neovim',
  --   name = 'rose-pine',
  --   config = function()
  --     require('rose-pine').setup({
  --       disable_background = true
  --     })
  --     vim.cmd.colorscheme 'rose-pine'
  --   end,
  -- },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        -- theme = 'darcula',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- Add indentation guides even on blank lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      -- indent = {
      --   highlight = { "CursorColumn", "Whitespace" },
      --   char = "",
      -- },
      -- whitespace = {
      --   highlight = { "CursorColumn", "Whitespace" },
      --   remove_blankline_trail = false,
      -- },
      scope = {
        enabled = true,
      },
    }
  },

  -- Automatically look up error with GPT or Google
  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {},
    keys = {
      {
        "gw",
        mode = { "n", "x" },
        function()
          require("wtf").ai()
        end,
        desc = "Debug diagnostic with AI",
      },
      {
        mode = { "n" },
        "gW",
        function()
          require("wtf").search()
        end,
        desc = "Search diagnostic with Google",
      },
    },
  },

  -- GPT Plugin
  {
    "robitx/gp.nvim",
    config = function()
      require("gp").setup()

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },

  -- GPT plugin
  -- {
  --   "jackMort/ChatGPT.nvim",
  --     event = "VeryLazy",
  --     config = function()
  --       require("chatgpt").setup()
  --     end,
  --     dependencies = {
  --       "MunifTanjim/nui.nvim",
  --       "nvim-lua/plenary.nvim",
  --       "folke/trouble.nvim",
  --       "nvim-telescope/telescope.nvim"
  --     }
  -- },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    opts = {
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = { line = 'gcc', block = 'gbc' },
      opleader = { line = 'gc', block = 'gb' },
      extra = { above = 'gcO', below = 'gco', eol = 'gcA' },
      mappings = { basic = true, extra = true },
      pre_hook = nil,
      post_hook = nil,
    }
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- time tracking, see https://wakatime.com/dashboard
  {
    'wakatime/vim-wakatime',
    lazy = false
  },

  -- java
  {
    "mfussenegger/nvim-jdtls",
  },

  -- kitty.conf highlighting
  {
    "fladson/vim-kitty"
  },

  -- markdown
  -- {
  --   'plasticboy/vim-markdown',
  --   branch = 'master',
  --   require = { 'godlygeek/tabular' },
  -- },

  -- markdown motions and some basic italics
  {
    "tadmccorkle/markdown.nvim",
    ft = "markdown", -- or 'event = "VeryLazy"'
    opts = {
      -- configuration here or empty for defaults
    },
  },

  -- better display of markdown within the editor
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- config = true,   -- or `opts = {}`
    opts = {
      markdown = {
        bullets = {}
      }
    }
  },

  -- https://www.josean.com/posts/neovim-linting-and-formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          javascriptreact = { "prettier" },
          typescriptreact = { "prettier" },
          svelte = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          graphql = { "prettier" },
          lua = { "stylua" },
          python = { "isort", "black" },
        },
        -- format_on_save = {
        --   lsp_fallback = true,
        --   async = false,
        --   timeout_ms = 500,
        -- },
      })

      vim.keymap.set({ "n", "v" }, "<leader>rf", function()
        conform.format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 1000,
        })
        local bufname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
        local mode = vim.api.nvim_get_mode().mode
        local is_visual = mode == "v" or mode == "V" or mode == "\22"
        if is_visual then
          vim.notify("Formatted range in '" .. bufname .. "'")
        else
          vim.notify("Formatted '" .. bufname .. "'")
        end
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping

  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins

  { import = 'custom.plugins' },

}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Better diff display
vim.o.diffopt = "internal,filler,closeoff,vertical,iwhite,linematch:60"

-- buffer thing (default is true)
--vim.o.hidden = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 0,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- Symbol prefix
-- vim.keymap.set('n', '<leader>/', require('telescope.builtin').current_buffer_fuzzy_find,
--   { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>?', require('telescope.builtin').help_tags, { desc = '[?] Search Help' })

-- [S]earch prefix
vim.keymap.set('n', '<leader>sgf', require('telescope.builtin').git_files, { desc = '[S]earch [G]it [F]iles' })
vim.keymap.set('n', '<leader>sgs', require('telescope.builtin').git_status, { desc = '[S]earch [G]it [S]tatus' })
vim.keymap.set('n', '<leader>sgc', require('telescope.builtin').git_commits, { desc = '[S]earch [G]it [C]ommits' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch Current [W]ord' })
vim.keymap.set('n', '<leader>sbg', require('telescope.builtin').live_grep, { desc = '[S]earch [B]y [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [F]ind prefix
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[F]ind Existing [B]uffers' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[F]ind [R]ecently Opened Files' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  modules = {},         -- i don't know what this does but the linter was complaining
  sync_install = false, -- default false
  ignore_install = {},
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'css',
    'glimmer',
    'go',
    'html',
    'java',
    'javascript',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
  },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>se', vim.diagnostic.open_float, { desc = '[S]how floating diagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.setloclist, { desc = 'Open diagnostics in [L]ocalList' })

-- disable floating virtual text - use <space>le to open local list and jump around
vim.diagnostic.config({
  virtual_text = false
})

-- Show line diagnostics automatically in hover window
-- vim.o.updatetime = 500
-- vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('<leader>su', require('telescope.builtin').lsp_references, 'Show Usages') -- this is a dupe of [G]oto [R]eferences
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  -- vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
  --   vim.lsp.buf.format()
  -- end, { desc = 'Format current buffer with LSP' })
  -- nmap('<leader>rf', vim.lsp.buf.format, '[R]e[f]ormat Code')
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },
  -- jdtls = {},
  gopls = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = {
        disable = { "missing-fields" },
      },
      format = {
        enable = true,
        defaultConfig = {
          indent_style = "space",
          indent_size = "4",
        }
      },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  -- disable in markdown files
  enabled = function()
    return (vim.bo.filetype ~= "markdown")
  end,
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}


-- set some options for "textual" files to enhance readability
local spellGroup = vim.api.nvim_create_augroup("spell_files", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = { "*.md, *.txt" },
  group = spellGroup,
  command = "setlocal spell wrap linebreak conceallevel=1",
  -- this is nice, but will mess with copy/paste
  --command = "setlocal spell wrap linebreak autoindent formatoptions=tacqw textwidth=80 wrapmargin=0",
})

-- auto save the buffer
-- vim.opt.autowriteall = true

-- spelling; this doesn't work very well
-- vim.opt.spell = true


-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
