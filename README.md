[![Build Status](https://travis-ci.org/s12v/puppet-blackfire.svg?branch=master)](https://travis-ci.org/s12v/puppet-blackfire)

# blackfire

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with blackfire](#setup)
    * [What blackfire affects](#what-blackfire-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with blackfire](#beginning-with-blackfire)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

The blackfire module installs, configures, and manages the [Blackfire](https://blackfire.io/) PHP profiler.

## Module Description

The blackfire module handles installing, configuring, and running Blackfire Agent and Probe (PHP extension) across a range of operating systems and distributions.

## Setup

### Beginning with blackfire

Agent and php extension can be installed separately.
You need to provide at least `server_id` and `server_token` parameters, therefore
minimum configuration for agent and php looks like this:
```puppet
class { 'blackfire':
	server_id    => 'b54114a9-df8a-563b-8ba3-e5457155010e',
	server_token => '7315b1cf617bf51575ba463e813156ed97c85d8ca5c5691db37bbfe36a622a4f'
}
include 'blackfire::agent'
include 'blackfire::php'
```

You can provide additional parameters to `blackfire::agent` and `blackfire::php`:
```puppet
class { 'blackfire':
	server_id    => 'b54114a9-df8a-563b-8ba3-e5457155010e',
	server_token => '7315b1cf617bf51575ba463e813156ed97c85d8ca5c5691db37bbfe36a622a4f'
}
class { 'blackfire::agent':
  `log_file`     => '/var/log/blackfire-agent.log'
}
class { 'blackfire::php':
  `log_file`     => '/var/log/blackfire-php.log'
}
```

## Reference

### Classes

#### Public classes

`blackfire`: Main class, validates common configuration parameters
`blackfire::agent`: Manages the Agent
`blackfire::php`: Manages the PHP extenstion (Probe)

#### Private classes
`blackfire::repo`: Handles the repository.
`blackfire::agent::install`: Handles the packages.
`blackfire::agent::config`: Handles the configuration file.
`blackfire::agent::service`: Handles the service.
`blackfire::php::install`: Handles the packages.
`blackfire::php::config`: Handles the configuration file.

### Parameters

#### Available parameters for blackfire class
`server_id` - Server ID to use for the agent (See [https://blackfire.io/account/agents])
`server_token` - Server Token to use for the agent (See [https://blackfire.io/account/agents])
`log_level` - Log verbosity level (4: debug, 3: info, 2: warning, 1: error). Default `1`
`socket` - Where the socket the agent will listen to. Default `unix:///var/run/blackfire/agent.sock`

#### Available parameters for blackfire::agent class

`version` - Which version of the agent to install. Default last version.
`ca_cert` - PEM encoded certicates
`collector` - URL of Blackfire's data collector. Default 'https://blackfire.io'
`http_proxy` - Http proxy to use
`https_proxy` - Https proxy to use
`log_file` - The path of the log file. Use `stderr` to log to stderr. Default `stderr`
`spec` - The path to the json specifications file

`service_manage` - Manage the service. Default is `true` 
`service_ensure` - Default is `present`

The following parameters inherited from the main class, and can be overriden:
`server_id`, `server_token`, `log_level`, `socket`

#### Available parameters for blackfire::php class

`version` - Which version of the probe to install. Default last version.
`log_file` - The path of the log file.
`agent_timeout` - The agent timeout. Default `0.25`

The following parameters inherited from the main class, and can be overriden:
`server_id`, `server_token`, `log_level`, `socket`

