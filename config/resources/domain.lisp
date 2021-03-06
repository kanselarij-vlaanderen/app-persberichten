(in-package :mu-cl-resources)

(defparameter *supply-cache-headers-p* t
  "when non-nil, cache headers are supplied.  this works together with mu-cache.")
(setf *cache-model-properties-p* t)
(defparameter *include-count-in-paginated-responses* t
  "when non-nil, all paginated listings will contain the number
   of responses in the result object's meta.")
(defparameter *cache-count-queries* t)
(defparameter *cache-model-properties* t)
(setf sparql:*experimental-no-application-graph-for-sudo-select-queries* t)

(defparameter *max-group-sorted-properties* t)

(read-domain-file "press-releases.json")
(read-domain-file "collaboration.json")
(read-domain-file "government.json")
(read-domain-file "contacts.json")
(read-domain-file "files.json")
(read-domain-file "users.json")
(read-domain-file "mailing-lists.json")
(read-domain-file "email.lisp")
