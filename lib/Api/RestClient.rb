module RestClient
 
  class << self
    attr_accessor :timeout
    attr_accessor :open_timeout
  end
 
  def self.post(url, payload, headers={}, &block)
    Request.execute(:method => :post,
                    :url => url,
                    :payload => payload,
                    :headers => headers,
                    :timeout=>@timeout,
                    :open_timeout=>@open_timeout,
                    &block)
  end
  def self.get(url, payload, headers={}, &block)
    Request.execute(:method => :get,
                    :url => url,
                    :payload => payload,
                    :headers => headers,
                    :timeout=>@timeout,
                    :open_timeout=>@open_timeout,
                    &block)
  end
  def self.put(url, payload, headers={}, &block)
    Request.execute(:method => :put,
                    :url => url,
                    :payload => payload,
                    :headers => headers,
                    :timeout=>@timeout,
                    :open_timeout=>@open_timeout,
                    &block)
  end
  def self.delete(url, payload, headers={}, &block)
    Request.execute(:method => :delete,
                    :url => url,
                    :payload => payload,
                    :headers => headers,
                    :timeout=>@timeout,
                    :open_timeout=>@open_timeout,
                    &block)
  end
 
end