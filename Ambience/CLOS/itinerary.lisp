(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @itinerary ()
	id
	itineraryPois
	count
	currentPoi
	user)

(defun base-description-strategy ((itinerary @itinerary))
	(error 'language-error :text "A language needs to be defined to get the description"))
	
(defun base-set-description-strategy ((itinerary @itinerary) (desc))
	(error 'language-error :text "A language needs to be defined to set the description"))
	
(defun base-add-poi-strategy ((itinerary @itinerary) (poi @poi))
	(add-to-list itineraryPois poi :append t)
	(setf count (1+ count)))
	
(defun base-set-current-poi-strategy ((itinerary @itinerary) (num))
	(setf currentPoi num))
	
(defun base-get-itinerary-pois-strategy ((itinerary @itinerary))
	itineraryPois)
	
(defun base-set-user-strategy ((itinerary @itinerary) (userId))
	(setf user userId))
	
;;ADAPTATIONS
(defun english-description-strategy ((itinerary @itinerary))
	(sql-select :columns (list "description")
	            :tables (list "Itinerary")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun english-set-description-strategy ((itinerary @itinerary) (d))
	(sql-select :columns (list "description")
	            :tables (list "Itinerary")
				:values (d)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun french-description-strategy ((itinerary @itinerary))
	(sql-select :columns (list "description")
	            :tables (list "Itinerary")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun french-set-description-strategy ((itinerary @itinerary) (d))
	(sql-select :columns (list "description")
	            :tables (list "Itinerary")
				:values (d)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))	

(defun dutch-description-strategy ((itinerary @itinerary))
	(sql-select :columns (list "description")
	            :tables (list "Itinerary")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))

(defun dutch-set-description-strategy ((itinerary @itinerary) (d))
	(sql-select :columns (list "description")
	            :tables (list "Itinerary")
				:values (d)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))
