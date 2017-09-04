Rails.application.config.session_store :cookie_store, key: '_acro_session', secure: Rails.env.production?;

