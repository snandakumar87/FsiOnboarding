PRJ_SUFFIX=${ARG_PROJECT_SUFFIX:-`echo $OPENSHIFT_USER | sed -e 's/[^-a-z0-9]/-/g'`}
PRJ=("$PRJ_NAME" "RHPAM7 Order IT Hardware Demo" "$PRJ_DESCRIPTION")
