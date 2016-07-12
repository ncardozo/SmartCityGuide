(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @category (clone @object))
(add-slot @category id 1)
(add-slot @category color "gray")
(add-slot @category name "")

(defmethod name ((category @category))
	(error 'language-error :text "A language needs to be defined to get the name"))
	
(defmethod set-name ((category @category) (n))
	(error 'language-error :text "A language needs to be defined to set the name"))
	
(defmethod id ((category @ category))
	'id)
	
(defmethod color ((category @category))
	'color)

(defmethod set-color ((category @category) (col))
	(setf 'color col))
	
;;ADAPTATIONS
(with-context (@english)
	(defmethod name ((category @category))
		(sql-select :columns (list "name")
		            :tables (list "Category")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))

	(defmethod set-name ((category @category) (n))
			(sql-update :table "Category"
	              		:columns (list "name")
	              		:values (list n)
						:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))
)