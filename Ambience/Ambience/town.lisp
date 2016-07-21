(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @town (clone @object))
(add-slot @town id -1)
(add-slot @town name "")
(add-slot @town pois ())

(defmethod id ((town @town))
	id)
	
(defmethod set-id ((town @town) (nid))
	(setf id nid))
	
(defmethod name ((town @town))
	(error 'language-error :text "A language needs to be defined to get the name"))
	
(defmethod set-name ((town @town) (name))
	(error 'language-error :text "A language needs to be defined to set the name"))
	
(defmethod pois ((town @town))
	pois)
	
(defmethod add-poi ((town @town) (poi @poi))
	(append poi pois))
	
;;ADAPTATIONS
(with-context (@english)
	(defmethod name ((town @town))
		(sql-select :columns (list "name")
		            :tables (list "Town")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN")))))
	
	(defmethod set-name ((town @town) (n))
		(sql-update :table (list "Town")
	          		:columns (list "name")
             		:values (list n)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))
)

(with-context (@french)
	(defmethod name ((town @town))
		(sql-select :columns (list "name")
		            :tables (list "Town")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "FR")))))
	
	(defmethod set-name ((town @town) (n))
		(sql-update :table (list "Town")
	          		:columns (list "name")
             		:values (list n)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "FR"))))
)

(with-context (@dutch)
	(defmethod name ((town @town))
		(sql-select :columns (list "name")
		            :tables (list "Town")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "NL")))))
	
	(defmethod set-name ((town @town) (n))
		(sql-update :table (list "Town")
	          		:columns (list "name")
             		:values (list n)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "NL"))))
)
