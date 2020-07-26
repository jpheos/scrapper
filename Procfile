web: bundle exec puma -t 5:5 -w 4 -p ${PORT:-3000} -e ${RACK_ENV:-development}
release: rails db:migrate
