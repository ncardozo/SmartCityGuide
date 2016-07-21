(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @user
	id)

(defun set-id ((user @user) (nid))
	(setf id nid))
	
(defun id ((user @user))
	id)
	
(defun get-location ((user @user))
	((random 100) (random 100)))
