# The model has already been created by the framework, and extends Rhom::RhomObject
# You can add more methods here
class Signature
  include Rhom::PropertyBag

  # Uncomment the following line to enable sync with Signature.
  # enable :sync

  #add model specifc code here
  property :signature_uri, :blob
end
