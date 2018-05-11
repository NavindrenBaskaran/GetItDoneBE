module ServiceResponse
  def response(success:, response:, error:)
    OpenStruct.new(success?: success, response: response, error: error)
  end
end
