require_relative "config/environment"
require 'opal'

# Instead of directly appending to a frozen array, do this:
paths = Opal.paths.dup  # duplicate the frozen array
paths.concat(['app'])    # append your paths safely
Opal.instance_variable_set(:@paths, paths)  # overwrite the frozen original

# or safer, if Opal exposes append_path class method, call it like this:
Opal.append_path('app') # but if this still errors, fallback to the above

run Rails.application
