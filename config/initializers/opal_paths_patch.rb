require "opal/paths"

# Make sure @paths is a mutable array before anything tries to append to it
paths = Opal.paths.dup
Opal.instance_variable_set(:@paths, paths)
