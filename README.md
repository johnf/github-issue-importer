# Project Status

All my projects have been on GitHub for a very long time, so I haven't personally used this tool in over two years. It really scratched a once off itch when I was moving some projects from LaunchPad.

While I probably won't do any work on it myself, I'm more than happy to take pull requests and I'll do releases based on those. 

# github-issue-importer

Github Issue Importer imports bugs into github issues. Currently it only
supports Launchpad. It is hoped it will support other bug trackers in the
future.

The importer will import each bug and it's comments into github. It uses the
following algorithm for Launchpad.

* Ignore the first comment as it holds the original description
* Set the Importance as a label
* Close the bug if it is in Fix Released or Fix Committed state.
* Add a one line summary to the end of the bug and comments with link to
  Launchpad and who the original author was.

Instructions
------------

First install them gem.

    gem install github-issue-importer

To import into github, you will need a public github repository with issues
enabled. You will also need the github API token for your account which can be
found on the [Account Admin Page](https://github.com/account/admin).

You can then import a project like so

    github-issue-importer --lp-project zookeepr --gh-login johnf --gh-token TOKEN --gh-repo johnf/test

## Note on Patches/Pull Requests

* Fork the project on github.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with Rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a
  commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Licensing

github Issue Importer is MIT licensed.
