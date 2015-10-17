#!/bin/sh

echo "#!/bin/bash"

cat <<EOF
if [ "\${0:0:2}" = "./" ]; then
    export LISPBOX_HOME=\`pwd\`${LISPBOX_HOME_RELATIVE}
else
    export LISPBOX_HOME=\`dirname \$0\`${LISPBOX_HOME_RELATIVE}
fi
EOF

if [ ! -z "${SBCL_DIR}" ]; then
    cat <<EOF
export SBCL_HOME=\${LISPBOX_HOME}/${SBCL_DIR}/lib/sbcl
EOF
fi

if [ ! -z "${OPENMCL_DIR}" ]; then
    cat <<EOF
export CCL_DEFAULT_DIRECTORY=\${LISPBOX_HOME}/${OPENMCL_DIR}
EOF
fi

if [ ! -z "${LINUX}" ]; then
    cat <<EOF
export EMACSDATA=\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/etc/
export EMACSDOC=\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/etc/
export EMACSLOADPATH=\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/site-lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/site-lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/leim:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/toolbar:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/textmodes:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/progmodes:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/play:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/obsolete:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/net:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/mail:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/language:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/international:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/gnus:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/eshell:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/emulation:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/emacs-lisp:\\
\${LISPBOX_HOME}/${EMACS}/share/emacs/${GNU_LINUX_EMACS_VERSION}/lisp/calendar


PATH=\$PATH:\${LISPBOX_HOME}/libexec/emacs/${GNU_LINUX_EMACS_VERSION}/i686-pc-linux-gnu
EOF

fi

cat <<EOF
exec \${LISPBOX_HOME}/${EMACS_EXE} --no-init-file --no-site-file --eval='(progn (load "lispbox") (slime))'
EOF
