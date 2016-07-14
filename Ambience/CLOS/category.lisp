(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @category ()
	(id
	 name
	 color))
	
(defun base-name-strategy ((category @category))
	(error 'language-error :text "A language needs to be defined to get the name"))

(defun base-set-name-strategy ((category @category) (n))
	(error 'language-error :text "A language needs to be defined to set the name"))

(defun base-id-strategy ((category @ category))
	'id)

(defun base-color-strategy ((category @category))
	'color)

(defun base-set-color-strategy ((category @category) (col))
	(setf 'color col))

;;ADAPTATIONS
(defun english-name-strategy ((category @category))
	(sql-select :columns (list "name")
	            :tables (list "Category")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun english-set-name-strategy ((category @category) (n))
		(sql-update :table "Category"
              		:columns (list "name")
              		:values (list n)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))

(defun french-name-strategy ((category @category))
	(sql-select :columns (list "name")
	            :tables (list "Category")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun french-set-name-strategy ((category @category) (n))
	(sql-update :table "Category"
           		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun dutch-name-strategy ((category @category))
	(sql-select :columns (list "name")
	            :tables (list "Category")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))

(defun dutch-set-name-strategy ((category @category) (n))
	(sql-update :table "Category"
           		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))
