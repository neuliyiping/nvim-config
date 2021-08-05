local cmd = vim.cmd
-- Django specific commands
cmd [[ command! Runserver call VimuxRunCommand("clear; echo -e 'Starting local development server'; poetry run ./manage.py runserver") ]]
cmd [[ command! Makemigrations call VimuxRunCommand("clear; echo -e 'Making new migrations'; poetry run ./manage.py makemigrations") ]]
cmd [[ command! RunTests call VimuxRunCommand("clear; echo -e 'Running Django Test Suite'; pdj") ]]
cmd [[ command! RunLinter call VimuxRunCommand("clear; echo -e 'poetry run linter'; poetry run linter") ]]

-- Cargo Commands
cmd [[ command! CargoBuild call VimuxRunCommand("clear; echo -e 'cargo build'; cargo build") ]]
cmd [[ command! CargoRun call VimuxRunCommand("clear; echo -e 'cargo run'; cargo run") ]]

-- Yarn Commands
cmd [[ command! YarnServe call VimuxRunCommand("clear; echo -e 'yarn serve'; yarn serve") ]]
cmd [[ command! YarnStart call VimuxRunCommand("clear; echo -e 'yarn start'; yarn start") ]]
cmd [[ command! YarnTest call VimuxRunCommand("clear; echo -e 'yarn test'; yarn test") ]]