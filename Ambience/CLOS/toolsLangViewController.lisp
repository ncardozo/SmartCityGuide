(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @toolsLangViewController 
	langContexts)

(defun base-table-view-strategy ((tlvc @toolsLangViewController) (index))
	(setf *lang-context* (format nil "~d-" (nth index langContexts))))
	
(defun base-add-lang-context-strategy ((tlvc @toolsLangViewController) (lang))
	(append lang langContexts))
