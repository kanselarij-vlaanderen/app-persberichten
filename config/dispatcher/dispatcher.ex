defmodule Dispatcher do
  use Matcher

  define_accept_types [
    html: ["text/html", "application/xhtml+html"],
    json: ["application/json", "application/vnd.api+json"],
  ]

  @any %{}
  @json %{
    accept: %{
      json: true
    }
  }
  @html %{
    accept: %{
      html: true
    }
  }

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

  match "/publication-channels/*path", @json do
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

  match "/mock/sessions/*path", @json do
    forward conn, path, "http://mock-login/sessions/"
  end

  match "/sessions/*path", @json do
    forward conn, path, "http://login/sessions/"
  end

  get "/users/*path", @json do
    forward conn, path, "http://cache/users/"
  end

  get "/accounts/*path", @json do
    forward conn, path, "http://cache/accounts/"
  end

  get "/user-groups/*path", @json do
    forward conn, path, "http://cache/user-groups/"
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

  match "/contact-lists/*path", @json do
    forward conn, path, "http://cache/contact-lists/"
  end

  match "/contact-items/*path", @json do
    forward conn, path, "http://cache/contact-items/"
  end

  get "/government-domains/*path", @json do
    forward conn, path, "http://cache/government-domains/"
  end

  get "/government-fields/*path", @json do
    forward conn, path, "http://cache/government-fields/"
  end

  get "/token-claims/*path", @json do
    # Directly connecting to resource since there seems to be a bug in cache clearing
    # when cache entries for multiple authorization groups must be cleared
    forward conn, path, "http://resource/token-claims/"
  end

  post "/collaboration-activities/:id/claims", @json do
    forward conn, [], "http://collaboration/collaboration-activities/" <> id <> "/claims"
  end

  delete "/collaboration-activities/:id/claims", @json do
    forward conn, [], "http://collaboration/collaboration-activities/" <> id <> "/claims"
  end

  post "/collaboration-activities/:id/approvals", @json do
    forward conn, [], "http://collaboration/collaboration-activities/" <> id <> "/approvals"
  end

  delete "/collaboration-activities/:id/approvals", @json do
    forward conn, [], "http://collaboration/collaboration-activities/" <> id <> "/approvals"
  end

  post "/collaboration-activities/:id/share", @json do
    forward conn, [], "http://collaboration/collaboration-activities/" <> id <> "/share"
  end

  put "/collaboration-activities/*path", @json do
    forward conn, path, "http://collaboration/collaboration-activities/"
  end

  delete "/collaboration-activities/*path", @json do
    forward conn, path, "http://collaboration/collaboration-activities/"
  end

  match "/collaboration-activities/*path", @json do
    # Directly connecting to resource since there seems to be a bug in cache clearing
    # when cache entries for multiple authorization groups must be cleared
    forward conn, path, "http://resource/collaboration-activities/"
  end

  get "/approval-activities/*path", @json do
    # Directly connecting to resource since there seems to be a bug in cache clearing
    # when cache entries for multiple authorization groups must be cleared
    forward conn, path, "http://resource/approval-activities/"
  end

  match "/press-release-activities/*path", @json do
    forward conn, path, "http://cache/press-release-activities/"
  end

  get "/csv/:id/parse", @json do
    forward conn, [], "http://csv-file-parser/csv/" <> id <> "/parse"
  end

  get "/images/*path", @any do
    forward conn, path, "http://static-file/images/"
  end

  match "/*_", %{ last_call: true } do
    send_resp(conn, 404, "Route not found.  See config/dispatcher.ex")
  end

end
