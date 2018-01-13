echo "Serving from \"dist/\" on :3000 with json-server on :4000"
concurrently --kill-others \
  "yarn run json:server" \
  "yarn run serve"
