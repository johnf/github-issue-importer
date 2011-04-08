require 'json'
require 'open-uri'

module GithubIssueImporter
  class Launchpad

    def initialize
      @owners = Hash.new
    end

    def get_bug_entries(project)
      bugs = get "https://api.launchpad.net/1.0/#{project}?ws.op=searchTasks"
      bugs['entries']
    end

    def get_bug(id)
      if id.is_a? Hash
        bug_link = id['bug_link']
      else
        bug_link = "https://api.launchpad.net/1.0/bugs/#{id}"
      end
      get bug_link
    end

    def get_bug_comments(id)
      if id.is_a? Hash
        bug_comments_link = id['messages_collection_link']
      else
        bug_comments_link = "https://api.launchpad.net/1.0/bugs/#{id}/comments"
      end
      comments = get bug_comments_link
      comments['entries']
    end

    def get_owner(id)
      if id.is_a? Hash
        owner_link = id['owner_link']
      else
        owner_link = "https://api.launchpad.net/1.0/~#{id}"
      end

      if @owners[owner_link].nil?
        @owners[owner_link] = get owner_link
      end

      @owners[owner_link]
    end

    def get(url)
      JSON.parse open(url).read
    end

  end
end

