require 'govuk_tech_docs'

GovukTechDocs.configure(self)

#deal with the folder structure
#set :http_prefix, '/api-catalogue'

# use relative paths for links and sources
activate :relative_assets
set :relative_links, true 
