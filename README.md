
docker run -v $(pwd):/srv/gitbook spohnan/gitbook "gitbook init"
docker run -v $(pwd):/srv/gitbook -p 4000:4000 spohnan/gitbook
