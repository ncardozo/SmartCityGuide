(in-package #:cl-user)
(defpackage #:scgs)
(in-package #:scgs)

(defclass @poi ()
	(id
	 name
	 description
	 address
	 category
	 state
	 image
	 schedule
	 longitude
	 latitude))
	
	
(defun base-description-strategy ((poi @poi))
	(error 'language-error :text "A language needs to be defined to get the description"))
	
(defun base-set-description-strategy ((poi @poi) (desc))
	(error 'language-error :text "A language needs to be defined to set the description"))
	
(defun base-name-strategy ((poi @poi))
	(error 'language-error :text "A language needs to be defined to get the name"))
	
(defun base-set-name-strategy ((poi @poi) (name))
	(error 'language-error :text "A language needs to be defined to set the name"))
	
(defun base-address-strategy ((poi @poi))
	(error 'language-error :text "A language needs to be defined to get the address"))
	
(defun base-set-address-strategy ((poi @poi) (address))
	(error 'language-error :text "A language needs to be defined to set the address"))
	
(defun base-add-category-strategy ((poi @poi) (cat @category))
	(setf category cat))
	
(defun base-category-strategy ((poi @poi))
	'category)
	
(defun base-set-state-strategy ((poi @poi) (s))
	(setf state s))
	
(defun base-p-closed-strategy ((poi @poi))
	(p-in-schedule schedule (get-decoded-time)))
	
(defun base-image-strategy ((poi @poi))
	(error 'time-error :text "A time needs to be defined to get the image"))
	
(defun base-set-image-strategy ((poi @poi) (img))
	(error 'time-error :text "A time needs to be defined to set the image"))
	
(defun base-distance-between-strategy ((x @poi) (y @poi))
	)
	
(defun base-print-strategy ((poi @poi))
	(format t "POI Information~%")
	(format t "Id: ~d~%" (id poi))
	(format t "Name: ~d~%" (name poi))
	(format t "Description: ~d~%" (description poi))
	(format t "Address: ~d~%" (addess poi))
	(format t "Image: ~D~%" (image poi))
	(format t "State: ~b~%" (state poi))
	(format t "Closed: ~b~%" (p-closed poi)))

;;ADAPTATIONS
(defun english-name-strategy ((poi @poi))
	(sql-select :columns (list "name")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun english-set-name-strategy ((poi @poi) (n))
			(sql-update :table "poi"
	              		:columns (list "name")
	              		:values (list n)
						:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN"))))
		
(defun english-description-strategy ((poi @poi))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun english-set-description-strategy ((poi @poi) (d))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))
	
(defun englihs-address-strategy ((poi @poi))
	(sql-select :columns (list "address")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
	                                     	:right (sql-identifier :name "EN"))))

(defun english-set-address-strategy ((poi @poi) (a))
	(sql-update :table "poi"
              	:columns (list "address")
              	:values (list a)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "EN"))))

(defun french-name-strategy ((poi @poi))
	(sql-select :columns (list "name")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun french-set-name-strategy ((poi @poi) (n))
	(sql-update :table "poi"
           		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))
		
(defun french-description-strategy ((poi @poi))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun french-set-description-strategy ((poi @poi) (d))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))
	
(defun french-address-strategy ((poi @poi))
	(sql-select :columns (list "address")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
	                                     	:right (sql-identifier :name "FR"))))

(defun french-set-address-strategy ((poi @poi) (a))
	(sql-update :table "poi"
              	:columns (list "address")
              	:values (list a)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "FR"))))

(defun dutch-name-strategy ((poi @poi))
	(sql-select :columns (list "name")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))

(defun dutch-set-name-strategy ((poi @poi) (n))
	(sql-update :table "poi"
           		:columns (list "name")
           		:values (list n)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
			                                     	:right (sql-identifier :name "NL"))))
		
(defun dutch-description-strategy ((poi @poi))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))

(defun dutch-set-description-strategy ((poi @poi) (d))
	(sql-update :table "poi"
              	:columns (list "description")
              	:values (list d)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))
	
(defun dutch-address-strategy ((poi @poi))
	(sql-select :columns (list "address")
	            :tables (list "Poi")
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
	                                     			 :right (sql-identifier :name "NL"))))

(defun dutch-set-address-strategy ((poi @poi) (a))
	(sql-update :table "poi"
              	:columns (list "address")
              	:values (list a)
				:where (sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     :right (sql-identifier :name "NL"))))

(defun kidEnglish-description-strategy ((poi @poi))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "type")
														:right (sql-identifier :name "Kid")) 
							(sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     	:right (sql-identifier :name "EN")))))

(defun kidEnglish-set-description-strategy ((poi @poi) (d))
	(sql-update :table "poi"
              	:columns (list "description")
              	:values (list d)
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "type")
														:right (sql-identifier :name "Kid")) 
							(sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "EN")))))

(defun kidFrench-description-strategy ((poi @poi))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "type")
														:right (sql-identifier :name "Kid")) 
							(sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     	:right (sql-identifier :name "FR")))))

(defun kidFrench-set-description-strategy ((poi @poi) (d))
	(sql-update :table "poi"
              	:columns (list "description")
              	:values (list d)
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "type")
														:right (sql-identifier :name "Kid")) 
							(sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "FR")))))

(defun kidDutch-description-strategy ((poi @poi))
	(sql-select :columns (list "description")
	            :tables (list "Poi")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "type")
														:right (sql-identifier :name "Kid")) 
							(sql-binary-operator :name '= :left (sql-identifier :name "langauge")
				                                     	:right (sql-identifier :name "NL")))))

(defun kidDutch-set-description-strategy ((poi @poi) (d))
	(sql-update :table "poi"
              	:columns (list "description")
              	:values (list d)
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "type")
														:right (sql-identifier :name "Kid")) 
							(sql-binary-operator :name '= :left (sql-identifier :name "langauge")
					                                     :right (sql-identifier :name "NL")))))

(defun morning-image-strategy ((poi @poi))
	(sql-update :table "Poi"
              	:columns (list "image")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "poi_id")
														:right (sql-identifier :name (id poi))) 
							(sql-binary-operator :name '= :left (sql-identifier :name "time")
					                                     :right (sql-identifier :name "Morning")))))

(defun afternoon-image-strategy ((poi @poi))
	(sql-update :table "Poi"
              	:columns (list "image")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "poi_id")
														:right (sql-identifier :name (id poi))) 
							(sql-binary-operator :name '= :left (sql-identifier :name "time")
					                                     :right (sql-identifier :name "Afternoon")))))

(defun night-image-strategy ((poi @poi))
	(sql-update :table "Poi"
              	:columns (list "image")
				:where (and (sql-binary-operator :name '= :left (sql-identifier :name "poi_id")
														:right (sql-identifier :name (id poi))) 
							(sql-binary-operator :name '= :left (sql-identifier :name "time")
					                                     :right (sql-identifier :name "Night")))))
