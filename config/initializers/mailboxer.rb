Mailboxer.setup do |config|

  #Configures if you application uses or not email sending for Notifications and Messages
  #config.uses_emails = true
  config.uses_emails = false

  #Configures the default from for emails sent for Messages and Notifications
  config.default_from = "no-reply@mailboxer.com"

  #Configures the methods needed by mailboxer
  # These methods must be implemented in the model which will be using mailboxer
  # This method is needed only if you are going to send an email for each converstion / replies
  config.email_method = :mailboxer_email
  # This method is needed if you want to user mailboxer
  config.name_method = :mailboxer_name

  #Configures if you use or not a search engine and which one you are using
  #Supported engines: [:solr,:sphinx]
  config.search_enabled = false
  config.search_engine = :solr

  #Configures maximum length of the message subject and body
  config.subject_max_length = 255
  config.body_max_length = 32000
end
