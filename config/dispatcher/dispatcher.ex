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

  get "/publication-channels/*path", @any do
    forward conn, path, "http://cache/publication-channels/"
  end

  match "/contacts/*path", @any do
    forward conn, path, "http://cache/contacts/"
  end

  match "/mail-addresses/*path", @any do
    forward conn, path, "http://cache/mail-addresses/"
  end

  match "/telephones/*path", @any do
    forward conn, path, "http://cache/telephones/"
  end

  match "/mobile-phones/*path", @any do
    forward conn, path, "http://cache/mobile-phones/"
  end

  get "/organizations/*path", @any do
    forward conn, path, "http://cache/organizations/"
  end

  get "/contact-status/*path", @any do
    forward conn, path, "http://cache/contact-status/"
  end

  get "/themes/*path", @any do
    forward conn, path, "http://cache/themes/"
  end

  match "/press-releases/*path", @any do
    forward conn, path, "http://cache/press-releases/"
  end

  match "/collaboration-activities/*path", @any do
    forward conn, path, "http://cache/collaboration-activities/"
  end

  match "/publication-events/*path", @any do
    forward conn, path, "http://cache/publication-events/"
  end

  match "_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
