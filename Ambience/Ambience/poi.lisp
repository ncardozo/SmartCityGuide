(in-package #:cl-user)
(defpackage #:scg (:use #:amos-cl))
(in-package #:scg)

(defproto @poi (clone @object))
(add-slot @poi 'id 1)
(add-slot @poi 'name "")
(add-slot @poi 'description "")
(add-slot @poi 'address "")
(add-slot @poi 'category nil)
(add-slot @poi 'state flase)
(add-slot @poi 'image "")
(add-slot @poi 'schedule nil)
(add-slot @poi 'latitude "")
(add-slot @poi 'longitude "")

(defmethod description ((poi @poi))
	(error 'language-error :text "A language needs to be defined to get the description"))
	
(defmethod set-description ((poi @poi) (desc))
	(error 'language-error :text "A language needs to be defined to set the description"))
	
(defmethod name ((poi @poi))
	(error 'language-error :text "A language needs to be defined to get the name"))
	
(defmethod set-name ((poi @poi) (name))
	(error 'language-error :text "A language needs to be defined to set the name"))
	
(defmethod address ((poi @poi))
	(error 'language-error :text "A language needs to be defined to get the address"))
	
(defmethod set-address ((poi @poi) (address))
	(error 'language-error :text "A language needs to be defined to set the address"))
	
(defmethod add-category ((poi @poi) (cat @category))
	(setf category cat))
	
(defmethod category ((poi @poi))
	'category)
	
(defmethod set-state ((poi @poi) (s))
	(setf state s))
	
(defmethod p-closed ((poi @poi))
	(p-in-schedule schedule (get-decoded-time)))
	
(defmethod image ((poi @poi))
	(error 'time-error :text "A time needs to be defined to get the image"))
	
(defmethod set-image ((poi @poi) (img))
	(error 'time-error :text "A time needs to be defined to set the image"))
	
(defmethod distance-between ((x @poi) (y @poi))
	)
	
(defmethod prit ((poi @poi))
	(format t "POI Information~%")
	(format t "Id: ~d~%" (id poi))
	(format t "Name: ~d~%" (name poi))
	(format t "Description: ~d~%" (description poi))
	(format t "Address: ~d~%" (addess poi))
	(format t "Image: ~D~%" (image poi))
	(format t "State: ~b~%" (state poi))
	(format t "Closed: ~b~%" (p-closed poi)))

;;ADAPTATIONS
(with-context (@english)
	(defmethod name ((poi @poi))
		(sql-select :columns (list (sql-all-columns))
		            :tables (list "Poi")
					:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))
	(defmethod set-name ((poi @poi) (n))
		(sql-insert :table "poi"
		            :columns (list "name")
		            :values (list n)))
)	
	