(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @itinerary (clone @object))
(add-slot @itinerary 'id 1)
(add-slot @itinerary 'itineraryPois ())
(add-slot @itinerary 'count 0)
(add-slot @itinerary 'currentPoi 0)
(add-slot @itinerary 'user -1)

(defmethod description ((itinerary @itinerary))
	(error 'language-error :text "A language needs to be defined to get the description"))
	
(defmethod set-description ((itinerary @itinerary) (desc))
	(error 'language-error :text "A language needs to be defined to set the description"))
	
(defmethod add-poi ((itinerary @itinerary) (poi @poi))
	(add-to-list itineraryPois poi :append t)
	(setf count (1+ count)))
	
(defmethod set-current-poi ((itinerary @itinerary) (num))
	(setf currentPoi num))
	
(defmethod get-itinerary-pois ((itinerary @itinerary))
	itineraryPois)
	
(defmethod set-user ((itinerary @itinerary) (userId))
	(setf user userId))
	
;;ADAPTATIONS
(with-context (@english)
	(defmethod description ((itinerary @itinerary))
		(sql-select :columns (list "description")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))

	(defmethod set-description ((itinerary @itinerary) (d))
		(sql-select :columns (list "description")
		            :tables (list "Itinerary")
					:values (list d)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))
)

(with-context (@french)
	(defmethod description ((itinerary @itinerary))
		(sql-select :columns (list "description")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "FR"))))

	(defmethod set-description ((itinerary @itinerary) (d))
		(sql-select :columns (list "description")
		            :tables (list "Itinerary")
					:values (list d)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "FR"))))
)	

(with-context (@dutch)
	(defmethod description ((itinerary @itinerary))
		(sql-select :columns (list "description")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "NL"))))

	(defmethod set-description ((itinerary @itinerary) (d))
		(sql-select :columns (list "description")
		            :tables (list "Itinerary")
					:values (list d)
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "NL"))))
)