# Set noop to true as default for current and children scopes, or 'reset' an inherited default with noop(false)
Puppet::Parser::Functions::newfunction(:noop, :arity => 1) do |args|
  raise(Puppet::ParseError, "noop(): Requires an array") unless args[0].is_a? Array

  require 'pry'
  binding.pry
  
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
