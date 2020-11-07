;;; ;; test/text-adjust-test.el ---
;; Copyright (C) 2020 by Free Software Foundation, Inc.
;;
;; Author: Youhei SASAKI <uwabami@gfd-dennou.org>
;;
;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.
;;
;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.
;;
;;; Commentary:
;;
;;; Code:
(require 'ert)
(require 'text-adjust)

;; setup
(defmacro text-adjust-test-with-test-buffer (&rest body)
  (declare (indent 0) (debug t))
  `(let ((test-buffer-name "*text-adjust test*"))
     (save-excursion
       (when (get-buffer test-buffer-name)
         (kill-buffer test-buffer-name))
       (switch-to-buffer (get-buffer-create test-buffer-name))
       ,@body)))

(defmacro text-adjust-test-with-common-setup (&rest body)
  (declare (indent 0) (debug t))
  `(text-adjust-test-with-test-buffer
    ,@body))

(ert-deftest text-adjust-test-codecheck ()
  "test: codecheck"
  (text-adjust-test-with-common-setup
   (insert "ｱｲｳｴｵabcde")
   (text-adjust-codecheck-buffer)
   (should (string-equal (buffer-string) "〓〓〓〓〓abcde"))))

(ert-deftest text-adjust-test-hankaku ()
  "test: hankaku"
  (text-adjust-test-with-common-setup
   (insert "ＡＢＣＤＥabcde")
   (text-adjust-hankaku-buffer)
   (should (string-equal (buffer-string) "ABCDEabcde"))))

(ert-deftest text-adjust-test-kutouten ()
  "test:kutouten."
  (text-adjust-test-with-common-setup
   (insert "あ，い, う. え、お。")
   (text-adjust-kutouten-buffer)
   (should (string-equal (buffer-string) "あ, い, う. え, お."))))

(ert-deftest text-adjust-test-space ()
  "test: space"
  (text-adjust-test-with-common-setup
   (insert "あaいbうcえdおe")
   (text-adjust-space-buffer)
   (should (string-equal (buffer-string) "あ a い b う c え d お e"))))

(ert-deftest text-adjust-test ()
  "test: all"
  (text-adjust-test-with-common-setup
   (insert "ｱあa，ｲいb, ｳうc. ｴえd、ｵおe。")
   (text-adjust-buffer)
   (should (string-equal (buffer-string) "〓あ a, 〓い b, 〓う c. 〓え d, 〓お e."))))

(provide 'text-adjust-test)
