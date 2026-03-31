vim.pack.add({
  {
    src = "https://github.com/nvim-orgmode/orgmode",
  },
})

require('orgmode').setup({
  org_agenda_files = '~/Dropbox/shm/00_org/**/*',
  org_default_notes_file = '~/Dropbox/shm/00_org/refile.org',
})
