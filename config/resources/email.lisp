(define-resource folder ()
  :class (s-prefix "nfo:Folder")
  :properties `((:name :string ,(s-prefix "nie:title"))
                 (:description :string ,(s-prefix "nie:description")))
  :has-many `((email :via ,(s-prefix "nmo:isPartOf")
                :inverse t
                :as "emails"))
  :resource-base (s-url "http://themis.vlaanderen.be/id/mail-folders/")
  :features '(include-uri)
  :on-path "mail-folders")

(define-resource email ()
  :class (s-prefix "nmo:Email")
  :properties `((:message-id :string ,(s-prefix "nmo:messageId"));; e-mail protocol-specific id: https://tools.ietf.org/html/rfc2822#section-3.6.4
                 (:from :string ,(s-prefix "nmo:messageFrom"))
                 (:to :string ,(s-prefix "nmo:emailTo"))
                 (:cc :string ,(s-prefix "nmo:emailCc"))
                 (:bcc :string ,(s-prefix "nmo:emailBcc"))
                 (:subject :string ,(s-prefix "nmo:messageSubject"))
                 (:content :string ,(s-prefix "nmo:plainTextMessageContent"))
                 (:html-content :string ,(s-prefix "nmo:htmlMessageContent"))
                 (:content-mime-type :string ,(s-prefix "nmo:contentMimeType"))
                 (:received-date :datetime ,(s-prefix "nmo:receivedDate"))
                 (:sent-date :datetime ,(s-prefix "nmo:sentDate")))
  :has-one `((email :via ,(s-prefix "nmo:inReplyTo")
               :as "in-reply-to")
              (folder :via ,(s-prefix "nmo:isPartOf")
                :as "folder"))
  :has-many `((file :via ,(s-prefix "nmo:hasAttachment")
                :as "attachments"))
  :resource-base (s-url "http://themis.vlaanderen.be/id/emails/")
  :features '(include-uri)
  :on-path "emails")