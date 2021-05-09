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

  get "/publicatiekanalen/*path", @any do
    forward conn, path, "http://cache/publication-channels/"
  end

  match "/contacten/*path", @any do
    forward conn, path, "http://cache/contacts/"
  end

  match "/emailadressen/*path", @any do
    forward conn, path, "http://cache/mail-addresses/"
  end

  match "/telefoons/*path", @any do
    forward conn, path, "http://cache/telephones/"
  end

  match "/mobieletelefoons/*path", @any do
    forward conn, path, "http://cache/mobile-phones/"
  end

  get "/organizaties/*path", @any do
    forward conn, path, "http://cache/organizations/"
  end

  match "_", %{ last_call: true } do
    send_resp( conn, 404, "Route not found.  See config/dispatcher.ex" )
  end

end
