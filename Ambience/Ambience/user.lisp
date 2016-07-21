(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @user (clone @object))
(add-slot @town id -1)

(defmethod set-id ((user @user) (nid))
	(setf id nid))
	
(defmethod id ((user @user))
	id)
	
(defmethod get-location ((user @user))
	((random 100) (random 100)))
	