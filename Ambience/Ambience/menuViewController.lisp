(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @menuViewController (clone @object))
(add-slot @menuViewController pvc nil)

(defmethod load-tour ((mvc @menuViewController))
	(display-poi pvc 1))
	
;;ADAPTATIONS
(with-context (@guidedTour)
	(defmethod laod-tour ((mvc @menuViewController))
		(activate @guidedTour)
		(defvar *itineraryId*)
		(defvar *res* (sql-select :columns (list "id")
		            :tables (list "Itinerary")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "user")
					                                     :right (sql-identifier :name (get-id user)))))
		(setf *itineraryId* (read-line t))
		(display-poi pvc 1 *itineraryId*)
)

(with-context (@freeVisit)
	(defmethod load-tour ((mvc @menuViewController))
		(deactivate @guidedTour)
		(display-poi pvc 1))
)
