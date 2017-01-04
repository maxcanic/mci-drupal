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

