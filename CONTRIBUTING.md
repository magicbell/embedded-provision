# Contributing

# Contributing

Contributions are always welcome, no matter how large or small!

We want this community to be friendly and respectful to each other. Please follow it in all your interactions with the project. Before contributing, please read the [code of conduct](./CODE_OF_CONDUCT.md).

## Setup

We automate some common tasks, like code formatting, linting, and release notes, using tools from the Javascript ecosystem.
We use a tool called [Husky](https://typicode.github.io/husky/) to manage our git hooks.

To enable Husky, run the following commands in the root repo directory:

```shell
yarn install
```

## Development workflow

1. Do your changes
1. Test them in the example app and via `swift test`
1. Consider [adding a changeset](#changesets) via `yarn changeset`
1. Open a PR and describe your change

### Changesets

We use a tool called [Changesets](https://github.com/changesets/changesets/blob/main/docs/adding-a-changeset.md) to manage our releases.
If you make a significant change that justifies a version bump you can add one by running `yarn changeset`.

We use [semantic versioning](https://semver.org). The gist is:

> MAJOR version when you make incompatible API changes
> MINOR version when you add functionality in a backward compatible manner
> PATCH version when you make backward compatible bug fixes

Minor and patch version changes typically only need one line of explanation. Major version bumps should include an explanation of the breaking changes and upgrade steps.

### Automated releases

Once your PR with a changeset merges, an automated GitHub workflow kicks into gears and prepares a new release PR. You will automatically be tagged in that PR and can follow the release to see when your changes become publicly available.

### Sending a pull request

> **Working on your first pull request?** You can learn how from this _free_ series: [How to Contribute to an Open Source Project on GitHub](https://app.egghead.io/playlists/how-to-contribute-to-an-open-source-project-on-github).

When you're sending a pull request:

- Prefer small pull requests focused on one change.
- Verify that linters and tests are passing.
- Review the documentation to make sure it looks good.
- Follow the pull request template when opening a pull request.
- For pull requests that change the API or implementation, discuss with maintainers first by opening an issue.
