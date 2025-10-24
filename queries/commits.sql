with commits as (
  SELECT
    repo.id as repo_id,
    COUNT(DISTINCT JSON_EXTRACT_SCALAR(commit, '$.sha')) AS unique_commit_shas,
    COUNT(DISTINCT json_extract_scalar(commit, '$.author.email')) AS unique_commit_authors
  FROM
    `githubarchive.month.*`,
      UNNEST(JSON_EXTRACT_ARRAY(payload, '$.commits')) AS commit

  WHERE
    (_TABLE_SUFFIX BETWEEN '202304' AND '202505')
    AND type = 'PushEvent'
    -- AND repo.name = 'tensorflow/tensorflow' -- Optional: Filter for a specific repository if needed
    AND JSON_EXTRACT_SCALAR(payload, '$.size') > '0' -- Filter for pushes with at least one commit
    -- AND JSON_EXTRACT_SCALAR(payload, '$.forced') = 'false' -- Optional: Exclude forced pushes
    AND JSON_EXTRACT(payload, '$.commits') IS NOT NULL -- Ensure the commits array exists
    -- Use UNNEST to flatten the commits array and access individual commit data
    AND EXISTS (
      SELECT 1
      FROM UNNEST(JSON_EXTRACT_ARRAY(payload, '$.commits')) AS commit
      WHERE commit IS NOT NULL
    )
  GROUP BY
    repo.id
  ORDER BY
    repo.id
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
  'FuelLabs/fuel-core',
  'rust-lang/rust',
  'tauri-apps/tauri',
  'rustdesk/rustdesk',
  'alacritty/alacritty',
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

select * from commits join repos on commits.repo_id = repos.repo_id
order by repo_name asc
