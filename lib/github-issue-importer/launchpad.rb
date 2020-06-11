require 'json'
require 'net/http'
require 'uri'

module GithubIssueImporter
  class Launchpad

    def initialize
      @owners = Hash.new
    end

    def get_bug_entries(project)
      entries = []

      url = "https://api.launchpad.net/1.0/#{project}?ws.op=searchTasks"
      loop do
        bugs = get url
        entries += bugs['entries']

        url = bugs['next_collection_link']
        break unless url
      end

      entries.sort_by! { |o| o['date_created'] }
    end

    def get_bug(id)
      if id.is_a? Hash
        bug_link = id['bug_link']
      else
        bug_link = "https://api.launchpad.net/1.0/bugs/#{id}"
      end
      get bug_link
    end

    def get_comment_attachments(comment)
	comment_attachments_link = comment['bug_attachments_collection_link']
	comment_attachments = get comment_attachments_link
	body = ""
	if !comment_attachments.nil?
	  comment_attachments['entries'].each do |attachment|
	    body += "Attachment: [#{attachment['title']}](#{attachment['data_link']})\n"
	  end
	  body += "\n"
	end
	return body
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
	  response = Net::HTTP.get_response(URI.parse(owner_link)).body
	  if response.include? "User is suspended"
	    @owners[owner_link] = response[22,response.length].concat("suspended user'")
	  else
	    json = JSON.parse response
	    @owners[owner_link] = json['display_name']
	  end
      end

      @owners[owner_link]
    end

    def get(url)
      JSON.parse Net::HTTP.get_response(URI.parse(url)).body rescue nil
    end

  end
end

