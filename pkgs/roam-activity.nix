{
  writeShellApplication,
  curl,
  jq,
}:

writeShellApplication {
  name = "roam-activity";
  runtimeInputs = [
    curl
    jq
  ];
  text = ''
    api="''${ROAM_API_URL:-https://api.ro.am/v1}"

    usage() {
      cat <<EOF
    Usage: roam-activity [set|info|help]

      set   Set the Roam activity (default)
      info  Print the token info (useful to find your user id)

    Environment:
      ROAM_TOKEN / ROAM_TOKEN_FILE  Personal access token (required)
      ROAM_USER_ID                  Roam user id (looked up via token.info if unset)
      ROAM_EXTERNAL_ID              Activity id           (default: nixos:ftw)
      ROAM_EMOJI                    Activity emoji        (default: ❄️)
      ROAM_TITLE                    Activity title        (default: NixOS)
      ROAM_SUBTITLE                 Activity subtitle     (default: ftw)
      ROAM_COLOR                    Activity color        (default: purple)
      ROAM_TTL                      TTL in seconds, max 3600 (default: 3600)
    EOF
    }

    token="''${ROAM_TOKEN:-}"
    if [ -z "$token" ] && [ -n "''${ROAM_TOKEN_FILE:-}" ]; then
      token="$(tr -d '[:space:]' < "$ROAM_TOKEN_FILE")"
    fi

    # Pass the token through a curl config on stdin so it never shows up in argv.
    call() {
      local method="$1" endpoint="$2"
      shift 2
      if [ -z "$token" ]; then
        echo "roam-activity: ROAM_TOKEN or ROAM_TOKEN_FILE must be set" >&2
        exit 1
      fi
      printf 'header = "Authorization: Bearer %s"\n' "$token" |
        curl --fail-with-body --silent --show-error --config - \
          -X "$method" "$api/$endpoint" "$@"
    }

    info() {
      call GET token.info
    }

    set_activity() {
      local user_id="''${ROAM_USER_ID:-}" response payload
      if [ -z "$user_id" ]; then
        response="$(info)"
        user_id="$(jq -r '.userId // .user.id // .user_id // empty' <<<"$response")"
        if [ -z "$user_id" ]; then
          echo "roam-activity: could not find a user id in token.info, set ROAM_USER_ID:" >&2
          echo "$response" >&2
          exit 1
        fi
      fi
      payload="$(
        jq -n \
          --arg externalId "''${ROAM_EXTERNAL_ID:-nixos:ftw}" \
          --arg userId "$user_id" \
          --arg emoji "''${ROAM_EMOJI:-❄️}" \
          --arg title "''${ROAM_TITLE:-NixOS}" \
          --arg subtitle "''${ROAM_SUBTITLE:-ftw}" \
          --arg color "''${ROAM_COLOR:-purple}" \
          --argjson ttl "''${ROAM_TTL:-3600}" \
          '{
            externalId: $externalId,
            userId: $userId,
            display: {
              emoji: $emoji,
              title: $title,
              subtitle: $subtitle,
              color: $color
            },
            ttlSeconds: $ttl
          }'
      )"
      call POST user.activity.set \
        -H "Content-Type: application/json" \
        --data-binary "$payload"
      echo
    }

    case "''${1:-set}" in
      set) set_activity ;;
      info) info && echo ;;
      help | -h | --help) usage ;;
      *)
        usage >&2
        exit 1
        ;;
    esac
  '';
}
