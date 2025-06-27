if exists("current_compiler")
  finish
endif
let current_compiler = "markdownlint"

CompilerSet errorformat=%f:%l:%c\ %m
CompilerSet makeprg=markdownlint\ %
