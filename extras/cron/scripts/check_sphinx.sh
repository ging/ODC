#!/bin/bash

echo "[Start] ODC check sphinx script"

: ${RAILS_ENV="production"} #to get the environment variable or define it
: ${RAILS_ROOT="/u/apps/odc/current"}
: ${SPHINX_PID_FILE="$RAILS_ROOT/log/$RAILS_ENV.sphinx.pid"}

#Load Rbenv
if [ -z "$(which rbenv)" ]; then
        export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
        eval "$(rbenv init -)"
fi


run_sphinx=false
if test -f $SPHINX_PID_FILE; then
        sphinx_ps="$(ps -p `cat $SPHINX_PID_FILE` -o comm=)"
        if [ "$sphinx_ps" != "searchd" ]; then
                run_sphinx=true
                rm $SPHINX_PID_FILE
        fi
else
        run_sphinx=true
fi

if $run_sphinx; then
        echo "Let's run Sphinx!"
        cd $RAILS_ROOT
        SPHINX_COMMAND="bundle exec rake --silent ts:rebuild RAILS_ENV=$RAILS_ENV"
        $SPHINX_COMMAND
else
        echo "Sphinx already running"
fi

echo "[Finish] ODC check sphinx script"