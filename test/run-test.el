;;; ;; test/run-test.el ---
;; Copyright (C) 2020 by Free Software Foundation, Inc.
;;;
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

;;; Commentary:

;;; Code:

(message "Running tests on Emacs %s" emacs-version)

;; Utils
(defun text-adjust:test-join-path (path &rest rest)
  "Join a list of PATHS with appropriate separator (such as /).
\(fn &rest paths)"
  (if rest
      (concat (file-name-as-directory path) (apply 'text-adjust:test-join-path rest))
    path))

(defconst text-adjust:test-dir
  (if load-file-name
      (file-name-directory load-file-name)
    ;; Fall back to default directory (in case of M-x eval-buffer)
    default-directory)
  "Directory of the test suite.")

(defconst text-adjust:root-dir (expand-file-name (concat text-adjust:test-dir "..")))

;; Setup `load-path'
(mapc (lambda (p) (add-to-list 'load-path p))
      (list text-adjust:test-dir
            text-adjust:root-dir))

(load "text-adjust-test")

;; Run tests
(if noninteractive
    (ert-run-tests-batch-and-exit)
  (ert t))

(provide 'run-test)
;;; run-test.el ends here
