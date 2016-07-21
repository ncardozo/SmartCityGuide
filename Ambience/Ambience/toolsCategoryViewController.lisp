(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @toolsCategoryViewController (clone @object))
(add-slot @toolsCategoryViewController categories ())

(defmethod table-view ((tcvc @toolsCategoryViewController) (index))
	(defvar *category* (nth index categories))
	(format t "~d" (name *category*))
	(format t "Category color BLACK"))
	
;;ADAPTATONS
(with-context (@color)
	(defmethod table-view ((tcvc @toolsCategoryViewController) (index))
		(defvar *category* (nth index categories))
		(format t "~d" (get-name *category*))
		(format t "Category color ~d" (color *category*)))
)
