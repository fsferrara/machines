################################################################################
# TMP AREA.
# Create my temp area
################################################################################
if [ -z "$TMP" ]; then
   export TMP=/tmp/$USER
   mkdir -p $TMP/bin
   export PATH=$TMP/bin:$PATH
fi
