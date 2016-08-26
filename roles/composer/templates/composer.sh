if [ "${PATH#{{ COMPOSER_GLOBAL_BIN }}}" = "$PATH" ]; then
  PATH=$PATH:{{ COMPOSER_GLOBAL_BIN }}
  export PATH
fi
