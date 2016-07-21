(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @town
	id
	name
	pois)

(defun base-id-strategy ((town @town))
	id)
	
(defun base-set-id-strategy ((town @town) (nid))
	(setf id nid))
	
(defun base-name-strategy ((town @town))
	(error 'language-error :text "A language needs to be defined to get the name"))
	
(defun base-set-name-strategy ((town @town) (name))
	(error 'language-error :text "A language needs to be defined to set the name"))
	
(defun base-pois-strategy ((town @town))
	pois)
	
(defun base-add-poi-strategy ((town @town) (poi @poi))
	(append poi pois))
	
;;ADAPTATIONS
(defun english-name-strategy ((town @town))
	(sql-select :columns (list "name")
	            :tables (list "Town")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN")))))
	
(defun english-set-name-strategy ((town @town) (n))
	(sql-update :table (list "Town")
          		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun french-name-strategy ((town @town))
	(sql-select :columns (list "name")
	            :tables (list "Town")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR")))))
	
(defun french-set-name-strategy ((town @town) (n))
	(sql-update :table (list "Town")
          		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun dutch-name-strategy ((town @town))
	(sql-select :columns (list "name")
	            :tables (list "Town")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL")))))
	
(defun dutch-set-name-strategy ((town @town) (n))
	(sql-update :table (list "Town")
          		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))

