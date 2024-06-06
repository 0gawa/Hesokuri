OmniAuth.config.test_mode = true

OmniAuth.config.mock_auth[:line] = OmniAuth::AuthHash.new(
  provider: 'line', 
  uid: '12345', 
  info: { email: 'test1@example.com', name: 'test_user' },
  credentials: { token: '1234qwer' }
)