;;; packages.el --- editing-utils layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author: edunonnn
;; URL: https://github.com/syl20bnr/spacemacs
;; URL: https://github.com/edunonnn/nonnn-cfg
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `editing-utils-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `editing-utils/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `editing-utils/pre-init-PACKAGE' and/or
;;   `editing-utils/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst editing-utils-packages
  '(xclip)
  "The list of Lisp packages required by the editing-utils layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

;; xclip package allows emacs to copy to and paste from the X clipboard
;; when running in xterm.
;; Ref:
;; http://stackoverflow.com/questions/5288213/how-can-i-paste-the-selected-region-outside-of-emacs/14659015#1465901
(defun editing-utils/init-xclip ()
  (use-package xclip
    :defer t
    :init
    (when (or
           (and (eq system-type 'darwin)
                (executable-find "pbcopy")
                t)
           (executable-find "xclip"))
      (xclip-mode 1))))

;;; packages.el ends here
