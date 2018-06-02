module ServiceResponse
  def response(success:, response:, message:)
    OpenStruct.new(success?: success, response: response, message: message)
  end
end
