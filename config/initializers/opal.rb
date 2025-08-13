require 'logger'

Rails.application.configure do
  config.opal.method_missing_enabled   = true
  config.opal.const_missing_enabled    = true
  config.opal.arity_check_enabled      = true
  config.opal.freezing_stubs_enabled   = true
  config.opal.dynamic_require_severity = :ignore
end