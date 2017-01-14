# Frontend

This is **frontend/theming** build which tries to remove frontend development and CSS theming out of Drupal site which should be free of Sass files and build tools.

The structure here largely depends on basic theming techniques but please try to remove any build process and tools from the theme itself here.

In the future, build process will include:

- [ ] autoprefixing
- [ ] CSS optimization (uglify for stage/prod)
- [ ] CSS evaluation (number of selectors, properties, depth)
- [ ] CSS linting
- [ ] Sass linting
- [ ] JS optimization (uglify, concatenate)
- [ ] Vendor libraries inclusion
- [ ] Images optimization
- [ ] Critical CSS separation for page inlining
- [ ] Inlining images, fonts, SVGs
- [ ] JS linting
- [ ] Sprites
- [ ] PostCSS processing

(feel free to suggest new tasks or order in [issues](https://gitlab.com/MacMladen/mci-boilerplate-d8/issues), we will translate that to `gulp` or whatever the current task runner is)

## Structure

- **./scss** — main entry point should be **styles.scss** and it should include everything else. Later, there should also be **critical.scss** that should be inlined in page.
- **./scss/{{sub_directories}}** — everything should be organized into some meaningful structure into subdirectories. [Sass boilerplate](https://github.com/HugoGiraudel/sass-boilerplate/) could be used as starting point and every component should be in its own file or even (another) subdirectory if needed. That separation eases readability and maintainability.
- **./images** — this will actually contain all source CSS images/SVGs (such as background) and those will be optimized and saved to theme. 
- **./media** — this is for media that will be "hardcoded" included (such as slider) or dynamically included but needs to be optimized and saved to theme.
- **./js** — hold source JS code which will be minified and concatenated into single file inside theme.
- **./fonts** — those will probably just be copied unless they will be inlined.
- **./node_modules** — will hold `node` components of the workflow but also vendor libraries that are hosted there
- **./vendor** — should hold all vendor libraries with their directory named as `library_version` for easier management.

## Recommended frontend workflow

As we are trying to optimize resource loading as early as possible, you should have all styles generated in one **styles.css** or two, one with **critical.css** that will get inlined in page and everything else in **styles.css**.
