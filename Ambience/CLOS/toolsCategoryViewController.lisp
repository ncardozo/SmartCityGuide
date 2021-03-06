(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @toolsCategoryViewController
	categories)

(defun base-table-view-strategy ((tcvc @toolsCategoryViewController) (index))
	(defvar *category* (nth index categories))
	(format t "~d" (name *category*))
	(format t "Category color BLACK"))
	
;;ADAPTATONS
(defun color-table-view-strategy ((tcvc @toolsCategoryViewController) (index))
	(defvar *category* (nth index categories))
	(defvar *fun-name* (format nil "~dname-strategy" *lang-context*))
	(format t "~d" (funcall (intern *fun-name* *category*)))
	(format t "Category color ~d" (color *category*)))
