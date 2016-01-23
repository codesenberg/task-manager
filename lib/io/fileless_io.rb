class FilelessIO < StringIO
  attr_accessor :original_filename, :content_type

  def initialize(*args)
    super(*args)
    yield self if block_given?
  end

  def self.from(content_type, filename, content)
    new(content) do |file|
      file.original_filename = filename
      file.content_type = content_type
    end
  end
end