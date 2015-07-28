#! /bin/bash

profile="standard"
sitealias=$2

if [ -z "$sitealias" ];
  sitealias="@drupalvm.dev"
fi


case $1 in
  A)
    echo "Running site-install on $2"
    ## Maybe sed would be better here.
    pass=`drush @drupalvm.dev site-install $profile -y | grep password | cut -d ' ' -f 10`
    echo "The password for admin is $pass"
    casperjs A.js $pass
    ;;
  B)
    drush @drupalvm.dev site-install $profile -y
    drush @drupalvm.dev pm-uninstall page_cache -y
    casperjs B.js
    ;;
  C)
    drush @drupalvm.dev site-install $profile -y
    casperjs C.js
    ;;
  D)
    pass=`drush @drupalvm.dev site-install $profile -y | grep password | cut -d ' ' -f 10`
    casperjs D.js $pass
    casperjs D2.js --alias=@drupalvm.dev
    ;;
esac