#! /bin/bash
gsutil rsync -r -d -x 'DS_Store' ./_site gs://www.brewoahu.com
gsutil rsync -r -x 'DS_Store|index.html' ./_site gs://event.brewoahu.com
gsutil rsync -r -x 'DS_Store' ./_site/event gs://event.brewoahu.com
