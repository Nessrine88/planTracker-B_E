def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = JWT.decode(token, 'your_secret_key', true, { algorithm: 'HS256' }) if token
    user_id = decoded_token.first['sub']
    User.find_by(id: user_id) if user_id
  end
  