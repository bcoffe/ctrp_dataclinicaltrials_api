Aws.config.update({
                      endpoint: Rails.configuration.environment.fetch('aws_dynamo_endpoint'),
                      #endpoint: Rails.application.secrets.aws_dynamo_endpoint,
                      access_key_id: Rails.application.secrets.aws_access_key_id,
                      secret_access_key: Rails.application.secrets.aws_secret_access_key,
                      region: Rails.configuration.environment.fetch('aws_region')
                  })