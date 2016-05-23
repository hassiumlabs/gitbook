
docker run -it --rm -v $(pwd):/srv/gitbook -v $(pwd)/html:/srv/html spohnan/gitbook bash
gitbook init

docker run -v $(pwd):/srv/gitbook -v $(pwd)/html:/srv/html -p 4000:4000 spohnan/gitbook