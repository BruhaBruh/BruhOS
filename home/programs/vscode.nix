{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      aaron-bond.better-comments
      bbenoist.nix
      jnoortheen.nix-ide
      bradlc.vscode-tailwindcss
      catppuccin.catppuccin-vsc-icons
      dbaeumer.vscode-eslint
      eamodio.gitlens
      github.github-vscode-theme
      k--kato.intellij-idea-keybindings
      ms-ceintl.vscode-language-pack-ru
    ];
    languageSnippets = {
      typescriptreact = {
        ReactComponent = {
          prefix = "rfc";
          description = "Create React Functional Component with arrow function";
          body = [
            "import React from 'react';"
            ""
            "export const \${1:Component}: React.FC\${2:<React.PropsWithChildren>} = (\${3:{ children \\}}) => {$0"
            "  return \${4:<>{children\\}</>};"
            "};"
            ""
          ];
        };
        ReactComponentWithForwardRef = {
          prefix = "rfr";
          description = "Create React Component with forward ref";
          body = [
            "import React from 'react';"
            ""
            "export const \${1:Component} = React.forwardRef<"
            "  \${2:HTMLDivElement},"
            "  \${3:React.PropsWithChildren}"
            ">((\${4:{ children \\}}, \${5:forwardedRef}) => {"
            "  return \${6:<div ref={\${5:forwardedRef}\\}>{children\\}</div>};"
            "});"
            "\${1:Component}.displayName = '\${1:Component}';"
            ""
          ];
        };
      };
    };
    userSettings = {
      "workbench.iconTheme" = "catppuccin-macchiato";
      "editor.tabSize" = 2;
      "editor.indentSize" = "tabSize";
      "editor.lineHeight" = 1.5;
      "editor.fontSize" = 16;
      "editor.fontLigatures" = false;
      "editor.fontVariations" = true;
      "editor.fontWeight" = "bold";
      "editor.letterSpacing" = 0.5;
      "editor.cursorWidth" = 1;
      "editor.smoothScrolling" = true;
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.minimap.enabled" = false;
      "editor.defaultFormatter" = "dbaeumer.vscode-eslint";
      "editor.formatOnType" = false;
      "editor.formatOnPaste" = false;
      "editor.formatOnSave" = true;
      "editor.formatOnSaveMode" = "file";
      "editor.codeActionsOnSave" = {
        "source.fixAll" = "always";
        "source.organizeImports" = "always";
      };
      "explorer.compactFolders" = false;
      "explorer.fileNesting.enabled" = true;
      "explorer.fileNesting.expand" = false;
      "explorer.fileNesting.patterns" = {
        "*.ts" = "$(capture).js, $(capture).d.ts.map, $(capture).*.ts, $(capture)_*.js, $(capture)_*.ts";
        "*.js" = "$(capture).js.map, $(capture).*.js, $(capture)_*.js";
        "*.jsx" = "$(capture).js, $(capture).*.jsx, $(capture)_*.js, $(capture)_*.jsx, $(capture).less, $(capture).module.less";
        "*.tsx" = "$(capture).types.ts, $(capture).props.ts, $(capture).variants.ts, $(capture).context.ts, $(capture).ts, $(capture).*.tsx, $(capture)_*.ts, $(capture)_*.tsx, $(capture).less, $(capture).module.less, $(capture).scss, $(capture).module.scss";
        "tsconfig.json" = "tsconfig.*.json";
        "package.json" = ".browserslist*, .circleci*, .commitlint*, .cz-config.js, .czrc, .dlint.json, .dprint.json*, .editorconfig, .eslint*, .firebase*, .flowconfig, .github*, .gitlab*, .gitmojirc.json, .gitpod*, .huskyrc*, .jslint*, .knip.*, .lintstagedrc*, .markdownlint*, .node-version, .nodemon*, .npm*, .nvmrc, .pm2*, .pnp.*, .pnpm*, .prettier*, .pylintrc, .release-please*.json, .releaserc*, .ruff.toml, .sentry*, .simple-git-hooks*, .stackblitz*, .styleci*, .stylelint*, .tazerc*, .textlint*, .tool-versions, .travis*, .versionrc*, .vscode*, .watchman*, .xo-config*, .yamllint*, .yarnrc*, Procfile, apollo.config.*, appveyor*, azure-pipelines*, biome.json, bower.json, build.config.*, bun.lockb, commitlint*, crowdin*, dangerfile*, dlint.json, dprint.json*, electron-builder.*, eslint*, firebase.json, grunt*, gulp*, jenkins*, knip.*, lerna*, lint-staged*, nest-cli.*, netlify*, nodemon*, npm-shrinkwrap.json, nx.*, package-lock.json, package.nls*.json, phpcs.xml, pm2.*, pnpm*, prettier.config*, pullapprove*, pyrightconfig.json, release-please*.json, release-tasks.sh, release.config.*, renovate*, rollup.config.*, rspack*, ruff.toml, simple-git-hooks*, sonar-project.properties, stylelint*, tslint*, tsup.config.*, turbo*, typedoc*, unlighthouse*, vercel*, vetur.config.*, webpack*, workspace.json, xo.config.*, yarn*";
        "*.cjs" = "$(capture).cjs.map, $(capture).*.cjs, $(capture)_*.cjs";
        "*.component.ts" = "$(capture).component.html, $(capture).component.spec.ts, $(capture).component.css, $(capture).component.scss, $(capture).component.sass, $(capture).component.less";
        "*.css" = "$(capture).css.map, $(capture).*.css";
        "*.go" = "$(capture)_test.go";
        "*.java" = "$(capture).class";
        "*.md" = "$(capture).*";
        "*.mjs" = "$(capture).mjs.map, $(capture).*.mjs, $(capture)_*.mjs";
        "*.module.ts" = "$(capture).resolver.ts, $(capture).controller.ts, $(capture).service.ts, $(capture).constants.ts, $(capture).wizard.ts, $(capture).scene.ts, $(capture).update.ts";
        "*.mts" = "$(capture).mts.map, $(capture).*.mts, $(capture)_*.mts";
        "+layout.svelte" = "+layout.ts,+layout.ts,+layout.js,+layout.server.ts,+layout.server.js,+layout.gql";
        "+page.svelte" = "+page.server.ts,+page.server.js,+page.ts,+page.js,+page.gql";
        ".env" = "*.env, .env.*, .envrc, env.d.ts";
        ".gitignore" = ".gitattributes, .gitmodules, .gitmessage, .mailmap, .git-blame*";
        "Cargo.toml" = ".clippy.toml, .rustfmt.toml, cargo.lock, clippy.toml, cross.toml, rust-toolchain.toml, rustfmt.toml";
        "Dockerfile" = "*.dockerfile, .devcontainer.*, .dockerignore, compose.*, docker-compose.*, dockerfile*";
        "Makefile" = "*.mk";
        "README*" = "AUTHORS, Authors, BACKERS*, Backers*, CHANGELOG*, CITATION*, CODEOWNERS, CODE_OF_CONDUCT*, CONTRIBUTING*, CONTRIBUTORS, COPYING*, CREDITS, Changelog*, Citation*, Code_Of_Conduct*, Codeowners, Contributing*, Contributors, Copying*, Credits, GOVERNANCE.MD, Governance.md, HISTORY.MD, History.md, LICENSE*, License*, MAINTAINERS, Maintainers, README*, Readme*, SECURITY.MD, SPONSORS*, Security.md, Sponsors*, authors, backers*, changelog*, citation*, code_of_conduct*, codeowners, contributing*, contributors, copying*, credits, governance.md, history.md, license*, maintainers, readme*, security.md, sponsors*";
        "Readme*" = "AUTHORS, Authors, BACKERS*, Backers*, CHANGELOG*, CITATION*, CODEOWNERS, CODE_OF_CONDUCT*, CONTRIBUTING*, CONTRIBUTORS, COPYING*, CREDITS, Changelog*, Citation*, Code_Of_Conduct*, Codeowners, Contributing*, Contributors, Copying*, Credits, GOVERNANCE.MD, Governance.md, HISTORY.MD, History.md, LICENSE*, License*, MAINTAINERS, Maintainers, README*, Readme*, SECURITY.MD, SPONSORS*, Security.md, Sponsors*, authors, backers*, changelog*, citation*, code_of_conduct*, codeowners, contributing*, contributors, copying*, credits, governance.md, history.md, license*, maintainers, readme*, security.md, sponsors*";
        "go.mod" = ".air*, go.sum";
        "go.work" = "go.work.sum";
        "next.config.*" = "*.env, .babelrc*, .codecov, .cssnanorc*, .env.*, .envrc, .htmlnanorc*, .lighthouserc.*, .mocha*, .postcssrc*, .terserrc*, api-extractor.json, ava.config.*, babel.config.*, capacitor.config.*, contentlayer.config.*, cssnano.config.*, cypress.*, env.d.ts, formkit.config.*, formulate.config.*, histoire.config.*, htmlnanorc.*, i18n.config.*, ionic.config.*, jasmine.*, jest.config.*, jsconfig.*, karma*, lighthouserc.*, next-env.d.ts, next-i18next.config.*, panda.config.*, playwright.config.*, postcss.config.*, puppeteer.config.*, rspack.config.*, svgo.config.*, tailwind.config.*, tsconfig.*, tsdoc.*, uno.config.*, unocss.config.*, vitest.config.*, vuetify.config.*, webpack.config.*, windi.config.*";
        "readme*" = "AUTHORS, Authors, BACKERS*, Backers*, CHANGELOG*, CITATION*, CODEOWNERS, CODE_OF_CONDUCT*, CONTRIBUTING*, CONTRIBUTORS, COPYING*, CREDITS, Changelog*, Citation*, Code_Of_Conduct*, Codeowners, Contributing*, Contributors, Copying*, Credits, GOVERNANCE.MD, Governance.md, HISTORY.MD, History.md, LICENSE*, License*, MAINTAINERS, Maintainers, README*, Readme*, SECURITY.MD, SPONSORS*, Security.md, Sponsors*, authors, backers*, changelog*, citation*, code_of_conduct*, codeowners, contributing*, contributors, copying*, credits, governance.md, history.md, license*, maintainers, readme*, security.md, sponsors*";
        "svelte.config.*" = "*.env, .babelrc*, .codecov, .cssnanorc*, .env.*, .envrc, .htmlnanorc*, .lighthouserc.*, .mocha*, .postcssrc*, .terserrc*, api-extractor.json, ava.config.*, babel.config.*, capacitor.config.*, contentlayer.config.*, cssnano.config.*, cypress.*, env.d.ts, formkit.config.*, formulate.config.*, histoire.config.*, houdini.config.*, htmlnanorc.*, i18n.config.*, ionic.config.*, jasmine.*, jest.config.*, jsconfig.*, karma*, lighthouserc.*, mdsvex.config.js, panda.config.*, playwright.config.*, postcss.config.*, puppeteer.config.*, rspack.config.*, svgo.config.*, tailwind.config.*, tsconfig.*, tsdoc.*, uno.config.*, unocss.config.*, vite.config.*, vitest.config.*, vuetify.config.*, webpack.config.*, windi.config.*";
        "vite.config.*" = "*.env, .babelrc*, .codecov, .cssnanorc*, .env.*, .envrc, .htmlnanorc*, .lighthouserc.*, .mocha*, .postcssrc*, .terserrc*, api-extractor.json, ava.config.*, babel.config.*, capacitor.config.*, contentlayer.config.*, cssnano.config.*, cypress.*, env.d.ts, formkit.config.*, formulate.config.*, histoire.config.*, htmlnanorc.*, i18n.config.*, ionic.config.*, jasmine.*, jest.config.*, jsconfig.*, karma*, lighthouserc.*, panda.config.*, playwright.config.*, postcss.config.*, puppeteer.config.*, rspack.config.*, svgo.config.*, tailwind.config.*, tsconfig.*, tsdoc.*, uno.config.*, unocss.config.*, vitest.config.*, vuetify.config.*, webpack.config.*, windi.config.*";
        "*.sqlite" = "\${capture}.\${extname}-*";
        "*.db" = "\${capture}.\${extname}-*";
        "*.sqlite3" = "\${capture}.\${extname}-*";
        "*.db3" = "\${capture}.\${extname}-*";
        "*.sdb" = "\${capture}.\${extname}-*";
        "*.s3db" = "\${capture}.\${extname}-*";
      };
      "files.autoSave" = "off";
      "security.workspace.trust.untrustedFiles" = "open";
      "eslint.format.enable" = true;
      "[json]" = {
        "editor.defaultFormatter" = "vscode.json-language-features";
      };
      "eslint.useFlatConfig" = true;
      "tailwindCSS.experimental.classRegex" = [
        [ "cva\\(([^)]*)\\)" "[\"'`]([^\"'`]*).*?[\"'`]" ]
        [ "cx\\(([^)]*)\\)" "(?:'|\"|`)([^']*)(?:'|\"|`)" ]
      ];
      "tailwindcss-intellisense.trace.server" = "verbose";
      "editor.renderWhitespace" = "all";
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
    };
  };
}
