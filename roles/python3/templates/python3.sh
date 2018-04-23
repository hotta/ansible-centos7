if [ "${PATH#{{ PYTHON3_BIN }}}" = "$PATH" ]; then
  PATH={{ PYTHON3_BIN }}:$PATH
  export PATH
fi
