# Workflow to Maintain This Gem

I use the gem-release gem

For more info see: https://github.com/svenfuchs/gem-release#usage

## Steps for an update

1. Update code and commit it.
2. Add entry to CHANGELOG
   * h1 for major release (1.0.0)
   * h2 for minor release (0.1.0)
   * h3 for patch release (0.0.1)
3. Update version in .gemspec
4. Commit CHANGELOG and .gemspec
5. Release it.
   * `gem release`
6. Create a git tag and push to origin.
   `gem tag`
