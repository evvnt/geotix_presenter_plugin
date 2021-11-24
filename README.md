# Evvnt Theme Presenter Plugin

A plugin for [COPRL](http://github.com/coprl/presenters) containing styles for the Evvnt branded theme.

Presenters themes are based on top of [theming MDC](https://material.io/develop/web/theming/theming-guide) components.
It uses a sparse loading of themed styles ontop of the default [COPRL] theme. 
This means unless you are changing the theme of a given component you should not copy it to the theme.

In some cases the [COPRL] presenters defaults may move ahead of the theme, 
in that case you need to copy the file from the presenters and re-apply the theme changes. 
This could be the source of subtle differences.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'theme_presenter_plugin', git: 'https://github.com/evvnt/theme_presenter_plugin', require: false
```

And then execute:

    $ bundle

## Usage

Create the Rails initializer `config/initializers/presenters_plugins.rb`
    
    Coprl::Presenters::Settings.configure do |config|
        config.presenters.plugins.push(:theme)
    end

## Develop
Install [NVM](https://github.com/nvm-sh/nvm#installing-and-updating)

To change the theme edit the files in the `views/theme` directory.

Run the script

    ./scripts/build.sh

Commit and push the changes.

[COPRL]:(https://github.com/coprl/coprl)
