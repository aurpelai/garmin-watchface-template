# Contributing to the Project

Contributions to the repository are always welcome!

- [Code of Conduct](#code-of-conduct)
- [Submission Guidelines](#submission-guidelines)
  - [Submitting a Pull Request (PR)](#submitting-a-pull-request-pr)
    - [Commit Message Validation](#commit-message-validation)
    - [Commit Message Format](#commit-message-format)
      - [Type](#type)
      - [Summary](#summary)
      - [Scope](#scope)
      - [Commit Message Examples](#commit-message-examples)

## Code of Conduct

🚧 UNDER CONSTRUCTION 🚧

## Submission Guidelines

<!-- ### Submitting and Issue -->

### Submitting a Pull Request (PR)

🚧 UNDER CONSTRUCTION 🚧

#### Commit Message Validation

Commit messages are validated within a workflow in our GitHub Actions, so it is suggested to set up [commitlint](https://commitlint.js.org/) within your local development environment. The easiest way to do this is to add it as a [git hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks) by placing the following content in the `.git/hooks/commit-msg` file within the project folder.

```shell
#!/bin/sh
# This is required if using Node Version Manager and Fork
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
export NODE_PATH=$(npm root -g)

npx -- commitlint --edit $1
```

#### Commit Message Format

Our project follows a version of the [Conventional Commits](https://www.conventionalcommits.org/) methology. In short, this means that the commit messages should follow the following format:

```text
<type>(<scope>): <summary>
```

The `<type>` and `<summary>` fields are mandatory, the `(<scope>)` field is optional.

##### Type

Must be one of the following:

- `build`: Changes that affect the build system or external dependencies
- `ci`: Changes to CI configuration files and scripts
- `docs`: Documentation change
- `feat`: A new feature
- `fix`: A bug fix
- `perf`: A code change that improves performance
- `refactor`: A code change that neither fixes a bug nor adds a feature

##### Summary

A summary of the changes in present tense. Not capitalized, except when mentioning specific parts in the code (e.g. `ValueComponent`). No period at the end

##### Scope

When a commit mainly targets one area of the application, it is encouraged to add a `<scope>` field to the commit message.

The following is the list of supported scopes:

- `comps`: A code change that affects one or more _components_
- `ctrlrs`: A code change that affects one or more _controllers_
- `settings`: A code change that affects the watch face's settings
- `types`: A code change that affects the _typing_ of the code
- `utils`: A code change that mainly affects the `Utils` module

##### Commit Message Examples

```shell
  git commit -m "docs: add important information to README.md"

  git commit -m "feat(settings): add a settings menu"
```
