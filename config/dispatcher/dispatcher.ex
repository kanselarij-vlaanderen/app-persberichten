defmodule Dispatcher do
  use Matcher

  define_accept_types [
    html: [ "text/html", "application/xhtml+html" ],
    json: [ "application/json", "application/vnd.api+json" ],
  ]

  @any %{}
  @json %{ accept: %{ json: true } }
  @html %{ accept: %{ html: true } }

  # In order to forward the 'themes' resource to the
  # resource service, use the following forward rule.
  #
  # docker-compose stop; docker-compose rm; docker-compose up
  # after altering this file.
  #
  # match "/themes/*path", @json do
  #   Proxy.forward conn, path, "http://resource/themes/"
  # end

  match "/press-releases/*path", @json do
    forward conn, path, "http://cache/press-releases/"
  end

  get "/publication-channels/*path", @json do
    forward conn, path, "http://cache/publication-channels/"
  end

  match "/publication-events/*path", @json do
    forward conn, path, "http://cache/publication-events/"
  end

  match "/contacts/*path", @json do
    forward conn, path, "http://resource/contacts/"
  end

  match "/mail-addresses/*path", @json do
    forward conn, path, "http://cache/mail-addresses/"
  end

  match "/telephones/*path", @json do
    forward conn, path, "http://cache/telephones/"
  end

  match "/mobile-phones/*path", @json do
    forward conn, path, "http://cache/mobile-phones/"
  end

  get "/organizations/*path", @json do
    forward conn, path, "http://cache/organizations/"
  end

  get "/contact-statuses/*path", @json do
    forward conn, path, "http://cache/contact-statuses/"
  end

  get "/themes/*path", @json do
    forward conn, path, "http://cache/themes/"
  end

  get "/files/:id/download", @any do
    forward conn, [], "http://file/files/" <> id <> "/download"
  end

  post "/files/*path", @any do
    forward conn, path, "http://file/files/"
  end

  delete "/files/*path", @any do
    forward conn, path, "http://file/files/"
  end

  match "/files/*path", @json do
    forward conn, path, "http://cache/files/"
  end

  match "_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
