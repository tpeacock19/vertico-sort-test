;;; init.el --- description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2022 Trey Peacock
;;
;; Author: Trey Peacock <https://github/tpeacock19>
;; Maintainer: Trey Peacock <git@treypeacock.com>
;; Created: November 27, 2022
;; Modified: November 27, 2022
;; Version: 0.0.1
;; Keywords:
;; Homepage: https://github.com/tpeacock19/init
;; Package-Requires: ((emacs 29.0.50) (cl-lib "0.5"))
;;
;; This file is not part of GNU Emacs.
;;
;; This file is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by the
;; Free Software Foundation; either version 3, or (at your option) any
;; later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.
;;
;;; Commentary:
;;
;; comments
;;
;;; Code:

(setq user-init-file (expand-file-name "init.el" user-emacs-directory))
(setq custom-file (make-temp-file "emacs-custom-"))

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(setq package-user-dir (expand-file-name "elpa" user-emacs-directory))
(package-initialize)
(package-refresh-contents)
(package-install 'vertico)

(require 'vertico)
(require 'vertico-multiform)
(vertico-mode)
(vertico-multiform-mode)

(require 'project)
(setq project-read-file-name-function #'project--read-file-absolute)
(project-remember-projects-under (file-name-parent-directory default-directory))

(setq file-name-history
      `(,(expand-file-name "d-one.el" (project-root (project-current)))
        ,(expand-file-name "c-two.el" (project-root (project-current)))
        ,(expand-file-name "b-three.el" (project-root (project-current)))
        ,(expand-file-name "a-four.el" (project-root (project-current)))))

(defvar test-sort-vertico-hla '())
(defvar test-sort-vertico-ha '())
(defvar test-sort-vertico-la '())
(defvar test-sort-vertico-a '())
(defvar test-sort-minibuffer '())

(defun test-vertico-sort (cands)
  (setq test-sort-vertico-hla
        (vertico-sort-history-length-alpha cands))
  (setq test-sort-vertico-ha
        (vertico-sort-history-alpha cands))
  (setq test-sort-vertico-la
        (vertico-sort-length-alpha cands))
  (setq test-sort-vertico-a
        (vertico-sort-alpha cands))
  (setq test-sort-minibuffer
        (minibuffer--sort-by-position file-name-history cands))
  cands)

(setq vertico-multiform-categories
      '((project-file
         (vertico-sort-function . test-vertico-sort))))

(project-find-file)

(run-with-timer
 3 nil
 (lambda()
   (with-current-buffer "*scratch*"
     (dolist (sym '(test-sort-vertico-hla
                    test-sort-vertico-ha
                    test-sort-vertico-la
                    test-sort-vertico-a
                    test-sort-minibuffer))
       (insert (format "%s:\n %s\n\n" sym (symbol-value sym)))))))


(provide 'init)
;;; init.el
