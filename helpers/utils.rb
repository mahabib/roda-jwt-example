module Utils
  def self.indifferent_data(data)
    # return data.reduce({}) do |memo, (k, v)|
    #   memo.tap { |m| m[k.to_sym] = indifferent_data(v) }
    # end if data.is_a? Hash
      
    # return data.reduce([]) do |memo, v| 
    #   memo << indifferent_data(v); memo
    # end if data.is_a? Array

		case data
		when Hash
			hash = Hash.new{|h, k| h[k.to_s] if Symbol === k}
			data.each{|k, v| hash[k] = indifferent_data(v)}
			hash
		when Array
			data.map{|x| indifferent_data(x)}
		else
			data
		end
  end

	def self.strip_and_squeeze(data)
		data.each do |key, val|
			if val.is_a? String
				data[key] = val.strip.squeeze(" ")
			else
				data[key] = val
			end
		end
		data
	end
	
	def self.slug(text)
		text ? text.strip.downcase.split(/\W+/).join("-") : ""
	end
end