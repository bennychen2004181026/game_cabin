Rails.application.config.session_store :cookie_store, key: '_game_cabin_session', secure: Rails.env.production?
