begin

  # Include defaults


  # Explicity define
  Setting.admin_facebook_ids = [
    7002294,    # greg leuch
  ]

rescue => err
  puts "Settings Initializer Error: #{err}"
  nil
end