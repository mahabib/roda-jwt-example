require 'sequel/model'

DB = Sequel.connect(ENV['DB_URL'])

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false
end

# Timestamp all model instances using +created_at+ and +updated_at+
# (called before loading subclasses)
Sequel::Model.plugin :timestamps

# Automatically sets up the following types of validations for your model columns:
# type validations for all columns
# not_null validations on NOT NULL columns (optionally, presence validations)
# unique validations on columns or sets of columns with unique indexes
# max length validations on string columns
Sequel::Model.plugin :auto_validations

# Make all model subclasses use prepared statements  (called before loading subclasses)
Sequel::Model.plugin :prepared_statements

require_relative 'models/user'