module Account
  class DefaultPayload
    def self.payload(user:)
      {
        user_id: user.id,
        exp: Time.current.to_i * 3 * 60 * 60
      }
    end
  end
end
