# let python36 as default python binary
if [ "${PATH#{{ PYTHON3_BINDIR }}}" = "$PATH" ]; then
  PATH={{ PYTHON3_BINDIR }}:$PATH
  export PATH
fi
