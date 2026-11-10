#!/bin/sh
# Publish this repo to GitBook as a public site: space -> Git import -> site -> publish.
#   GITBOOK_API_TOKEN=... ./gitbook-publish.sh   (token: app.gitbook.com/account/developer)
# Idempotent enough: re-running imports again into the space id stored in .gitbook-ids.
set -e
A="Authorization: Bearer $GITBOOK_API_TOKEN"; J="Content-Type: application/json"; G=https://api.gitbook.com/v1
ORG=${GITBOOK_ORG:-$(curl -s -H "$A" $G/orgs | python3 -c 'import json,sys;print(json.load(sys.stdin)["items"][0]["id"])')}
[ -f .gitbook-ids ] && . ./.gitbook-ids
[ -n "$SPACE" ] || SPACE=$(curl -s -H "$A" -H "$J" -X POST $G/orgs/$ORG/spaces -d '{"title":"AI GIF Maker API"}' | python3 -c 'import json,sys;print(json.load(sys.stdin)["id"])')
curl -s -o /dev/null -w "git import %{http_code}\n" -H "$A" -H "$J" -X POST $G/spaces/$SPACE/git/import \
  -d '{"url":"https://github.com/hanshs474/aigifmaker-docs.git","ref":"refs/heads/main","force":true}'
[ -n "$SITE" ] || { SITE=$(curl -s -H "$A" -H "$J" -X POST $G/orgs/$ORG/sites -d '{"title":"AI GIF Maker API","type":"basic"}' | python3 -c 'import json,sys;print(json.load(sys.stdin)["id"])')
  curl -s -o /dev/null -H "$A" -H "$J" -X POST $G/orgs/$ORG/sites/$SITE/site-spaces -d "{\"spaceId\":\"$SPACE\"}"; }
printf 'ORG=%s\nSPACE=%s\nSITE=%s\n' "$ORG" "$SPACE" "$SITE" > .gitbook-ids
curl -s -o /dev/null -H "$A" -H "$J" -X PATCH $G/orgs/$ORG/sites/$SITE -d '{"visibility":"public","basename":"aigifmaker-api"}'
curl -s -o /dev/null -H "$A" -X POST $G/orgs/$ORG/sites/$SITE/publish
curl -s -H "$A" $G/orgs/$ORG/sites/$SITE | python3 -c 'import json,sys;d=json.load(sys.stdin);print(d.get("visibility"),d.get("urls",{}).get("published"))'
