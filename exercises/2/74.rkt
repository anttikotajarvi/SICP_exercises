; SICP 2.4.3
; Chapter: Building Abstractions with Data
; Section: Multiple Representations for Abstract Data
; Subsection: Data-Directed Programming and Additivity
; Exercise 2.74:
; Insatiable Enterprises, Inc., is a highly decentralized 
;  conglomerate company consisting of a large number of 
;  independent divisions located all over the world.
; The company's computer facilities have just been 
;  interconnected by means of a clever nnetwork-interfacing 
;  scheme that makes the entire network appear to any user to be
;  a single computer.
; Insatiable's president, in her first attempt to expoit the 
;  ability of the network to extract administrative information
;  from division files, is dismayed to discover that, although
;  all the division files have been implemented as data
;  structures in Scheme, the particular data structure used
;  varies from division to division. 
; A meeting of division managers is hastily called to search for
;  a strategy to integrate the files that will satisfy 
;  headquarters' needs while preserving nthe existing autonomy
;  of the divisions.
;
; Show how such a srategy can be implemented with data-directed
;  programming.
; As an example, suppose that each division's personnel records 
;  consist of a single file, which contains a set of records
;  keyed on employees' names.
; The structure of the sett varies from division to division.
; Furthermore, each employee's record is itself a set 
;  (structured differently from division to division) that 
;  contains information keyed under identifiers such as 'address'
;  and 'salary'. 
; In particular:
;
; a. Implement for headquarters a 'get-record' procedure that 
;    that retrieves a specified employee's record from a 
;    specified personnel file.  The procedure should be 
;    applicable to any division's file.  Explain how the 
;    individual divisions' files should be structured. 
;    In particular, what type of information must be supplied?
; ______________________________________________________________
#lang sicp
(#%require sicp-lib)
(#%require sicp-lib/generic)
;; Here lets assume every divisions personnel file is tagged 
;;  with a unique type.
;; Realistically the tag shouldnt just be "division-name" but 
;;  also tell the user what the data is, so something like:
;;  "austin#personnel-file"

(define (get-record employee-name personnel-file)
  (let ([proc (get 'get-record (type-tag personnel-file))])
    (if proc
        (proc employee-name (contents personnel-file))
        (error "Unknown division file type: GET-RECORD"
               (type-tag personnel-file)))))

; ______________________________________________________________
; b. Implement for headquarters a 'get-salary' procedure that 
;    returns the salary informaition from a given employee's 
;    record from any division's personnel file.  How should the
;    record be structured in order to make this operation work?
; ______________________________________________________________

;; The employee-file type tag could be something like 
;;  "austin#employee-record"
(define (get-salary employee-file)
  (let ([proc (get 'get-salary (type-tag employee-file))])
    (if proc
      (proc employee-file)
      (error "Unkwown emmployee file type: GET-SALARY"
            (type-tag employee-file)))))
; ______________________________________________________________
; c. Implement for headquarters a 'find-employee-record' 
;    procedure.  This should search all the divisions' files for 
;    the record of a given employee and return the record.
;    Assume that this procedure takes as arguments an employee's 
;    name and a list of all the divisions' files.
; ______________________________________________________________
(define (find-employee-record name personnel-files)
  (if (null? personnel-files)
      false
      (let* ([file (car personnel-files)]
             [res  (get-record name file)])
        (if res
            res
            (find-employee-record name
                                  (cdr personnel-files))))))
; ______________________________________________________________
; d. When Insatiable takes over a new company, what changes must
;    be made in order to incorporate the new personnel 
;    information into the central system?
; ______________________________________________________________

;; Integrating with Satiable Inc. we now just do:
;;  (define satiable-file (attach-tag 'satiable#personnel-file))
;; tagging all their data and implement their methods:
(define (install-satiable-package)

  (define (lookup-record name file)
    ;; Satiable-specific way to find employee in file
    )

  (define (salary record)
    ;; Satiable-specific way to extract salary from record
    )

  (define (tag-record record)
    (attach-tag 'satiable#personnel-record record))

  (put 'get-record
       'satiable#personnel-file
       (lambda (name file)
         (let ([record (lookup-record name file)])
           (if record
               (tag-record record)
               false))))

  (put 'get-salary
       'satiable#employee-record
       salary)
  'done)

;; And headquarters can index the file somewhere like:
(define all-personnel-files
  (list austin-file
        satiable-file))
