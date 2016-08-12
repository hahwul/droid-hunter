#/usr/bin/bash
echo 'Install droid-hunter'
echo ' -> install gem'
echo ' -> gem::html-table'
gem install html-table
echo ' -> gem::colorize'
gem install colorize
echo ' -> set command'
MYPWD=`pwd`
echo '#/usr/bin/ruby
ruby '$MYPWD'/dhunter.rb $*' >> /usr/bin/dhunter
echo 'Finish. run a dhunter'
