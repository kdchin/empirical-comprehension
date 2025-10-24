with comments_on_prs as (
  SELECT
    COUNT(DISTINCT id) AS non_bot_comment_count,
    COUNT(DISTINCT COALESCE(
                    JSON_EXTRACT_SCALAR(payload, '$.issue.pull_request.url'),
                    JSON_EXTRACT_SCALAR(payload, '$.pull_request.url')
            )) AS pr_url_count,
    COUNT(DISTINCT cOALESCE(
      JSON_EXTRACT_SCALAR(payload, '$.comment.user.login'), -- Path for IssueCommentEvent
      JSON_EXTRACT_SCALAR(payload, '$.review.user.login') -- Path for PullRequestReviewCommentEvent
    )) as n_comment_authors_count,
      -- repo.name as repo_name,
      repo.id as repo_id
  FROM
    `githubarchive.month.*`
    -- `githubarchive.day.2024*`

  WHERE
    (_TABLE_SUFFIX BETWEEN '202304' AND '202505')
    -- (_TABLE_SUFFIX BETWEEN '202501' AND '202502')
    -- (_TABLE_SUFFIX BETWEEN '0601' AND '0606')
    AND (
      type = 'PullRequestReviewEvent'
      OR
      (type = 'IssueCommentEvent'   -- Filter out comments on issues that are *not* pull requests
      AND JSON_EXTRACT_SCALAR(payload, '$.issue.pull_request.url') IS NOT NULL)
      OR
      (type = 'PullRequestReviewCommentEvent'
      AND JSON_EXTRACT_SCALAR(payload, '$.review.body') is NOT NULL)
    )
    AND repo.id in (
  51980455,
  24195339,
  3638964,
  50904245,
  6765281,
  4710920,
  23418517,
  17165658,
  32848140,
  699532645,
  1181927,
  589831718,
  523379232,
  133442384,
  4164482,
  365244061,
  9384267,
  77213120,
  29028775,
  160919119,
  290882787,
  331107018,
  15634981,
  27729880,
  12888993,
  203587744,
  155220641,
  33015583,
  71948498,
  100060912,
  20929025,
  41881900,
  193215554,
  80945428,
  22067521,
  5108051,
  90796663,
  724712,
  299354207,
  843222,
  6296790,
  52980493,
  196701619,
  45717250,
  22887094,
  641656392,
  257485422,
  137078487,
  33791743,
  340547520,
  31006158
  )
  and 
      cOALESCE(
      JSON_EXTRACT_SCALAR(payload, '$.comment.user.type'), -- Path for IssueCommentEvent
      JSON_EXTRACT_SCALAR(payload, '$.review.user.type') -- Path for PullRequestReviewCommentEvent
      -- actor.login -- The most reliable path, as it's a top-level field
      ) != 'Bot'
  -- -- Filter out common bot accounts, case-insensitive
  -- AND NOT REGEXP_CONTAINS(
  --   cOALESCE(
  --   JSON_EXTRACT_SCALAR(payload, '$.comment.user.login'), -- Path for IssueCommentEvent
  --   JSON_EXTRACT_SCALAR(payload, '$.review.user.login') -- Path for PullRequestReviewCommentEvent
  --   -- actor.login -- The most reliable path, as it's a top-level field
  --   ),
  -- '(?i)(^dependabot|bot$|-bot$|-ci$|k8s-|kube-|-helper|^Copilot|automerge|github-actions)')
  -- AND cOALESCE(
  --   JSON_EXTRACT_SCALAR(payload, '$.comment.user.login'), -- Path for IssueCommentEvent
  --   JSON_EXTRACT_SCALAR(payload, '$.review.user.login'), -- Path for PullRequestReviewCommentEvent
  --   actor.login -- The most reliable path, as it's a top-level field
  -- ) != 'Copilot'

  group by repo.id
),

repos as (
  SELECT
    repo.id AS repo_id,
    repo.name as repo_name
  FROM
    `githubarchive.month.202509` -- Query a recent month
  WHERE
    repo.name in (
      'tensorflow/tensorflow',
  'electron/electron',
  'facebook/react-native',
  'microsoft/terminal',
  'godotengine/godot',
  'bitcoin/bitcoin',
  'opencv/opencv',
  'tesseract-ocr/tesseract',
  'ocornut/imgui',
  'grpc/grpc',
  'x64dbg/x64dbg',
  'angular/angular',
  'microsoft/vscode',
  'vuejs/core',
  'hoppscotch/hoppscotch',
  'n8n-io/n8n',
  'nestjs/nest',
  'puppeteer/puppeteer',
  'Eugeny/tabby',
  'microsoft/TypeScript',
  'vitejs/vite',
  'apache/spark',
  'spring-projects/spring-kafka',
  'apache/dubbo',
  'apache/ignite',
  'elastic/elasticsearch-java',
  'apache/hadoop',
  'apache/cassandra-java-driver',
  'apache/zeppelin',
  'apache/beam',
  'spring-projects/spring-boot',
  'huggingface/transformers',
  'localstack/localstack',
  'keras-team/keras',
  'ansible/ansible',
  'scikit-learn/scikit-learn',
  'fastapi/fastapi',
  'django/django',
  -- 'CompVis/stable-diffusion',
  'FuelLabs/fuel-core',
  'rust-lang/rust',
  'tauri-apps/tauri',
  'rustdesk/rustdesk',
  'alacritty/alacritty',
  'comfyanonymous/ComfyUI',
  'home-assistant/core',
  'unionlabs/union',
  'astral-sh/uv',
  'FuelLabs/sway',
  'denoland/deno',
  'zed-industries/zed'
    )
  GROUP BY
    repo.id, repo.name
)

select * from comments_on_prs join repos on comments_on_prs.repo_id = repos.repo_id
order by repo_name asc
