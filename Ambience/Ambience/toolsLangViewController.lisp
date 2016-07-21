(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @toolsLangViewController (clone @object))
(add-slot @toolsLangViewController langContexts ())

(defmethod table-view ((tlvc @toolsLangViewController) (index))
	(defvar *newLang* (nth index langContexts))
	(activate *newLang*))
	
(defmethod add-lang-context ((tlvc @toolsLangViewController) (lang))
	(append lang langContexts))
	