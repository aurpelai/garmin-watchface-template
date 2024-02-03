# garmin-watchface-template

## Commit message styling

```text
<type>(<scope>): <short summary>
  │       │             │
  │       │             └─⫸ Summary in present tense. Not capitalized. No period at the end
  │       │
  │       └─⫸ Commit Scope: types|views|ctrls|settings
  │
  └─⫸ Commit Type: build|ci|feat|fix|perf|refactor
```

The `<type>` and `<summary>` fields are mandatory, the `(<scope>)` field is optional.

### Type

Must be one of the following:

- **build**: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- **ci**: Changes to our CI configuration files and scripts (examples: CircleCi, SauceLabs)
- **feat**: A new feature
- **fix**: A bug fix
- **perf**: A code change that improves performance
- **refactor**: A code change that neither fixes a bug nor adds a feature
