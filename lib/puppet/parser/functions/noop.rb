# Set noop to true as default for current and children scopes, or 'reset' an inherited default with noop(false)
Puppet::Parser::Functions::newfunction(:noop, :doc => "Set noop default for all resources
  in local scope and children scopes. This can be overriden in
  child scopes, or explicitly on each resource.
  ") do |args|

  if args.length == 1
    unless args[0].is_a? Array
      raise(Puppet::ParseError, "noop(): Requires an array")
    end
  else
    raise(Puppet::ParseError, "noop(): Only takes one parameter")
  end



  class << resource('Class','role::test')
    def lookupdefaults(type)
      values = super(type)

      # Create a new :noop parameter with the specified value (true/false) for our defaults hash
      noop = Puppet::Parser::Resource::Param.new(
        :name => :noop, :value => true, :source => self.source )

      # Replace whatever defaults we recieved
      values[:noop] = noop
      values
    end
  end

  require 'pry'
  binding.pry

end
