web:  bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}

worker1: QUEUE=high rake jobs:work
worker2: QUEUE=high rake jobs:work
worker3: QUEUE=high rake jobs:work
worker4: QUEUE=medium rake jobs:work
worker5: QUEUE=medium rake jobs:work
worker6: QUEUE=medium rake jobs:work
worker7: QUEUES=high rake jobs:work
worker8: QUEUE=low rake jobs:work

