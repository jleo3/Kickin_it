Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
#Paperclip::Attachment.default_options[:s3_host_name] = 's3-website-us-east-1.amazonaws.com'
#kickin_it_s3.s3-website-us-east-1.amazonaws.com

Paperclip::Attachment.default_options[:bucket] = 'kickin_it_s3'

#change defail t pic to amzon